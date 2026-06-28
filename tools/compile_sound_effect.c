#include "fileio.h"
#include <unistd.h>
#include <stdint.h>
#include <ctype.h>

static void print_var(FILE *out, uint8_t index)
{
    fprintf(out, "%c%u", "lh"[index & 1], index >> 1);
}

static void print_wvar(FILE *out, uint8_t index)
{
    fprintf(out, "w%u", index >> 1);
}

static void print_s16(FILE *out, int16_t v)
{
    if (v < 0) {
        fprintf(out, "-0x%x", (unsigned)(uint16_t)-v);
    }
    else {
        fprintf(out, "+0x%x", (unsigned)v);
    }
}

static void print_s8(FILE *out, int8_t v)
{
    if (v < 0) {
        fprintf(out, "-0x%x", (unsigned)(uint8_t)-v);
    }
    else {
        fprintf(out, "+0x%x", (unsigned)v);
    }
}

/* Decompiler */

typedef enum {
    FMT_NONE,       // name 
    FMT_REPEAT,     // repeat N { 
    FMT_U8_HEX,     // name 0xN 
    FMT_U8_DEC,     // name N 
    FMT_U16_HEX,    // name 0xN 
    FMT_S16_HEX,    // name ±0xN 
    FMT_U8_U8,      // name N, N 
    FMT_S8_S8,      // name ±N, ±N 
    FMT_V8,         // name var 
    FMT_WV8,        // name wvar 
    FMT_WV8_PLUS,   // name +wvar 
    FMT_V8_IMM,     // name var, #N 
    FMT_WV8_IMM,    // name wvar, #N 
    FMT_V8_IMMHEX,  // name var, #0xNN 
    FMT_V8_V8,      // name var, var 
    FMT_WV8_V8,     // name wvar, var 
    FMT_ADSR,       // adsr DR, AR, SL, SR
    FMT_BRANCH,     // not supported in decompiler
    FMT_PADDING,    // padding byte
} fmt_t;

typedef struct {
    const char *name;
    fmt_t fmt;
} op_t;

