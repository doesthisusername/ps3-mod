BASE_ADDRESS = 0x33000000;

hook = 0x4F8400;
unhook = 0x4F8500;

player_moby = 0x96BD60;
player_bolts = 0x969CA0;
current_planet = 0x969C70;

should_load = 0xA10700;
level_frame_count = 0xA10710;

spawn_moby = 0x0EFA28;
memcpy = 0x5C5AD0;
printf = 0x5CD098;

SECTIONS {
    . = BASE_ADDRESS;
    .text : {
        *(.text);
    }

    . = ALIGN(0x10000);
    .rodata : {
        *(.rodata*);
    }

    . = ALIGN(0x10000);
    .got : {
        *(.got);
        *(.got2);
    }

    . = ALIGN(0x10000);
    .opd : {
        *(.opd);
    }

    . = ALIGN(0x10000);
    .data : {
        *(.data);
    }

    . = ALIGN(0x10000);
    .bss : {
        *(.bss);
    }

    . = ALIGN(0x10000);
    .branch_lt : {
        *(.branch_lt);
    }
}
