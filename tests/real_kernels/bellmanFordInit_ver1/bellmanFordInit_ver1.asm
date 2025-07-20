.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel bellmanFordIter_ver1
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 10
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0082
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
        .arg edges, "uint2*", uint2*, global, const restrict, rdonly
        .arg weights, "double*", double*, global, const restrict, rdonly
        .arg d, "double*", double*, global, restrict
        .arg changed, "uint*", uint*, global, restrict
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dword    s1, s[4:5], 0x30
/*000000000010*/ s_lshl_b32      s2, s6, 6
/*000000000014*/ v_add_u32       v0, vcc, s2, v0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_cmp_gt_u32    vcc, s1, v0
/*000000000024*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000028*/ s_cbranch_execz .L296_0
/*00000000002c*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_add_u32       v2, vcc, s2, v0
/*000000000048*/ v_mov_b32       v3, s3
/*00000000004c*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*000000000050*/ flat_load_dwordx2 v[7:8], v[2:3]
/*000000000058*/ s_load_dwordx2  s[2:3], s[4:5], 0x48
/*000000000060*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000064*/ v_mov_b32       v4, v7
/*000000000068*/ v_mov_b32       v5, 0
/*00000000006c*/ v_lshlrev_b64   v[4:5], 3, v[4:5]
/*000000000074*/ v_add_u32       v6, vcc, s2, v4
/*000000000078*/ v_mov_b32       v4, s3
/*00000000007c*/ v_addc_u32      v7, vcc, v4, v5, vcc
/*000000000080*/ flat_load_dwordx2 v[4:5], v[6:7]
/*000000000088*/ v_mov_b32       v6, 0xa2000000
/*000000000090*/ v_mov_b32       v7, 0x426d1a94
/*000000000098*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*00000000009c*/ v_cmp_lt_f64    vcc, v[4:5], v[6:7]
/*0000000000a0*/ s_and_saveexec_b64 s[6:7], vcc
/*0000000000a4*/ s_cbranch_execz .L296_0
/*0000000000a8*/ s_load_dwordx2  s[8:9], s[4:5], 0x40
/*0000000000b0*/ v_mov_b32       v9, 0
/*0000000000b4*/ v_lshlrev_b64   v[2:3], 3, v[8:9]
/*0000000000bc*/ v_add_u32       v2, vcc, s2, v2
/*0000000000c0*/ v_mov_b32       v6, s3
/*0000000000c4*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000000c8*/ s_waitcnt       lgkmcnt(0)
/*0000000000cc*/ v_add_u32       v0, vcc, s8, v0
/*0000000000d0*/ v_mov_b32       v6, s9
/*0000000000d4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d8*/ flat_load_dwordx2 v[6:7], v[2:3]
/*0000000000e0*/ flat_load_dwordx2 v[0:1], v[0:1]
/*0000000000e8*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000000ec*/ v_add_f64       v[0:1], v[4:5], v[0:1]
/*0000000000f4*/ v_cmp_gt_f64    vcc, v[6:7], v[0:1]
/*0000000000f8*/ s_and_saveexec_b64 s[2:3], vcc
/*0000000000fc*/ s_cbranch_execz .L296_0
/*000000000100*/ flat_store_dwordx2 v[2:3], v[0:1]
/*000000000108*/ v_mov_b32       v0, 1
/*00000000010c*/ s_load_dwordx2  s[4:5], s[4:5], 0x50
/*000000000114*/ s_waitcnt       lgkmcnt(0)
/*000000000118*/ v_mov_b32       v1, s4
/*00000000011c*/ v_mov_b32       v2, s5
/*000000000120*/ flat_store_dword v[1:2], v0
.L296_0:
/*000000000128*/ s_endpgm
