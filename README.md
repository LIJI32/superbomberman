This branch is for Super Hard Bomberman, a difficulty hack of Super Bomberman with new features and various improvements.

# Features & Changes
This ROM hack introduces the following changes and new features:
* Completely reworked story mode focusing on difficulty, incorporating gimmicks that were formerly exclusive to battle mode
* New enemies and new behaviors for certain existing enemies to improve variety
* Revised boss behaviors for increased challenge
* Reduced the initial invincibility duration to prevent abuse
* New Boss Rush mode, available in both single and two player mode
* Three new Battle Mode stages
* The option to randomly pick Battle Mode stages and randomly switch them between rounds
* Various bug fixes compared to the original
* Available in both English and Japanese flavors

Read [the complete change list](CHANGES.md). Beware, it contains spoilers!


# Requirements
The following are required to build a ROM:
* A UNIX-like system to build the ROM on. I generally use OS X to build, but I also correctly built a ROM on a Linux system. I did not test on other UNIX-like systems or Windows.
* [sfcasm](https://github.com/LIJI32/sfcasm)
* md5 or md5sum, for verifying the ROM after compilation
* Clang (or GCC) and libpng, required to build many of the game- and SNES-specific tools in this repository, such as graphic and audio conversion tools
* Make

Build by running <code>make</code> or <code>make CONFIG=x</code>, where x is us, j, or debug.Using the -s and -j flags is recommended.

Alternatively, you can download [IPS patches](https://github.com/LIJI32/superbomberman/releases) and apply them over an original ROM.
