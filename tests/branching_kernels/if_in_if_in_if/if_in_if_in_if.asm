.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_in_if_in_if
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 17
        .vgprsnum 8
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
        .arg nEdges, "uint", uint
        .arg edges_x, "uint*", uint*, global, const restrict, rdonly
        .arg edges_y, "uint*", uint*, global, const restrict, rdonly
        .arg some_const, "uint", uint
        .arg weights, "double*", double*, global, const restrict, rdonly
        .arg d, "double*", double*, global, restrict
        .arg changed, "uint*", uint*, global, restrict
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_lshl_b32      s2, s6, 6
/*000000000018*/ v_add_u32       v0, vcc, s2, v0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_cmp_gt_u32    vcc, s1, v0
/*000000000028*/ s_and_saveexec_b64 s[0:1], vcc
/*00000000002c*/ s_cbranch_execz .L340_0
/*000000000030*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[2:3], 2, v[0:1]
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ v_add_u32       v4, vcc, s2, v2
/*00000000004c*/ v_mov_b32       v5, s3
/*000000000050*/ v_addc_u32      v5, vcc, v5, v3, vcc
/*000000000054*/ flat_load_dword v4, v[4:5]
/*00000000005c*/ s_load_dwordx2  s[2:3], s[4:5], 0x58
/*000000000064*/ v_mov_b32       v5, 0
/*000000000068*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*00000000006c*/ v_lshlrev_b64   v[4:5], 3, v[4:5]
/*000000000074*/ v_add_u32       v4, vcc, s2, v4
/*000000000078*/ v_mov_b32       v6, s3
/*00000000007c*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*000000000080*/ flat_load_dwordx2 v[4:5], v[4:5]
/*000000000088*/ s_load_dword    s6, s[4:5], 0x48
/*000000000090*/ s_waitcnt       lgkmcnt(0)
/*000000000094*/ v_cvt_f64_u32   v[6:7], s6
/*000000000098*/ s_waitcnt       vmcnt(0)
/*00000000009c*/ v_cmp_lt_f64    vcc, v[4:5], v[6:7]
/*0000000000a0*/ s_and_saveexec_b64 s[6:7], vcc
/*0000000000a4*/ s_cbranch_execz .L340_0
/*0000000000a8*/ s_load_dwordx2  s[8:9], s[4:5], 0x40
/*0000000000b0*/ s_load_dwordx2  s[10:11], s[4:5], 0x50
/*0000000000b8*/ s_waitcnt       lgkmcnt(0)
/*0000000000bc*/ v_add_u32       v2, vcc, s8, v2
/*0000000000c0*/ v_mov_b32       v6, s9
/*0000000000c4*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000000c8*/ flat_load_dword v2, v[2:3]
/*0000000000d0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000dc*/ v_mov_b32       v3, s11
/*0000000000e0*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000e4*/ flat_load_dwordx2 v[0:1], v[0:1]
/*0000000000ec*/ v_mov_b32       v3, 0
/*0000000000f0*/ s_waitcnt       vmcnt(1) & lgkmcnt(1)
/*0000000000f4*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*0000000000fc*/ v_add_u32       v2, vcc, s2, v2
/*000000000100*/ v_mov_b32       v6, s3
/*000000000104*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*000000000108*/ flat_load_dwordx2 v[6:7], v[2:3]
/*000000000110*/ s_waitcnt       vmcnt(1) & lgkmcnt(1)
/*000000000114*/ v_add_f64       v[0:1], v[4:5], v[0:1]
/*00000000011c*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000120*/ v_cmp_gt_f64    vcc, v[6:7], v[0:1]
/*000000000124*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000128*/ s_cbranch_execz .L340_0
/*00000000012c*/ flat_store_dwordx2 v[2:3], v[0:1]
/*000000000134*/ v_mov_b32       v0, 1
/*000000000138*/ s_load_dwordx2  s[4:5], s[4:5], 0x60
/*000000000140*/ s_waitcnt       lgkmcnt(0)
/*000000000144*/ v_mov_b32       v1, s4
/*000000000148*/ v_mov_b32       v2, s5
/*00000000014c*/ flat_store_dword v[1:2], v0
.L340_0:
/*000000000154*/ s_endpgm
