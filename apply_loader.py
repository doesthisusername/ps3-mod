#!/usr/bin/env python3

elfmem = None
with open("EBOOT.ELF.bak", "rb") as elf:
    elfmem = bytearray(elf.read())

with open("patch.txt", "r") as txt:
    with open("EBOOT.ELF", "wb+") as elf:
        while True:
            line = txt.readline()
            if line == "":
                break
            
            if line[0] == "#" or line[0] == "\n" or line[0] == "\r":
                continue

            where, what = line.split(": ")
            where = int(where, 0) - 0x10000 # base address in memory is 0x10000
            
            try:
                what = int(what, 0).to_bytes(4, "big")
            except ValueError:
                with open(what.strip(), "rb") as patch:
                    what = patch.read()

            elfmem[where : where + len(what)] = what
            
        elf.write(elfmem)
