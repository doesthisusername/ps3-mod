.set memcpy_addr, 0x5C5AD0

.text
.globl _start
_start:
    .prologue:
        lis     r29, 0xB0   # scratch
        std     r0, -0x08(r29)
        std     r1, -0x10(r29)
        std     r2, -0x18(r29)
        std     r3, -0x20(r29)
        std     r4, -0x28(r29)
        std     r5, -0x30(r29)
        std     r6, -0x38(r29)
        std     r7, -0x40(r29)
        std     r8, -0x48(r29)
        std     r9, -0x50(r29)
        std     r10, -0x58(r29)
        std     r11, -0x60(r29)
        std     r12, -0x68(r29)
        std     r13, -0x70(r29)
        std     r14, -0x78(r29)
        std     r15, -0x80(r29)
        std     r16, -0x88(r29)
        std     r17, -0x90(r29)
        std     r18, -0x98(r29)
        std     r19, -0xA0(r29)
        std     r20, -0xA8(r29)
        std     r21, -0xB0(r29)
        std     r22, -0xB8(r29)
        std     r23, -0xC0(r29)
        std     r24, -0xC8(r29)
        std     r25, -0xD0(r29)
        std     r26, -0xD8(r29)
        std     r27, -0xE0(r29)
        std     r28, -0xE8(r29)
        std     r30, -0xF0(r29)
        std     r31, -0xF8(r29)
    .copy_dir_path:
        lis     r3, ovl_full_path@h
        lis     r4, moddir_path@h
        ori     r3, r3, ovl_full_path@l
        ori     r4, r4, moddir_path@l
        li      r5, moddir_path_len
        bla     memcpy_addr
    .open_dir:
        lis     r3, moddir_path@h
        lis     r31, moddir_fd@h
        ori     r3, r3, moddir_path@l
        ori     r31, r31, moddir_fd@l
        mr      r4, r31
        li      r11, 0x325  # opendir
        sc
        lis     r30, dirent_type@h
        ori     r30, r30, dirent_type@l
        lis     r29, dir_nread@h
        ori     r29, r29, dir_nread@l
    .iterate_dir:
        lwz     r3, 0x00(r31)
        mr      r4, r30
        mr      r5, r29
        li      r11, 0x326  # readdir
        sc
        ld      r3, 0x00(r29)   # load nread
        cmpdi   5, r3, 0        # nread == 0
        beq     5, .close_dir
        lbz     r3, 0x00(r30)   # load d_type
        cmpwi   5, r3, 2        # CELL_FS_TYPE_REGULAR
        bne     5, .iterate_dir
        lis     r3, ovl_full_path@h
        ori     r3, r3, ovl_full_path@l
        addi    r3, r3, moddir_path_len
        addi    r4, r30, 0x02   # dirent_name
        lbz     r5, 0x01(r30)   # dirent_namlen
        addi    r5, r5, 0x01    # include null term
        bla     memcpy_addr
        lis     r3, ovlmid@h
        lis     r4, ovl_full_path@h
        lis     r6, ovl_entry@h
        li      r5, 0x00
        ori     r3, r3, ovlmid@l
        ori     r4, r4, ovl_full_path@l
        ori     r6, r6, ovl_entry@l
        li      r11, 0x1C2  # sys_overlay_load_module
        sc
        cmpwi   5, r3, 0
        bne     5, .iterate_dir    # skip on fail
        lis     r3, ovl_entry@h
        lis     r5, ovl_n@h
        ori     r3, r3, ovl_entry@l
        ori     r5, r5, ovl_n@l
        lwz     r6, 0x00(r5)    # ovl_n
        lis     r7, ovl_modules@h
        ori     r7, r5, ovl_modules@l
        mulli   r8, r6, sizeof_ovl
        add     r8, r8, r7
        lwz     r3, 0x00(r3)
        #ld      r4, 0x00(r3)    # _start function pointer
        #ld      r20, 0x08(r3)    # TOC address
        li      r20, 0x00
        ori     r20, r20, 0x8000
        stw     r3, ovl_start(r8)
        #stw     r20, ovl_toc(r8)
        addi    r6, r6, 1
        stw     r6, 0x00(r5)
        mtctr   r3
        bctrl
        b       .iterate_dir
    .close_dir:
        lwz     r3, 0x00(r31)
        li      r11, 0x327  # closedir
        sc
    .epilogue:
        lis     r29, 0xB0
        ld      r0, -0x08(r29)
        ld      r1, -0x10(r29)
        ld      r2, -0x18(r29)
        ld      r3, -0x20(r29)
        ld      r4, -0x28(r29)
        ld      r5, -0x30(r29)
        ld      r6, -0x38(r29)
        ld      r7, -0x40(r29)
        ld      r8, -0x48(r29)
        ld      r9, -0x50(r29)
        ld      r10, -0x58(r29)
        ld      r11, -0x60(r29)
        ld      r12, -0x68(r29)
        ld      r13, -0x70(r29)
        ld      r14, -0x78(r29)
        ld      r15, -0x80(r29)
        ld      r16, -0x88(r29)
        ld      r17, -0x90(r29)
        ld      r18, -0x98(r29)
        ld      r19, -0xA0(r29)
        ld      r20, -0xA8(r29)
        ld      r21, -0xB0(r29)
        ld      r22, -0xB8(r29)
        ld      r23, -0xC0(r29)
        ld      r24, -0xC8(r29)
        ld      r25, -0xD0(r29)
        ld      r26, -0xD8(r29)
        ld      r27, -0xE0(r29)
        ld      r28, -0xE8(r29)
        ld      r30, -0xF0(r29)
        ld      r31, -0xF8(r29)
        ba      0x0147D4    # return

