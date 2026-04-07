#include <stdio.h>
#include <stdbool.h>

static inline FILE *file_open(const char *arg, const char *mode)
{
    FILE *ret = fopen(arg, mode);
    if (!ret) {
        fprintf(stderr, "Can't open %s: %s\n", arg, strerror(errno));
        exit(1);
    }
    return ret;
}

static inline const char *file_read_line(FILE *f)
{
    static char *line = NULL;
    if (line) {
        free(line);
        line = NULL;
    }
    size_t size = 0;
    errno = 0;
    if (getline(&line, &size, f) < 0) {
        if (line) {
            free(line);
            line = NULL;
        }
        if (errno == 0) return "";
        perror("Read error");
        exit(1);
    }
    return line;
}

static inline void file_write(FILE *f, const void *data, size_t size)
{
    if (fwrite(data, 1, size, f) != size) {
        perror("Write error");
        exit(1);
    }
}

static inline bool file_read(FILE *f, void *data, size_t size)
{
    ssize_t ret = fread(data, 1, size, f);
    if (ret == 0) return false;
    if (ret != size) {
        perror("Read error");
        exit(1);
    }
    return true;
}
