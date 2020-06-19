.kernel localVarExample
    .config
        .dims xy
        .cws 16, 16, 16
        .sgprsnum 16
        .vgprsnum 7
        .localsize 512
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
        .arg res, "int*", int*, global,
    .text
        s_mov_b32       m0, 0x10000
        s_load_dwordx4  s[0:3], s[4:5], 0x0
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s1, s6, 4
        v_add_u32       v0, vcc, s1, v0
        s_lshl_b32      s1, s7, 4
        v_add_u32       v1, vcc, s1, v1
        v_add_u32       v5, vcc, s0, v0
        v_lshlrev_b32   v2, 2, v5
        v_mov_b32       v3, 0
        ds_write_b32    v2, v3
        v_add_u32       v1, vcc, s2, v1
        v_lshlrev_b32   v3, 2, v1
        v_mov_b32       v4, 1
        ds_write_b32    v3, v4 offset:256
        v_mov_b32       v4, 0
        v_ashrrev_i64   v[4:5], 30, v[4:5]
        v_mov_b32       v0, 0
        v_ashrrev_i64   v[0:1], 30, v[0:1]
        s_waitcnt       lgkmcnt(0)
        s_barrier
        v_mov_b32       v6, 1
        ds_add_u32      v2, v6
        s_waitcnt       lgkmcnt(0)
        s_barrier
        s_load_dwordx2  s[0:1], s[4:5], 0x30
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v6, s1
        v_addc_u32      v1, vcc, v6, v1, vcc
        v_add_u32       v4, vcc, s0, v4
        v_addc_u32      v5, vcc, v6, v5, vcc
        s_barrier
        ds_read_b32     v6, v2
        s_waitcnt       lgkmcnt(0)
        ds_write_b32    v2, v6 offset:256
        v_mov_b32       v6, 1
        ds_add_u32      v3, v6 offset:256
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read_b32     v6, v3 offset:256
        s_waitcnt       lgkmcnt(0)
        ds_write_b32    v2, v6
        s_waitcnt       lgkmcnt(0)
        s_barrier
        ds_read_b32     v2, v2
        ds_read_b32     v3, v3 offset:256
        s_waitcnt       lgkmcnt(1)
        flat_store_dword v[4:5], v2
        s_waitcnt       lgkmcnt(1)
        flat_store_dword v[0:1], v3
        s_endpgm