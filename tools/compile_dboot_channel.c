#include "fileio.h"
#include <unistd.h>
#include <ctype.h>

static uint8_t *decompress(FILE *f, size_t *size, bool *compressed)
{
    uint16_t decompressed_size = 0;
    file_read(f, &decompressed_size, sizeof(decompressed_size));
    decompressed_size = ntohs(decompressed_size);
    
    if (decompressed_size == 0) { // Not compressed
        fseek(f, 0, SEEK_END);
        *size = ftell(f) - 2;
        fseek(f, 2, SEEK_SET);
        uint8_t *ret = malloc(*size);
        file_read(f, ret, *size);
        *compressed = false;
        return ret;
    }
    *compressed = true;
    
    *size = decompressed_size;
    uint8_t *ret = malloc(*size);
    
    size_t pos = 0;
    while (pos < *size) {
        uint8_t bits;
        file_read(f, &bits, sizeof(bits));
        
        for (unsigned i = 8; i--;) {
            if (bits & 0x80) {
                uint8_t byte;
                file_read(f, &byte, sizeof(byte));
                uint8_t length = (byte >> 5) + 3;
                uint8_t offset = (byte & 0x1F) + 1;
                if (offset > pos) {
                    fprintf(stderr, "Malformed compression\n");
                    abort();
                }
                while (length) {
                    ret[pos] = ret[pos - offset];
                    pos++;
                    length--;
                    if (pos == *size) return ret;
                }
            }
            else {
                file_read(f, ret + pos, sizeof(*ret));
                pos++;
                if (pos == *size) return ret;
            }
            bits <<= 1;
        }
    }
    return ret;
}

#define WINDOW_SIZE 0x20
#define LOOKAHEAD_SIZE 10

typedef struct {
    uint8_t data[WINDOW_SIZE];
    size_t length;
} window_t;

static void window_push(window_t *window, uint8_t byte) {
    if (window->length < WINDOW_SIZE) {
        window->data[window->length++] = byte;
    }
    else {
        memmove(window->data, window->data + 1, WINDOW_SIZE - 1);
        window->data[WINDOW_SIZE - 1] = byte;
    }
}

static void find_match(window_t *window, uint8_t *lookahead, size_t lookahead_len,
                       size_t *best_offset, size_t *best_length)
{
    *best_length = 0;
    if (!window->length) return;
    
    for (size_t start = 0; start < window->length; start++) {
        size_t pos = start, length = 0;
        
        while (length < lookahead_len && window->data[pos] == lookahead[length]) {
            length++;
            pos++;
            if (pos == window->length) pos = start;
        }
        
        if (length > *best_length) {
            *best_length = length;
            *best_offset = start;
            if (length == lookahead_len) return;
        }
    }
}

static void compress(FILE *in, FILE *out)
{
    fseek(in, 0, SEEK_END);
    uint16_t input_size = (uint16_t)ftell(in);
    fseek(in, 0, SEEK_SET);
    
    uint8_t header[2] = { input_size >> 8, input_size & 0xFF };
    file_write(out, header, 2);
    
    window_t window = {0, };
    uint8_t lookahead[LOOKAHEAD_SIZE];
    size_t lookahead_len = fread(lookahead, 1, LOOKAHEAD_SIZE, in);
        
    while (lookahead_len > 0) {
        uint8_t flags = 0;
        uint8_t chunk[16];
        size_t chunk_len = 0;
        
        for (unsigned i = 0; i < 8; i++) {
            if (!lookahead_len) {
                flags <<= 8 - i;
                break;
            }
            
            size_t offset = 0, length = 0;
            find_match(&window, lookahead, lookahead_len, &offset, &length);
            
            if (length >= 3) {
                uint8_t encoded = ((length - 3) << 5) | (window.length - offset - 1);
                
                flags <<= 1;
                flags |= 1;
                chunk[chunk_len++] = encoded;
                
                for (unsigned j = 0; j < length; j++) {
                    window_push(&window, lookahead[j]);
                }
                memmove(lookahead, lookahead + length, lookahead_len - length);
                lookahead_len -= length;
                lookahead_len += fread(lookahead + lookahead_len, 1, length, in);
            }
            else {
                flags <<= 1;
                chunk[chunk_len++] = lookahead[0];
                window_push(&window, lookahead[0]);
                memmove(lookahead, lookahead + 1, lookahead_len - 1);
                if (!file_read(in, &lookahead[lookahead_len - 1], 1)) {
                    lookahead_len--;
                }
            }
        }
        
        file_write(out, &flags, 1);
        file_write(out, chunk, chunk_len);
    }
}

