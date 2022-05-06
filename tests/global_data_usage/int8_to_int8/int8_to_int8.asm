/* Disassembling 'global_data_usage\int8_to_int8\int8_to_int8.bin' */
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
    .byte 0x0b, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00
    .byte 0x0d, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00, 0x00
    .byte 0x0f, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00
    .byte 0x11, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00
    .byte 0x13, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00
    .byte 0x15, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00, 0x00
    .byte 0x17, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00
.kernel int_test
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 12
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0042
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
        .arg out, "int8*", int8*, global, 
        .arg i, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 6
/*000000000010*/ s_add_u32       s0, s1, s0
/*000000000014*/ v_add_u32       v0, vcc, s0, v0
/*000000000018*/ v_mov_b32       v1, 0
/*00000000001c*/ v_lshlrev_b64   v[0:1], 5, v[0:1]
/*000000000024*/ s_mov_b32       s1, .gdata>>32
/*00000000002c*/ s_mov_b32       s0, .gdata&0xffffffff
/*000000000034*/ v_add_u32       v2, vcc, s0, v0
/*000000000038*/ v_mov_b32       v3, s1
/*00000000003c*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*000000000040*/ v_add_u32       v4, vcc, v2, 16
/*000000000048*/ v_addc_u32      v5, vcc, v3, 0, vcc
/*000000000050*/ flat_load_dwordx4 v[4:7], v[4:5]
/*000000000058*/ flat_load_dwordx4 v[8:11], v[2:3]
/*000000000060*/ s_load_dwordx2  s[0:1], s[4:5], 0x30
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ v_add_u32       v0, vcc, s0, v0
/*000000000070*/ v_mov_b32       v2, s1
/*000000000074*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000078*/ v_add_u32       v2, vcc, v0, 16
/*000000000080*/ v_addc_u32      v3, vcc, v1, 0, vcc
/*000000000088*/ s_waitcnt       vmcnt(1)
/*00000000008c*/ flat_store_dwordx4 v[2:3], v[4:7]
/*000000000094*/ s_waitcnt       vmcnt(1)
/*000000000098*/ flat_store_dwordx4 v[0:1], v[8:11]
/*0000000000a0*/ s_endpgm
