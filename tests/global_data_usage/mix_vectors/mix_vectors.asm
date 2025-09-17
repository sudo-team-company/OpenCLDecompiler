.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.globaldata
.gdata:
    .byte 0x0b, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00
    .byte 0x0d, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00, 0x00
    .fill 16, 1, 0x00
    .byte 0x00, 0x00, 0x80, 0x3f, 0x00, 0x00, 0x00, 0x40
    .byte 0x00, 0x00, 0x40, 0x40, 0x00, 0x00, 0x80, 0x40
    .byte 0x00, 0x00, 0xa0, 0x40, 0x00, 0x00, 0xc0, 0x40
    .byte 0x00, 0x00, 0xe0, 0x40, 0x00, 0x00, 0x00, 0x41
.kernel test
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 17
        .vgprsnum 6
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
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
        .arg in, "float*", float*, global, 
        .arg out, "int*", int*, global, 
        .arg i, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x40
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_ashr_i32      s1, s0, 31
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000018*/ s_lshl_b64      s[0:1], s[0:1], 2
/*00000000001c*/ s_mov_b32       s9, (.gdata+32)>>32
/*000000000024*/ s_mov_b32       s8, (.gdata+32)&0xffffffff
/*00000000002c*/ s_mov_b32       s11, .gdata>>32
/*000000000034*/ s_mov_b32       s10, .gdata&0xffffffff
/*00000000003c*/ s_add_u32       s8, s8, s0
/*000000000040*/ s_addc_u32      s9, s9, s1
/*000000000044*/ s_add_u32       s0, s10, s0
/*000000000048*/ s_addc_u32      s1, s11, s1
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_load_dword    s3, s[8:9], 0x0
/*000000000058*/ s_load_dwordx4  s[8:11], s[4:5], 0x30
/*000000000060*/ s_lshl_b32      s4, s6, 6
/*000000000064*/ s_load_dword    s0, s[0:1], 0x0
/*00000000006c*/ s_add_u32       s1, s4, s2
/*000000000070*/ v_add_u32       v1, vcc, s1, v0
/*000000000074*/ v_mov_b32       v0, 0
/*000000000078*/ v_ashrrev_i64   v[0:1], 30, v[0:1]
/*000000000080*/ s_waitcnt       lgkmcnt(0)
/*000000000084*/ v_add_u32       v2, vcc, s8, v0
/*000000000088*/ v_mov_b32       v3, s9
/*00000000008c*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*000000000090*/ v_mov_b32       v4, s3
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_mov_b32       v5, s11
/*00000000009c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a0*/ v_mov_b32       v5, s0
/*0000000000a4*/ flat_store_dword v[2:3], v4
/*0000000000ac*/ flat_store_dword v[0:1], v5
/*0000000000b4*/ s_endpgm
