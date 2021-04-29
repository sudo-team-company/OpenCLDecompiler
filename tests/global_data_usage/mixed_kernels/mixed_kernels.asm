/* Disassembling 'global_data_usage\mixed_kernels\mixed_kernels.bin' */
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
    .byte 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .byte 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .byte 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .byte 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .byte 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.kernel some_array_test
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
        .pgmrsrc2 0x0000098c
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
        .arg out, "long*", long*, global, 
        .arg i, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 3
/*000000000010*/ s_add_u32       s0, s1, s0
/*000000000014*/ v_add_u32       v2, vcc, s0, v0
/*000000000018*/ v_mov_b32       v3, 0
/*00000000001c*/ v_lshlrev_b64   v[4:5], 2, v[2:3]
/*000000000024*/ s_mov_b32       s1, .gdata>>32
/*00000000002c*/ s_mov_b32       s0, .gdata&0xffffffff
/*000000000034*/ v_add_u32       v4, vcc, s0, v4
/*000000000038*/ v_mov_b32       v0, s1
/*00000000003c*/ v_addc_u32      v5, vcc, v0, v5, vcc
/*000000000040*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000000048*/ s_mov_b32       s1, (.gdata+32)>>32
/*000000000050*/ s_mov_b32       s0, (.gdata+32)&0xffffffff
/*000000000058*/ flat_load_dword v12, v[4:5]
/*000000000060*/ v_add_u32       v4, vcc, s0, v2
/*000000000064*/ v_mov_b32       v0, s1
/*000000000068*/ v_addc_u32      v5, vcc, v0, v3, vcc
/*00000000006c*/ flat_load_dwordx2 v[4:5], v[4:5]
/*000000000074*/ s_load_dwordx2  s[0:1], s[4:5], 0x30
/*00000000007c*/ s_lshl_b32      s3, s7, 3
/*000000000080*/ s_add_u32       s2, s3, s2
/*000000000084*/ v_add_u32       v0, vcc, s2, v1
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000094*/ s_waitcnt       lgkmcnt(0)
/*000000000098*/ v_add_u32       v10, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v7, s1
/*0000000000a0*/ v_addc_u32      v11, vcc, v7, v3, vcc
/*0000000000a4*/ v_add_u32       v0, vcc, s0, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ac*/ s_waitcnt       vmcnt(1)
/*0000000000b0*/ v_ashrrev_i32   v13, 31, v12
/*0000000000b4*/ flat_store_dwordx2 v[10:11], v[12:13]
/*0000000000bc*/ s_waitcnt       vmcnt(1)
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[4:5]
/*0000000000c8*/ s_endpgm
