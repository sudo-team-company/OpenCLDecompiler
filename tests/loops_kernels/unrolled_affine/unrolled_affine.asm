.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 0
.driver_version 203603
.kernel unrolled_affine
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac02c0
        .pgmrsrc2 0x0000008c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_lshl_b32      s2, s6, 6
/*00000000000c*/ s_load_dwordx2  s[6:7], s[4:5], 0x30
/*000000000014*/ v_add_u32       v0, vcc, s2, v0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ v_add_u32       v0, vcc, v0, s0
/*000000000024*/ v_mov_b32       v1, s1
/*000000000028*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s6, v0
/*000000000038*/ v_mov_b32       v2, s7
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ flat_load_dword v2, v[0:1]
/*000000000048*/ s_load_dword    s0, s[4:5], 0x38
/*000000000050*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000054*/ v_mul_lo_u32    v2, v2, s0
/*00000000005c*/ v_add_u32       v2, vcc, 1, v2
/*000000000060*/ v_mul_lo_u32    v2, v2, s0
/*000000000068*/ v_add_u32       v2, vcc, 3, v2
/*00000000006c*/ v_mul_lo_u32    v2, v2, s0
/*000000000074*/ v_add_u32       v2, vcc, 7, v2
/*000000000078*/ v_mul_lo_u32    v2, v2, s0
/*000000000080*/ v_add_u32       v2, vcc, 15, v2
/*000000000084*/ v_mul_lo_u32    v2, v2, s0
/*00000000008c*/ v_add_u32       v2, vcc, 31, v2
/*000000000090*/ v_mul_lo_u32    v2, v2, s0
/*000000000098*/ v_add_u32       v2, vcc, 63, v2
/*00000000009c*/ v_mul_lo_u32    v2, v2, s0
/*0000000000a4*/ v_add_u32       v2, vcc, 0x7f, v2
/*0000000000ac*/ v_mul_lo_u32    v2, v2, s0
/*0000000000b4*/ v_add_u32       v2, vcc, 0xff, v2
/*0000000000bc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000c4*/ v_add_u32       v2, vcc, 0x1ff, v2
/*0000000000cc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000d4*/ v_add_u32       v2, vcc, 0x3ff, v2
/*0000000000dc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000e4*/ v_add_u32       v2, vcc, 0x7ff, v2
/*0000000000ec*/ v_mul_lo_u32    v2, v2, s0
/*0000000000f4*/ v_add_u32       v2, vcc, 0xfff, v2
/*0000000000fc*/ v_mul_lo_u32    v2, v2, s0
/*000000000104*/ v_add_u32       v2, vcc, 0x1fff, v2
/*00000000010c*/ v_mul_lo_u32    v2, v2, s0
/*000000000114*/ v_add_u32       v2, vcc, 0x3fff, v2
/*00000000011c*/ v_mul_lo_u32    v2, v2, s0
/*000000000124*/ v_add_u32       v2, vcc, 0x7fff, v2
/*00000000012c*/ v_mul_lo_u32    v2, v2, s0
/*000000000134*/ v_add_u32       v2, vcc, 0xffff, v2
/*00000000013c*/ v_mul_lo_u32    v2, v2, s0
/*000000000144*/ v_add_u32       v2, vcc, 0x1ffff, v2
/*00000000014c*/ v_mul_lo_u32    v2, v2, s0
/*000000000154*/ v_add_u32       v2, vcc, 0x3ffff, v2
/*00000000015c*/ v_mul_lo_u32    v2, v2, s0
/*000000000164*/ v_add_u32       v2, vcc, 0x7ffff, v2
/*00000000016c*/ v_mul_lo_u32    v2, v2, s0
/*000000000174*/ v_add_u32       v2, vcc, 0xfffff, v2
/*00000000017c*/ flat_store_dword v[0:1], v2
/*000000000184*/ s_endpgm
