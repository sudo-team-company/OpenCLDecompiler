.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_else_in_if_and_else_of_if_else
    .config
        .dims xyz
        .cws 4, 4, 4
        .sgprsnum 17
        .vgprsnum 12
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
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 2
/*000000000018*/ v_add_u32       v0, vcc, s1, v0
/*00000000001c*/ s_lshl_b32      s1, s7, 2
/*000000000020*/ s_lshl_b32      s3, s8, 2
/*000000000024*/ v_add_u32       v1, vcc, s1, v1
/*000000000028*/ v_add_u32       v2, vcc, s3, v2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ v_add_u32       v6, vcc, s10, v2
/*000000000034*/ v_add_u32       v8, vcc, s2, v1
/*000000000038*/ v_cmp_eq_i32    vcc, 1, v0
/*00000000003c*/ s_load_dword    s0, s[4:5], 0x30
/*000000000044*/ s_load_dword    s1, s[4:5], 0x40
/*00000000004c*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000054*/ s_and_saveexec_b64 s[4:5], vcc
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_mul_lo_u32    v1, v8, s0
/*000000000064*/ s_cbranch_execz .L168_0
/*000000000068*/ v_subrev_u32    v4, vcc, s1, v1
/*00000000006c*/ v_mov_b32       v1, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000078*/ v_add_u32       v0, vcc, s2, v0
/*00000000007c*/ v_mov_b32       v5, s3
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v4
/*00000000008c*/ s_cmp_ge_i32    s0, s1
/*000000000090*/ s_cselect_b64   vcc, exec, 0
/*000000000094*/ v_mul_lo_u32    v0, v6, s0
/*00000000009c*/ v_mul_lo_u32    v1, v8, s1
/*0000000000a4*/ v_cndmask_b32   v4, v0, v1, vcc
.L168_0:
/*0000000000a8*/ s_andn2_b64     exec, s[4:5], exec
/*0000000000ac*/ v_mul_lo_u32    v4, v0, s1
/*0000000000b4*/ s_cbranch_execz .L240_0
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000c8*/ v_mov_b32       v5, s3
/*0000000000cc*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000d0*/ flat_store_dword v[0:1], v4
/*0000000000d8*/ s_cmp_ge_i32    s0, s1
/*0000000000dc*/ s_cselect_b64   s[6:7], exec, 0
/*0000000000e0*/ v_add_u32       v0, vcc, s0, v6
/*0000000000e4*/ v_add_u32       v1, vcc, s1, v8
/*0000000000e8*/ v_cndmask_b32   v4, v0, v1, s[6:7]
.L240_0:
/*0000000000f0*/ s_mov_b64       exec, s[4:5]
/*0000000000f4*/ v_mov_b32       v7, 0
/*0000000000f8*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000100*/ v_add_u32       v10, vcc, s2, v0
/*000000000104*/ v_mov_b32       v5, s3
/*000000000108*/ v_addc_u32      v11, vcc, v5, v1, vcc
/*00000000010c*/ v_mov_b32       v9, 0
/*000000000110*/ v_lshlrev_b64   v[0:1], 2, v[8:9]
/*000000000118*/ v_add_u32       v0, vcc, s2, v0
/*00000000011c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000120*/ v_mov_b32       v7, s0
/*000000000124*/ flat_store_dword v[10:11], v4
/*00000000012c*/ flat_store_dword v[0:1], v7
/*000000000134*/ s_endpgm
