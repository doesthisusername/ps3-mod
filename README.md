# ps3-mod

## Summary
Modloader for PS3 games, designed to be feasibly ported to new games (can't support all out of the box like this). Currently just supports Ratchet & Clank (NPEA00385). It will only work in RPCS3 until it's figured out how to make PS3 not reject the overlays.

## Usage
Usage is split up into three READMEs, in increasing order of complexity. I recommend reading them in order up to your preferred level of complexity:
- [USERS.md](USERS.md), for running pre-compiled mods, and applying the loader.bin file to a game EBOOT. Minimal set of programs required.
- [COMPILERS.md](COMPILERS.md), for compiling mods and loaders yourself, if you can't find them pre-compiled. Explains setting up a development "toolchain".
- [DEVELOPERS.md](DEVELOPERS.md), for writing new mods and loaders.