static const op_t decompiler_opcodes[256] = {
    [0x80] = {"pitch",         FMT_U16_HEX},
     // Not entirely sure how they differ in practice, but one pitch sets both the pitch and "shadow pitch", while bend only the latter
    [0x81] = {"pitch",         FMT_S16_HEX},
    [0x82] = {"bend",          FMT_S16_HEX},
    [0x83] = {"",              FMT_REPEAT},
    [0x85] = {"b",             FMT_BRANCH},
    [0x86] = {"volume",        FMT_U8_U8},
    // Same difference as pitch as bend
    [0x87] = {"volume",        FMT_S8_S8},
    [0x88] = {"bend-volume",   FMT_S8_S8},
    [0x8b] = {"inst",          FMT_U8_DEC},
    [0x8d] = {"play",          FMT_NONE},
    [0x8e] = {"stop",          FMT_NONE},
    [0x91] = {"wait",          FMT_U8_DEC},
    [0x92] = {"end",           FMT_NONE},
    [0x95] = {"add",           FMT_V8_IMM},
    [0x96] = {"sub",           FMT_V8_IMM},
    [0x97] = {"mul",           FMT_WV8_IMM},
    [0x98] = {"div-mod",       FMT_WV8_IMM},
    [0x99] = {"not",           FMT_V8},
    [0x9a] = {"and",           FMT_V8_IMMHEX},
    [0x9b] = {"or",            FMT_V8_IMMHEX},
    [0x9c] = {"eor",           FMT_V8_IMMHEX},
    [0x9d] = {"inc",           FMT_V8},
    [0x9e] = {"dec",           FMT_V8},
    [0x9f] = {"neg",           FMT_V8},
    [0xa0] = {"add",           FMT_V8_V8},
    [0xa1] = {"sub",           FMT_V8_V8},
    [0xa2] = {"mul",           FMT_WV8_V8},
    [0xa3] = {"div-mod",       FMT_WV8_V8},
    [0xa4] = {"and",           FMT_V8_V8},
    [0xa5] = {"or",            FMT_V8_V8},
    [0xa6] = {"eor",           FMT_V8_V8},
    [0xa7] = {"cmp",           FMT_V8_IMM},
    [0xa8] = {"cmp",           FMT_V8_V8},
    [0xa9] = {"beq",           FMT_BRANCH},
    [0xaa] = {"bne",           FMT_BRANCH},
    [0xab] = {"bpl",           FMT_BRANCH},
    [0xac] = {"bmi",           FMT_BRANCH},
    [0xad] = {"bcc",           FMT_BRANCH},
    [0xae] = {"bcs",           FMT_BRANCH},
    [0xaf] = {"mov",           FMT_V8_IMM},
    [0xb0] = {"mov",           FMT_V8_V8},
    [0xb3] = {"pitch",         FMT_WV8},
    [0xb4] = {"pitch",         FMT_WV8_PLUS},
    [0xb5] = {"bend",          FMT_WV8},
    [0xb6] = {"volume",        FMT_WV8},
    [0xb7] = {"volume",        FMT_WV8_PLUS},
    [0xb8] = {"bend-volume",   FMT_WV8},
    [0xb9] = {"wait",          FMT_V8},
    [0xba] = {"asl",           FMT_V8},
    [0xbb] = {"lsr",           FMT_V8},
    [0xc1] = {"asr",           FMT_V8},
    [0xc3] = {"ror",           FMT_V8},
    [0xc4] = {"rol",           FMT_V8},
    [0x89] = {"adsr",          FMT_ADSR},
    [0x8a] = {"cmd_8a",        FMT_U8_HEX},
    [0x8c] = {"cmd_8c",        FMT_NONE},
    [0x8f] = {"cmd_8f",        FMT_U16_HEX},
    [0x90] = {"cmd_90",        FMT_U16_HEX},
    [0x93] = {"cmd_93",        FMT_NONE},
    [0x94] = {"cmd_94",        FMT_U8_HEX},
    [0xb1] = {"cmd_b1",        FMT_U8_HEX},
    [0xb2] = {"cmd_b2",        FMT_U8_HEX},
    [0xbc] = {"cmd_bc",        FMT_U8_HEX},
    [0xbd] = {"cmd_bd",        FMT_U8_HEX},
    [0xbe] = {"cmd_be",        FMT_U16_HEX},
    [0xbf] = {"cmd_bf",        FMT_U16_HEX},
    [0xc0] = {"cmd_c0",        FMT_NONE},
    [0xc2] = {"cmd_c2",        FMT_U16_HEX},
    [0xc5] = {"cmd_c5",        FMT_U8_HEX},
    [0xc6] = {"cmd_c6",        FMT_NONE},
    [0xc7] = {"cmd_c7",        FMT_NONE},
    [0xff] = {"",              FMT_PADDING}
};

static uint8_t rd_u8(FILE *f)
{
    uint8_t b;
    file_read(f, &b, 1);
    return b;
}

static uint16_t rd_u16le(FILE *f)
{
    uint8_t b[2];
    file_read(f, b, 2);
    return b[0] | (b[1] << 8);
}

