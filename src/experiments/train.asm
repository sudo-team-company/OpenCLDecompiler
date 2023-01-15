/* Disassembling 'unused_params\two_unused_params\two_unused_params.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel two_unused_params
    .config
        .dims xy
        .sgprsnum 20
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x00000990
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg n, "int", int
        .arg w, "int", int
        .arg z, "int", int
        .arg data, "int*", int*, global,
        .arg data1, "int*", int*, global, , rdonly
        .arg x, "int", int
        .arg y, "int", int
    .text
    test_instruction
    ds_add_u32                        v4, v5 offset:256
    ds_bpermute_b32                   v0, v0, v1 offset:0x10
    ds_read_b32                       v3, v4 offset:256
    ds_read_b64                       v3, v4 offset:256
    ds_read2_b64                      v90, v[76:77], offset0:16 offset1:32
    ds_write_b32                      v4, v5 offset:256
    ds_write_b64                      v4, v[5:6] offset:256
    ds_write2_b64                     v4, v[5:6], v[7:8] offset0:256 offset1:offset
    flat_atomic_add                   v4, v[5:6], v7
    flat_load_dword                   v2, v[2:3]
    flat_load_dwordx4                 v[1:2], v[2:3]
    flat_store_dword                  v[0:1], v2
    flat_store_dwordx2                v[0:1], v[2:3]
    flat_store_dwordx4                v[0:1], v[2:5]
    global_load_dword                 v2, v[0:1], off
    global_load_dwordx2               v[2:3], v[0:1], off
    global_store_dword                v[2:3], v4, off
    global_store_dwordx2              v[2:3], v[4:5], off
    s_load_dword                      s1, s[4:5], 0x30
    s_load_dwordx2                    s[0:1], s[4:5], 0x0
    s_load_dwordx4                    s[0:3], s[4:5], 0x4
    s_load_dwordx8                    s[0:7], s[4:5], 0x30
    s_and_saveexec_b64                s[0:1], vcc
    s_getpc_b64                       s[0:1]
    s_mov_b32                         s0, s6
    s_mov_b64                         exec, s[4:5]
    s_not_b64                         s[0:1], s[2:3]
    s_setpc_b64                       s[0:1]
    s_swappc_b64                      s[0:1], s[2:3]
    s_add_u32                         s0, s4, s0
    s_addc_u32                        s9, s13, -1
    s_and_b32                         s5, s0, 0xffff
    s_and_b64                         s[10:11], s[8:9], s[10:11]
    s_andn2_b64                       exec, s[4:5], exec
    s_ashr_i32                        s0, s1, 31
    s_bfe_u32                         s0, s0, 0x100010
    s_bfe_i32                         s0, s0, 0x100010
    s_cselect_b64                     vcc, exec, 0
    s_lshl_b32                        s6, s6, 6
    s_lshl_b64                        s[0:1], s[4:5], 2
    s_lshr_b32                        s0, s3, 2
    s_min_i32                         s0, s1, s0
    s_mul_i32                         s5, s5, s8
    s_sub_i32                         s6, 4, s9
    s_sub_u32                         s6, 4, s9
    s_cmp_eq_i32                      s0, s1
    s_cmp_eq_u32                      s0, s1
    s_cmp_eq_u64                      1, s[0:1]
    s_cmp_ge_i32                      s0, s1
    s_cmp_ge_u32                      s10, s0
    s_cmp_lt_i32                      s2, s3
    s_set_gpr_idx_on                  s0, s1
    s_movk_i32                        s1, 0x0
    s_mulk_i32                        s2, 0x6
    s_setreg_b32                      s0, s1, s2, s3, s4
    s_barrier
    s_branch                          .L172_0
    s_cbranch_execz                   .L172_0
    s_cbranch_scc0                    .L172_0
    s_cbranch_scc1                    .L172_0
    s_cbranch_vccnz                   .L172_0
    s_cbranch_vccz                    .L172_0
    s_nop
    s_set_gpr_id_offs_set_gpr_id_off
    s_waitcnt                         lgkmcnt(0)
    v_cvt_f32_u32                     v0, s0
    v_cvt_f64_i32                     v[0:1], s0
    v_cvt_u32_f32                     v0, s0
    v_mov_b32                         v2, s3
    v_add_u32                         v0, vcc, s0, v0
    v_addc_u32                        v1, vcc, v2, v1, vcc
    v_and_b32                         v2, 1, v4
    v_ashrrev_i32                     v1, 31, v2
    v_ashrrev_i64                     v[0:1], 30, v[0:1]
    v_cndmask_b32                     v4, v0, v1, s[6:7]
    v_lshlrev_b32                     v4, v0, v1, s[6:7]
    v_lshlrev_b64                     v[0:1], 2, v[0:1]
    v_lshrrev_b64                     v[0:1], 2, v[0:1]
    v_mac_f32                         v3, v2, v5
    v_min_u32                         v0, s0, s1
    v_mul_f32                         v3, v4, v3
    v_mul_i32_i24                     v0, v0, v0
    v_sub_u32                         v6, vcc, 0, v3
    v_sub_f32                         v3, 1.0, v2
    v_subrev_u32                      v4, vcc, s1, v1
    v_xor_b32                         v0, s0, s1
    v_alignbit_b32                    v0, s0, s1, s2
    v_alignbyte_b32                   v0, s0, s1, s2
    v_and_or_b32                      v0, s0, s1, s2
    v_bfi_b32                         v0, s0, s1, s2
    v_div_fixup_f64                   v0, s0, s1, s2
    v_fma_f32                         v0, s0, s1, s2
    v_mul_f64                         v[0:1], s[0:1], s[2:3]
    v_mul_lo_u32                      v0, s0, s2
    v_cmp_eq_i32                      vcc, 1, v0
    v_cmp_eq_u32                      vcc, 1, v0
    v_cmp_eq_f32                      vcc, s2, v2
    v_cmp_ge_u32                      vcc, s2, v2
    v_cmp_gt_u64                      vcc, s0, v2
    v_cmp_gt_i32                      vcc, s0, v2
    v_cmp_lg_i32                      s[6:7], v0, 1
    v_cmp_lg_u32                      s[6:7], v0, 1
    v_cmp_lt_u32                      s[6:7], v0, 1
    v_cmpx_class_f64                  vcc, s[0:1], s[2:3]
    v_cmpx_eq_f64                     vcc, v[2:3], v[4:5]
    v_cmpx_le_u32                     vcc, v0, v1
    s_endpgm