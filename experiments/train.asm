.kernel copy3_new
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
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
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
        s_load_dwordx2  s[0:1], s[4:5], 0x8
        s_load_dwordx2  s[2:3], s[4:5], 0x38
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s1, s6, 3
        v_add_u32       v2, vcc, s1, v0
        s_lshl_b32      s1, s7, 3
        s_add_u32       s0, s1, s0
        v_mov_b32       v3, 0
        v_lshlrev_b64   v[2:3], 2, v[2:3]
        v_add_u32       v4, vcc, s0, v1
        v_add_u32       v0, vcc, s2, v2
        v_mov_b32       v1, s3
        v_addc_u32      v1, vcc, v1, v3, vcc
        flat_store_dword v[0:1], v4
        s_endpgm