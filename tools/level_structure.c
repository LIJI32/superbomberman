#include <errno.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include "fileio.h"
#include "rle.h"

/* Since we're using chars as indexes, we're explicitly specifying unsigned chars in this file
   and ignore pointer sign mismatch so we can use string.h functions */
#pragma GCC diagnostic ignored "-Wpointer-sign"

#define TILEMAP_ROWS 13
#define TILEMAP_COLS 17
#define TILEMAP_SIZE (TILEMAP_ROWS * TILEMAP_COLS)

static const unsigned char SYMBOLS[]         = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1245678";
static const unsigned char FLIPPED_SYMBOLS[] = "abcdefghijklmnopqrstuvwxyz!@$%^&*";

static const unsigned char flip(unsigned char c)
{
    const unsigned char *p = strchr(SYMBOLS, c);
    if (!p) return 0;
    return FLIPPED_SYMBOLS[p - &SYMBOLS[0]];
}

static unsigned char tile_to_symbol(uint16_t tile, uint16_t *mapping)
{
    const unsigned char *symbols = " #\"ABCDEFGHIJKLMNOPQRSTUVWXYZ1245678abcdefghijklmnopqrstuvwxyz!@$%^&*";
    while (*symbols) {
        if (mapping[*symbols] == tile) return *symbols;
        symbols++;
    }
    return 0;
}

static int encode(FILE *in, FILE *out)
{
    static uint16_t mapping[256];
    
    memset(mapping, 0xFF, sizeof(mapping));
    
    // Read collision (lines 0-12) and pack bits
    uint16_t mask = 0;
    unsigned bits_left = 15;
    
    for (unsigned i = 0; i < TILEMAP_ROWS; i++) {
        const char *line = file_read_line(in);
        for (unsigned j = 0; j < TILEMAP_COLS; j++) {
            if (line[j] == 0 || line[j] == '\n') {
                fprintf(stderr, "Invalid collision data\n");
                return 1;
            }
            if (line[j] == '#') {
                mask |= (1 << bits_left);
            }
            
            if (bits_left == 0) {
#if __BIG_ENDIAN__
                mask = __builtin_bswap16(mask);
#endif
                file_write(out, &mask, sizeof(mask));
                mask = 0;
                bits_left = 15;
            }
            else {
                bits_left--;
            }
        }
    }
    
    // Write final padded bits
#if __BIG_ENDIAN__
    mask = __builtin_bswap16(mask);
#endif
    file_write(out, &mask, sizeof(mask));

    
    // Remember position after collision (start of tilemap at lines 13-25)
    size_t tilemap_start = ftell(in);
    
    // Skip tilemap to read symbol table (13 lines of tilemap, then symbol table)
    for (unsigned i = 0; i < TILEMAP_ROWS; i++) {
        file_read_line(in);
    }
    
    // Build symbol map
    while (true) {
        unsigned char c = 0;
        unsigned tile = 0;
        if (fscanf(in, "%c = %04x\n", &c, &tile) == 1) {
            fprintf(stderr, "Invalid symbol table in input\n");
            return 1;
        }
        if (!c) break;
        mapping[c] = tile;
        unsigned char flipped = flip(c);
        if (flipped && mapping[flipped] == 0xFFFF) {
            mapping[flipped] = tile | 0x40;
        }
    }
    
    // Open temp file for tilemap stream
    FILE *encoded = tmpfile();
    
    // Rewind to read tilemap (lines 13-25) and write tiles to temp file
    fseek(in, tilemap_start, SEEK_SET);
    
    uint16_t tile = 0;
    for (unsigned i = 0; i < TILEMAP_ROWS; i++) {
        const char *line = file_read_line(in);
        for (unsigned j = 0; line[j] && j < TILEMAP_COLS; j++) {
            unsigned char sym = line[j];
            
            if (mapping[sym] == 0xFFFF) {
                fprintf(stderr, "Undefined symbol '%c'\n", sym);
                fclose(encoded);
                return 1;
            }
            
            tile = htons(mapping[sym]);
            file_write(encoded, &tile, sizeof(tile));
        }
    }
    
    // Write padding: 0000 + last tile + 0000
    uint16_t padding = 0;
    file_write(encoded, &padding, sizeof(padding));
    file_write(encoded, &tile, sizeof(tile));
    file_write(encoded, &padding, sizeof(padding));
    
    // Write compressed
    fseek(encoded, 0, SEEK_SET);
    int ret = rle_compress(encoded, out);
    fclose(encoded);
    
    return ret;
}

