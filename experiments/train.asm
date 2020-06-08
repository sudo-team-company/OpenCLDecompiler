.kernel localVarExample
    .config
        .dims xyz
        .cws 16, 16, 16
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
        .arg data, "int*", int*, global,
        .arg y, "int", int
    .text
        s_load_dwordx2  s[0:1], s[4:5], 0x0
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s1, s6, 4
        v_add_u32       v0, vcc, s1, v0
        v_add_u32       v0, vcc, s0, v0
        v_cmp_eq_i32    vcc, 0, v0
        s_load_dwordx2  s[0:1], s[4:5], 0x38
        s_and_saveexec_b64 s[2:3], vcc
        s_cbranch_execz .L160_0
        s_load_dwordx2  s[10:11], s[4:5], 0x8
        s_lshl_b32      s6, s7, 4
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s6, s6, s10
        v_add_u32       v1, vcc, s6, v1
        v_and_b32       v1, 1, v1
        v_cmp_eq_u32    vcc, 0, v1
        s_and_saveexec_b64 s[6:7], vcc
        s_cbranch_execz .L160_0
        s_load_dwordx2  s[10:11], s[4:5], 0x10
        s_lshl_b32      s8, s8, 4
        s_load_dword    s9, s[4:5], 0x30
        v_add_u32       v1, vcc, s8, v2
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v1, vcc, v1, s10
        v_mov_b32       v2, s11
        v_addc_u32      v2, vcc, 0, v2, vcc
        v_lshlrev_b64   v[1:2], 2, v[1:2]
        v_add_u32       v1, vcc, s0, v1
        v_mov_b32       v3, s1
        v_addc_u32      v2, vcc, v3, v2, vcc
        v_mov_b32       v3, s9
        flat_store_dword v[1:2], v3
.L160_0:
        s_mov_b64       exec, s[2:3]
        s_load_dword    s2, s[4:5], 0x40
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v2, s1
        v_addc_u32      v1, vcc, v2, v1, vcc
        v_mov_b32       v2, s2
        flat_store_dword v[0:1], v2
        s_endpgm