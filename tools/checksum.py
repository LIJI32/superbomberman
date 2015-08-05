import struct

def calculate_checksum(stream):
    checksum = 0
    while True:
        byte = stream.read(1)
        if byte == "":
            return checksum
        checksum += ord(byte)
        checksum &= 0xFFFF

def update_checksum(stream):
    checksum = calculate_checksum(stream)
    stream.seek(0xFFDC)
    stream.write(struct.pack("<HH", checksum ^ 0xFFFF , checksum))
    
if __name__ == "__main__":
    import sys
    for filename in sys.argv[1:]:
        with open(filename, "r+") as stream:
            update_checksum(stream)
        