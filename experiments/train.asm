
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uint*", uint*, global,
    .text
        s_lshl_b32      s0, s6, 1
        v_add_u32       v0, vcc, s0, v0
        s_lshl_b32      s0, s7, 1
        s_lshl_b32      s1, s8, 2
        s_load_dwordx4  s[8:11], s[4:5], 0x8
        s_load_dwordx2  s[2:3], s[4:5], 0x38
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s0, s0, s8
        s_add_u32       s1, s1, s10
        v_add_u32       v3, vcc, s0, v1
        v_add_u32       v2, vcc, s1, v2
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v2, vcc, v2, v3
        v_add_u32       v0, vcc, s2, v0
        v_mov_b32       v3, s3
        v_addc_u32      v1, vcc, v3, v1, vcc
        flat_store_dword v[0:1], v2
        s_endpgm