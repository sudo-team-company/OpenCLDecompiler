.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 0
.driver_version 203603
.kernel unrolled_polynomial
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
/*000000000050*/ s_waitcnt       lgkmcnt(0)
/*000000000054*/ s_mul_i32       s1, s0, s0
/*000000000058*/ s_waitcnt       vmcnt(0)
/*00000000005c*/ v_mul_lo_u32    v2, v2, s1
/*000000000064*/ v_add_u32       v2, vcc, 1, v2
/*000000000068*/ v_mul_lo_u32    v2, v2, s0
/*000000000070*/ v_add_u32       v2, vcc, 4, v2
/*000000000074*/ v_mul_lo_u32    v2, v2, s0
/*00000000007c*/ v_add_u32       v2, vcc, 9, v2
/*000000000080*/ v_mul_lo_u32    v2, v2, s0
/*000000000088*/ v_add_u32       v2, vcc, 16, v2
/*00000000008c*/ v_mul_lo_u32    v2, v2, s0
/*000000000094*/ v_add_u32       v2, vcc, 25, v2
/*000000000098*/ v_mul_lo_u32    v2, v2, s0
/*0000000000a0*/ v_add_u32       v2, vcc, 36, v2
/*0000000000a4*/ v_mul_lo_u32    v2, v2, s0
/*0000000000ac*/ v_add_u32       v2, vcc, 49, v2
/*0000000000b0*/ v_mul_lo_u32    v2, v2, s0
/*0000000000b8*/ v_add_u32       v2, vcc, 64, v2
/*0000000000bc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000c4*/ v_add_u32       v2, vcc, 0x51, v2
/*0000000000cc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000d4*/ v_add_u32       v2, vcc, 0x64, v2
/*0000000000dc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000e4*/ v_add_u32       v2, vcc, 0x79, v2
/*0000000000ec*/ v_mul_lo_u32    v2, v2, s0
/*0000000000f4*/ v_add_u32       v2, vcc, 0x90, v2
/*0000000000fc*/ v_mul_lo_u32    v2, v2, s0
/*000000000104*/ v_add_u32       v2, vcc, 0xa9, v2
/*00000000010c*/ v_mul_lo_u32    v2, v2, s0
/*000000000114*/ v_add_u32       v2, vcc, 0xc4, v2
/*00000000011c*/ v_mul_lo_u32    v2, v2, s0
/*000000000124*/ v_add_u32       v2, vcc, 0xe1, v2
/*00000000012c*/ v_mul_lo_u32    v2, v2, s0
/*000000000134*/ v_add_u32       v2, vcc, 0x100, v2
/*00000000013c*/ v_mul_lo_u32    v2, v2, s0
/*000000000144*/ v_add_u32       v2, vcc, 0x121, v2
/*00000000014c*/ v_mul_lo_u32    v2, v2, s0
/*000000000154*/ v_add_u32       v2, vcc, 0x144, v2
/*00000000015c*/ v_mul_lo_u32    v2, v2, s0
/*000000000164*/ v_add_u32       v2, vcc, 0x169, v2
/*00000000016c*/ flat_store_dword v[0:1], v2
/*000000000174*/ s_endpgm
