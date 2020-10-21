.kernel add_long_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 15
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
        .pgmrsrc2 0x0000138c
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v7, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000048*/ v_add_u32       v9, vcc, s0, v2
/*00000000004c*/ v_add_u32       v11, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v12, vcc, v3, v4, vcc
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 4
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v13, vcc, s4, v8
/*000000000084*/ v_addc_u32      v14, vcc, v3, v9, vcc
/*000000000088*/ v_lshlrev_b64   v[8:9], 0, 8
/*000000000090*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[1:2], v[5:6]
/*0000000000a0*/ flat_store_dwordx2 v[13:14], v[8:9]
/*0000000000a8*/ s_endpgm