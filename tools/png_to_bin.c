#include <errno.h>
#include <png.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fileio.h"
#include "rle.h"

/* PNG tile encoding modes */
typedef enum {
    MODE_SPRITE,  /* 4bpp RLE, part_size=0x20 */
    MODE_BG,      /* 4bpp RLE terminated */
    MODE_OVERLAY, /* 4bpp RLE, no parts */
    MODE_RAW,     /* 4bpp no RLE */
    MODE_RAW2,    /* 2bpp no RLE */
} encoding_mode_t;

/* NULL_TILE pattern used for filtering alignment padding */
static const uint8_t NULL_TILE[64] = {
    1,1,1,1,1,1,1,1,
    1,2,0,0,0,0,3,1,
    1,0,2,0,0,3,0,1,
    1,0,0,2,3,0,0,1,
    1,0,0,3,2,0,0,1,
    1,0,3,0,0,2,0,1,
    1,3,0,0,0,0,2,1,
    1,1,1,1,1,1,1,1,
};

#define TILE_SIZE 64

typedef struct {
    unsigned width;
    unsigned height;
    uint8_t *pixels;
} bitmap_t;

typedef struct {
    uint8_t *data;
    unsigned count;
} tileset_t;

static bitmap_t *read_png(const char *filename)
{
    FILE *f = file_open(filename, "rb");

    png_structp png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    png_infop info = png_create_info_struct(png);

    png_init_io(png, f);
    png_read_info(png, info);

    unsigned width = png_get_image_width(png, info);
    unsigned height = png_get_image_height(png, info);

    png_read_update_info(png, info);

    bitmap_t *bitmap = malloc(sizeof(*bitmap));
    bitmap->width = width;
    bitmap->height = height;
    bitmap->pixels = malloc(width * height);

    uint8_t *pointer = bitmap->pixels;
    for (unsigned y = 0; y < height; y++) {
        png_read_row(png, (png_bytep)pointer, NULL);
        pointer += width;
    }

    png_destroy_read_struct(&png, &info, NULL);
    fclose(f);
    
    return bitmap;
}

static void free_bitmap(bitmap_t *bitmap)
{
    if (!bitmap) return;
    free(bitmap->pixels);
    free(bitmap);
}

static bool is_null_tile(const uint8_t *tile)
{
    for (unsigned i = 0; i < TILE_SIZE; i++) {
        if ((tile[i] & 0xF) != NULL_TILE[i])
            return false;
    }
    return true;
}

static tileset_t *bitmap_to_tileset(const bitmap_t *bitmap, unsigned part)
{
    unsigned tiles_x = bitmap->width / 8;
    unsigned tiles_y = bitmap->height / 8;
    unsigned total_tiles = tiles_x * tiles_y;
    unsigned start = 0;
    
    if (part != -1) {
        if (total_tiles & 0x1F) {
            fprintf(stderr, "Input does not divide to 32 tile chunks\n");
            abort();
        }
        start = part * 0x20;
        if (start + 0x20 > total_tiles) {
            fprintf(stderr, "Input part is out of range\n");
            abort();
        }

        total_tiles = 0x20;
    }

    tileset_t *tileset = malloc(sizeof(*tileset));
    tileset->data = malloc(total_tiles * TILE_SIZE);
    tileset->count = 0;

    for (unsigned tile_idx = start; tile_idx < start + total_tiles; tile_idx++) {
        unsigned tile_y = tile_idx / tiles_x;
        unsigned tile_x = tile_idx % tiles_x;
        uint8_t *tile = tileset->data + tileset->count * TILE_SIZE;

        /* Extract 8x8 tile */
        for (unsigned y = 0; y < 8; y++) {
            for (unsigned x = 0; x < 8; x++) {
                tile[y * 8 + x] = bitmap->pixels[(tile_y * 8 + y) * bitmap->width + (tile_x * 8 + x)];
            }
        }

        /* Don't count NULL tiles, let them be overwritten */
        if (!is_null_tile(tile)) {
            tileset->count++;
        }
    }

    return tileset;
}

static void free_tileset(tileset_t *tileset)
{
    if (tileset) {
        free(tileset->data);
        free(tileset);
    }
}