void append_string(char **dest, const char *append)
{
    if (!*dest) {
        *dest = strdup(append);
        return;
    }
    *dest = realloc(*dest, strlen(*dest) + strlen(append) + 1);
    strcat(*dest, append);
}

static unsigned relative_note(unsigned note, uint8_t relative)
{
    if (relative > 0xF) {
        return note - 1 - (relative ^ 0x1F);
    }
    return note + relative;
}

static void decompile(FILE *in, FILE *out, bool mpt_format)
{
    size_t size;
    bool compressed;
    uint8_t *data = decompress(in, &size, &compressed);
    void *data_start = data;
    
    if (compressed && !mpt_format) {
        fprintf(out, "#compressed\n");
        uint8_t byte = 0;
        if (file_read(in, &byte, sizeof(byte))) {
            /* The original compression output a single junk byte if the compressed data size is divisible by 9.
               It's probably some uninitialized memory from the original compressor, so we need to write it down
               to reproduce it. */
            fprintf(out, "#junk-byte %02x\n", byte);
        }
    }
    if (mpt_format) {
        fprintf(out, "ModPlug Tracker  IT\n");
    }
    
#define MAX_POLY 8
    
    struct {
        unsigned playing_note;
        unsigned vol_range;
    } state[MAX_POLY];
    
    for (unsigned i = 0; i < MAX_POLY; i++) {
        state[i].playing_note = -1;
    }
    
    typedef struct {
        struct {
            char bar;
            char note[3];
            char instrument[2];
            char v;
            char volume[2];
            char command[3];
        } subchannels[MAX_POLY];
    } mpt_line;
    
    typedef struct {
        char volume[2];
        struct {
            char bar;
            char note[3];
            char command;
            char v;
            char vol_range;
        } subchannels[MAX_POLY];
    } native_line;
    
    struct line {
        struct line *next;
        union {
            mpt_line mpt;
            native_line native;
        };
        bool joint_line;
        char *prefix;
        unsigned halts;
    } *lines = NULL, *last = NULL, *bend_pause_line = NULL;
    
    
    const char *empty = mpt_format?
    "|...........|...........|...........|...........|...........|...........|...........|..........." :
    "..|......|......|......|......|......|......|......|......";
    
    lines = last = calloc(sizeof(*last), 1);
    memcpy(&last->mpt, empty, sizeof(last->mpt));

    
    unsigned last_note = -1;
    unsigned last_step = 0;
    unsigned previous_step = 0;
    signed last_bend = 0;
    unsigned steps = 0;
    unsigned used_subchannels = 0;
    unsigned mpt_volume = 127;
    unsigned mpt_effective_volume = 64;
    unsigned vol_range = 0;
    unsigned mpt_inst = 0;

    static const char *note[] = {
        "C-", "C#", "D-", "D#", "E-", "F-", "F#", "G-", "G#", "A-", "A#", "B-"
    };
    
    static const char hex_digits[] = "0123456789ABCDEF";
    
    unsigned channel_order[MAX_POLY] = {0, 1, 2, 3, 4, 5, 6, 7};
    unsigned stopped_notes = 0;
    unsigned last_subchannel_played = 0;
    unsigned last_subchannel_stopped = 0;
    
    while (size) {
        uint8_t command = *(data++);
        size--;
        
        if ((command >> 5) != 2 && command != 0xD7) {
            previous_step = 0;
        }
        else if (previous_step != 32 && previous_step != 255 && previous_step != 0) {
            append_string(&last->prefix, "#nop\n");
        }
        
        switch (command >> 5) {
            case 0: { // play note, relative
                bend_pause_line = NULL;
                last_note = relative_note(last_note, command & 0x1f);
                play_far:;
                bool retry = false;
                retry:;
                unsigned subchannel = 0;
                for (; subchannel < MAX_POLY; subchannel++) {
                    if (channel_order[subchannel] < last_subchannel_played) continue; // Must play in order
                    if (state[channel_order[subchannel]].playing_note == -1) {
                        break;
                    }
                }
                if (subchannel == MAX_POLY) {
                    if (retry || mpt_format) {
                        fprintf(stderr, "Reached maximum polyphony\n");
                        abort();
                    }
                    retry = true;
                    last->next = calloc(sizeof(*last), 1);
                    last = last->next;
                    memcpy(&last->mpt, empty, sizeof(last->mpt));
                    last->joint_line = true;
                    for (unsigned i = 0; i < MAX_POLY; i++) {
                        channel_order[i] = i;
                    }
                    stopped_notes = 0;
                    last_subchannel_stopped = 0;
                    last_subchannel_played = 0;
                    goto retry;
                }
                
                subchannel = channel_order[subchannel];
                if (subchannel > last_subchannel_played) {
                    last_subchannel_played = subchannel;
                }
                
                if (subchannel + 1 > used_subchannels) {
                    used_subchannels = subchannel + 1;
                }
                state[subchannel].playing_note = last_note;
                state[subchannel].vol_range = vol_range;
                if (mpt_format) {
                    memcpy(last->mpt.subchannels[subchannel].note, note[last_note % 12], 2);
                    last->mpt.subchannels[subchannel].note[2] = '0' + last_note / 12;
                    
                    last->mpt.subchannels[subchannel].v = 'v';
                    last->mpt.subchannels[subchannel].volume[0] = '0' + mpt_effective_volume / 10;
                    last->mpt.subchannels[subchannel].volume[1] = '0' + mpt_effective_volume % 10;
                    
                    last->mpt.subchannels[subchannel].instrument[0] = '0' + mpt_inst / 10;
                    last->mpt.subchannels[subchannel].instrument[1] = '0' + mpt_inst % 10;

                }
                else {
                    memcpy(last->native.subchannels[subchannel].note, note[last_note % 12], 2);
                    last->native.subchannels[subchannel].note[2] = '0' + last_note / 12;
                    last->native.subchannels[subchannel].v = 'v';
                    last->native.subchannels[subchannel].vol_range = '0' + vol_range;
                }
                break;
            }
            case 1: { // stop note, relative
                bend_pause_line = NULL;
                last_note = relative_note(last_note, command & 0x1f);
                stop_last_note:;
                unsigned subchannel = 0;
                for (; subchannel < MAX_POLY; subchannel++) {
                    if (state[subchannel].playing_note == last_note) {
                        break;
                    }
                }
                if (subchannel == MAX_POLY) {
                    fprintf(stderr, "Attempt to stop a non-playing note\n");
                    abort();
                }
                state[subchannel].playing_note = -1;
                if (!mpt_format && subchannel < last_subchannel_stopped) {
                    last->next = malloc(sizeof(*last));
                    last = last->next;
                    last->next = NULL;
                    memcpy(&last->mpt, empty, sizeof(last->mpt));
                    last->prefix = NULL;
                    last->joint_line = true;
                    last->halts = 0;
                    for (unsigned i = 0; i < MAX_POLY; i++) {
                        channel_order[i] = i;
                    }
                    stopped_notes = 0;
                    last_subchannel_stopped = 0;
                    last_subchannel_played = 0;
                }
                if (mpt_format) {
                    memcpy(last->mpt.subchannels[subchannel].note, "===", 3);
                }
                else {
                    if (last->native.subchannels[subchannel].note[0] != '.') {
                        last->native.subchannels[subchannel].command = 'S';
                    }
                    else {
                        memcpy(last->native.subchannels[subchannel].note, "===", 3);
                    }
                }
                last_subchannel_stopped = subchannel;
                
                if (!mpt_format) {
                    for (unsigned i = MAX_POLY - 1; i > stopped_notes; i--) {
                        if (channel_order[i] == subchannel) {
                            channel_order[i] = channel_order[i - 1];
                            channel_order[i - 1] = subchannel;
                        }
                    }
                }
                stopped_notes++;
                
                break;
            }
            case 3: { // step (inline), stop last note
            case 2:   // step
                if (memcmp(&last->native, empty, sizeof(last->native)) == 0) {
                    bend_pause_line = last;
                }
                else {
                    bend_pause_line = NULL;
                }
                steps = (command & 0x1F) + 1;
                if ((command >> 5) == 2) {
                    last_step = steps;
                    previous_step = steps;
                }
                step:;
                while (steps--) {
                    last->next = calloc(sizeof(*last), 1);
                    last = last->next;
                    memcpy(&last->mpt, empty, sizeof(last->mpt));
                }
                
                for (unsigned i = 0; i < MAX_POLY; i++) {
                    channel_order[i] = i;
                }
                stopped_notes = 0;
                last_subchannel_played = 0;
                last_subchannel_stopped = 0;

                if ((command >> 5) == 3 || (command >> 5) == 4) {
                    goto stop_last_note;
                }
                if ((command >> 5) == 7) {
                    goto bend;
                }
                break;
            }
            case 4: // step (last length), stop note, relative
                last_note = relative_note(last_note, command & 0x1f);
                steps = last_step;
                goto step;
            case 5: { // bend
                bend:;
                if (mpt_format) {
                    fprintf(stderr, "TODO: bend commands not implemented in OpenMPT conversion\n");
                    break;
                }
                last_bend = relative_note(last_bend, command & 0x1f);
                bend_far:;
                unsigned subchannel = 0;
                for (; subchannel < MAX_POLY; subchannel++) {
                    if (last->native.subchannels[subchannel].note[0] == '.') {
                        break;
                    }
                }
                if (subchannel == MAX_POLY) {
                    fprintf(stderr, "Reached maximum polyphony\n");
                    abort();
                }
                if (subchannel + 1 > used_subchannels) {
                    used_subchannels = subchannel + 1;
                }
                if (last_bend >= 0) {
                    last->native.subchannels[subchannel].note[0] = '+';
                }
                else {
                    last->native.subchannels[subchannel].note[0] = '-';
                }
                unsigned abs_bend = abs(last_bend);
                last->native.subchannels[subchannel].note[1] = hex_digits[abs_bend >> 4];
                last->native.subchannels[subchannel].note[2] = hex_digits[abs_bend & 0xF];
                last->native.subchannels[subchannel].command = 'B';
                if (bend_pause_line) {
                    append_string(&bend_pause_line->prefix, "#bend-start\n");
                    bend_pause_line = NULL;
                }
                break;
            }
            case 7:   // step (last length), bend (relative)
                bend_pause_line = NULL;
                last_note = relative_note(last_note, command & 0x1f);
                steps = last_step;
                append_string(&last->prefix, "#bend-start\n");
                goto step;
            case 6: { // extended command
#define JOIN_IF_NON_EMPTY \
if (!mpt_format && memcmp(&last->native, empty, sizeof(last->native)) != 0) { \
    last->next = malloc(sizeof(*last)); \
    last = last->next; \
    last->next = NULL; \
    memcpy(&last->mpt, empty, sizeof(last->mpt)); \
    last->prefix = NULL; \
    last->joint_line = true; \
    last->halts = 0; \
} \

                char temp[16];
                switch (command & 0x1F) {
                    case 1: { // set song
                        if (!size) goto missing_imm;
                        uint8_t song = *(data++);
                        size--;
                        sprintf(temp, "#song %d\n", song);
                        append_string(&last->prefix, temp);
                        if (mpt_format) {
                            fprintf(stderr, "TODO: song commands not implemented in OpenMPT conversion\n");
                        }
                        break;
                    }
                    case 2: { // set volume
                        if (!size) goto missing_imm;
                        uint8_t volume = *(data++);
                        size--;
                        if (mpt_format) {
                            mpt_volume = volume;
                            mpt_effective_volume = (mpt_volume + 1) * vol_range / 6;
                            if (mpt_effective_volume > 64) mpt_effective_volume = 64;
                            for (unsigned i = 0; i < MAX_POLY; i++) {
                                if (state[i].playing_note != -1) {
                                    last->mpt.subchannels[i].v = 'v';
                                    last->mpt.subchannels[i].volume[0] = '0' + mpt_effective_volume / 10;
                                    last->mpt.subchannels[i].volume[1] = '0' + mpt_effective_volume % 10;
                                }
                            }
                        }
                        else {
                            JOIN_IF_NON_EMPTY
                            if (lines == last || last->prefix) {
                                sprintf(temp, "#volume %02x\n", volume);
                                append_string(&last->prefix, temp);
                            }
                            else {
                                last->native.volume[0] = hex_digits[volume >> 4];
                                last->native.volume[1] = hex_digits[volume & 0xF];
                            }
                        }
                        break;
                    }
                    case 3: { // set pan
                        if (!size) goto missing_imm;
                        uint8_t pan = *(data++);
                        size--;
                        if (mpt_format) {
                            fprintf(stderr, "TODO: pan commands not implemented in OpenMPT conversion\n");
                        }
                        else {
                            sprintf(temp, "#pan %d\n", pan);
                            JOIN_IF_NON_EMPTY
                            append_string(&last->prefix, temp);
                        }
                        break;
                    }
                    case 6: { // unknown
                        if (!size) goto missing_imm;
                        uint8_t imm = *(data++);
                        size--;
                        sprintf(temp, "#unk6 %d\n", imm);
                        JOIN_IF_NON_EMPTY
                        append_string(&last->prefix, temp);
                        break;
                    }
                    case 0xa: { // set instrument
                        if (!size) goto missing_imm;
                        uint8_t inst = *(data++);
                        size--;
                        if (mpt_format) {
                            mpt_inst = inst;
                            for (unsigned i = 0; i < MAX_POLY; i++) {
                                if (state[i].playing_note != -1) {
                                    last->mpt.subchannels[i].instrument[0] = '0' + mpt_inst / 10;
                                    last->mpt.subchannels[i].instrument[1] = '0' + mpt_inst % 10;
                                }
                            }
                        }
                        else {
                            sprintf(temp, "#inst %d\n", inst);
                            JOIN_IF_NON_EMPTY
                            append_string(&last->prefix, temp);
                        }
                        break;
                    }
                    case 0xb: { // set tempo
                        if (!size) goto missing_imm;
                        uint8_t tempo = *(data++);
                        size--;
                        sprintf(temp, "#tempo %d\n", tempo);
                        JOIN_IF_NON_EMPTY
                        append_string(&last->prefix, temp);
                        if (mpt_format) {
                            fprintf(stderr, "TODO: tempo commands not implemented in OpenMPT conversion\n");
                        }
                        break;
                    }
                    case 0x0c: {
                        JOIN_IF_NON_EMPTY
                        append_string(&last->prefix, "#unkc\n");
                        break;
                    }
                    case 0x0d: {
                        last->halts++;
                        break;
                    }
                    case 0x0f: { // track
                        if (!size) goto missing_imm;
                        uint8_t imm = *(data++);
                        size--;
                        sprintf(temp, "#track %d\n", imm);
                        append_string(&last->prefix, temp);
                        break;
                    }
                    case 0x10: { // play far
                        if (!size) goto missing_imm;
                        last_note = *(data++);
                        size--;
                        goto play_far;
                    }
                    case 0x11: { // stop far
                        if (!size) goto missing_imm;
                        last_note =*(data++);
                        size--;
                        goto stop_last_note;
                    }
                    case 0x13: { // step, stop far
                        if (!size) goto missing_imm;
                        last_note = *(data++);
                        size--;
                        command = (3 << 5);
                        steps = last_step;
                        goto step;
                    }
                    case 0x14: { // bend far
                        if (!size) goto missing_imm;
                        last_bend = *(data++) - 0x40;
                        size--;
                        goto bend_far;
                    }
                    case 0x15: {
                        append_string(&last->prefix, "#unk15\n");
                    }
                    case 0x16: { // step, bend far
                        if (!size) goto missing_imm;
                        last_bend = *(data++) - 0x40;
                        size--;
                        command = (7 << 5);
                        steps = last_step;
                        append_string(&last->prefix, "#bend-start\n");
                        goto step;
                    }
                    case 0x17: { // step 255
                        steps = 255;
                        previous_step = 255;
                        goto step;
                    }
                    case 0x18:
                    case 0x19:
                    case 0x1a:
                    case 0x1b: { // vol range
                        vol_range = command & 3;
                        break;
                    }
                    default:
                        fprintf(stderr, "Unrecognized command: %x\n", command);
                        abort();
                }
                bend_pause_line = NULL;
                break;
            }
        }
    }
    while (lines) {
        if (!mpt_format && lines->joint_line) {
            fputs("#join\n", out);
        }
        
        if (!lines->halts && lines->prefix) {
            if (!mpt_format) {
                fputs(lines->prefix, out);
            }
            free(lines->prefix);
        }
        
        if (mpt_format) {
            file_write(out, &lines->mpt, used_subchannels * 12);
        }
        else {
            file_write(out, &lines->native, used_subchannels * 7 + 2);
        }
        fputc('\n', out);
        
        if (lines->halts && lines->prefix) {
            if (!mpt_format) {
                fputs("#join\n", out);
                fputs(lines->prefix, out);
            }
            free(lines->prefix);
        }
        
        while (lines->halts--) {
            fputs("#halt\n", out);
        }
        
        void *next = lines->next;
        free(lines);
        lines = next;
    }
    free(data_start);
    return;

    missing_imm:
        fprintf(stderr, "Missing command immidiate\n");
        abort();
}

