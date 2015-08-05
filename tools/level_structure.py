import struct
from congraph import FauxStream

SYMBOLS         = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1245678"
FLIPPED_SYMBOLS = "abcdefghijklmnopqrstuvwxyz!@$%^&*"

SIZE = 17*13

def decode(stream):
    collision = ""
    for i in xrange(14):
        word = struct.unpack("<H", stream.read(2))[0]
        collision += '{0:016b}'.format(word).replace("0"," ").replace("1", "#")

    collision = collision[:SIZE]
    collision = "\n".join([collision[i:i+17] for i in range(0, len(collision), 17)])

    tilemap = []
    repeat = None
    symbols = {}

    symbol = 0

    for i in xrange(7):
        mask = struct.unpack("<H", stream.read(2))[0]
        for i in xrange(16):
            mask <<= 1
            if mask & 0x10000:
                repeat = [stream.read(2), stream.read(2)]
            tilemap += repeat

    # Automatic detection of common symbols
    symbols[tilemap[0x47]] = '#'
    symbols[tilemap[0x58]] = '"'
    symbols[tilemap[0x46]] = ' '
    symbols['\0\0'] = '0'

    for index, tile in enumerate(tilemap):
        if tile not in symbols:
            unflipped_tile = tile[0] + chr(ord(tile[1]) & ~0x40)
            symbols[unflipped_tile] = SYMBOLS[symbol]
            flipped_tile = tile[0] + chr(ord(tile[1]) | 0x40)
            symbols[flipped_tile] = FLIPPED_SYMBOLS[symbol]
            symbol += 1
        tilemap[index] = symbols[tile]
    tilemap = tilemap[:SIZE]
    tilemap = "\n".join(["".join(tilemap[i:i+17]) for i in range(0, len(tilemap), 17)])

    return (collision, tilemap, {v: k for k, v in symbols.items()})

def encode(stream, out):
    lines = stream.read().splitlines()
    collision = ("".join(lines[:13]) + "   ").replace(" ", "0").replace("#", "1")
    assert len(collision) == SIZE + 3
    for i in xrange(0, SIZE, 16):
        out.write(struct.pack("<H", int(collision[i:i+16], 2)))

    tilemap = "".join(lines[13:26])
    assert len(tilemap) == SIZE

    symbols = {}

    for symbol in lines[26:]:
        if len(symbol) == 0: continue
        find, replace = symbol.split("=")
        replace = replace.decode("hex")
        symbols[find] = replace
        if find in SYMBOLS:
            symbols[FLIPPED_SYMBOLS[SYMBOLS.index(find)]] = replace[0] + chr(ord(replace[1]) | 0x40)

    tilemap = "".join([symbols[x] for x in tilemap])
    tilemap += "\0\0" + tilemap[-2:] + "\0\0" # Rounding
    map_stream = FauxStream(tilemap)

    done = False
    while True:
        mask = 0
        last_dword = "\0\0\0\0"
        current_data = ""
        for i in xrange(16):
            dword = map_stream.read(4)
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


if __name__ == "__main__":
    import sys
    if sys.argv[1] == "decode":
        collision, tilemap, symbols = decode(open(sys.argv[2]))
        print collision
        print tilemap
        for symbol in ' "#' + SYMBOLS:
            if symbol not in symbols: continue
            print "%s=%s" % (symbol, symbols[symbol].encode("hex"))

    if sys.argv[1] == "encode":
        encode(open(sys.argv[2]), open(sys.argv[3], "w"))