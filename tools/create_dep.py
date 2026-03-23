def deps_for_asm(filename):
    global deps
    try:
        lines = open(filename).readlines()
    except:
        deps.remove(filename)
        return []
    for line in lines:
        line = line.split(";")[0].strip()
        if line.startswith('include "') and line.endswith('"'):
            dep = line[9:-1]
            if "/" in filename:
                dep = filename[:filename.rindex("/")+1] + dep
            if dep not in deps:
                deps += [dep]
                deps_for_asm(dep)
        if line.startswith('incbin "'):
            line = line.split(",")[0]
            if "type/name" in line:
                continue
            if line.endswith('"'):
                dep = line[8:-1]
                if "/" in filename:
                    dep = filename[:filename.rindex("/")+1] + dep
                if dep not in deps:
                    deps += [dep]
        if line.startswith('asset '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[6:] + ".bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('asset_j '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = line[8:] + "_j.bin"
            if dep not in deps:
                deps += [dep]
        if line.startswith('palette '):
            line = line.replace(", ", "/").replace(",", "/")
            dep = "graphics/" + line[8:] + ".bin"
            if dep not in deps:
                deps += [dep]
    return deps

if __name__ == "__main__":
    import sys
    deps = []
    deps_for_asm(sys.argv[1])
    print sys.argv[1].replace(".asm", ".sfc"), ":", " ".join(deps)
    print sys.argv[1].replace(".asm", ".dep"), ":", " ".join([x for x in deps if x.endswith(".asm")])