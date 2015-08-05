import png
from congraph import *


if __name__ == "__main__":
    import sys

    bitmap = []
    width = 64

    palette_for_tile = {}
    config_list = sys.argv[1].split(";")
    palettes = [int(config_list[0], 16)]
    extra_tiles = 0
    map_width = None
    use_bg_palettes = False
    depth = 4
    compressed = True
    raw_order = False
    
    for config in config_list[1:]:
        if config.startswith("+"):
            extra_tiles = int(config[1:], 16)
            continue
        if config.startswith("w"):
            map_width = int(config[1:], 16)
            continue
        if config == "b":
            use_bg_palettes = True
            continue
        if config.startswith("z"):
            depth = int(config[1:], 16)
            continue
        if config == "u":
            compressed = False
            continue
        if config == "r":
            raw_order = True
            continue
        tiles_list, palette = config.split(":")
        palette = int(palette, 16)
        if palette not in palettes:
            palettes += [palette]
        for tiles in tiles_list.split(","):
            if "-" in tiles:
                start, end = tiles.split("-")
                for i in xrange(int(start, 16), int(end, 16) + 1):
                    palette_for_tile[i] = palettes.index(palette)
            else:
                palette_for_tile[int(tiles, 16)] = palettes.index(palette)
    print palette_for_tile
    i = 0

    for filename in sys.argv[3:]:
        stream = open(filename)
        stream.seek(-3, 2)
        terminated = stream.read() == "\x81\xaa\x00"
        print filename
        if terminated: 
            print "TERMINATED!"
        stream.seek(0)
        if compressed:
            n_tiles = 0
            decompressed = FauxStream("")
            while True:
                if raw_order:
                    decompressed += decompress_snes_rle_interleaved(stream, True, 0x1800)
                else:
                    decompressed += decompress_snes_rle_interleaved(stream, terminated, None)
                leftovers = stream.read()
                if leftovers == "": break
                stream = FauxStream(leftovers)
            n_tiles = len(decompressed.data) / (8 * depth)
        else:
            decompressed = stream
            stream.seek(0, 2)
            n_tiles = stream.tell() / (8 * depth)
            stream.seek(0)
        print n_tiles
        tileset = read_tileset(decompressed, n_tiles, depth)
        tileset += [NULL_TILE] * extra_tiles
        for tile in tileset:
            if i in palette_for_tile:
                for j in xrange(len(tile)):
                    tile[j] += palette_for_tile[i] * (1 << depth)
            i += 1

        tilemap = default_tilemap(len(tileset), width=map_width)
        width = len(tilemap[0])*8
        bitmap += map_tiles(tileset, tilemap)

    palette_colors = []
    for palette in palettes:
        palette_colors += convert_palette(open("rom.sfc"), (0x20000 if use_bg_palettes else 0x21200) + palette * (2 << depth), (1 << depth))

    png.Writer(width=width, height=len(bitmap)/width, bitdepth = 8, palette = palette_colors).write_array(open(sys.argv[2], "w"), bitmap)