static int decode(FILE *in, FILE *out)
{
    static uint16_t mapping[256] = {0,};
    memset(mapping, 0xFF, sizeof(mapping));
    
    // Decode collision
    unsigned pos = 0;
    for (unsigned i = 0; i < 14; i++) {
        uint16_t mask;
        if (!file_read(in, &mask, sizeof(mask))) {
            return 1;
        }
#if __BIG_ENDIAN__
        mask = __builtin_bswap16(mask);
#endif
        for (unsigned bit = 16; bit--;) {
            if (pos == TILEMAP_SIZE) break;
            fputc((mask & (1 << bit)) ? '#' : ' ', out);
            if ((pos + 1) % TILEMAP_COLS == 0) {
                fputc('\n', out);
            }
            pos++;
        }
    }
    
    FILE *decompressed = tmpfile();
    
    if (rle_decompress(in, decompressed) != 0) {
        fclose(decompressed);
        return 1;
    }
    
    // Auto-detect empty, hardblocks, and shaded empty tiles
    fseek(decompressed, 0x46 * sizeof(mapping[0]), SEEK_SET);
    file_read(decompressed, &mapping[' '], sizeof(mapping[0]));
    fseek(decompressed, 0x47 * sizeof(mapping[0]), SEEK_SET);
    file_read(decompressed, &mapping['#'], sizeof(mapping[0]));
    fseek(decompressed, 0x58 * sizeof(mapping[0]), SEEK_SET);
    file_read(decompressed, &mapping['"'], sizeof(mapping[0]));
    
    mapping[' '] = ntohs(mapping[' ']);
    mapping['#'] = ntohs(mapping['#']);
    mapping['"'] = ntohs(mapping['"']);
    
    fseek(decompressed, 0, SEEK_SET);

    unsigned last_symbol = 0;
    unsigned countdown = TILEMAP_COLS;
    
    for (unsigned i = TILEMAP_SIZE; i--;) {
        uint16_t tile;
        
        if (!file_read(decompressed, &tile, sizeof(tile))) break;
        tile = ntohs(tile);
        
        unsigned char c = tile_to_symbol(tile, mapping);
        if (c) {
            file_write(out, &c, sizeof(c));
            goto newline;
        }
        
        c = SYMBOLS[last_symbol++];
        if (!c) {
            fprintf(stderr, "Too many different tiles\n");
            return 1;
        }
        uint16_t unflipped_tile = tile & ~ 0x40;
        mapping[c] = unflipped_tile;
        mapping[flip(c)] = unflipped_tile | 0x40;
        if (tile != unflipped_tile) {
            c = flip(c);
        }
        file_write(out, &c, sizeof(c));
        
    newline:
        if (--countdown == 0) {
            unsigned char c = '\n';
            file_write(out, &c, sizeof(c));
            countdown = TILEMAP_COLS;
        }
    }
    
    fprintf(out, " =%04x\n", mapping[' ']);
    fprintf(out, "\"=%04x\n", mapping['"']);
    fprintf(out, "#=%04x\n", mapping['#']);
    
    const unsigned char *symbol = SYMBOLS;
    while (*symbol) {
        if (mapping[*symbol] != 0xFFFF) {
            uint16_t tile = ntohs(mapping[*symbol]);
            fprintf(out, "%c=%02x%02x\n", *symbol, tile & 0xff, tile >> 8);
        }
        symbol++;
    }
    
    fclose(decompressed);
    return 0;
}

int main(int argc, char **argv)
{
    if (argc != 4) {
        fprintf(stderr, "Usage: %s (encode|decode) INPUT OUTPUT\n", argv[0]);
        return 1;
    }
    
    if (strcmp(argv[1], "encode") == 0) {
        FILE *input = file_open(argv[2], "rb");
        FILE *output = file_open(argv[3], "wb");
        int ret = encode(input, output);
        fclose(input);
        fclose(output);
        if (ret) {
            unlink(argv[3]);
        }
        return ret;
    }
    else if (strcmp(argv[1], "decode") == 0) {
        FILE *input = file_open(argv[2], "rb");
        FILE *output = file_open(argv[3], "wb");
        int ret = decode(input, output);
        fclose(input);
        fclose(output);
        if (ret) {
            unlink(argv[3]);
        }
        return ret;
    }
    else {
        fprintf(stderr, "Usage: %s (encode|decode) INPUT OUTPUT\n", argv[0]);
        return 1;
    }
}
