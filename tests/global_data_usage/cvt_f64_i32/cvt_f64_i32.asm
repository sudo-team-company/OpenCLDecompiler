/* Disassembling 'global_data_usage\cvt_f64_i32\cvt_f64_i32.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.globaldata
.gdata:
    .byte 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
    .byte 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
    .byte 0x05, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00
    .byte 0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00
    .byte 0x09, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00
.kernel float_test
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 13
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0041
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
        .arg out, "double*", double*, global, 
        .arg i, "int", int
    .text
/*000000000000*/ s_lshl_b32      s0, s6, 3
/*000000000004*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*00000000000c*/ s_waitcnt       lgkmcnt(0)
/*000000000010*/ s_add_u32       s0, s0, s2
/*000000000014*/ v_add_u32       v0, vcc, s0, v0
/*000000000018*/ v_mov_b32       v1, 0
/*00000000001c*/ v_lshlrev_b64   v[2:3], 2, v[0:1]
/*000000000024*/ s_mov_b32       s1, .gdata>>32
/*00000000002c*/ s_mov_b32       s0, .gdata&0xffffffff
/*000000000034*/ v_add_u32       v2, vcc, s0, v2
/*000000000038*/ v_mov_b32       v4, s1
/*00000000003c*/ v_addc_u32      v3, vcc, v4, v3, vcc
/*000000000040*/ flat_load_dword v2, v[2:3]
/*000000000048*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000050*/ s_load_dwordx2  s[0:1], s[4:5], 0x30
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v0, vcc, s0, v0
/*000000000060*/ v_mov_b32       v3, s1
/*000000000064*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000068*/ s_waitcnt       vmcnt(0)
/*00000000006c*/ v_cvt_f64_i32   v[2:3], v2
/*000000000070*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000078*/ s_endpgm
