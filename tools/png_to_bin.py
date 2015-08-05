import png
from congraph import encode_tileset, bitmap_to_tileset, compress_snes_rle_interleaved, NULL_TILE

def convert_file(filename, terminated=False, overlay=False, raw=False, depth=4):
    reader = png.Reader(filename)
    bitmap = list(reader.read()[2])
    tileset = [x for x in bitmap_to_tileset(bitmap) if [y & 0xF for y in x] != NULL_TILE]
    is_japanese = False
    if filename.endswith("_j.png"):
        is_japanese = True
        filename = filename.replace("_j.png", ".png")
    part_size = 0x20
    if overlay or raw: part_size = 0xFFFF
    if not terminated:
        for i in xrange(0, len(tileset), part_size):
            encoded_tileset = encode_tileset(tileset[i:i+part_size], depth=depth)
            if raw:
                data = encoded_tileset.read()
            else:
                data = compress_snes_rle_interleaved(encoded_tileset, terminated=False).read()
            if len(tileset) <= part_size:
                out_name = filename.replace(".png", "_graphic.bin")
            else:
                out_name = filename.replace(".png", "_graphic_%d.bin" % (i / part_size, ))
            if is_japanese:
                out_name = out_name.replace(".bin", "_j.bin")
            open(out_name, "w").write(data)
    else:
        encoded_tileset = encode_tileset(tileset, depth=4)
        data = compress_snes_rle_interleaved(encoded_tileset, terminated=True).read()
        out_name = filename.replace(".png", "_graphic.bin")
        if is_japanese:
            out_name = out_name.replace(".bin", "_j.bin")
        open(out_name, "w").write(data)

if __name__ == "__main__":
    import sys
    terminated = False
    overlay = False
    raw = False
    depth = 4
    
    filenames = sys.argv[1:]
    if sys.argv[1] == "bg":
        filenames = filenames[1:]
        terminated = True
    elif sys.argv[1] == "overlay":
        filenames = filenames[1:]
        overlay = True
    elif sys.argv[1] == "raw":
        filenames = filenames[1:]
        raw = True
    elif sys.argv[1] == "raw2":
        filenames = filenames[1:]
        raw = True
        depth=2
    for filename in filenames:
        convert_file(filename, terminated, overlay, raw, depth)
        
