.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel uint2_uint
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0041
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
        .arg edges, "uint2*", uint2*, global, const restrict, rdonly
        .arg d, "double*", double*, global, restrict
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000010*/ s_lshl_b32      s1, s6, 6
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ flat_load_dwordx2 v[4:5], v[0:1]
/*000000000040*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000044*/ v_cmp_gt_u32    vcc, v5, v4
/*000000000048*/ s_and_saveexec_b64 s[0:1], vcc
/*00000000004c*/ s_cbranch_execz .L160_0
/*000000000050*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000058*/ v_mov_b32       v2, v4
/*00000000005c*/ v_mov_b32       v3, 0
/*000000000060*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ v_add_u32       v2, vcc, s2, v2
/*000000000070*/ v_mov_b32       v4, s3
/*000000000074*/ v_addc_u32      v3, vcc, v4, v3, vcc
/*000000000078*/ flat_load_dwordx2 v[2:3], v[2:3]
/*000000000080*/ v_mov_b32       v6, 0
/*000000000084*/ v_lshlrev_b64   v[0:1], 3, v[5:6]
/*00000000008c*/ v_add_u32       v0, vcc, s2, v0
/*000000000090*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*000000000094*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000098*/ flat_store_dwordx2 v[0:1], v[2:3]
.L160_0:
/*0000000000a0*/ s_endpgm
