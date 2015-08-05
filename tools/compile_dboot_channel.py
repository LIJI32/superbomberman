import struct, conaudio

def note_to_index(note):
    return ["C-", "C#", "D-", "D#", "E-", "F-", "F#", "G-", "G#", "A-", "A#", "B-"].index(note[:2]) + int(note[2]) * 12
    
def get_relative(index):
    global current_note
    relative = index - current_note
    assert -0x10 <= relative < 0x10
    current_note = index
    return (relative + 0x20) & 0x1F

    
current_note = None # Force crashing if used relatively before explicit definition
current_bend = 0
data = ""
compressed = False

def play(note, far=False):
    global current_note, data
    index = note_to_index(note)

    if far:
        data += "\xd0"
        data += chr(index)
        current_note = index
        return
        
    data += chr(get_relative(index))

# Pause can be False (Do not pause), True (Pause with default length) or a number (pause with specific length).
def stop(note = None, pause=False, far=False):
    global current_note, data
    if note != None:
        index = note_to_index(note)
    else:
        index = current_note
    if far:
        assert not pause
        current_note = index
        data += "\xd1"
        data += chr(index)
        return
    if type(pause) == type(True):
        command = 4 if pause else 1
        relative = get_relative(index)
        data += chr((command << 5) | relative)
        return
    pause = int(pause)
    assert index == current_note
    assert 0 < pause <= 0x20
    data += chr((3 << 5) | (pause - 1))
    
def pause(length, set=True):
    global data
    if length == 0xFF:
        assert not set
        data += "\xd7"
        return
    assert set
    assert 0 < length <= 0x20
    data += chr((2 << 5) | (length - 1))    

def bend(semitones, far=False, pause=False):
    global data, current_bend
    
    if far:
        current_bend = semitones
        data += '\xd6' if pause else '\xd4'
        data += chr(current_bend + 0x40)
        return
    command = 7 if pause else 5
    relative = semitones - current_bend
    assert -0x10 <= relative < 0x10
    current_bend = semitones
    data += chr((command << 5) | relative)
    return
    
def nop(kind=0xcc):
    global data
    assert kind in [0xcc, 0xd5]
    data += chr(kind)
    
def halt():
    global data
    data += "\xcd"
    
def set_note(note, pause=True):
    global data, current_note
    assert pause # For verbosity
    index = note_to_index(note)
    current_note = index
    data += "\xd3"
    data += chr(index)

def vol_range(range):
    global data
    assert 0 <= range <= 3
    data += chr(range + 0xd8)
def compress():
    global compressed, data
    assert not compressed
    compressed = True

    def find(haystack, needle, haystack_len):
        if not haystack: return (None, 0)
    
        best = (None, 0)
        for start in xrange(max(haystack_len - 0x20, 0), haystack_len):
            current = start
            for pos, char in enumerate(needle):
                if haystack[current] != char:
                    if pos > best[1]:
                        best = (start, pos)
                    break
                current += 1
                if current == haystack_len:
                    current = start
            else:
                return (start, len(needle))
        return best
    
    def encode(current, next, current_len):
        if next == "":
            return (0, "", 0)
        offset, length = find(current, next, current_len)
        if length >= 3:
            return (1, chr(((length - 3) << 5) + current_len - offset - 1), length)
        return (0, next[0], 1)
            
    pos = 0
    output = ""
    length = len(data)
    while pos < length:
        flags = 0
        chunk = ""
        for i in xrange(0, 8):
            flag, encoded, advance = encode(data[:pos], data[pos:pos + 10], pos)
            flags = (flags << 1) + flag
            chunk += encoded
            pos += advance
        output += chr(flags) + chunk
    data = struct.pack(">H", len(data)) + output
    
simple_functions = [
("song", 0xc1),
("volume", 0xc2),
("pan", 0xc3),
("c6", 0xc6),
("inst", 0xca),
("tempo", 0xcb),
("track", 0xcf),
]

template = """
def %s(parameter):
    global data
    data += chr(%d)
    data += chr(parameter)
"""

exec "".join(template % x for x in simple_functions)

if __name__ == "__main__":
    import sys
    exec open(sys.argv[1])
    if not compressed:
        data = "\x00\x00" + data
    open(sys.argv[2], "w").write(data)