moddir_path: 
    .ascii      "/dev_hdd0/game/NPEA00385/USRDIR/mod/\0"

.set moddir_path_len, . - moddir_path - 1

# align 0x400
.align 10
hook:
    hook.prologue:
        lis     r5, hooks@h
        ori     r5, r5, hooks@l
    .find_empty:
        lwz     r4, 0x00(r5)
        cmpwi   5, r4, 0x00
        beq     5, .write_hook
        addi    r5, r5, sizeof_hook
        b       .find_empty
    .write_hook:
        lwz     r6, hook_func(r3)
        stw     r6, hook_func(r5)
        lwz     r6, hook_target(r3)
        stw     r6, hook_target(r5)
        lwz     r6, hook_priority(r3)
        stw     r6, hook_priority(r5)
        blr

# align 0x100
.align 8
unhook:
    unhook.prologue:
        lis     r5, hooks@h
        ori     r5, r5, hooks@l
        li      r7, 0x00
        b       .find_hook_first
    .find_hook:
        addi    r5, r5, sizeof_hook
        addi    r7, r7, 1
        cmpwi   5, r7, 32
        beqlr   5
    .find_hook_first:
        lwz     r4, hook_func(r5)
        lwz     r6, hook_func(r3)
        cmpw    5, r4, r6
        bne     5, .find_hook
        lwz     r4, hook_target(r5)
        lwz     r6, hook_target(r3)
        cmpw    5, r4, r6
        bne     5, .find_hook
        lwz     r4, hook_priority(r5)
        lwz     r6, hook_priority(r3)
        cmpw    5, r4, r6
        bne     5, .find_hook
        li      r3, 0x00
        stw     r3, hook_func(r5)
        stw     r3, hook_target(r5)
        stw     r3, hook_priority(r5)
        blr

# align 0x100
.align 8
hookpoint:
    hookpoint.prologue:
        stwu    r1, -0x40(r1)
        stw     r31, 0x3C(r1)
        stw     r30, 0x38(r1)
        stw     r29, 0x34(r1)
        stw     r28, 0x30(r1)
        stw     r27, 0x2C(r1)
        stw     r20, 0x28(r1)
        mr      r27, r3
        mflr    r3
        stw     r3, 0x24(r1)
        li      r31, 0x00
    hookpoint.level:
        addi    r31, r31, 1
        lis     r30, hooks@h
        ori     r30, r30, hooks@l
        li      r28, 0x00
        b       .find_hook_begin
    .find_hook_again:
        addi    r30, r30, sizeof_hook
        addi    r28, r28, 1
        cmpwi   5, r28, 32
        bne     5, .find_hook_begin
        cmpwi   5, r31, prio_level_n
        bne     5, hookpoint.level
        lwz     r3, 0x24(r1)
        mtlr    r3
        lwz     r20, 0x28(r1)
        lwz     r27, 0x2C(r1)
        lwz     r28, 0x30(r1)
        lwz     r29, 0x34(r1)
        lwz     r30, 0x38(r1)
        lwz     r31, 0x3C(r1)
        addi    r1, r1, 0x40
        blr
    .find_hook_begin:
        lwz     r29, hook_priority(r30)
        cmpw    5, r29, r31
        bne     5, .find_hook_again
        lwz     r29, hook_target(r30)
        cmpw    5, r27, r29
        bne     5, .find_hook_again
        lwz     r27, hook_func(r30)
        mtctr   r27
        li      r20, 0x00
        ori     r20, r20, 0x8000
        bctrl
        b       .find_hook_again

# align 0x100
.align 8
hookpoint_input:
    hookpoint_input.prologue:
        stwu    r1, -0x10(r1)
        stw     r3, 0x0C(r1)
        mflr    r3
        stw     r3, 0x08(r1)
        li      r3, target_input
        bl      hookpoint
        lwz     r3, 0x08(r1)
        mtlr    r3
        lwz     r3, 0x0C(r1)
        addi    r1, r1, 0x10
        blr

# align 0x100
.align 8
hookpoint_draw:
    hookpoint_draw.prologue:
        stwu    r1, -0x10(r1)
        stw     r3, 0x0C(r1)
        mflr    r3
        stw     r3, 0x08(r1)
        li      r3, target_draw
        bl      hookpoint
        lwz     r3, 0x08(r1)
        mtlr    r3
        lwz     r3, 0x0C(r1)
        addi    r1, r1, 0x10
        blr

.data

moddir_fd:
    .int        0

dir_nread:
    .quad       0

dirent_type:
    .byte       0

dirent_namlen:
    .byte       0

dirent_name:
    .rept       256
    .byte       0
    .endr

.align 2
ovl_full_path:
    .rept       256
    .byte       0
    .endr

ovlmid:
    .int        0

ovl_entry:
    .int        0

.set sizeof_ovl, 0x08
.set ovl_start, 0x00
.set ovl_toc, 0x04

ovl_n:
    .int        0

ovl_modules:
    .rept       16
    .int        0
    .int        0
    .endr

.set target_input, 0
.set target_draw, 1

.set prio_level_n, 3
.set prio_early, 1
.set prio_normal, 2
.set prio_late, 3

.set sizeof_hook, 0x0C
.set hook_func, 0x00
.set hook_target, 0x04
.set hook_priority, 0x08

hooks:
    .rept       32
    .int        0       # func
    .int        0       # target
    .int        0       # priority
    .endr
