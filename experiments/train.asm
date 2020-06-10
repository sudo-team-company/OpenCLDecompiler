.kernel localVarExample
    .config
        .dims xyz
        .cws 16, 16, 16
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
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
        s_add_u32       s0, s1, s0
        v_add_u32       v3, vcc, s0, v0
        v_cmp_eq_i32    vcc, 0, v3
        s_and_saveexec_b64 s[0:1], vcc
        s_cbranch_execz .L60_0
        s_load_dwordx2  s[2:3], s[4:5], 0x8
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s3, s7, 4
        s_add_u32       s2, s3, s2
        v_add_u32       v3, vcc, s2, v1
.L60_0:
        s_mov_b64       exec, s[0:1]
        s_load_dwordx2  s[0:1], s[4:5], 0x38
        s_load_dword    s2, s[4:5], 0x30
        v_mov_b32       v0, v3
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v4, s1
        v_addc_u32      v1, vcc, v4, v1, vcc
        v_mov_b32       v4, s2
        flat_store_dword v[0:1], v4
        s_load_dword    s3, s[4:5], 0x40
        s_waitcnt       lgkmcnt(0)
        s_cmp_lt_i32    s2, s3
        s_cbranch_scc0  .L172_0
        s_load_dwordx2  s[4:5], s[4:5], 0x10
        s_lshl_b32      s2, s8, 4
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s2, s2, s4
        v_add_u32       v0, vcc, s2, v2
        s_branch        .L176_0
.L172_0:
        v_mov_b32       v0, v3
.L176_0:
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v2, s1
        v_addc_u32      v1, vcc, v2, v1, vcc
        v_mov_b32       v2, s3
        flat_store_dword v[0:1], v2
        s_endpgm