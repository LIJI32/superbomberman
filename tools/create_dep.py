def deps_for_asm(filename):
    try:
        lines = open(filename).readlines()
    except:
        # An auto generated file, assume no deps
        return []

    global deps
    for line in lines:
        line = line.split(";")[0].strip()
        if line.startswith('.INCLUDE "') and line.endswith('"'):
            dep = line[10:-1]
            if "/" in filename:
                dep = filename[:filename.rindex("/")+1] + dep
            if dep not in deps:
                deps += [dep]
                deps_for_asm(dep)
        if line.startswith('.INCBIN "'):
            line = line.split(",")[0]
            if line.endswith('"'):
                dep = line[9:-1]
                if "/" in filename:
                    dep = filename[:filename.rindex("/")+1] + dep
                if dep not in deps:
                    deps += [dep]
        if line.startswith('ASSET '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[6:] + ".bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('ASSET_J '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[8:] + "_j.bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('ASSET2 '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[7:] + ".bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('ASSET2_J '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[9:] + "_j.bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('PALETTE '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = "graphics/" + line[8:] + ".bin"
            if dep not in deps:
                deps += [dep]
    return deps

if __name__ == "__main__":
    import sys
    deps = []
    deps_for_asm(sys.argv[1])
    print sys.argv[1].replace(".asm", ".o"), ":", " ".join(deps)
    print sys.argv[1].replace(".asm", ".dep"), ":", " ".join([x for x in deps if x.endswith(".asm")])