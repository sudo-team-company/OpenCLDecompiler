.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel char_char_short_test
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
        .arg x1, "char", char
        .arg x2, "char", char
        .arg y, "short", short
        .arg data0, "uint*", uint*, global, 
        .arg data1, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dword    s1, s[4:5], 0x30
/*000000000010*/ s_load_dwordx4  s[8:11], s[4:5], 0x38
/*000000000018*/ s_lshl_b32      s2, s6, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s2, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_bfe_i32       s0, s1, 0x80000
/*000000000030*/ s_bfe_i32       s2, s1, 0x80008
/*000000000038*/ s_add_u32       s0, s2, s0
/*00000000003c*/ v_mov_b32       v1, 0
/*000000000040*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000048*/ v_add_u32       v2, vcc, s8, v0
/*00000000004c*/ v_mov_b32       v3, s9
/*000000000050*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*000000000054*/ v_mov_b32       v4, s0
/*000000000058*/ s_bfe_i32       s0, s1, 0x100010
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_mov_b32       v5, s11
/*000000000068*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ flat_store_dword v[2:3], v4
/*000000000078*/ flat_store_dword v[0:1], v5
/*000000000080*/ s_endpgm
