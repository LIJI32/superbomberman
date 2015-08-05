import struct
from congraph import FauxStream

SYMBOLS         = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-[];'\,./`"
FLIPPED_SYMBOLS = 'abcdefghijklmnopqrstuvwxyz!@#$%^&*()_{}:"|<>?~'

def decode(stream, no_plus, width = 32):
    tilemap = ""
    symbols = {}

    symbol = 0

    tile = "\0\0"
    while True:
        prev = tile

        tile = stream.read(2)
        if not tile: break
        if not no_plus and tile not in symbols and tile == chr(ord(prev[0]) + 2) + prev[1]:
            tilemap += "+"
        else:
            if tile not in symbols:
                if tile[0] == "\0" and " " not in symbols.values():
                    symbols[tile] = " "
                elif FLIPPED_SYMBOLS == "":
                    symbols[tile] = SYMBOLS[symbol]
                    symbol += 1
                else:
                    unflipped_tile = tile[0] + chr(ord(tile[1]) & ~0x40)
                    symbols[unflipped_tile] = SYMBOLS[symbol]
                    flipped_tile = tile[0] + chr(ord(tile[1]) | 0x40)
                    symbols[flipped_tile] = FLIPPED_SYMBOLS[symbol]
                    symbol += 1
            tilemap += symbols[tile]
    if width == 17: # Dirty hack, sorry. :(
        align = tilemap[:6]
        tilemap = tilemap[6:]
    tilemap = "\n".join(["".join(tilemap[i:i+width]) for i in range(0, len(tilemap), width)])
    if width == 17: # Dirty hack, sorry. :(
        tilemap = align + "\n" + tilemap

    return (tilemap, {v: k for k, v in symbols.items()})

def decompress(stream):
    tilemap = ""
    repeat = "\0\0\0\0"

    while True:
        r = stream.read(2)
        if r == "": break
        mask = struct.unpack("<H", r)[0]
        for i in xrange(16):
            mask <<= 1
            if mask & 0x10000:
                repeat = stream.read(4)
            tilemap += repeat

    return FauxStream(tilemap)

def compress(stream, out):
    done = False
    while True:
        mask = 0
        last_dword = "\0\0\0\0"
        current_data = ""
        for i in xrange(16):
            dword = stream.read(4)
            if dword == "":
                done = True
                break
            mask <<= 1
            if dword != last_dword:
                current_data += dword
                last_dword = dword
                mask |= 1
        if done: break
        out.write(struct.pack("<H", mask) + current_data)

def encode(stream, symbols):
    tile = "\0\0"
    data = ""
    while True:
        symbol = stream.read(1)
        if symbol == "\n": continue
        if symbol == "": break
        if symbol == "+":
            tile = chr(ord(tile[0]) + 2) + tile[1]
        else:
            tile = symbols[symbol]
        data += tile
    return data

if __name__ == "__main__":
    import sys

    if "no-flip" in sys.argv:
        SYMBOLS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-[];'\,./`!@#$%^&*()_{}:\"|<>?~"
        FLIPPED_SYMBOLS = ""
        sys.argv.remove("no-flip")

    width = 32

    if "narrow" in sys.argv:
        width = 17
        sys.argv.remove("narrow")

    no_plus = False
    if "no-plus" in sys.argv:
        sys.argv.remove("no-plus")
        no_plus = True

    stream = open(sys.argv[2])

    if sys.argv[1] == "decompress":
        sys.argv[1] = "decode"
        stream = decompress(stream)
    if sys.argv[1] == "decode":
        tilemap, symbols = decode(stream, no_plus, width)
        print tilemap
        print
        for symbol in ' ' + SYMBOLS:
            if symbol not in symbols or (symbol not in tilemap and FLIPPED_SYMBOLS[SYMBOLS.index(symbol)] not in tilemap): continue
            print "%s=%s" % (symbol, symbols[symbol].encode("hex"))
    elif sys.argv[1] in ("encode", "compress"):
        data, symbols_def = stream.read().split("\n\n", 2)
        symbols = {}
        for line in symbols_def.splitlines():
            if len(line) == 0: continue
            find, replace = line.split("=")
            replace = replace.decode("hex")
            symbols[find] = replace
            if find in SYMBOLS:
                flipped_find = FLIPPED_SYMBOLS[SYMBOLS.index(find)]
                if flipped_find not in symbols:
                    symbols[flipped_find] = replace[0] + chr(ord(replace[1]) | 0x40)
        encoded = encode(FauxStream(data), symbols)
        if sys.argv[1] == "compress":
            compress(FauxStream(encoded), open(sys.argv[3], "w"))
        else:
            open(sys.argv[3], "w").write(encoded)


