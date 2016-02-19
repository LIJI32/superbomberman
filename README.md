# superbomberman
Disassembly and remade build system for SNES game Super Bomberman, inspired by [pokered](https://github.com/iimarckus/pokered) and [pokecrystal](https://github.com/kanzure/pokecrystal).

This branch is the _randomizer_ branch.

# Output ROM
This disassembly builds a ROM with randomized story mode levels, based on the following headerless SNES ROMs:
<pre>
Super Bomberman 1 (US): d83699a009a62480a7e7e9f1bb5bff6e
Super Bomberman 1 (J) : cbef5f02304a2b821a0e1642a6307564
Super Bomberman 1 (E) : ddee4ddff2f3b6e31b8f73d0cb597ef1
</pre>
It can also build a bugfix version, based on the US version, that fixes some (mostly graphical) bugs, and can also restore access to the debug menu used during development with a debug version. The configuration files let you mix-and-match specific regional changes.

# Requirements
The following are required to build a ROM:
* A UNIX-like system to build the ROM on. I generally use OS X to build, but I also correctly built a ROM on a Linux system. I did not test on other UNIX-like systems or Windows.
* ca65 and ld65, from the [cc65 package](https://github.com/cc65/cc65). It is required for assembling and linking the ROM.
* md5 or md5sum, for verifying the ROM after compilation
* python, required to run many of the game- and SNES-specific tools in this repository, such as graphic and audio conversion tools

Build by running <code>make</code> or <code>make CONFIG=x</code>, where x is us, j, e, bugfix, debug or any other configuration file in the config folder. Using the -s and -j flags is recommended

# What is done
* Shuffling the order of areas
* Including battle-mode-only areas in story mode
* Randomized enemies and bonuses
* Enemies and bonuses are introduced as the game progresses
* Difficulty is increased as the game progresses

# What's not done
* Boss and arena levels have constant difficulty, regardless of their position in the game progress
* Most “traps” (clouds, trampolines, tunnels, etc) are not included.
* Other planned features:
 * Inclusion of harder versions of existing enemies (Similar to Propene and Metal Propene, for example)
 * Enhancements to boss levels
 * Configurable difficulty function
 * Fixing bugs and design flaws that make the game easier (Such as the “Bombs Trick”)
 * Open to suggestions!
 
# Known Issues
* In arena levels, the crowd will not make any sound if the arena is not world 5
* After beating Spiderer, some of the bonuses will reset

# Legal note
I am not a copyright owner of Super Bomberman, and this repository is provided for education proposes only. Any non-educational use of this repository might be illegal if you do not legally own a copy of the game.
