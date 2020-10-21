# Compiling loader
## Prerequisites
- `powerpc64-linux-gnu-gcc`; can be installed in [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) with `sudo apt install powerpc64-linux-gnu-gcc`

## Procedure
1. `cd` to `<game-serial>/loader/`.
2. Run `./make-loader.sh`.
3. [Apply](USERS.md#applying-loader).

# Compiling mods
## Prerequisites
- Python 3, `clang`, `lld`; `sudo apt install python3 clang lld`,
- Patched `lld`; run `python3 patch_lld.py`. Doesn't affect system installation

## Procedure
1. In the project root, run `GAME=<serial-folder> MOD=<mod-folder-name> make`, e.g. `GAME=npea00385 MOD=multi make`.
2. [Apply](USERS.md#installing-mods).
