.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_else_in_if_of_if_else
    .config
        .dims xyz
        .cws 4, 4, 4
        .sgprsnum 16
        .vgprsnum 11
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0082
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 2
/*000000000010*/ v_add_u32       v0, vcc, s1, v0
/*000000000014*/ s_lshl_b32      s1, s7, 2
/*000000000018*/ v_add_u32       v1, vcc, s1, v1
/*00000000001c*/ v_add_u32       v5, vcc, s0, v0
/*000000000020*/ v_add_u32       v7, vcc, s2, v1
/*000000000024*/ v_cmp_eq_i32    vcc, 1, v5
/*000000000028*/ s_load_dword    s0, s[4:5], 0x40
/*000000000030*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000038*/ s_load_dword    s1, s[4:5], 0x30
/*000000000040*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ v_mul_lo_u32    v4, v7, s1
/*000000000050*/ s_cbranch_execz .L176_0
/*000000000054*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*00000000005c*/ v_mov_b32       v6, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 2, v[5:6]
/*000000000068*/ v_subrev_u32    v4, vcc, s0, v4
/*00000000006c*/ v_add_u32       v0, vcc, s2, v0
/*000000000070*/ v_mov_b32       v5, s3
/*000000000074*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_lshl_b32      s5, s8, 2
/*000000000080*/ v_add_u32       v2, vcc, s5, v2
/*000000000084*/ v_add_u32       v5, vcc, s4, v2
/*000000000088*/ flat_store_dword v[0:1], v4
/*000000000090*/ s_cmp_lt_i32    s1, s0
/*000000000094*/ s_cbranch_scc0  .L168_0
/*000000000098*/ s_add_u32       s4, s4, s1
/*00000000009c*/ v_add_u32       v2, vcc, s4, v2
/*0000000000a0*/ v_mov_b32       v6, 0
/*0000000000a4*/ s_branch        .L176_0
.L168_0:
/*0000000000a8*/ v_add_u32       v2, vcc, s0, v7
/*0000000000ac*/ v_mov_b32       v6, 0
.L176_0:
/*0000000000b0*/ s_andn2_b64     exec, s[6:7], exec
/*0000000000b4*/ v_mul_lo_u32    v2, v5, s0
/*0000000000bc*/ v_mov_b32       v6, 0
/*0000000000c0*/ s_mov_b64       exec, s[6:7]
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 2, v[5:6]
/*0000000000cc*/ v_add_u32       v9, vcc, s2, v0
/*0000000000d0*/ v_mov_b32       v5, s3
/*0000000000d4*/ v_addc_u32      v10, vcc, v5, v1, vcc
/*0000000000d8*/ v_mov_b32       v8, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*0000000000e4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000ec*/ v_mov_b32       v7, s1
/*0000000000f0*/ flat_store_dword v[9:10], v2
/*0000000000f8*/ flat_store_dword v[0:1], v7
/*000000000100*/ s_endpgm
