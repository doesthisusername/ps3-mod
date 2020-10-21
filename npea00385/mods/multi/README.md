# rc1 // multi

## Summary
This mod adds extremely simplistic multiplayer to the game, with a host-client model. The two players are unable to interact much, but can see each other.

## Setup
1. Place `multi.elf` in your `NPEA00385/USRDIR/mod/` folder.
2. Create the file `host.txt` in `NPEA00385/USRDIR/mod/multi/`.

## Host usage
1. Edit `host.txt` such that it contains only `0.0.0.0:<fitting port>`, e.g. `0.0.0.0:27111`.
2. Ensure the port you chose is open.

## Client usage
1. Edit `host.txt` such that it contains only `<host's public ip>:<same port as host>`, e.g. `93.86.111.201:27111`.
