#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>

__attribute__((unused)) static int rle_compress(FILE *in, FILE *out)
{
    bool done = false;
    while (true) {
        uint16_t mask = 0;
        uint32_t last_dword = 0;
        uint32_t dwords[16] = {0,};
        unsigned dword_count = 0;

        for (unsigned i = 0; i < 16; i++) {
            uint32_t dword;
            if (!file_read(in, &dword, sizeof(dword))) {
                done = true;
                break;
            }
            mask <<= 1;
            if (dword != last_dword) {
                dwords[dword_count++] = dword;
                last_dword = dword;
                mask |= 1;
            }
        }
        if (done) {
            return 0;
        }
#if __BIG_ENDIAN__
        mask = __builtin_bswap16(mask);
#endif
        file_write(out, &mask, sizeof(mask));
        file_write(out, dwords, sizeof(dwords[0]) * dword_count);
    }
}

__attribute__((unused)) static int rle_compress_8bit(FILE *in, FILE *out)
{
    bool done = false;
    while (true) {
        uint8_t mask = 0;
        uint8_t last_byte = 0;
        uint8_t bytes[8] = {0,};
        unsigned byte_count = 0;
        
        for (unsigned i = 0; i < 8; i++) {
            uint8_t byte;
            if (!file_read(in, &byte, sizeof(byte))) {
                done = true;
                break;
            }
            mask <<= 1;
            if (byte != last_byte) {
                bytes[byte_count++] = byte;
                last_byte = byte;
                mask |= 1;
            }
        }
        if (done) {
            return 0;
        }

        file_write(out, &mask, sizeof(mask));
        file_write(out, bytes, byte_count);
    }
}

__attribute__((unused)) static int rle_decompress(FILE *in, FILE *out)
{
    uint32_t repeat = 0;

    while (true) {
        uint16_t mask = 0;
        if (!file_read(in, &mask, sizeof(mask))) break;
#if __BIG_ENDIAN__
        mask = __builtin_bswap16(mask);
#endif
        for (unsigned i = 16; i--;) {
            if (mask & 0x8000) {
                if (!file_read(in, &repeat, sizeof(repeat))) {
                    fprintf(stderr, "Truncated file\n");
                    return 1;
                }
            }
            mask <<= 1;
            file_write(out, &repeat, sizeof(repeat));
        }
    }
    return 0;
}
