.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel loop_kernel_0
    .config
        .dims , x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x0000000c
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_cmp_eq_i32    s0, 0
/*000000000010*/ s_cbranch_scc1  .L144_0
/*000000000014*/ s_load_dwordx4  s[4:7], s[4:5], 0x30
/*00000000001c*/ s_sub_u32       s0, 0, s0
/*000000000020*/ s_movk_i32      s1, 0x1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ v_mov_b32       v0, s7
/*00000000002c*/ s_mov_b32       s2, s4
/*000000000030*/ s_mov_b32       s3, s5
/*000000000034*/ s_nop           0x0
/*000000000038*/ s_nop           0x0
/*00000000003c*/ s_nop           0x0
.L64_0:
/*000000000040*/ v_mov_b32       v1, s2
/*000000000044*/ v_mov_b32       v2, s3
/*000000000048*/ flat_load_dword v3, v[1:2]
/*000000000050*/ s_cmp_eq_i32    s0, s1
/*000000000054*/ s_cselect_b64   s[4:5], exec, 0
/*000000000058*/ s_cmp_gt_u32    s1, 63
/*00000000005c*/ s_cselect_b64   s[8:9], exec, 0
/*000000000060*/ s_or_b64        s[4:5], s[4:5], s[8:9]
/*000000000064*/ s_add_u32       s1, s1, 1
/*000000000068*/ s_add_u32       s2, s2, 4
/*00000000006c*/ s_addc_u32      s3, s3, 0
/*000000000070*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000074*/ v_add_u32       v0, vcc, v3, v0
/*000000000078*/ flat_store_dword v[1:2], v0
/*000000000080*/ v_mul_lo_u32    v0, v0, s6
/*000000000088*/ s_and_b64       vcc, s[4:5], exec
/*00000000008c*/ s_cbranch_vccz  .L64_0
.L144_0:
/*000000000090*/ s_endpgm
.kernel loop_kernel_1
    .config
        .dims , x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000000c
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
/*000000000000*/ s_load_dword    s2, s[4:5], 0x40
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_cmp_eq_i32    s2, 0
/*000000000010*/ s_cbranch_scc1  .L124_1
/*000000000014*/ s_load_dwordx4  s[4:7], s[4:5], 0x30
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_mov_b32       s0, s4
/*000000000024*/ s_mov_b32       s1, s5
/*000000000028*/ v_mov_b32       v0, s7
/*00000000002c*/ s_nop           0x0
/*000000000030*/ s_nop           0x0
/*000000000034*/ s_nop           0x0
/*000000000038*/ s_nop           0x0
/*00000000003c*/ s_nop           0x0
.L64_1:
/*000000000040*/ v_mov_b32       v1, s0
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_load_dword v3, v[1:2]
/*000000000050*/ s_add_u32       s0, s0, 4
/*000000000054*/ s_addc_u32      s1, s1, 0
/*000000000058*/ s_add_u32       s2, s2, -1
/*00000000005c*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000060*/ v_add_u32       v0, vcc, v3, v0
/*000000000064*/ flat_store_dword v[1:2], v0
/*00000000006c*/ v_mul_lo_u32    v0, v0, s6
/*000000000074*/ s_cmp_eq_i32    s2, 0
/*000000000078*/ s_cbranch_scc0  .L64_1
.L124_1:
/*00000000007c*/ s_endpgm
.kernel loop_kernel_2
    .config
        .dims , x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x0000000c
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
/*000000000000*/ s_load_dword    s8, s[4:5], 0x40
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_cmp_eq_i32    s8, 0
/*000000000010*/ s_cbranch_scc1  .L124_2
/*000000000014*/ s_load_dwordx4  s[4:7], s[4:5], 0x30
/*00000000001c*/ s_movk_i32      s9, 0x0
/*000000000020*/ s_lshl_b64      s[2:3], s[8:9], 2
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s0, s4, s2
/*00000000002c*/ s_addc_u32      s1, s5, s3
/*000000000030*/ v_mov_b32       v0, s7
/*000000000034*/ s_nop           0x0
/*000000000038*/ s_nop           0x0
/*00000000003c*/ s_nop           0x0
.L64_2:
/*000000000040*/ v_mov_b32       v1, s0
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_load_dword v3, v[1:2]
/*000000000050*/ s_add_u32       s0, s0, -4
/*000000000054*/ s_addc_u32      s1, s1, -1
/*000000000058*/ s_add_u32       s8, s8, -1
/*00000000005c*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000060*/ v_add_u32       v0, vcc, v3, v0
/*000000000064*/ flat_store_dword v[1:2], v0
/*00000000006c*/ v_mul_lo_u32    v0, v0, s6
/*000000000074*/ s_cmp_eq_i32    s8, 0
/*000000000078*/ s_cbranch_scc0  .L64_2
.L124_2:
/*00000000007c*/ s_endpgm
