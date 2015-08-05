from conaudio import dboot_join, dboot_join_channels, print_dboot_music, pack_dboot_samples
import sys

if __name__ == "__main__":
    if sys.argv[1] == "join":
        dboot_join(open(sys.argv[2], "w"), sys.argv[3:])
    elif sys.argv[1] == "join-songs":
        dboot_join(open(sys.argv[2], "w"), sys.argv[3:], count=True, sizes=True)
    elif sys.argv[1] == "join-channels":
        dboot_join_channels(open(sys.argv[2], "w"), sys.argv[3:])
    elif sys.argv[1] == "parse-channel":
        print_dboot_music(open(sys.argv[2], "r"))
    elif sys.argv[1] == "pack-samples":
        pack_dboot_samples(open(sys.argv[3], "w"), sys.argv[2])
    else:
        print "Unknown command."
        exit(1)