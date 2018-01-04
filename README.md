# superbomberman
Disassembly and remade build system for SNES game Super Bomberman, inspired by [pokered](https://github.com/iimarckus/pokered) and [pokecrystal](https://github.com/kanzure/pokecrystal).

# Output ROM
This disassembly can build the following headerless SNES ROMs:
<pre>
Super Bomberman 1 (US)           : d83699a009a62480a7e7e9f1bb5bff6e
Super Bomberman 1 (J)            : cbef5f02304a2b821a0e1642a6307564
Super Bomberman 1 (E)            : ddee4ddff2f3b6e31b8f73d0cb597ef1
Super Bomberman 1 (US Prototype) : d67a1a2b0fac0564d950f8cd45fee3c2
</pre>
It can also build a bugfix version, based on the US version, that fixes some (mostly graphical) bugs, and can also restore access to the debug menu used during development with a debug version. The configuration files let you mix-and-match specific regional changes.

The [randomizer branch](https://github.com/LIJI32/superbomberman/tree/randomizer) can also build ROMs with randomly generated levels.

# Requirements
The following are required to build a ROM:
* A UNIX-like system to build the ROM on. I generally use OS X to build, but I also correctly built a ROM on a Linux system. I did not test on other UNIX-like systems or Windows.
* ca65 and ld65, from the [cc65 package](https://github.com/cc65/cc65). It is required for assembling and linking the ROM.
* md5 or md5sum, for verifying the ROM after compilation
* python, required to run many of the game- and SNES-specific tools in this repository, such as graphic and audio conversion tools

Build by running <code>make</code> or <code>make CONFIG=x</code>, where x is us, j, e, bugfix, debug or any other configuration file in the config folder. Using the -s and -j flags is recommended

# What is done
* Naming many of the subroutines (285 out of 817!)
* Conversion of all graphics/palettes to PNGs
* Conversion of all level structures and tilemaps
* Unpacking and repacking of the DBoot (SPC engine used in the game) data
* Decompilation and recompilation of songs
* Unpacking and repacking BRR samples
* Mapping the entire ROM to data/code; all offsets are marked as such, so adding code or data at any point is possible
* Most internal formats are decoded to some level either in the ASM or external files

# What's not done
* Naming all subroutines
* Conversion of all DBoot files:
 * banks sub-file: Documented, conversion tools not written yet.
 * sound_effcts sub-file: Probably the same or very similar to songs sub-file
 * instruments sub-file: Format only partially documented
 * firmware subfile: This is the code that runs on the SPC. Due to the lack of an SPC700 IDA processor module, I only have a partial, uncommitted disassembly of the code, with only code related to the music format. Due to not being able to re-assemble such code, it is provided in binary form
 * Conversion of WAVs to BRR. I couldn't find or create an algorithm to compress WAVs back to BRR files without losing more information (Assuming the WAV files themselves were converted from BRR files). Both WAV and BRR files are provided, and the build system ignores the WAV files.
* Not all internal formats are as well decoded as they should be, like sprite/animation definitions
* The RAM is not entirely mapped, and ram.asm is a *huge* mess. Also, not all *RAM* offsets are marked as such in code, meaning data can't easily be inserted in the RAM.

# Hidden secrets
* There were at least two levels in the game that never saw the light of day, judging by leftover data:
 * Two unused level structures. One has its palettes right after the park palettes, and one has its deleted palettes after the tunnel zone palettes. The first structure was not structured like a regular level, but had a big unpassable object in the middle of the level, making the level ring-like. These structures do not match any of the existing tilesets, and no unused tileset exists in code.
 * Groups of 5 unused or delete palettes in the middle of background palettes section.
 * A few chunks of empty tiles inside the animated tiles graphic file, and an unused animated tile. The unused tile does not match any palette in the game.
* A strange purple palette that seems to match the Bomberman sprite. It's unused.
* Old palette used for the Starnuts enemy, and an old palette used for the Gold Mecha Bomberman (This is neither the final US or J palette of the same graphic)
* An unused palette shows that there used to be green bombs in the game.
* The game has a debug menu that cannot be accessed (It can be built with a debug flag). It seems that official debug builds had a debug menu instead of a pause option. Some features no longer work (game speed) some are labeled incorrectly (kick and power are swapped, and the Sound Test screen, that was added later is unlisted causing an offset), and some are simply cryptically labels (VS check is a debugging tool for Pakupa). If the debug flag is used, the debug menu can be accessed using the select button. It restores missing function calls and removes a short circuit in a function.
* Both the Japanese and Western function include code and graphics for both "Draw" screens, but each version uses only one.
* Generally, it seems that most changes in the US versions appear, at some level or another, in the Japanese version, but are unused or incomplete. This possibly means the Japanese version was rushed and the release game was not in a perfect, final form.
* unknown.png. I have no clue what that thing is.
* Probably more things I forgot. :)

# Legal note
I am not a copyright owner of Super Bomberman, and this repository is provided for education proposes only. Any non-educational use of this repository might be illegal if you do not legally own a copy of the game.
