.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel loop_break_kernel
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
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
        .arg data, "uint*", uint*, global, 
        .arg x, "uint", uint
        .arg y, "uint", uint
        .arg unrollingBreaker, "uint", uint
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x40
/*000000000008*/ s_load_dword    s1, s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_cmp_eq_i32    s0, 0
/*000000000020*/ s_cbranch_scc1  .L132_0
/*000000000024*/ s_load_dword    s7, s[4:5], 0x3c
/*00000000002c*/ s_mov_b32       s8, s2
/*000000000030*/ s_mov_b32       s9, s3
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_mov_b32       v1, s7
/*00000000003c*/ s_movk_i32      s7, 0x0
.L64_0:
/*000000000040*/ v_mov_b32       v2, s8
/*000000000044*/ v_mov_b32       v3, s9
/*000000000048*/ flat_load_dword v4, v[2:3]
/*000000000050*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000054*/ v_add_u32       v1, vcc, v4, v1
/*000000000058*/ flat_store_dword v[2:3], v1
/*000000000060*/ v_cmp_lg_i32    vcc, 0, v1
/*000000000064*/ s_cbranch_vccz  .L132_0
/*000000000068*/ v_mul_lo_u32    v1, v1, s1
/*000000000070*/ s_add_u32       s8, s8, 4
/*000000000074*/ s_addc_u32      s9, s9, 0
/*000000000078*/ s_add_u32       s7, s7, 1
/*00000000007c*/ s_cmp_ge_u32    s7, s0
/*000000000080*/ s_cbranch_scc0  .L64_0
.L132_0:
/*000000000084*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*00000000008c*/ s_lshl_b32      s0, s6, 6
/*000000000090*/ v_add_u32       v0, vcc, s0, v0
/*000000000094*/ s_waitcnt       lgkmcnt(0)
/*000000000098*/ v_add_u32       v0, vcc, v0, s4
/*0000000000a0*/ v_mov_b32       v1, s5
/*0000000000a4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_mov_b32       v2, s3
/*0000000000b8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000000bc*/ flat_load_dword v2, v[0:1]
/*0000000000c4*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000000c8*/ v_add_u32       v2, vcc, s1, v2
/*0000000000cc*/ flat_store_dword v[0:1], v2
/*0000000000d4*/ s_endpgm