static int decompile(FILE *in, FILE *out)
{
    uint8_t header[2];
    file_read(in, header, 2);
    fprintf(out, "header %02x %02x\n", header[0], header[1]);

    bool indented = false;
    uint8_t op;

    while (file_read(in, &op, 1)) {
        if (op == 0x84) { // End repeat
            if (!indented) {
                fprintf(stderr, "Unexpected end repeat opcode before repeat\n");
                exit(1);
            }
            fprintf(out, "}\n");
            indented = false;
            continue;
        }

        if (indented) {
            fprintf(out, "    ");
        }

        const op_t *opcode = &decompiler_opcodes[op];

        if (!opcode->name) {
            fprintf(stderr, "Illegal opcode %02x\n", op);
            exit(1);
        }

        switch (opcode->fmt) {
            case FMT_NONE:
                fprintf(out, "%s\n", opcode->name);
                break;
            case FMT_REPEAT:
                if (indented) {
                    fprintf(stderr, "Unexpected nested repeat opcode\n");
                    exit(1);
                }
                fprintf(out, "repeat %u {\n", rd_u16le(in));
                indented = true;
                break;
            case FMT_U8_HEX:
                fprintf(out, "%s 0x%x\n", opcode->name, rd_u8(in));
                break;
            case FMT_U8_DEC:
                fprintf(out, "%s %u\n", opcode->name, rd_u8(in));
                break;
            case FMT_U16_HEX:
                fprintf(out, "%s 0x%x\n", opcode->name, rd_u16le(in));
                break;
            case FMT_S16_HEX:
                fprintf(out, "%s ", opcode->name);
                print_s16(out, (int16_t)rd_u16le(in));
                fputc('\n', out);
                break;
            case FMT_U8_U8: {
                uint8_t a = rd_u8(in), b = rd_u8(in);
                fprintf(out, "%s %u, %u\n", opcode->name, a, b);
                break;
            }
            case FMT_S8_S8:
                fprintf(out, "%s ", opcode->name);
                print_s8(out, (int8_t)rd_u8(in));
                fprintf(out, ", ");
                print_s8(out, (int8_t)rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_V8:
                fprintf(out, "%s ", opcode->name);
                print_var(out, rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_WV8:
                fprintf(out, "%s ", opcode->name);
                print_wvar(out, rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_WV8_PLUS:
                fprintf(out, "%s +", opcode->name);
                print_wvar(out, rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_V8_IMM:
                fprintf(out, "%s ", opcode->name);
                print_var(out, rd_u8(in));
                fprintf(out, ", #%u\n", rd_u8(in));
                break;
            case FMT_WV8_IMM:
                fprintf(out, "%s ", opcode->name);
                print_wvar(out, rd_u8(in));
                fprintf(out, ", #%u\n", rd_u8(in));
                break;
            case FMT_V8_IMMHEX:
                fprintf(out, "%s ", opcode->name);
                print_var(out, rd_u8(in));
                fprintf(out, ", #0x%02x\n", rd_u8(in));
                break;
            case FMT_V8_V8:
                fprintf(out, "%s ", opcode->name);
                print_var(out, rd_u8(in));
                fprintf(out, ", ");
                print_var(out, rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_WV8_V8:
                fprintf(out, "%s ", opcode->name);
                print_wvar(out, rd_u8(in));
                fprintf(out, ", ");
                print_var(out, rd_u8(in));
                fputc('\n', out);
                break;
            case FMT_ADSR: {
                uint16_t v = rd_u16le(in);
                uint8_t ar = (v >> 12) & 7;
                uint8_t dr = (v >> 8) & 0xF;
                uint8_t sl = (v >> 5) & 7;
                uint8_t sr = v & 0x1F;
                fprintf(out, "adsr %u, %u, %u, %u\n", ar, dr, sl, sr);
                break;
            }
            case FMT_BRANCH:
                /* Not present in existing data, not supported */
                fprintf(stderr, "Branch opcode %s (%02x) not supported in decompiler\n", opcode->name, op);
                exit(1);
            case FMT_PADDING: {
                uint8_t extra;
                if (file_read(in, &extra, 1)) {
                    fprintf(stderr, "Unexpected padding byte before EOF\n");
                    exit(1);
                }
                goto done;
            }
        }
    }
done:
    return 0;
}

/* Compiler */

static void emit_u8(FILE *f, uint8_t v)
{
    file_write(f, &v, 1);
}

static void emit_u16(FILE *f, uint16_t v)
{
    uint8_t b[2] = {v, v >> 8};
    file_write(f, b, 2);
}

static uint8_t parse_v8(const char *s)
{
    if (s[0] == 'l') return (uint8_t)(atoi(s + 1) * 2);
    if (s[0] == 'h') return (uint8_t)(atoi(s + 1) * 2 + 1);
    fprintf(stderr, "Expected 8-bit variable (l/h), got: %s\n", s);
    exit(1);
}

static uint8_t parse_wv8(const char *s)
{
    if (s[0] == 'w') return (uint8_t)(atoi(s + 1) * 2);
    fprintf(stderr, "Expected 16-bit variable (w), got: %s\n", s);
    exit(1);
}

static bool is_v8_name(const char *s)
{
    return s[0] == 'l' || s[0] == 'h';
}

static bool is_var_name(const char *s)
{
    return is_v8_name(s) || s[0] == 'w';
}

static uint8_t parse_imm(const char *s)
{
    if (s[0] != '#') {
        fprintf(stderr, "Expected immediate value, got %s\n", s);
        exit(1);
    }
    return strtol(s + 1, NULL, 0);
}

static void emit_unary(FILE *out, uint8_t op, const char *s)
{
    emit_u8(out, op);
    emit_u8(out, parse_v8(s));
}

static void emit_binary(FILE *out, uint8_t op_imm, uint8_t op_var, const char *dst, const char *src)
{
    if (!is_v8_name(src)) {
        emit_u8(out, op_imm);
        emit_u8(out, parse_v8(dst));
        emit_u8(out, parse_imm(src));
    }
    else {
        emit_u8(out, op_var);
        emit_u8(out, parse_v8(dst));
        emit_u8(out, parse_v8(src));
    }
}

static void emit_wide_binary(FILE *out, uint8_t op_imm, uint8_t op_var, const char *dst, const char *src)
{
    if (!is_var_name(src)) {
        emit_u8(out, op_imm);
        emit_u8(out, parse_wv8(dst));
        emit_u8(out, parse_imm(src));
    }
    else {
        emit_u8(out, op_var);
        emit_u8(out, parse_wv8(dst));
        emit_u8(out, parse_v8(src));
    }
}

#define MAX_LABELS  64
#define MAX_RELOCATIONS 64

typedef struct {
    char name[64];
    size_t pos;
} label_t;

typedef struct {
    char name[64];
    size_t pos;
} relocation_t;

static void emit_branch(FILE *out, relocation_t *relocations, unsigned *n_relocations, uint8_t op, const char *label_name)
{
    emit_u8(out, op);
    if (*n_relocations >= MAX_RELOCATIONS) {
        fprintf(stderr, "Too many branch relocations\n");
        exit(1);
    }
    if (strlen(label_name) > sizeof(relocations->name) - 1) {
        fprintf(stderr, "Label '%s' too long\n", label_name);
        exit(1);
    }
    strcpy(relocations[*n_relocations].name, label_name);
    relocations[*n_relocations].pos = ftell(out);
    (*n_relocations)++;
    emit_u16(out, 0x00); /* s816 offset placeholder */
}

static const struct {
    const char *name;
    uint8_t op;
} plain_ops[] = {
    {"play",   0x8d},
    {"stop",   0x8e},
    {"end",    0x92},
    {"cmd_8c", 0x8c},
    {"cmd_93", 0x93},
    {"cmd_c0", 0xc0},
    {"cmd_c6", 0xc6},
    {"cmd_c7", 0xc7},
    {NULL, 0}
};

static const struct {
    const char *name;
    uint8_t op;
} u8_ops[] = {
    {"inst",   0x8b},
    {"cmd_8a", 0x8a},
    {"cmd_94", 0x94},
    {"cmd_b1", 0xb1},
    {"cmd_b2", 0xb2},
    {"cmd_bc", 0xbc},
    {"cmd_bd", 0xbd},
    {"cmd_c5", 0xc5},
    {NULL, 0}
};

static const struct {
    const char *name;
    uint8_t op;
} u16_ops[] = {
    {"cmd_8f", 0x8f},
    {"cmd_90", 0x90},
    {"cmd_be", 0xbe},
    {"cmd_bf", 0xbf},
    {"cmd_c2", 0xc2},
    {NULL, 0}
};

static const struct {
    const char *name;
    uint8_t op;
} unary_ops[] = {
    {"not", 0x99},
    {"inc", 0x9d},
    {"dec", 0x9e},
    {"neg", 0x9f},
    {"asl", 0xba},
    {"lsr", 0xbb},
    {"asr", 0xc1},
    {"ror", 0xc3},
    {"rol", 0xc4},
    {NULL, 0}
};

static const struct {
    const char *name;
    uint8_t op_imm;
    uint8_t op_var;
} binary_ops[] = {
    {"add",     0x95, 0xa0},
    {"sub",     0x96, 0xa1},
    {"and",     0x9a, 0xa4},
    {"or",      0x9b, 0xa5},
    {"eor",     0x9c, 0xa6},
    {"cmp",     0xa7, 0xa8},
    {"mov",     0xaf, 0xb0},
    {NULL, }
};

static const struct {
    const char *name;
    uint8_t op_imm;
    uint8_t op_var;
} wide_binary_ops[] = {
    {"mul",     0x97, 0xa2},
    {"div-mod", 0x98, 0xa3},
    {NULL, }
};

static const struct { const char *name; uint8_t op; } branch_ops[] = {
    {"b",   0x85},
    {"beq", 0xa9},
    {"bne", 0xaa},
    {"bpl", 0xab},
    {"bmi", 0xac},
    {"bcc", 0xad},
    {"bcs", 0xae},
    {NULL, }
};

static char *get_arg(void)
{
    char *tok = strtok(NULL, ",");
    if (!tok) return NULL;
    while (isspace(*tok)) {
        tok++;
    }
    if (!*tok) return NULL;
    char *end = tok + strlen(tok);
    while (end > tok && isspace(end[-1])) {
        *--end = 0;  
    } 
    return *tok? tok : NULL;
}

static char *req_arg(const char *cmd)
{
    char *arg = get_arg();
    if (!arg) {
        fprintf(stderr, "compile: %s: too few arguments\n", cmd);
        exit(1);
    }
    for (const char *p = arg; *p; p++) {
        if (isspace(*p)) {
            fprintf(stderr, "compile: %s: arguments must be comma-separated\n", cmd);
            exit(1);
        }
    }
    return arg;
}

static void req_done(const char *cmd)
{
    if (get_arg()) {
        fprintf(stderr, "compile: %s: too many arguments\n", cmd);
        exit(1);
    }
}

static int compile(FILE *in, FILE *out)
{
    label_t labels[MAX_LABELS]; unsigned n_labels = 0;
    relocation_t relocations[MAX_RELOCATIONS];
    unsigned n_relocations = 0;
    bool has_header = false;
    bool in_repeat = false;

    while (!feof(in)) {
        char *line = (char *)file_read_line(in);
        char *comment = strchr(line, ';');
        if (comment) *comment = 0;

        size_t length = strlen(line);
        while (length > 1) {
            if (line[length - 1] == ' ' || line[length - 1] == '\n') {
                line[length - 1] = 0;
                length--;
            }
            else break;
        }
        
        
        /* Check for label definition */
        if (line[length - 1] == ':') {
            line[length - 1] = 0;
            if (n_labels >= MAX_LABELS) {
                fprintf(stderr, "Too many labels\n");
                exit(1);
            }
            if (length - 1 > sizeof(labels[0]) - 1) {
                fprintf(stderr, "Label '%s' too long\n", line);
                exit(1);
            }
            strcpy(labels[n_labels].name, line);
            labels[n_labels].pos = ftell(out);
            if (labels[n_labels].pos == 0) {
                fprintf(stderr, "Missing label\n");
                exit(1);
            }
            n_labels++;
            continue;
        }

        char *token = strtok(line, " \n");
        if (!token) continue;
        
        if (strcmp(token, "header") == 0) {
            if (has_header) {
                fprintf(stderr, "Multiple header commands\n");
                exit(1);
            }
            has_header = true;
            char *b1 = strtok(NULL, " \t");
            char *b2 = strtok(NULL, " \n");
            if (!b1 || !b2) {
                fprintf(stderr, "header: too few arguments\n");
                exit(1);
            }
            if (strtok(NULL, " \n")) {
                fprintf(stderr, "header: too many arguments\n");
                exit(1);
            }
            emit_u8(out, (uint8_t)strtol(b1, NULL, 16));
            emit_u8(out, (uint8_t)strtol(b2, NULL, 16));
            continue;
        }
        
        if (!has_header) {
            fprintf(stderr, "File must begin with a header command\n");
            exit(1);
        }

        for (unsigned i = 0; plain_ops[i].name; i++) {
            if (strcmp(token, plain_ops[i].name) == 0) {
                emit_u8(out, plain_ops[i].op);
                req_done(plain_ops[i].name);
                goto next;
            }
        }
        for (unsigned i = 0; u8_ops[i].name; i++) {
            if (strcmp(token, u8_ops[i].name) == 0) {
                emit_u8(out, u8_ops[i].op);
                emit_u8(out, (uint8_t)strtol(req_arg(u8_ops[i].name), NULL, 0));
                req_done(u8_ops[i].name);
                goto next;
            }
        }
        for (unsigned i = 0; u16_ops[i].name; i++) {
            if (strcmp(token, u16_ops[i].name) == 0) {
                emit_u8(out, u16_ops[i].op);
                emit_u16(out, (uint16_t)strtol(req_arg(u16_ops[i].name), NULL, 0));
                req_done(u16_ops[i].name);
                goto next;
            }
        }
        for (unsigned i = 0; unary_ops[i].name; i++) {
            if (strcmp(token, unary_ops[i].name) == 0) {
                emit_unary(out, unary_ops[i].op, req_arg(unary_ops[i].name));
                req_done(unary_ops[i].name);
                goto next;
            }
        }
        for (unsigned i = 0; binary_ops[i].name; i++) {
            if (strcmp(token, binary_ops[i].name) == 0) {
                char *dst = req_arg(binary_ops[i].name);
                char *src = req_arg(binary_ops[i].name);
                req_done(binary_ops[i].name);
                emit_binary(out, binary_ops[i].op_imm, binary_ops[i].op_var, dst, src);
                goto next;
            }
        }
        for (unsigned i = 0; wide_binary_ops[i].name; i++) {
            if (strcmp(token, wide_binary_ops[i].name) == 0) {
                char *dst = req_arg(wide_binary_ops[i].name);
                char *src = req_arg(wide_binary_ops[i].name);
                req_done(wide_binary_ops[i].name);
                emit_wide_binary(out, wide_binary_ops[i].op_imm, wide_binary_ops[i].op_var, dst, src);
                goto next;
            }
        }
        for (unsigned i = 0; branch_ops[i].name; i++) {
            if (strcmp(token, branch_ops[i].name) == 0) {
                char *label = req_arg(branch_ops[i].name);
                req_done(branch_ops[i].name);
                emit_branch(out, relocations, &n_relocations, branch_ops[i].op, label);
                goto next;
            }
        }


        if (strcmp(token, "pitch") == 0) {
            char *arg = req_arg("pitch");
            if (arg[0] == 'w') {
                emit_u8(out, 0xb3);
                emit_u8(out, parse_wv8(arg));
            }
            else if (arg[0] == '+' && arg[1] == 'w') {
                emit_u8(out, 0xb4);
                emit_u8(out, parse_wv8(arg + 1));
            }
            else if (arg[0] == '+' || arg[0] == '-') {
                emit_u8(out, 0x81);
                emit_u16(out, (uint16_t)(int16_t)strtol(arg, NULL, 0));
            }
            else {
                emit_u8(out, 0x80);
                emit_u16(out, (uint16_t)strtol(arg, NULL, 0));
            }
            req_done("pitch");
        }
        else if (strcmp(token, "volume") == 0) {
            char *arg = req_arg("volume");
            if (arg[0] == 'w') {
                emit_u8(out, 0xb6);
                emit_u8(out, parse_wv8(arg));
            }
            else if (arg[0] == '+' && arg[1] == 'w') {
                emit_u8(out, 0xb7);
                emit_u8(out, parse_wv8(arg + 1));
            }
            else if (arg[0] == '+' || arg[0] == '-') {
                char *b = req_arg("volume");
                emit_u8(out, 0x87);
                emit_u8(out, (uint8_t)(int8_t)strtol(arg, NULL, 0));
                emit_u8(out, (uint8_t)(int8_t)strtol(b, NULL, 0));
            }
            else {
                char *b = req_arg("volume");
                emit_u8(out, 0x86);
                emit_u8(out, (uint8_t)strtol(arg, NULL, 0));
                emit_u8(out, (uint8_t)strtol(b, NULL, 0));
            }
            req_done("volume");
        }
        else if (strcmp(token, "bend") == 0) {
            char *arg = req_arg("bend");
            if (arg[0] == '+' || arg[0] == '-') {
                emit_u8(out, 0x82);
                emit_u16(out, (uint16_t)(int16_t)strtol(arg, NULL, 0));
            }
            else {
                emit_u8(out, 0xb5);
                emit_u8(out, parse_wv8(arg));
            }
            req_done("bend");
        }
        else if (strcmp(token, "bend-volume") == 0) {
            char *arg = req_arg("bend-volume");
            if (arg[0] == '+' || arg[0] == '-') {
                char *arg2 = req_arg("bend-volume");
                emit_u8(out, 0x88);
                emit_u8(out, (uint8_t)(int8_t)strtol(arg, NULL, 0));
                emit_u8(out, (uint8_t)(int8_t)strtol(arg2, NULL, 0));
            }
            else {
                emit_u8(out, 0xb8);
                emit_u8(out, parse_wv8(arg));
            }
            req_done("bend-volume");
        }
        else if (strcmp(token, "repeat") == 0) {
            if (in_repeat) {
                fprintf(stderr, "Nested repeats are not allowed\n");
                exit(1);
            }
            char *count_tok = strtok(NULL, " \t");
            if (!count_tok) {
                fprintf(stderr, "repeat: missing count\n");
                exit(1);
            }
            uint16_t count = (uint16_t)strtol(count_tok, NULL, 0);
            char *brace = strtok(NULL, " \n");
            if (!brace || strcmp(brace, "{") != 0) {
                fprintf(stderr, "repeat: expected '{'\n");
                exit(1);
            }
            if (strtok(NULL, " \n")) {
                fprintf(stderr, "repeat: unexpected token after '{'\n");
                exit(1);
            }
            in_repeat = true;
            emit_u8(out, 0x83);
            emit_u16(out, count);
        }
        else if (strcmp(token, "}") == 0) {
            if (!in_repeat){ 
                fprintf(stderr, "Unexpected {\n");
                exit(1);
            }
            req_done("}");
            in_repeat = false;
            emit_u8(out, 0x84);
        }
        else if (strcmp(token, "wait") == 0) {
            char *arg = req_arg("wait");
            if (is_v8_name(arg)) {
                emit_u8(out, 0xb9);
                emit_u8(out, parse_v8(arg));
            }
            else {
                emit_u8(out, 0x91);
                emit_u8(out, (uint8_t)strtol(arg, NULL, 0));
            }
            req_done("wait");
        }
        else if (strcmp(token, "adsr") == 0) {
            uint8_t ar = (uint8_t)strtol(req_arg("adsr"), NULL, 0);
            uint8_t dr = (uint8_t)strtol(req_arg("adsr"), NULL, 0);
            uint8_t sl = (uint8_t)strtol(req_arg("adsr"), NULL, 0);
            uint8_t sr = (uint8_t)strtol(req_arg("adsr"), NULL, 0);
            req_done("adsr");
            emit_u8(out, 0x89);
            emit_u8(out, (sl << 5) | sr);
            emit_u8(out, 0x80 | (ar << 4) | dr); // Always enabled
        }
        else {
            fprintf(stderr, "Unknown command: %s\n", token);
            return 1;
        }
    next:;
    }

    /* Resolve branch relocations */
    for (unsigned i = 0; i < n_relocations; i++) {
        int found = -1;
        for (unsigned j = 0; j < n_labels; j++) {
            if (strcmp(relocations[i].name, labels[j].name) == 0) {
                found = j;
                break;
            }
        }
        if (found < 0) {
            fprintf(stderr, "Undefined label: %s\n", relocations[i].name);
            exit(1);
        }
        signed offset = (signed)labels[found].pos - (signed)(relocations[i].pos + 2);
        fseek(out, relocations[i].pos, SEEK_SET);
        emit_u16(out, offset);
        fseek(out, 0, SEEK_END);
    }

    /* Pad to even size */
    if (ftell(out) & 1) {
        emit_u8(out, 0xFF);
    }

    return 0;
}

int main(int argc, const char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s compile|decompile in out\n", argv[0]);
        return 1;
    }
    if (strcmp(argv[1], "decompile") == 0) {
        if (argc != 4) {
            fprintf(stderr, "Usage: %s decompile in out\n", argv[0]);
            return 1;
        }
        FILE *in  = file_open(argv[2], "r");
        FILE *out = file_open(argv[3], "w");
        int ret = decompile(in, out);
        fclose(in);
        fclose(out);
        if (ret) unlink(argv[3]);
        return ret;
    }
    if (strcmp(argv[1], "compile") == 0) {
        if (argc != 4) {
            fprintf(stderr, "Usage: %s compile in out\n", argv[0]);
            return 1;
        }
        FILE *in  = file_open(argv[2], "r");
        FILE *out = file_open(argv[3], "w");
        int ret = compile(in, out);
        fclose(in);
        fclose(out);
        if (ret) unlink(argv[3]);
        return ret;
    }
    fprintf(stderr, "%s %s: No such command\n", argv[0], argv[1]);
    return 1;
}
