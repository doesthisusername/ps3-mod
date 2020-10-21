# Applying loader
Only needs to be done once per game.

## Prerequisites
- [RPCS3](https://rpcs3.net),
- [Python 3](https://www.python.org/downloads/),
- [apply_loader.py](apply_loader.py),
- [make_fself.exe](make_fself.exe),
- patch.txt for your game, can be found at `<this-repo>/<game-serial>/loader/patch.txt`,
- loader.bin for your game, can hopefully be found in the Releases tab

## Procedure
1. Open RPCS3.
2. At the top, select `Utilities` -> `Decrypt PS3 Binaries`.
3. Browse to the game's `EBOOT.BIN`, and select it for decryption:
    - Windows: `<rpcs3-exe-dir>/dev_hdd0/game/<game-serial>/USRDIR/EBOOT.BIN`
    - Linux: `~/.config/rpcs3/dev_hdd0/game/<game-serial>/USRDIR/EBOOT.BIN`
4. Move the resultant `EBOOT.elf` to the same directory as you put `apply_loader.py`, `patch.txt`, `loader.bin`, and `make_fself.exe`.
5. Rename `EBOOT.elf` to `EBOOT.ELF.bak`.
6. Run `apply_loader.py`. This can be done via double-click or the command line.
7. Run `make_fself.exe EBOOT.ELF EBOOT.BIN` in `cmd` or terminal. On Linux, `wine` works.
8. Move `EBOOT.BIN` back to the game directory, replacing it in the process. Backing up the original `EBOOT.BIN` is recommended, as it will enable you to swap between the loader and vanilla.
9. Celebrate!

# Installing mods
## Prerequisites
- The mod (usually ends in .elf), compiled for the game in question
- Loader applied for the game in question

## Procedure
1. Browse to the game's `EBOOT.BIN`.
2. Make a directory called `mod`.
3. Place the mod in the `mod` folder.
4. If required, follow any mod-specific instructions.