static unsigned parse_hex(char h)
{
    if (h >= '0' && h <= '9') return h - '0';
    if (h >= 'A' && h <= 'F') return h - 'A' + 10;
    if (h >= 'a' && h <= 'f') return h - 'a' + 10;
    fprintf(stderr, "Invalid hex character %c\n", h);
    abort();
}

static void output_steps(FILE *out, unsigned *steps, unsigned *last_step, bool skip_remainder, bool is_bend)
{
    while (*steps >= 255) {
        fputc((6 << 5) | 0x17, out);
        *steps -= 255;
    }
    
    while (*steps > 32 - is_bend) { // It's >= is bend due to a bug in the original encoder
        fputc((2 << 5) | 0x1F, out);
        *steps -= 32;
        *last_step = 32;
    }
    
    if (skip_remainder) return;
    
    if (*steps) {
        fputc((2 << 5) | (*steps - 1), out);
        *last_step = *steps;
        *steps = 0;
    }
}

static void compile(FILE *in, FILE *out)
{
    uint16_t size_placeholder = 0;
    file_write(out, &size_placeholder, sizeof(size_placeholder));
    union {
        struct {
            char volume[2];
            struct {
                char bar;
                char note[3];
                char command;
                char v;
                char vol_range;
            } subchannels[MAX_POLY];
            char newline;
            char null;
        };
        char string[1];
    } line;
    
    static const char empty[] = "..|......|......|......|......|......|......|......|......";
    bool compressed = false;
    FILE *compressed_out = NULL;
    
    unsigned steps = 0;
    unsigned last_step = 0;
    unsigned last_bend = 0xffff;

    struct {
        unsigned playing_note;
        unsigned vol_range;
    } state[MAX_POLY];
    
    for (unsigned i = 0; i < MAX_POLY; i++) {
        state[i].playing_note = -1;
    }
    
    unsigned last_note = 0xffff;
    unsigned vol_range = 0;
    
    uint8_t junk_byte = 0;
    bool has_junk = false;

    while (strcpy((char *)&line, empty), fgets(line.string, sizeof(line), in)) {
        if (line.string[0] == '#') {
            if (strcmp(line.string, "#compressed\n") == 0) {
                if (compressed) continue;
                compressed = true;
                compressed_out = out;
                out = tmpfile();
                continue;
            }
            if (strcmp(line.string, "#unkc\n") == 0) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0xC, out);
                continue;
            }
            if (strcmp(line.string, "#nop\n") == 0) {
                output_steps(out, &steps, &last_step, false, false);
                continue;
            }
            if (strcmp(line.string, "#bend-start\n") == 0) {
                if (last_step != steps) {
                    output_steps(out, &steps, &last_step, false, false);
                }
                continue;
            }
            if (strcmp(line.string, "#join\n") == 0) {
                if (steps) {
                    steps--;
                }
                continue;
            }
            if (strcmp(line.string, "#halt\n") == 0) {
                if (steps) {
                    steps--;
                    output_steps(out, &steps, &last_step, false, false);
                    steps++;
                }
                fputc((6 << 5) | 0xD, out);
                continue;
            }
            if (strcmp(line.string, "#unk15\n") == 0) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0x15, out);
                continue;
            }
            unsigned imm = 0;
            if (sscanf(line.string, "#song %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0x1, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#unk6 %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0x6, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#inst %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0xa, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#tempo %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0xb, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#track %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0xf, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#pan %u\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0x3, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#volume %02x\n", &imm) == 1) {
                output_steps(out, &steps, &last_step, false, false);
                fputc((6 << 5) | 0x2, out);
                fputc(imm, out);
                continue;
            }
            if (sscanf(line.string, "#junk-byte %02hhx\n", &junk_byte) == 1) {
                has_junk = true;
                continue;
            }
            fprintf(stderr, "Unsupported directive: %s", line.string);
            abort();
        }
        
        if (line.volume[0] != '.') {
            output_steps(out, &steps, &last_step, false, false);
            fputc((6 << 5) | 0x2, out);
            fputc((parse_hex(line.volume[0]) << 4) | parse_hex(line.volume[1]), out);
        }
        
        bool did_stop_a_note = false;
        bool did_play_notes = false;
        for (unsigned pass = 0; pass < 2; pass++) {
            for (unsigned i = 0; i < MAX_POLY; i++) {
                unsigned note_to_stop = state[i].playing_note;
                if (note_to_stop == -1) continue;
                if (line.subchannels[i].note[2] == '.') continue;
                if (pass == 0) {
                    // First pass, ignore explicit stops
                    if (line.subchannels[i].note[2] == '=') continue;
                }
                else {
                    // Second pass, handle explicit stops (after handling plays)
                    if (line.subchannels[i].note[2] != '=' && line.subchannels[i].command != 'S') continue;
                }
                did_stop_a_note = true;

                // Output steps > 32
                output_steps(out, &steps, &last_step, true, false);
                
                signed relative = note_to_stop - last_note;
                last_note = note_to_stop;
                bool is_relative = relative < 0x10 && relative >= -0x10;
                
                state[i].playing_note = -1;
                
                // Stop, depending on steps and note distance
                if (!steps) {
                no_steps:
                    if (is_relative) {
                        // Stop relative
                        fputc((1 << 5) | (relative & 0x1F), out);
                    }
                    else {
                        // Stop far
                        fputc((6 << 5) | 0x11, out);
                        fputc(note_to_stop, out);
                    }
                }
                else if (steps == last_step) {
                    if (is_relative) {
                        // step (last length), stop note, relative
                        fputc((4 << 5) | (relative & 0x1F), out);
                        steps = 0;
                    }
                    else {
                        // Step (last legnth), stop far
                        fputc((6 << 5) | 0x13, out);
                        fputc(note_to_stop, out);
                        steps = 0;
                    }
                }
                else if (relative == 0) {
                    // step (inline), stop last note
                    fputc((3 << 5) | (steps - 1), out);
                    steps = 0;
                }
                else {
                    output_steps(out, &steps, &last_step, false, false);
                    goto no_steps;
                }
            }
            
            if (pass == 0 && did_stop_a_note) continue;
            if (did_play_notes) continue;
            did_play_notes = true;
            
            for (unsigned i = 0; i < MAX_POLY; i++) {
                if (line.subchannels[i].note[2] == '.') continue;
                if (line.subchannels[i].note[2] == '=') continue;
                if (line.subchannels[i].command == 'B') continue;
                                
                output_steps(out, &steps, &last_step, false, false);
                
                unsigned note_to_play = 12 * parse_hex(line.subchannels[i].note[2]);
                if (line.subchannels[i].note[1] == '#') note_to_play++;
                if (line.subchannels[i].note[1] == 'b') note_to_play--;
                
                static const unsigned scale[] = {9, 11, 0, 2, 4, 5, 7};
                if ((unsigned)toupper(line.subchannels[i].note[0]) - 'A' > 6) {
                    fprintf(stderr, "Invalid note %c%c%c\n", line.subchannels[i].note[0], line.subchannels[i].note[1], line.subchannels[i].note[2]);
                    abort();
                }
                
                note_to_play += scale[toupper(line.subchannels[i].note[0]) - 'A'];
                
                state[i].playing_note = note_to_play;
                unsigned subchannel_vol_range = state[i].vol_range;
                if (line.subchannels[i].v == 'v') {
                    if (line.subchannels[i].vol_range < '0' || line.subchannels[i].vol_range > '3') {
                        fprintf(stderr, "Invalid volume range %c\n", line.subchannels[i].vol_range);
                        abort();
                    }
                    subchannel_vol_range = line.subchannels[i].vol_range - '0';
                    state[i].vol_range = subchannel_vol_range;
                }
                if (subchannel_vol_range != vol_range) {
                    output_steps(out, &steps, &last_step, false, false);
                    fputc(((6 << 5) | 0x18) + subchannel_vol_range, out);
                    vol_range = subchannel_vol_range;
                }
                
                signed relative = note_to_play - last_note;
                last_note = note_to_play;
                bool is_relative = relative < 0x10 && relative >= -0x10;
                
                if (is_relative) {
                    // play relative
                    fputc((0 << 5) | (relative & 0x1F), out);
                }
                else {
                    fputc((6 << 5) | 0x10, out);
                    fputc(note_to_play, out);
                }
            }
        }
        
        for (unsigned i = 0; i < MAX_POLY; i++) {
            if (line.subchannels[i].command != 'B') continue;

            output_steps(out, &steps, &last_step, true, true);
            
            unsigned new_bend = parse_hex(line.subchannels[i].note[2]) + parse_hex(line.subchannels[i].note[1]) * 0x10;
            if (line.subchannels[i].note[0] == '+') {
                new_bend += 0x40;
            }
            else if (line.subchannels[i].note[0] == '-') {
                new_bend = 0x40 - new_bend;
            }
            
            
            signed relative = new_bend - last_bend;
            last_bend = new_bend;
            bool is_relative = relative < 0x10 && relative >= -0x10;
            
            if (is_relative) {
                // bend relative
                if (steps == last_step) {
                    fputc((7 << 5) | (relative & 0x1F), out);
                    steps = 0;
                }
                else {
                    output_steps(out, &steps, &last_step, false, false);
                    fputc((5 << 5) | (relative & 0x1F), out);
                }
            }
            else {
                // bend far
                if (steps == last_step) {
                    fputc((6 << 5) | 0x16, out);
                    fputc(new_bend, out);
                    steps = 0;
                }
                else {
                    output_steps(out, &steps, &last_step, false, false);
                    fputc((6 << 5) | 0x14, out);
                    fputc(new_bend, out);
                }
            }
        }
        
        steps++;
    }
    
    if (compressed) {
        fseek(out, 0, SEEK_SET);
        fseek(compressed_out, 0, SEEK_SET);
        compress(out, compressed_out);
        if (has_junk) {
            file_write(compressed_out, &junk_byte, 1);
        }
        fclose(out);
    }
}

