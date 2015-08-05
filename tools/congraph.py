import struct
import png

# This tile is always skipped and is used for alignment
NULL_TILE = [1,1,1,1,1,1,1,1,
    1,2,0,0,0,0,3,1,
    1,0,2,0,0,3,0,1,
    1,0,0,2,3,0,0,1,
    1,0,0,3,2,0,0,1,
    1,0,3,0,0,2,0,1,
    1,3,0,0,0,0,2,1,
    1,1,1,1,1,1,1,1,]
    
class FauxStream(object):
    def __init__(self, data):
        self.data = data
        self.pos = 0
    
    def read(self, n=0xFFFFFFFF):
        r = self.data[self.pos:self.pos + n]
        self.pos = min(self.pos + n, len(self.data))
        return r
    
    def tell(self):
        return self.pos
    
    def seek(self, pos):
        self.pos = pos
    
    def __add__(self, x):
        return FauxStream(self.data + x.data)
        
def decompress_snes_rle(stream, terminated=False, max_size = None):
    data = ""
    size = 0x40
    if terminated or max_size == -1: size = 0x2000 # Terminated by 81AA
    for i in xrange(size):
        byte = stream.read(1)
        if byte == "": break
        mask = ord(byte)
        last_byte = "\x00"

        if terminated and mask == 0x81:
            if stream.read(1) == "\xAA":
                term = stream.read(1)
                if term != '\x00': print "term = %x" % (ord(term),)
                break
            stream.seek(stream.tell() - 1)
                
        for j in xrange(8):
            mask <<= 1
            if mask & 0x100:
                last_byte = stream.read(1)
            data += last_byte
            if max_size and max_size != -1 and len(data) >= max_size:
                return FauxStream(data)

    return FauxStream(data)

def decompress_snes_rle_interleaved(stream, terminated=False, max_size = None):
    data = ""
    if max_size:
        max_size /= 2
    even = decompress_snes_rle(stream, terminated, max_size)
    odd = decompress_snes_rle(stream, terminated, max_size)
    if len(even.data) != len(odd.data):
        print len(even.data), "!=", len(odd.data)
        assert False
    for i in xrange(len(even.data)):
        data += even.read(1) + odd.read(1)
    return FauxStream(data)

def compress_snes_rle_interleaved(stream, terminated=False):
    even = ""
    odd = ""
    
    while True:
        data = stream.read(2)
        if len(data) == 0: break
        assert len(data) == 2
        even += data[0]
        odd += data [1]
    
    return compress_snes_rle(FauxStream(even), terminated=terminated) + compress_snes_rle(FauxStream(odd), terminated=terminated)

def compress_snes_rle(stream, terminated=False):
    data = ""
    done = False
    while True:
        mask = 0
        last_byte = "\x00"
        current_data = ""
        for i in xrange(8):
            byte = stream.read(1)
            if byte == "":
                done = True
                break
            mask <<= 1
            if byte != last_byte:
                current_data += byte
                last_byte = byte
                mask |= 1
        if done: break
        mask = chr(mask)
        data += mask + current_data
    
    if terminated:
        data += "\x81\xaa\x00"
    
    return FauxStream(data)
    
def encode_tile(data, depth=2):
    bitplanes = [[] for x in xrange(depth)]
    for row in xrange(8):
        for bitplane in xrange(depth):
            bitplanes[bitplane] += [0]
        for pixel in xrange(8):
            color = data[row * 8 + pixel]
            for bitplane in xrange(depth):
                bitplanes[bitplane][-1] <<= 1
                bitplanes[bitplane][-1] |= color & 1
                color >>= 1

    data = ""
    for row in xrange(8):
        for i in xrange(min(depth, 2)):
            data += chr(bitplanes[i][row])
    for row in xrange(8):
        for i in xrange(2, depth):
            data += chr(bitplanes[i][row])
    
    return data

def encode_tileset(tileset, depth=2):
    return FauxStream("".join([encode_tile(tile, depth=depth) for tile in tileset]))
    
def read_tile(stream, depth=2):
    data = [0] * 64
    for bit2 in xrange(0, depth, 2):
        for y in xrange(8):
            for bit in xrange(bit2, min(bit2 + 2, depth)):
                byte = ord(stream.read(1))
                for x in xrange(8):
                    data[y*8 + 7-x] |= (byte & 1) << depth
                    data[y*8 + 7-x] >>= 1
                    byte >>= 1
    return data

def bitmap_to_tileset(bitmap):
    width = len(bitmap[0])
    height = len(bitmap)
    n_tiles = width * height / 64
    assert n_tiles * 64 == width * height
    
    data = []
    for tile in xrange(n_tiles):
        tile_data = []
        tile_x = tile % (width / 8)
        tile_y = tile / (width / 8)
        for y in xrange(8):
            for x in xrange(8):
                tile_data += [bitmap[tile_y * 8 + y][tile_x * 8 + x]]
        data += [tile_data]

    return data
    
def read_tileset(stream, length=256, depth=2):
    return [read_tile(stream, depth) for i in xrange(length)]

def map_tiles(tileset, tilemap=None):
    data = []
    if not tilemap:
        tilemap = default_tilemap(len(tileset))
    for line in tilemap:
        for y in xrange(8):
            for tile in line:
                for x in xrange(8):
                    data += [tileset[tile][y * 8 + x]]
    return data
    
def default_tilemap(size, width=None):
    divisors = [x for x in range(1, size +1) if size % x == 0]
    if width == None or width not in divisors:
        width = divisors[len(divisors) >> 1]
    height = size/width
    
    return [range(y * width, (y+1) * width) for y in xrange(height)]

def default_palette(bitmap):
    size = max(bitmap) - min(bitmap) + 1
    return [None] * min(bitmap) + [[i*255/(size-1)] * 3 for i in xrange(size)]

def map_palette(bitmap, palette = None):
    if not palette:
        palette = default_palette(bitmap)
    return "".join([palette[x] for x in bitmap])

def convert(stream, offset = None, palette = None, terminated = False, extra_tiles = 0, depth = 4, max_size = None):
    if offset: stream.seek(offset)
    start = stream.tell()
    decompressed = decompress_snes_rle_interleaved(stream, terminated, max_size)
    n_tiles = len(decompressed.data) / (8 * depth)
    #print "MakeArray(0x%x, %d); 'Start: %X End: %X, Size: %d, Tiles: %d';" % (0xC00000 + start, stream.tell()-start, 0xC00000 + start, stream.tell() + 0xC00000, stream.tell()-start, n_tiles)
    return map_palette(map_tiles(read_tileset(decompressed, n_tiles, depth) + extra_tiles * [[0]*64]), palette)

def extract(stream, *args, **kw):
    start = stream.tell()
    convert(stream, *args, **kw)
    size = stream.tell() - start
    stream.seek(start)
    return stream.read(size)

def convert_palette(stream, offset = None, count = 16):
    def scale(x):
        return x * 8 + x / 4
    
    if offset: stream.seek(offset)
    colors = [struct.unpack("<H", stream.read(2))[0] for x in xrange(count)]
    return [[scale(x & 0x1F), scale((x >> 5) & 0x1F) , scale((x >> 10) & 0x1F)] for x in colors];

def create_palette(palette):
    def scale(x):
        return x / 8

    out = ""
    for r, g, b in palette:
        r, g, b = [scale(x) for x in (r, g, b)]
        out += struct.pack("<H", (b << 10) | (g << 5) | (r) )

    return out;

