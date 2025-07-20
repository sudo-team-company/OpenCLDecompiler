.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_else_and_if_else_0_labels
    .config
        .dims xyz
        .cws 4, 4, 4
        .sgprsnum 20
        .vgprsnum 6
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x40
/*00000000001c*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000024*/ s_load_dword    s4, s[4:5], 0x30
/*00000000002c*/ s_lshl_b32      s5, s6, 2
/*000000000030*/ v_add_u32       v0, vcc, s5, v0
/*000000000034*/ s_lshl_b32      s5, s7, 2
/*000000000038*/ v_add_u32       v1, vcc, s5, v1
/*00000000003c*/ s_lshl_b32      s5, s8, 2
/*000000000040*/ v_add_u32       v2, vcc, s5, v2
/*000000000044*/ v_add_u32       v3, vcc, s14, v1
/*000000000048*/ v_add_u32       v0, vcc, s12, v0
/*00000000004c*/ v_cmp_lg_i32    s[6:7], v0, 1
/*000000000054*/ s_waitcnt       lgkmcnt(0)
/*000000000058*/ v_mul_lo_u32    v1, v3, s4
/*000000000060*/ v_subrev_u32    v1, vcc, s1, v1
/*000000000064*/ v_mul_lo_u32    v4, v0, s1
/*00000000006c*/ v_cndmask_b32   v4, v1, v4, s[6:7]
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_mov_b32       v5, s3
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ s_cmp_ge_i32    s4, s1
/*00000000009c*/ s_cselect_b64   s[6:7], exec, 0
/*0000000000a0*/ s_add_u32       s0, s0, s4
/*0000000000a4*/ v_add_u32       v1, vcc, s0, v2
/*0000000000a8*/ v_add_u32       v2, vcc, s1, v3
/*0000000000ac*/ v_cndmask_b32   v2, v1, v2, s[6:7]
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000c8*/ flat_store_dword v[0:1], v2
/*0000000000d0*/ v_mov_b32       v4, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*0000000000dc*/ v_add_u32       v0, vcc, s2, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s4
/*0000000000e8*/ flat_store_dword v[0:1], v2
/*0000000000f0*/ s_endpgm