int main(int argc, char **argv)
{
    if (argc != 4) {
        fprintf(stderr, "Usage: %s (encode|decode|decode-mpt) INPUT OUTPUT\n", argv[0]);
        return 1;
    }
    
    if (strcmp(argv[1], "encode") == 0) {

        FILE *input = file_open(argv[2], "r");
        FILE *output = file_open(argv[3], "wb");
        compile(input, output);
        fclose(input);
        fclose(output);
        return 0;
    }
    else if (strcmp(argv[1], "decode") == 0) {
        printf("%s\n", argv[2]);
        FILE *input = file_open(argv[2], "rb");
        FILE *output = file_open(argv[3], "w");
        decompile(input, output, false);
        fclose(input);
        fclose(output);
        return 0;
    }
    else if (strcmp(argv[1], "decode-mpt") == 0) {
        FILE *input = file_open(argv[2], "rb");
        FILE *output = file_open(argv[3], "w");
        decompile(input, output, true);
        fclose(input);
        fclose(output);
        return 0;
    }
    else if (strcmp(argv[1], "decompress") == 0) {
        FILE *input = file_open(argv[2], "rb");
        FILE *output = file_open(argv[3], "wb");
        uint16_t header = 0;
        size_t size;
        file_write(output, &header, sizeof(header));
        bool decompressed;
        file_write(output, decompress(input, &size, &decompressed), size);
        fclose(input);
        fclose(output);
        return 0;
    }
    else {
        fprintf(stderr, "Usage: %s (encode|decode|decode-mpt) INPUT OUTPUT\n", argv[0]);
        return 1;
    }
}
