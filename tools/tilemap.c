#include <errno.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <string.h>
#include "fileio.h"
#include "rle.h"

/* Since we're using chars as indexes, we're explicitly specifying unsigned chars in this file
   and ignore pointer sign mismatch so we can use string.h functions */
#pragma GCC diagnostic ignored "-Wpointer-sign"


static const unsigned char SYMBOLS[]         = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-[];'\\,./`";
static const unsigned char FLIPPED_SYMBOLS[] = "abcdefghijklmnopqrstuvwxyz!@#$%^&*()_{}:\"|<>?~";

static const unsigned char flip(unsigned char c)
{
    const unsigned char *p = strchr(SYMBOLS, c);
    if (!p) return 0;
    return FLIPPED_SYMBOLS[p - &SYMBOLS[0]];
}

static int encode(FILE *in, FILE *out)
{
    static uint16_t mapping[256] = {0,};
    memset(mapping, 0xFF, sizeof(mapping));
    
    unsigned data_lines = 0;
    
    while (true) {
        const char *line = file_read_line(in);
        data_lines++;
        if (line[0] == '\n') break; // Reached symbol table
        if (line[0] == '\0') { // Reach EOF, no symbol table
            fprintf(stderr, "No symbol table in input\n");
            return 1;
        }
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
    
    fseek(in, 0, SEEK_SET);
    
    // It's safe to assume we can't fail here unless the user modified the file while we were reading it
    uint16_t tile = 0;
    while (data_lines) {
        unsigned char c = 0;
        file_read(in, &c, sizeof(c));
        if (c == '\n') {
            data_lines--;
            continue;
        }
        if (!c) {
            return 1;
        }
        if (c == '+') {
            tile += 0x200;
        }
        else {
            tile = mapping[c];
            if (tile == 0xFFFF) {
                fprintf(stderr, "Undefined symbol %c\n", c);
                return 1;
            }
        }
        uint8_t data[2] = {
            tile >> 8,
            tile,
        };
        file_write(out, data, sizeof(data));
    }
    return 0;
}

int compress(FILE *in, FILE *out)
{
    FILE *encoded = tmpfile();
    int ret = encode(in, encoded);
    if (ret) {
        fclose(encoded);
        return ret;
    }
    fseek(encoded, 0, SEEK_SET);
    ret = rle_compress(encoded, out);
    fclose(encoded);
    return ret;
}

static unsigned char tile_to_symbol(uint16_t tile, uint16_t *mapping)
{
    const unsigned char *symbols = " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-[];'\\,./`abcdefghijklmnopqrstuvwxyz!@#$%^&*()_{}:\"|<>?~";

    while (*symbols) {
        if (mapping[*symbols] == tile) return *symbols;
        symbols++;
    }
    return 0;
}

int decode(FILE *in, FILE *out, bool narrow, bool no_flip, bool no_plus)
{
    const unsigned char *effective_symbols = no_flip? (unsigned char *)&"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-[];'\\,./`!@#$%^&*()_{}:\"|<>?~" : SYMBOLS;
    unsigned last_symbol = 0;
    unsigned width = narrow? 17 : 32;
    
    uint16_t tile = 0;
    uint16_t prev = 0;
    
    static uint16_t mapping[256] = {0,};
    memset(mapping, 0xFF, sizeof(mapping));

    unsigned countdown = narrow? 6 : 32; // 6 rather 17 for alignment;
    
    while (true) {
        prev = tile;
        if (!file_read(in, &tile, sizeof(tile))) break;
        tile = ntohs(tile);
        
        if (!no_plus && tile == prev + 0x200 && !tile_to_symbol(tile, mapping)) {
            unsigned char c = '+';
            file_write(out, &c, sizeof(c));
            goto newline;
        }
        
        unsigned char c = tile_to_symbol(tile, mapping);
        if (c) {
            file_write(out, &c, sizeof(c));
            goto newline;
        }
        
        if ((tile >> 8) == 0 && mapping[' '] == 0xFFFF) {
            c = ' ';
        }
        else {
            c = effective_symbols[last_symbol++];
        }
        if (!c) {
            fprintf(stderr, "Too many different tiles\n");
            return 1;
        }
        if (no_flip || c == ' ') {
            mapping[c] = tile;
        }
        else {
            uint16_t unflipped_tile = tile & ~ 0x40;
            mapping[c] = unflipped_tile;
            mapping[flip(c)] = unflipped_tile | 0x40;
            if (tile != unflipped_tile) {
                c = flip(c);
            }
        }
        file_write(out, &c, sizeof(c));

newline:
        if (--countdown == 0) {
            unsigned char c = '\n';
            file_write(out, &c, sizeof(c));
            countdown = width;
        }
    }
    
    unsigned char c = '\n';
    file_write(out, &c, sizeof(c));
    if (mapping[' '] != 0xFFFF) {
        fprintf(out, " =%04x\n", mapping[' ']);
    }
    
    while (*effective_symbols) {
        if (mapping[*effective_symbols] != 0xFFFF) {
            uint16_t tile = ntohs(mapping[*effective_symbols]);
            fprintf(out, "%c=%02x%02x\n", *effective_symbols, tile & 0xff, tile >> 8);
        }
        effective_symbols++;
    }
    
    return 0;
}

int decompress(FILE *in, FILE *out, bool narrow, bool no_flip, bool no_plus)
{
    FILE *decompressed = tmpfile();
    int ret = rle_decompress(in, decompressed);
    if (ret) {
        fclose(decompressed);
        return ret;
    }
    fseek(decompressed, 0, SEEK_SET);
    ret = decode(decompressed, out, narrow, no_flip, no_plus);
    fclose(decompressed);
    return ret;
}

int main(int argc, char **argv)
{
    bool narrow = false;
    bool no_flip = false;
    bool no_plus = false;
    
    for (unsigned i = 2; i < argc; i++) {
        if (strcmp(argv[i], "--narrow") == 0) {
            narrow = true;
            goto remove;
        }
        if (strcmp(argv[i], "--no-flip") == 0) {
            no_flip = true;
            goto remove;
        }
        if (strcmp(argv[i], "--no-plus") == 0) {
            no_plus = true;
            goto remove;
        }
        continue;
remove:
        for (unsigned j = i; j < argc - 1; j++) {
            argv[j] = argv[j + 1];
        }
        argc--;
        i--;
    }
    
    if (argc != 4) {
usage:
        fprintf(stderr, "Usage: %s encode|compress INPUT OUTPUT\n"
                        "       %s decode|decompress [--narrow] [--no-flip] [--no-plus] INPUT OUTPUT\n", argv[0], argv[0]);
        return 1;
    }
    
    FILE *input = file_open(argv[2], "rb");
    FILE *output = file_open(argv[3], "wb");
    
    int ret = 0;
    
    if (strcmp(argv[1], "encode") == 0) {
        ret = encode(input, output);
    }
    else if (strcmp(argv[1], "compress") == 0) {
        ret = compress(input, output);
    }
    else if (strcmp(argv[1], "decode") == 0) {
        ret = decode(input, output, narrow, no_flip, no_plus);
    }
    else if (strcmp(argv[1], "decompress") == 0) {
        ret = decompress(input, output, narrow, no_flip, no_plus);
    }
    else {
        goto usage;
    }

    fclose(input);
    fclose(output);
    
    if (ret) {
        unlink(argv[3]);
    }
    return ret;
}
