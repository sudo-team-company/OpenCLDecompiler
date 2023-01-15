/* Disassembling 'vector_type_params\char2_reverse_char2\char2_reverse_char2.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel char2_reverse_char2
    .config
        .dims x
        .cws 64, 1, 1
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
        .arg edges1, "char2*", char2*, global, restrict
        .arg edges2, "char2", char2
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dword    s1, s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s4, s6, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_and_b32       s0, s1, 0xff
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 1, v[0:1]
/*00000000003c*/ s_bfe_u32       s1, s1, 0x80008
/*000000000044*/ v_mov_b32       v2, 0x2010004
/*00000000004c*/ v_mov_b32       v3, s0
/*000000000050*/ v_add_u32       v0, vcc, s2, v0
/*000000000054*/ v_mov_b32       v4, s3
/*000000000058*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*00000000005c*/ v_perm_b32      v2, s1, v3, v2
/*000000000064*/ flat_store_short v[0:1], v2
/*00000000006c*/ s_endpgm
