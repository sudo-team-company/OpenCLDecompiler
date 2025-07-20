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
.kernel test
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg in, "int*", int*, global, 
        .arg out, "uint*", uint*, global, , rdonly
        .arg i, "int", int
    .text
/*000000000000*/ s_load_dword    s8, s[4:5], 0x40
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_ashr_i32      s9, s8, 31
/*000000000024*/ s_lshl_b64      s[6:7], s[8:9], 2
/*000000000028*/ s_mov_b32       s9, .gdata>>32
/*000000000030*/ s_mov_b32       s8, .gdata&0xffffffff
/*000000000038*/ s_add_u32       s6, s8, s6
/*00000000003c*/ s_addc_u32      s7, s9, s7
/*000000000040*/ s_load_dword    s0, s[6:7], 0x0
/*000000000048*/ s_add_u32       s1, s1, s2
/*00000000004c*/ v_add_u32       v1, vcc, s1, v0
/*000000000050*/ v_mov_b32       v0, 0
/*000000000054*/ v_ashrrev_i64   v[0:1], 30, v[0:1]
/*00000000005c*/ v_add_u32       v0, vcc, s4, v0
/*000000000060*/ v_mov_b32       v2, s5
/*000000000064*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ v_mov_b32       v2, s0
/*000000000070*/ flat_store_dword v[0:1], v2
/*000000000078*/ s_endpgm
