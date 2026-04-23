#include "fileio.h"
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>

static uint8_t *file_contents(const char *path, size_t *size)
{
    FILE *f = file_open(path, "rb");
    
    fseek(f, 0, SEEK_END);
    *size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t *buf = malloc(*size);
    file_read(f, buf, *size);
    fclose(f);
    return buf;
}

static void write_u16_be(FILE *f, uint16_t v)
{
    uint8_t bytes[2] = { v >> 8, v };
    file_write(f, bytes, sizeof(bytes));
}

static void write_u16_le(FILE *f, uint16_t v)
{
    uint8_t bytes[2] = { v, v >> 8 };
    file_write(f, bytes, sizeof(bytes));
}

static void write_u32_be(FILE *f, uint32_t v)
{
    uint8_t bytes[4] = { v >> 24, v >> 16, v >> 8, v };
    file_write(f, bytes, sizeof(bytes));
}

static int dboot_join(FILE *out, unsigned count, const char *files[], bool prepend_sizes, bool prepend_count)
{
    if (prepend_count) {
        write_u16_be(out, count);
    }
    
    fseek(out, count * (prepend_sizes? 8 : 4), SEEK_CUR);
        
    for (unsigned i = 0; i < count; i++) {
        FILE *in = file_open(files[i], "rb");
        
        fseek(in, 0, SEEK_END);
        size_t size = ftell(in);
        fseek(in, 0, SEEK_SET);
        
        size_t offset = ftell(out);
        while (size) {
            static uint8_t buffer[0x1000];
            ssize_t read = fread(buffer, 1, sizeof(buffer) < size? sizeof(buffer) : size, in);
            if (read <= 0) {
                perror("fread");
                exit(1);
            }
            file_write(out, buffer, read);
            size -= read;
        }
        fseek(out, i * (prepend_sizes? 8 : 4) + (prepend_count? 2 : 0), SEEK_SET);
        write_u32_be(out, offset);
        if (prepend_sizes) {
            write_u32_be(out, ftell(in));
        }
        fclose(in);
        fseek(out, 0, SEEK_END);
    }
    return 0;
}

static int dboot_join_channels(FILE *out, unsigned count, const char **channels)
{
    for (unsigned i = 0; i < count; i++) {
        FILE *in = file_open(channels[i], "rb");
        fseek(in, 0, SEEK_END);
        size_t size = ftell(in);
        fseek(in, 0, SEEK_SET);
        write_u16_le(out, size);

        while (size) {
            static uint8_t buffer[0x1000];
            ssize_t read = fread(buffer, 1, sizeof(buffer) < size? sizeof(buffer) : size, in);
            if (read <= 0) {
                perror("fread");
                exit(1);
            }
            file_write(out, buffer, read);
            size -= read;
        }
        fclose(in);
    }
    
    write_u16_le(out, 0xFFFF);
    
    if (ftell(out) & 1) {
        fputc(0xFF, out);
    }
    return 0;
}

static int pack_dboot_samples(FILE *out, const char *definition)
{
    FILE *f = file_open(definition, "r");
    
    chdir(dirname((char *)definition));
    
    char *line = NULL;
    uint8_t **samples = NULL;
    size_t *sizes = NULL;
    uint16_t *loops = NULL;
    size_t count = 0;
    
    while (!feof(f)) {
        line = (char *)file_read_line(f);
        char *comment = strchr(line, '#');
        if (comment) *comment = 0;
        
        char *filename = strtok(line, " \t\r\n");
        if (!filename) continue;
        char *loop = strtok(NULL, " \t\r\n");
        if (!loop) {
            fprintf(stderr, "Missing loop size for sample %s\n", filename);
            return 1;
        }
        
        samples = realloc(samples, sizeof(void *)   * (count + 1));
        sizes   = realloc(sizes,   sizeof(size_t)   * (count + 1));
        loops   = realloc(loops,   sizeof(uint16_t) * (count + 1));
                
        samples[count] = file_contents(filename, &sizes[count]);
        
        unsigned loop_value = atoi(loop);
        uint16_t off = (loop_value * 9) / 16;
        if (loop_value % 16) off++;
        
        loops[count] = off;
        count++;
    }
    
    fclose(f);
    
    uint32_t offset = 8 * count;
    
    for (size_t i = 0; i < count; i++) {
        write_u32_be(out, offset);
        write_u16_be(out, sizes[i]);
        write_u16_be(out, loops[i]);
        offset += sizes[i];
    }
    
    for (size_t i = 0; i < count; i++) {
        file_write(out, samples[i], sizes[i]);
        free(samples[i]);
    }
    
    free(samples);
    free(sizes);
    free(loops);
    return 0;
}

int main(int argc, const char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s join|join-songs|join-channels|pack-samples ...\n", argv[0]);
        return 1;
    }
    
    if (strcmp(argv[1], "join") == 0) {
        if (argc < 4) {
            fprintf(stderr, "Usage: %s join out files...\n", argv[0]);
            return 1;
        }
        FILE *out = file_open(argv[2], "wb");
        int ret = dboot_join(out, argc - 3, &argv[3], false, false);
        fclose(out);
        if (ret) unlink(argv[2]);
        return ret;
    }
    if (strcmp(argv[1], "join-songs") == 0) {
        if (argc < 4) {
            fprintf(stderr, "Usage: %s join-songs out files...\n", argv[0]);
            return 1;
        }
        FILE *out = file_open(argv[2], "wb");
        int ret = dboot_join(out, argc - 3, &argv[3], true, true);
        fclose(out);
        if (ret) unlink(argv[2]);
        return ret;
    }
    if (strcmp(argv[1], "join-channels") == 0) {
        if (argc < 4) {
            fprintf(stderr, "Usage: %s join-channels out files...\n", argv[0]);
            return 1;
        }
        FILE *out = file_open(argv[2], "wb");
        int ret = dboot_join_channels(out, argc - 3, &argv[3]);
        fclose(out);
        if (ret) unlink(argv[2]);
        return ret;
    }
    if (strcmp(argv[1], "pack-samples") == 0) {
        if (argc != 4) {
            fprintf(stderr, "Usage: %s pack-samples definition out\n", argv[0]);
        }
        FILE *out = file_open(argv[3], "wb");
        int ret = pack_dboot_samples(out, argv[2]);
        fclose(out);
        if (ret) unlink(argv[3]);
        return ret;
    }
    
    fprintf(stderr, "%s %s: No such command\n", argv[0], argv[1]);
    return 1;
}
