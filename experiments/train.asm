.kernel localVarExample
    .config
        .dims xy
        .cws 16, 16, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        s_load_dwordx4  s[0:3], s[4:5], 0x0
        s_waitcnt       lgkmcnt(0)
        s_load_dword    s1, s[4:5], 0x30
        s_load_dwordx2  s[4:5], s[4:5], 0x38
        s_lshl_b32      s3, s6, 4
        s_lshl_b32      s6, s7, 4
        s_add_u32       s2, s6, s2
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s1, s2, s1
        v_add_u32       v2, vcc, s1, v1
        s_add_u32       s0, s3, s0
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v0, vcc, s4, v0
        v_mov_b32       v3, s5
        v_addc_u32      v1, vcc, v3, v1, vcc
        flat_store_dword v[0:1], v2
        s_endpgm