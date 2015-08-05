from congraph import FauxStream
import struct
import os

def convert_audio(stream):
    out = ""
    k1 = [0, 0x10000 * 15 / 16, 0x10000 * 61 / 32, 0x10000 * 115 / 64]
    k2 = [0, 0                , 0x10000 * 15 / 16, 0x10000 * 13  / 16]

    s1 = 0
    s2 = 0

    while True:
        block = [ord(x) for x in stream.read(9)]

        r = block[0] >> 4
        f = (block[0] >> 2) & 3
        assert r <= 12

        samples = []
        for sample_pair in block[1:]:
            samples += [sample_pair >> 4]
            samples += [sample_pair & 0xf]

        for sample in samples:
            if sample > 7: sample -= 16
            s0 = (sample << r) * 0x10000
            s = (s0 + k1[f] * s1 - k2[f] * s2) / 0x10000
            #s = min(max(s, -0x8000), 0x7FFF)
            s2 = s1
            s1 = s
            out += struct.pack(">h", s)

        if block[0] & 1:
            return out

def extract_dboot_music(stream):
    song_count = struct.unpack(">H", stream.read(2))[0]
    songs = []
    for song_id in xrange(song_count):
        songs += [struct.unpack(">LL", stream.read(8))]
    for song_id, (start, size) in enumerate(songs):
        song_file = open("song_%02d.bin" % (song_id,), "wb")
        stream.seek(start)
        song_file.write(stream.read(size))
        song_file.close()

def split_dboot_music_to_channels(filename):
    stream = open(filename, "r")
    channel = 0
    os.mkdir(filename.replace(".bin", ""))
    while True:
        size = struct.unpack("<H", stream.read(2))[0]
        if size == 0xFFFF: break
        channel_file = open(filename.replace(".bin", "/channel_%d.bin") % (channel,), "wb")
        channel_file.write(stream.read(size))
        channel_file.close()
        channel += 1
    stream.close()


def decompress_dboot_music(stream):
    full_size = struct.unpack(">H", stream.read(2))[0]
    if full_size == 0:
        return stream # Not compressed
    output = ""
    while 1:
        try:
            bits = ord(stream.read(1))
        except:
            assert(full_size == len(output))
            return FauxStream(output)
        for i in xrange(8):
            if bits & 0x80:
                try:
                    byte = ord(stream.read(1))
                except:
                    break
                length = (byte >> 5) + 3
                offset = (byte & 0x1F) + 1
                for j in xrange(length):
                    output += output[-offset]
            else:
                output +=stream.read(1)
            bits <<= 1

def print_dboot_music(_stream):
    current_note = 0
    current_bend = 0
    notes = ["C-", "C#", "D-", "D#", "E-", "F-", "F#", "G-", "G#", "A-", "A#", "B-"]
    stream = decompress_dboot_music(_stream)
    while 1:
        byte = stream.read(1)
        if byte == "":
            if _stream != stream: # Detect compression
                print "compress()"
            return
        byte = ord(byte)
        command = byte >> 5
        parameter = byte & 0x1F

        if command == 0:
            if parameter > 0xF:
                parameter = -1 - (parameter ^ 0x1F)
            current_note += parameter
            print "play\t('%s%d')" % (notes[current_note % 12], current_note / 12)

        elif command == 1 or command == 4:
            if parameter > 0xF:
                parameter = -1 - (parameter ^ 0x1F)
            current_note += parameter
            print "stop\t('%s%d'%s)" % (notes[current_note % 12], current_note / 12, ", pause=True" if command == 4 else "")

        elif command == 2:
            print "pause\t(%d)" % (parameter + 1, )

        elif command == 3:
            print "stop\t('%s%d', pause=%d)" % (notes[current_note % 12], current_note / 12, parameter + 1)

        elif command == 5 or command == 7:
            if parameter > 0xF:
                parameter = -1 - (parameter ^ 0x1F)
            current_bend += parameter
            print "bend\t(%d%s)" % (current_bend, ", pause=True" if command == 7 else "" )

        # CX DX commands
        elif byte == 0xC1:
            print "song\t(%d)" % (ord(stream.read(1)), )
        elif byte == 0xC2:
            print "volume\t(%d)" % (ord(stream.read(1)), )
        elif byte == 0xC3:
            print "pan\t(%d)" % (ord(stream.read(1)), )
        elif byte == 0xC6:
            print "c6(0x%x)" % (ord(stream.read(1)), ) # Sets the value in an array in the index set in CF XX
        elif byte == 0xCA:
            print "inst\t(0x%x)" % (ord(stream.read(1)), )
        elif byte == 0xCB:
            print "tempo\t(%d)" % (ord(stream.read(1)), )
        elif byte == 0xCC:
            print "nop()"
        elif byte == 0xCD:
            print "halt\t()"
        elif byte == 0xCF:
            print "track\t(0x%x)" % (ord(stream.read(1)), ) # A track may be controlled by two different channels.
        elif byte == 0xD0:
            current_note = ord(stream.read(1))
            print "play\t('%s%d', far=True)" % (notes[current_note % 12], current_note / 12)
        elif byte == 0xD1:
            current_note = ord(stream.read(1))
            print "stop\t('%s%d', far=True)" % (notes[current_note % 12], current_note / 12)
        elif byte == 0xD3:
            current_note = ord(stream.read(1))
            print "set_note('%s%d', pause=True)" % (notes[current_note % 12], current_note / 12)
        elif byte == 0xD4 or byte == 0xD6:
            current_bend = ord(stream.read(1)) - 0x40
            print "bend\t(%d, far=True%s)" % (current_bend, ", pause = True" if byte == 0xD6 else "")
        elif byte == 0xD5:
            print "nop(0xd5)"
        elif byte == 0xD7:
            print "pause\t(255, set=False)"
        elif byte & 0xFC == 0xD8:
            print "vol_range\t(%d)" % (byte & 3, )
        else:
            print "#UNSUPPORTED COMMAND %X" % (byte, )

