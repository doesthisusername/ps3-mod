#!/bin/bash

s() {
    powerpc64-linux-gnu-as -o $1.o -mregnames -mcell -be $1.s
    powerpc64-linux-gnu-ld -Ttext=$2 -Tdata=$3 -o $1.elf $1.o
    powerpc64-linux-gnu-objcopy --dump-section .text=${1}.bin $1.elf
    rm $1.o $1.elf
}

s loader 4F8000 B00000
