#include <errno.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <png.h>
#include "fileio.h"

static inline uint16_t encode_rgb(uint8_t r, uint8_t g, uint8_t b)
{
    uint8_t r5 = r >> 3;
    uint8_t g5 = g >> 3;
    uint8_t b5 = b >> 3;
    
    uint16_t ret = (b5 << 10) | (g5 << 5) | r5;
#if  __BIG_ENDIAN__
     ret = __builtin_bswap16(ret);
#endif
    return ret;
}

static bool photoshop_fix(png_colorp palette, unsigned *palette_size)
{
    /* Photoshop adds extra colors to a palette sometimes.
       We should remove them. */
    if (*palette_size % 16 != 0) {
        return true;
    }

    unsigned num_chunks = *palette_size / 16;
    for (unsigned i = 0; i < num_chunks; i++) {
        bool is_default = true;
        for (unsigned j = 0; j < 16; j++) {
            unsigned index = i * 16 + j;
            if (palette[index].red != index ||
                palette[index].green != index ||
                palette[index].blue != index) {
                is_default = false;
                break;
            }
        }
        if (is_default) {
            *palette_size = i * 16;
            return true;
        }
    }
    return true;
}

static int extract_palettes(char *input_file, const char *output_file)
{
    unsigned part = 0;
    char *colon = strrchr(input_file, ':');
    if (colon) {
        *colon = 0;
        part = atoi(colon + 1);
    }
    
    FILE *f = file_open(input_file, "rb");

    png_structp png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    png_infop info = png_create_info_struct(png);
    png_init_io(png, f);
    png_read_info(png, info);

    /* Check if PNG has a palette */
    png_colorp palette;
    unsigned palette_size;
    if (png_get_PLTE(png, info, &palette, (int *)&palette_size) != PNG_INFO_PLTE) {
        png_destroy_read_struct(&png, &info, NULL);
        fclose(f);
        fprintf(stderr, "PNG has no palette\n");
        return 1;
    }
    
    if (palette_size < part * 16 + 16) {
        fprintf(stderr, "PNG doesn't have enough colors to extract SNES palette %u\n", part);
        return 1;
    }

    photoshop_fix(palette, &palette_size);

    uint16_t palette_data[16];
    
    for (unsigned i = 0; i < 16; i++) {
        unsigned index = part * 16 + i;
        palette_data[i] = encode_rgb(
            palette[index].red,
            palette[index].green,
            palette[index].blue
        );
    }
    
    /* Write palette data */
    FILE *out = file_open(output_file, "wb");
    file_write(out, palette_data, sizeof(palette_data));
    fclose(out);

    png_destroy_read_struct(&png, &info, NULL);
    fclose(f);
    return 0;
}

int main(int argc, char **argv)
{
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <png file>[:part] <palette.bin>\n", argv[0]);
        return 1;
    }

    return extract_palettes(argv[1], argv[2]);
}
