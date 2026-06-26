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

static int compile_banks(FILE *out, const char *definition)
{
    FILE *f = file_open(definition, "r");

    uint8_t *instruments = NULL, *sounds = NULL, *songs = NULL;
    size_t n_instruments = 0, n_sounds = 0, n_songs = 0;
    unsigned n_banks = 0;

    write_u16_be(out, 0);

    while (!feof(f)) {
        char *line = (char *)file_read_line(f);
        char *comment = strchr(line, '#');
        if (comment) *comment = 0;

        char *keyword = strtok(line, " \t\r\n");
        if (!keyword) continue;

        uint8_t **list = NULL;
        size_t *count = NULL;

        if (strcmp(keyword, "instruments") == 0) {
            if (n_banks) {
                write_u16_le(out, (uint16_t)(3 + n_instruments + n_sounds + n_songs));
                fputc((uint8_t)n_instruments, out);
                if (n_instruments) file_write(out, instruments, n_instruments);
                fputc((uint8_t)n_sounds, out);
                if (n_sounds) file_write(out, sounds, n_sounds);
                fputc((uint8_t)n_songs, out);
                if (n_songs) file_write(out, songs, n_songs);
                if (instruments) free(instruments);
                if (sounds) free(sounds);
                if (songs) free(songs);
                songs = instruments = sounds = NULL;
                n_songs = n_instruments = n_sounds = 0;
            }
            n_banks++;
            list = &instruments;
            count = &n_instruments;
        }
        else if (strcmp(keyword, "sounds") == 0) {
            if (!n_banks) {
                fprintf(stderr, "'sounds' before 'instruments'\n");
                exit(1);
            }
            if (n_sounds) {
                fprintf(stderr, "Multiple 'sounds' commands in a bank\n");
                exit(1);
            }
            list = &sounds;
            count = &n_sounds;
        }
        else if (strcmp(keyword, "songs") == 0) {
            if (!n_banks) {
                fprintf(stderr, "'songs' before 'instruments'\n");
                exit(1);
            }
            if (n_songs) {
                fprintf(stderr, "Multiple 'songs' commands in a bank\n");
                exit(1);
            }
            list = &songs;
            count = &n_songs;
        }
        else {
            fprintf(stderr, "Unknown keyword '%s'\n", keyword);
            exit(1);
        }


        char *token;
        while ((token = strtok(NULL, ", \t\r\n"))) {
            *list = realloc(*list, *count + 1);
            if (*count == 0xFF) {
                fprintf(stderr, "Too many iterms in '%s'\n", keyword);
                exit(1);
            }
            (*list)[(*count)++] = (uint8_t)atoi(token);
        }
    }

    fclose(f);

    if (n_banks) {
        write_u16_le(out, (uint16_t)(3 + n_instruments + n_sounds + n_songs));
        fputc((uint8_t)n_instruments, out);
        if (n_instruments) file_write(out, instruments, n_instruments);
        fputc((uint8_t)n_sounds, out);
        if (n_sounds) file_write(out, sounds, n_sounds);
        fputc((uint8_t)n_songs, out);
        if (n_songs) file_write(out, songs, n_songs);
    }

    if (instruments) free(instruments);
    if (sounds) free(sounds);
    if (songs) free(songs);

    if (ftell(out) & 1) {
        fputc(0, out);
    }

    fseek(out, 0, SEEK_SET);
    write_u16_be(out, (uint16_t)n_banks);
    return 0;
}

static void write_bank_list(FILE *out, const char *keyword, uint8_t *ids, unsigned count)
{
    fprintf(out, "%s", keyword);
    for (unsigned i = 0; i < count; i++) {
        fprintf(out, i ? ", %u" : "%u", ids[i]);
    }
    fputc('\n', out);
}

static int decompile_banks(FILE *in, FILE *out)
{
    uint8_t header[2];
    if (!file_read(in, header, 2)) {
        fprintf(stderr, "Unexpected end of file\n");
        return 1;
    }
    unsigned n_banks = (header[0] << 8) | header[1];

    for (unsigned i = 0; i < n_banks; i++) {
        uint8_t size_buf[2];
        file_read(in, size_buf, 2); /* content_size (little-endian) */

        static uint8_t list[256];
        
        uint8_t count = 0;
        
        if (i) fputc('\n', out);
        fprintf(out, "# Bank %u\n", i);

        file_read(in, &count, sizeof(count));
        file_read(in, list, count);
        write_bank_list(out, "instruments  ", list, count);

        file_read(in, &count, sizeof(count));
        file_read(in, list, count);
        write_bank_list(out, "sounds       ", list, count);
        
        file_read(in, &count, sizeof(count));
        file_read(in, list, count);
        write_bank_list(out, "songs        ", list, count);
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
        fprintf(stderr, "Usage: %s join|join-songs|join-channels|pack-samples|compile-banks|decompile-banks ...\n", argv[0]);
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
    if (strcmp(argv[1], "compile-banks") == 0) {
        if (argc != 4) {
            fprintf(stderr, "Usage: %s compile-banks definition out\n", argv[0]);
            return 1;
        }
        FILE *out = file_open(argv[3], "wb");
        int ret = compile_banks(out, argv[2]);
        fclose(out);
        if (ret) unlink(argv[3]);
        return ret;
    }
    if (strcmp(argv[1], "decompile-banks") == 0) {
        if (argc != 4) {
            fprintf(stderr, "Usage: %s decompile-banks in out\n", argv[0]);
            return 1;
        }
        FILE *in  = file_open(argv[2], "rb");
        FILE *out = file_open(argv[3], "w");
        int ret = decompile_banks(in, out);
        fclose(in);
        fclose(out);
        if (ret) unlink(argv[3]);
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