static uint8_t *encode_tile(const uint8_t *tile, unsigned depth)
{
    uint8_t *out = malloc(depth * 8);
    memset(out, 0, depth * 8);
    
    for (unsigned y = 0; y < 8; y++) {
        for (unsigned x = 0; x < 8; x++) {
            // Bit plane 0
            out[y * 2] <<= 1;
            if (tile[y * 8 + x] & 1) out[y * 2] |= 1;
            
            // Bit plane 1
            out[y * 2 + 1] <<= 1;
            if (tile[y * 8 + x] & 2) out[y * 2 + 1] |= 1;
            
            if (depth == 4) {
                // Bit plane 2
                out[y * 2 + 16] <<= 1;
                if (tile[y * 8 + x] & 4) out[y * 2 + 16] |= 1;
                
                // Bit plane 3
                out[y * 2 + 17] <<= 1;
                if (tile[y * 8 + x] & 8) out[y * 2 + 17] |= 1;
            }
        }
    }
    
    return out;
}

static void interleave_stream(FILE *in, FILE *even, FILE *odd)
{
    while (true) {
        uint8_t byte;
        if (!file_read(in, &byte, sizeof(byte))) break;
        file_write(even, &byte, 1);
        if (!file_read(in, &byte, sizeof(byte))) break;
        file_write(odd, &byte, 1);
    }
}

static int encode_raw(const tileset_t *tileset, unsigned depth, FILE *out)
{
    for (unsigned i = 0; i < tileset->count; i++) {
        uint8_t *encoded = encode_tile(tileset->data + i * TILE_SIZE, depth);
        file_write(out, encoded, depth * 8);
        free(encoded);
    }
    return 0;
}

static int encode_rle(const tileset_t *tileset, unsigned depth, bool terminated, FILE *out)
{
    /* Create temporary file for encoded tiles */
    FILE *raw = tmpfile();

    /* Encode all tiles to temp file */
    encode_raw(tileset, depth, raw);


    /* Rewind and interleave */
    fseek(raw, 0, SEEK_SET);
    FILE *even = tmpfile();
    FILE *odd = tmpfile();
    interleave_stream(raw, even, odd);
    fclose(raw);
    
    /* Compress */
    
    fseek(even, 0, SEEK_SET);
    rle_compress_8bit(even, out);
    fclose(even);
    if (terminated) {
        uint8_t bytes[] = {0x81, 0xaa, 00};
        file_write(out, bytes, sizeof(bytes));
    }
    
    fseek(odd, 0, SEEK_SET);
    rle_compress_8bit(odd, out);
    fclose(odd);
    if (terminated) {
        uint8_t bytes[] = {0x81, 0xaa, 00};
        file_write(out, bytes, sizeof(bytes));
    }

    return 0;
}

static int main_impl(encoding_mode_t mode, char *input_file, const char *output_file)
{
    unsigned part = -1;
    char *colon = strrchr(input_file, ':');
    if (colon) {
        *colon = 0;
        part = atoi(colon + 1);
    }
    
    /* Read PNG */
    bitmap_t *bitmap = read_png(input_file);
    if (!bitmap) {
        fprintf(stderr, "Failed to read PNG: %s\n", input_file);
        return 1;
    }

    tileset_t *tileset = bitmap_to_tileset(bitmap, part);
    free_bitmap(bitmap);

    /* Open output file */
    FILE *out = file_open(output_file, "wb");

    int ret = 0;
    unsigned depth = 4;

    switch (mode) {
    case MODE_RAW2:
        depth = 2;
        /* Fall through */
    case MODE_RAW:
        ret = encode_raw(tileset, depth, out);
        break;

    case MODE_BG:
        ret = encode_rle(tileset, 4, true, out);
        break;

    case MODE_OVERLAY:
    case MODE_SPRITE:
        ret = encode_rle(tileset, 4, false, out);
        break;
    }

    fclose(out);
    free_tileset(tileset);
    return ret;
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
    usage:
        fprintf(stderr, "Usage: %s <mode> input.png output.bin\n", argv[0]);
        fprintf(stderr, "       %s sprite input.png:part output.bin\n", argv[0]);
        fprintf(stderr, "Modes: sprite, bg, overlay, raw, raw2\n");
        return 1;
    }

    encoding_mode_t mode = MODE_SPRITE;

    if (strcmp(argv[1], "bg") == 0) {
        mode = MODE_BG;
    }
    else if (strcmp(argv[1], "overlay") == 0) {
        mode = MODE_OVERLAY;
    }
    else if (strcmp(argv[1], "raw") == 0) {
        mode = MODE_RAW;
    }
    else if (strcmp(argv[1], "raw2") == 0) {
        mode = MODE_RAW2;
    }
    else if (strcmp(argv[1], "sprite") == 0) {
        mode = MODE_SPRITE;
    }
    else {
        goto usage;
    }

    return main_impl(mode, argv[2], argv[3]);
}
