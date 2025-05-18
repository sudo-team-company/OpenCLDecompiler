.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_and_if
    .config
        .dims xyz
        .cws 4, 4, 4
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 2
/*000000000010*/ s_add_u32       s0, s1, s0
/*000000000014*/ v_add_u32       v3, vcc, s0, v0
/*000000000018*/ v_cmp_eq_i32    vcc, 0, v3
/*00000000001c*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000020*/ s_cbranch_execz .L60_0
/*000000000024*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s3, s7, 2
/*000000000034*/ s_add_u32       s2, s3, s2
/*000000000038*/ v_add_u32       v3, vcc, s2, v1
.L60_0:
/*00000000003c*/ s_mov_b64       exec, s[0:1]
/*000000000040*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000048*/ s_load_dword    s2, s[4:5], 0x30
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*00000000005c*/ s_waitcnt       lgkmcnt(0)
/*000000000060*/ v_add_u32       v0, vcc, s0, v0
/*000000000064*/ v_mov_b32       v4, s1
/*000000000068*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*00000000006c*/ v_mov_b32       v4, s2
/*000000000070*/ flat_store_dword v[0:1], v4
/*000000000078*/ s_load_dword    s3, s[4:5], 0x40
/*000000000080*/ s_waitcnt       lgkmcnt(0)
/*000000000084*/ s_cmp_lt_i32    s2, s3
/*000000000088*/ s_cbranch_scc0  .L164_0
/*00000000008c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000094*/ s_lshl_b32      s2, s8, 2
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_add_u32       s2, s2, s4
/*0000000000a0*/ v_add_u32       v3, vcc, s2, v2
.L164_0:
/*0000000000a4*/ v_mov_b32       v4, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*0000000000b0*/ v_add_u32       v0, vcc, s0, v0
/*0000000000b4*/ v_mov_b32       v2, s1
/*0000000000b8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000000bc*/ v_mov_b32       v2, s3
/*0000000000c0*/ flat_store_dword v[0:1], v2
/*0000000000c8*/ s_endpgm