def dboot_to_modplug_channel(dboot_sheet):
    global modplug_state
    modplug_state = dict()
    modplug_state['output'] = []
    modplug_state['current_lines'] = ["..........."] * 8
    modplug_state['last_pause'] = 0
    modplug_state['last_note'] = None
    modplug_state['current_instrument'] = 0
    modplug_state['current_volume'] = 0
    modplug_state['current_range'] = 0
    modplug_state['playing_notes'] = [None] * 8
    modplug_state['max_channel'] = 0
    modplug_state['track_id'] = None


    def pause(pause=None, set=False):
        global modplug_state
        if pause == None: pause = modplug_state['last_pause']
        if set: modplug_state['last_pause'] = pause
        modplug_state['output'] += [modplug_state['current_lines']]
        modplug_state['current_lines'] = ["..........."] * 8
        modplug_state['output'] += [["..........."] * 8] * (pause - 1)

    _pause = pause

    def play(note, far=False):
        global modplug_state
        try:
            index = modplug_state['playing_notes'].index(note)
        except:
            index = modplug_state['playing_notes'].index(None)
        modplug_state['max_channel'] = max(modplug_state['max_channel'], index)

        modplug_state['current_lines'][index] = note + ("%02dv%02d" % (modplug_state['current_instrument'], modplug_state['current_volume'] * modplug_state['current_range'] * 64 / 255 / 3)) + modplug_state['current_lines'][index][8:]
        modplug_state['last_note'] = note
        modplug_state['playing_notes'][index] = note

    def stop(note, far=False, pause=False):
        global modplug_state

        if pause == True: _pause()
        elif pause != False: _pause(pause)

        if note not in modplug_state['playing_notes']:
            print "Warning: Stopping a non-playing note"
            return

        index = modplug_state['playing_notes'].index(note)
        modplug_state['playing_notes'][index] = None

        modplug_state['current_lines'][index] = "===" + modplug_state['current_lines'][index][3:]

    def inst(instrument):
        global modplug_state
        modplug_state['current_instrument'] = instrument

    def volume(vol):
        global modplug_state
        modplug_state['current_volume'] = vol
        for i in xrange(8):
            modplug_state['current_lines'][i] = modplug_state['current_lines'][i][:5] + "v%02d" % (modplug_state['current_volume'] * modplug_state['current_range'] * 64 / 255 / 3, ) + modplug_state['current_lines'][i][8:]

    def vol_range(range):
        global modplug_state
        modplug_state['current_range'] = range
        volume(modplug_state['current_volume'])

    def pan(value):
        global modplug_state
        for i in xrange(8):
            modplug_state['current_lines'][i] = modplug_state['current_lines'][i][:8] + ("X%x" %(value,))

    def halt(): pass
    def nop(): pass
    def song(song_id):
        print "Warning: song() not supported in modplug format"

    def track(track_id):
        modplug_state['track_id'] = track_id

    def set_note(note, pause = True):
        _pause()

    exec dboot_sheet in locals(), locals()

    return (modplug_state['track_id'], [x[:modplug_state['max_channel'] + 1] for x in modplug_state['output']])

def dboot_join(out, subfiles, sizes=False, count=False):
    subfiles_data = [open(x).read() for x in subfiles]
    pos = 0
    if count:
        out.write(struct.pack(">H", len(subfiles)))
        pos += 2
    pos += len(subfiles) * 4
    if sizes:
        pos += len(subfiles) * 4
    for data in subfiles_data:
        out.write(struct.pack(">L", pos))
        if sizes:
            out.write(struct.pack(">L", len(data)))
        pos += len(data)
    for data in subfiles_data:
        out.write(data)

def dboot_join_channels(out, subfiles):
    subfiles_data = [open(x).read() for x in subfiles]
    for data in subfiles_data:
        out.write(struct.pack("<H", len(data)))
        out.write(data)
    out.write("\xFF\xFF")
    if out.tell() % 2 == 1:
        out.write("\xFF")

def pack_dboot_samples(out, definition):
    samples = open(definition).readlines()
    samples_data = []
    loops = []

    for line, sample in enumerate(samples):
        sample = sample.split("#")[0].strip()
        split = [x for x in sample.split(" ") if x != ""]
        if len(split) == 0: continue
        assert len(split) == 2, "Syntax Error at %s:%d. Syntax is: 'path_to_brr loop_in_samples'" % (definition, line + 1)
        try:
            filename = os.path.join(os.path.dirname(definition), split[0])
            samples_data += [open(filename).read()]
        except:
            assert False, "Error at %s:%d. Could not open %s"  % (definition, line + 1, filename)

        try:
            # Convert sample to file offset
            loops += [int(split[1]) * 9 / 16]
            if int(split[1]) % 16 > 0:
                loops[-1] += 1
        except:
            assert "Syntax Error at %s:%d. Could not parse loop index %s" % (definition, line + 1, split[1])

    offset = 8 * len(samples_data)
    for sample, loop in zip (samples_data, loops):
        out.write(struct.pack(">L", offset))
        out.write(struct.pack(">H", len(sample)))
        out.write(struct.pack(">H", loop))
        offset += len(sample)

    for sample in samples_data:
        out.write(sample)