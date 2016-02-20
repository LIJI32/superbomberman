import png
from congraph import create_palette

def photoshop_fix(palette):
    # Photoshop adds extra colors to a palette sometimes.
    # We should remove it.
    if len(palette) % 16 != 0: return palette

    default_photoshop_palette = [(x, x, x) for x in xrange(256)]
    for i in xrange(len(palette) / 16):
        if palette[i * 16: i * 16 + 16] == default_photoshop_palette[i * 16: i * 16 + 16]:
            return palette[: i * 16]
        if palette[i * 16: i * 16 + 16] == [(0,0,0)] * 16:
            return palette[: i * 16]
    return palette


def convert_file(filename,):
    reader = png.Reader(filename)
    reader.read()
    palettes = reader.palette()
    palettes = photoshop_fix(palettes)
    is_japanese = False
    if filename.endswith("_j.png"):
        is_japanese = True
        filename = filename.replace("_j.png", ".png")
    for i in xrange(0, len(palettes), 0x10):
        palette = create_palette(palettes[i : i+0x10])
        if len(palettes) == 0x10:
            out_name = filename.replace(".png", "_palette.bin")
        else:
            out_name = filename.replace(".png", "_palette_%d.bin" % (i / 0x10, ))
        if is_japanese:
            out_name = out_name.replace(".bin", "_j.bin")
        open(out_name, "w").write(palette)

if __name__ == "__main__":
    import sys
    
    for filename in sys.argv[1:]:
        convert_file(filename)
        
