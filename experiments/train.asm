.kernel localVarExample
    .config
        .dims xy
        .cws 16, 16, 1
        .sgprsnum 16
        .vgprsnum 6
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
        .arg y, "int", int
    .text
        s_load_dwordx4  s[0:3], s[4:5], 0x0
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s1, s6, 4
        v_add_u32       v0, vcc, s1, v0
        s_lshl_b32      s1, s7, 4
        s_add_u32       s1, s1, s2
        v_add_u32       v0, vcc, s0, v0
        v_add_u32       v2, vcc, s1, v1
        v_cmp_eq_i32    vcc, 1, v0
        s_load_dword    s0, s[4:5], 0x30
        s_load_dword    s1, s[4:5], 0x40
        s_load_dwordx2  s[2:3], s[4:5], 0x38
        s_and_saveexec_b64 s[4:5], vcc
        v_mov_b32       v1, 0
        s_cbranch_execz .L112_0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v0, vcc, s2, v0
        v_mov_b32       v3, s3
        v_addc_u32      v1, vcc, v3, v1, vcc
        v_mul_lo_u32    v3, v2, s0
        v_subrev_u32    v4, vcc, s1, v3
.L112_0:
        s_andn2_b64     exec, s[4:5], exec
        s_cbranch_execz .L156_0
        s_waitcnt       lgkmcnt(0)
        s_mul_i32       s1, s1, s0
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v0, vcc, s2, v0
        v_mov_b32       v3, s3
        v_addc_u32      v1, vcc, v3, v1, vcc
        v_mov_b32       v4, s1
.L156_0:
        s_mov_b64       exec, s[4:5]
        v_mov_b32       v3, 0
        v_lshlrev_b64   v[2:3], 2, v[2:3]
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v2, vcc, s2, v2
        v_mov_b32       v5, s3
        v_addc_u32      v3, vcc, v5, v3, vcc
        v_mov_b32       v5, s0
        flat_store_dword v[0:1], v4
        flat_store_dword v[2:3], v5
        s_endpgm