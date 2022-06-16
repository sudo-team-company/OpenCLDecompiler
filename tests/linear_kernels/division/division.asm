/* Disassembling 'linear_kernels\division_x_y\division_x_y.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel div_x_y_char
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 5
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
        .arg data, "char*", char*, global, 
        .arg x, "char", char
        .arg y, "char", char
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_i32       s1, s0, 0x80008
/*00000000002c*/ s_bfe_i32       s0, s0, 0x80000
/*000000000034*/ s_xor_b32       s6, s0, s1
/*000000000038*/ s_ashr_i32      s6, s6, 30
/*00000000003c*/ v_cvt_f32_i32   v1, s1
/*000000000040*/ v_cvt_f32_i32   v2, s0
/*000000000044*/ s_or_b32        s0, s6, 1
/*000000000048*/ v_rcp_f32       v3, v1
/*00000000004c*/ v_mul_f32       v3, v2, v3
/*000000000050*/ v_trunc_f32     v4, v3
/*000000000054*/ v_mad_f32       v2, -v4, v1, v2
/*00000000005c*/ v_cmp_ge_f32    vcc, abs(v2), abs(v1)
/*000000000064*/ s_cmp_eq_u64    vcc, 0
/*000000000068*/ s_cselect_b32   s0, 0, s0
/*00000000006c*/ v_cvt_i32_f32   v1, v3
/*000000000070*/ v_add_u32       v2, vcc, s0, v1
/*000000000074*/ s_add_u32       s0, s2, s4
/*000000000078*/ s_addc_u32      s1, s3, s5
/*00000000007c*/ v_add_u32       v0, vcc, v0, s0
/*000000000084*/ v_mov_b32       v1, s1
/*000000000088*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*00000000008c*/ flat_store_byte v[0:1], v2
/*000000000094*/ s_endpgm
.kernel div_x_y_uchar
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
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
        .arg data, "uchar*", uchar*, global, 
        .arg x, "uchar", uchar
        .arg y, "uchar", uchar
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s1, s0, 0x80008
/*00000000002c*/ v_cvt_f32_u32   v1, s1
/*000000000030*/ s_and_b32       s0, s0, 0xff
/*000000000038*/ v_cvt_f32_u32   v2, s0
/*00000000003c*/ v_rcp_f32       v3, v1
/*000000000040*/ v_mul_f32       v3, v2, v3
/*000000000044*/ v_trunc_f32     v3, v3
/*000000000048*/ v_mad_f32       v2, -v3, v1, v2
/*000000000050*/ v_cmp_ge_f32    vcc, abs(v2), abs(v1)
/*000000000058*/ s_cmp_eq_u64    vcc, 0
/*00000000005c*/ s_cselect_b32   s0, 0, 1
/*000000000060*/ v_cvt_u32_f32   v1, v3
/*000000000064*/ v_add_u32       v2, vcc, s0, v1
/*000000000068*/ s_add_u32       s0, s2, s4
/*00000000006c*/ s_addc_u32      s1, s3, s5
/*000000000070*/ v_add_u32       v0, vcc, v0, s0
/*000000000078*/ v_mov_b32       v1, s1
/*00000000007c*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*000000000080*/ flat_store_byte v[0:1], v2
/*000000000088*/ s_endpgm
.kernel div_x_y_short
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 5
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
        .arg data, "short*", short*, global, 
        .arg x, "short", short
        .arg y, "short", short
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_i32       s1, s0, 0x100010
/*00000000002c*/ s_bfe_i32       s0, s0, 0x100000
/*000000000034*/ s_xor_b32       s6, s0, s1
/*000000000038*/ s_ashr_i32      s6, s6, 30
/*00000000003c*/ v_cvt_f32_i32   v1, s1
/*000000000040*/ v_cvt_f32_i32   v2, s0
/*000000000044*/ s_or_b32        s0, s6, 1
/*000000000048*/ v_rcp_f32       v3, v1
/*00000000004c*/ v_mul_f32       v3, v2, v3
/*000000000050*/ v_trunc_f32     v4, v3
/*000000000054*/ v_mad_f32       v2, -v4, v1, v2
/*00000000005c*/ v_cmp_ge_f32    vcc, abs(v2), abs(v1)
/*000000000064*/ s_cmp_eq_u64    vcc, 0
/*000000000068*/ s_cselect_b32   s0, 0, s0
/*00000000006c*/ v_add_u32       v0, vcc, v0, s2
/*000000000074*/ v_mov_b32       v1, s3
/*000000000078*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*00000000007c*/ v_cvt_i32_f32   v2, v3
/*000000000080*/ v_add_u32       v2, vcc, s0, v2
/*000000000084*/ v_lshlrev_b64   v[0:1], 1, v[0:1]
/*00000000008c*/ v_add_u32       v0, vcc, s4, v0
/*000000000090*/ v_mov_b32       v3, s5
/*000000000094*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000098*/ flat_store_short v[0:1], v2
/*0000000000a0*/ s_endpgm
.kernel div_x_y_ushort
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
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
        .arg data, "ushort*", ushort*, global, 
        .arg x, "ushort", ushort
        .arg y, "ushort", ushort
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s1, s0, 0x100010
/*00000000002c*/ v_cvt_f32_u32   v1, s1
/*000000000030*/ s_and_b32       s0, s0, 0xffff
/*000000000038*/ v_cvt_f32_u32   v2, s0
/*00000000003c*/ v_rcp_f32       v3, v1
/*000000000040*/ v_mul_f32       v3, v2, v3
/*000000000044*/ v_trunc_f32     v3, v3
/*000000000048*/ v_mad_f32       v2, -v3, v1, v2
/*000000000050*/ v_cmp_ge_f32    vcc, abs(v2), abs(v1)
/*000000000058*/ s_cmp_eq_u64    vcc, 0
/*00000000005c*/ s_cselect_b32   s0, 0, 1
/*000000000060*/ v_add_u32       v0, vcc, v0, s2
/*000000000068*/ v_mov_b32       v1, s3
/*00000000006c*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*000000000070*/ v_cvt_u32_f32   v2, v3
/*000000000074*/ v_add_u32       v2, vcc, s0, v2
/*000000000078*/ v_lshlrev_b64   v[0:1], 1, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s4, v0
/*000000000084*/ v_mov_b32       v3, s5
/*000000000088*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000008c*/ flat_store_short v[0:1], v2
/*000000000094*/ s_endpgm
.kernel div_x_y_int
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 20
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
        .arg y, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s6, s6, 6
/*00000000001c*/ v_add_u32       v2, vcc, s6, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_cmp_lt_i32    s0, 0
/*000000000028*/ s_cselect_b64   s[6:7], exec, 0
/*00000000002c*/ s_sub_u32       s8, 0, s0
/*000000000030*/ s_max_i32       s0, s0, s8
/*000000000034*/ s_cmp_lt_i32    s1, 0
/*000000000038*/ s_cselect_b64   s[8:9], exec, 0
/*00000000003c*/ s_sub_u32       s10, 0, s1
/*000000000040*/ s_max_i32       s10, s1, s10
/*000000000044*/ v_cvt_f32_u32   v0, s10
/*000000000048*/ v_rcp_f32       v0, v0
/*00000000004c*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000054*/ v_cvt_u32_f32   v3, v0
/*000000000058*/ v_mad_u64_u32   v[0:1], vcc, s10, v3, 0
/*000000000060*/ v_sub_u32       v4, vcc, 0, v0
/*000000000064*/ v_cmp_lg_i32    s[12:13], 0, v1
/*00000000006c*/ v_cndmask_b32   v0, v4, v0, s[12:13]
/*000000000074*/ v_mul_hi_u32    v0, v0, v3
/*00000000007c*/ v_sub_u32       v1, vcc, v3, v0
/*000000000080*/ v_add_u32       v0, vcc, v3, v0
/*000000000084*/ v_cndmask_b32   v0, v0, v1, s[12:13]
/*00000000008c*/ v_mul_hi_u32    v0, v0, s0
/*000000000094*/ v_mul_lo_u32    v1, v0, s10
/*00000000009c*/ v_sub_u32       v3, vcc, s0, v1
/*0000000000a0*/ v_cmp_ge_u32    s[12:13], s0, v1
/*0000000000a8*/ v_cmp_ge_u32    s[10:11], v3, s10
/*0000000000b0*/ s_and_b64       s[10:11], s[12:13], s[10:11]
/*0000000000b4*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*0000000000bc*/ v_addc_u32      v0, vcc, v0, -1, s[12:13]
/*0000000000c4*/ v_sub_u32       v1, vcc, 0, v0
/*0000000000c8*/ s_mov_b32       s0, 0x80000000
/*0000000000d0*/ v_cmp_lg_i32    s[10:11], v0, s0
/*0000000000d8*/ s_cmp_lg_i32    s1, 0
/*0000000000dc*/ s_cselect_b64   vcc, exec, 0
/*0000000000e0*/ v_mov_b32       v3, 0x80000000
/*0000000000e8*/ v_cndmask_b32   v1, v3, v1, vcc
/*0000000000ec*/ s_and_b64       vcc, vcc, s[10:11]
/*0000000000f0*/ v_mov_b32       v3, 0x7fffffff
/*0000000000f8*/ v_cndmask_b32   v0, v3, v0, vcc
/*0000000000fc*/ s_xor_b64       vcc, s[6:7], s[8:9]
/*000000000100*/ v_cndmask_b32   v3, v0, v1, vcc
/*000000000104*/ v_add_u32       v0, vcc, v2, s2
/*00000000010c*/ v_mov_b32       v1, s3
/*000000000110*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*000000000114*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000011c*/ v_add_u32       v0, vcc, s4, v0
/*000000000120*/ v_mov_b32       v2, s5
/*000000000124*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000128*/ flat_store_dword v[0:1], v3
/*000000000130*/ s_endpgm
.kernel div_x_y_uint
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_lshl_b32      s6, s6, 6
/*00000000001c*/ v_add_u32       v2, vcc, s6, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_cvt_f32_u32   v0, s1
/*000000000028*/ v_rcp_f32       v0, v0
/*00000000002c*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000034*/ v_cvt_u32_f32   v3, v0
/*000000000038*/ v_mad_u64_u32   v[0:1], vcc, s1, v3, 0
/*000000000040*/ v_sub_u32       v4, vcc, 0, v0
/*000000000044*/ v_cmp_lg_i32    s[6:7], 0, v1
/*00000000004c*/ v_cndmask_b32   v0, v4, v0, s[6:7]
/*000000000054*/ v_mul_hi_u32    v0, v0, v3
/*00000000005c*/ v_sub_u32       v1, vcc, v3, v0
/*000000000060*/ v_add_u32       v0, vcc, v3, v0
/*000000000064*/ v_cndmask_b32   v0, v0, v1, s[6:7]
/*00000000006c*/ v_mul_hi_u32    v0, v0, s0
/*000000000074*/ v_mul_lo_u32    v1, v0, s1
/*00000000007c*/ v_sub_u32       v3, vcc, s0, v1
/*000000000080*/ v_cmp_ge_u32    s[6:7], s0, v1
/*000000000088*/ v_cmp_ge_u32    s[8:9], v3, s1
/*000000000090*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*000000000094*/ v_addc_u32      v0, vcc, v0, 0, s[8:9]
/*00000000009c*/ v_addc_u32      v0, vcc, v0, -1, s[6:7]
/*0000000000a4*/ s_cmp_lg_i32    s1, 0
/*0000000000a8*/ s_cselect_b64   s[6:7], exec, 0
/*0000000000ac*/ v_mul_lo_u32    v1, v0, s1
/*0000000000b4*/ v_sub_u32       v1, vcc, s0, v1
/*0000000000b8*/ v_cmp_le_u32    vcc, s1, v1
/*0000000000bc*/ v_addc_u32      v0, vcc, 0, v0, vcc
/*0000000000c0*/ v_cndmask_b32   v3, -1, v0, s[6:7]
/*0000000000c8*/ v_add_u32       v0, vcc, v2, s2
/*0000000000d0*/ v_mov_b32       v1, s3
/*0000000000d4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000d8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000e0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e4*/ v_mov_b32       v2, s5
/*0000000000e8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000000ec*/ flat_store_dword v[0:1], v3
/*0000000000f4*/ s_endpgm
.kernel div_x_y_long
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 24
        .vgprsnum 20
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "long*", long*, global, 
        .arg x, "long", long
        .arg y, "long", long
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x40
/*000000000008*/ s_load_dwordx4  s[8:11], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ v_sub_u32       v1, vcc, 0, s0
/*00000000001c*/ v_mov_b32       v2, s1
/*000000000020*/ v_subb_u32      v3, vcc, 0, v2, vcc
/*000000000024*/ v_sub_u32       v4, vcc, 0, s10
/*00000000002c*/ v_mov_b32       v5, s11
/*000000000030*/ v_subb_u32      v6, vcc, 0, v5, vcc
/*000000000034*/ v_cmp_lt_i64    s[2:3], s[0:1], 0
/*00000000003c*/ v_mov_b32       v7, s0
/*000000000040*/ v_cmp_lt_i64    vcc, s[10:11], 0
/*000000000048*/ v_mov_b32       v8, s10
/*00000000004c*/ v_cndmask_b32   v18, v7, v1, s[2:3]
/*000000000054*/ v_cndmask_b32   v19, v2, v3, s[2:3]
/*00000000005c*/ v_cndmask_b32   v16, v8, v4, vcc
/*000000000060*/ v_cndmask_b32   v17, v5, v6, vcc
/*000000000064*/ v_cmp_lg_i64    vcc, 1, v[18:19]
/*000000000068*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000006c*/ v_cvt_f32_u32   v7, v18
/*000000000070*/ s_cbranch_execz .L864_6
/*000000000074*/ v_cvt_f32_u32   v8, v19
/*000000000078*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000080*/ v_rcp_f32       v7, v7
/*000000000084*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*00000000008c*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000094*/ v_trunc_f32     v8, v8
/*000000000098*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*0000000000a0*/ v_cvt_u32_f32   v7, v7
/*0000000000a4*/ v_cvt_u32_f32   v8, v8
/*0000000000a8*/ v_sub_u32       v9, vcc, 0, v18
/*0000000000ac*/ v_subb_u32      v10, vcc, 0, v19, vcc
/*0000000000b0*/ v_mul_lo_u32    v11, v9, v8
/*0000000000b8*/ v_mul_lo_u32    v12, v10, v7
/*0000000000c0*/ v_add_u32       v11, vcc, v11, v12
/*0000000000c4*/ v_mul_hi_u32    v12, v9, v7
/*0000000000cc*/ v_add_u32       v11, vcc, v11, v12
/*0000000000d0*/ v_mul_lo_u32    v12, v9, v7
/*0000000000d8*/ v_mul_hi_u32    v13, v7, v12
/*0000000000e0*/ v_mul_lo_u32    v14, v8, v12
/*0000000000e8*/ v_add_u32       v13, vcc, v13, v14
/*0000000000ec*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000000f4*/ v_mul_lo_u32    v15, v7, v11
/*0000000000fc*/ v_add_u32       v13, vcc, v13, v15
/*000000000100*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*000000000108*/ v_mul_hi_u32    v12, v8, v12
/*000000000110*/ v_add_u32       v12, vcc, v13, v12
/*000000000114*/ v_cndmask_b32   v13, 0, 1, vcc
/*00000000011c*/ v_mul_hi_u32    v14, v7, v11
/*000000000124*/ v_add_u32       v12, vcc, v12, v14
/*000000000128*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000130*/ v_mul_lo_u32    v14, v8, v11
/*000000000138*/ v_add_u32       v12, vcc, v12, v14
/*00000000013c*/ v_mul_hi_u32    v11, v8, v11
/*000000000144*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000148*/ v_add_u32       v7, s[12:13], v7, v12
/*000000000150*/ v_addc_u32      v12, vcc, v8, v11, s[12:13]
/*000000000158*/ v_add_u32       v8, vcc, v8, v11
/*00000000015c*/ v_mul_lo_u32    v11, v9, v12
/*000000000164*/ v_mul_lo_u32    v10, v10, v7
/*00000000016c*/ v_add_u32       v10, vcc, v11, v10
/*000000000170*/ v_mul_hi_u32    v11, v9, v7
/*000000000178*/ v_add_u32       v10, vcc, v10, v11
/*00000000017c*/ v_mul_lo_u32    v9, v9, v7
/*000000000184*/ v_mul_hi_u32    v11, v7, v9
/*00000000018c*/ v_mul_lo_u32    v13, v12, v9
/*000000000194*/ v_add_u32       v11, vcc, v11, v13
/*000000000198*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000001a0*/ v_mul_lo_u32    v14, v7, v10
/*0000000001a8*/ v_add_u32       v11, vcc, v11, v14
/*0000000001ac*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000001b4*/ v_mul_hi_u32    v9, v12, v9
/*0000000001bc*/ v_add_u32       v9, vcc, v11, v9
/*0000000001c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000001c8*/ v_mul_hi_u32    v13, v7, v10
/*0000000001d0*/ v_add_u32       v9, vcc, v9, v13
/*0000000001d4*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000001dc*/ v_mul_lo_u32    v13, v12, v10
/*0000000001e4*/ v_add_u32       v9, vcc, v9, v13
/*0000000001e8*/ v_mul_hi_u32    v10, v12, v10
/*0000000001f0*/ v_addc_u32      v10, vcc, v11, v10, vcc
/*0000000001f4*/ v_add_u32       v7, s[14:15], v7, v9
/*0000000001fc*/ v_addc_u32      v8, vcc, v8, v10, s[12:13]
/*000000000204*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*00000000020c*/ v_mul_hi_u32    v9, v16, v7
/*000000000214*/ v_mul_lo_u32    v10, v17, v7
/*00000000021c*/ v_add_u32       v9, vcc, v9, v10
/*000000000220*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000228*/ v_mul_lo_u32    v11, v16, v8
/*000000000230*/ v_add_u32       v9, vcc, v9, v11
/*000000000234*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*00000000023c*/ v_mul_hi_u32    v7, v17, v7
/*000000000244*/ v_add_u32       v7, vcc, v9, v7
/*000000000248*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000250*/ v_mul_hi_u32    v10, v16, v8
/*000000000258*/ v_add_u32       v7, vcc, v7, v10
/*00000000025c*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000264*/ v_mul_lo_u32    v10, v17, v8
/*00000000026c*/ v_add_u32       v7, vcc, v7, v10
/*000000000270*/ v_mul_hi_u32    v8, v17, v8
/*000000000278*/ v_addc_u32      v8, vcc, v9, v8, vcc
/*00000000027c*/ v_mul_lo_u32    v9, v18, v8
/*000000000284*/ v_mul_lo_u32    v10, v19, v7
/*00000000028c*/ v_add_u32       v9, vcc, v9, v10
/*000000000290*/ v_mul_hi_u32    v10, v18, v7
/*000000000298*/ v_add_u32       v9, vcc, v9, v10
/*00000000029c*/ v_mul_lo_u32    v10, v18, v7
/*0000000002a4*/ v_sub_u32       v3, s[12:13], v16, v10
/*0000000002ac*/ v_subb_u32      v10, vcc, v17, v9, s[12:13]
/*0000000002b4*/ v_sub_u32       v4, vcc, v17, v9
/*0000000002b8*/ v_cmp_ge_u32    vcc, v3, v18
/*0000000002bc*/ v_cndmask_b32   v9, 0, -1, vcc
/*0000000002c4*/ v_cmp_ge_u32    vcc, v10, v19
/*0000000002c8*/ v_cndmask_b32   v11, 0, -1, vcc
/*0000000002d0*/ v_cmp_eq_i32    vcc, v10, v19
/*0000000002d4*/ v_cndmask_b32   v9, v11, v9, vcc
/*0000000002d8*/ v_cmp_lg_u32    vcc, 0, v9
/*0000000002dc*/ s_and_saveexec_b64 s[14:15], vcc
/*0000000002e0*/ s_cbranch_execz .L840_6
/*0000000002e4*/ v_sub_u32       v3, s[16:17], v3, v18
/*0000000002ec*/ v_subb_u32      v4, vcc, v4, v19, s[12:13]
/*0000000002f4*/ v_subb_u32      v4, vcc, v4, 0, s[16:17]
/*0000000002fc*/ v_cmp_ge_u32    vcc, v3, v18
/*000000000300*/ v_cndmask_b32   v1, 0, -1, vcc
/*000000000308*/ v_cmp_ge_u32    vcc, v4, v19
/*00000000030c*/ v_cndmask_b32   v3, 0, -1, vcc
/*000000000314*/ v_add_u32       v7, vcc, v7, 1
/*00000000031c*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*000000000324*/ v_cmp_eq_i32    vcc, v4, v19
/*000000000328*/ v_cndmask_b32   v1, v3, v1, vcc
/*00000000032c*/ v_add_u32       v2, vcc, v7, 1
/*000000000334*/ v_addc_u32      v3, vcc, v8, 0, vcc
/*00000000033c*/ v_cmp_lg_u32    vcc, 0, v1
/*000000000340*/ v_cndmask_b32   v8, v8, v3, vcc
/*000000000344*/ v_cndmask_b32   v7, v7, v2, vcc
.L840_6:
/*000000000348*/ s_mov_b64       exec, s[14:15]
/*00000000034c*/ v_cmp_lg_i64    vcc, 0, v[18:19]
/*000000000350*/ v_cndmask_b32   v16, -1, v7, vcc
/*000000000354*/ v_mov_b32       v3, 0x7fffffff
/*00000000035c*/ v_cndmask_b32   v17, v3, v8, vcc
.L864_6:
/*000000000360*/ s_mov_b64       exec, s[2:3]
/*000000000364*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*00000000036c*/ s_lshl_b32      s4, s6, 6
/*000000000370*/ v_add_u32       v0, vcc, s4, v0
/*000000000374*/ v_mov_b32       v3, s1
/*000000000378*/ v_xor_b32       v3, s11, v3
/*00000000037c*/ v_cmp_lt_i32    s[4:5], v3, 0
/*000000000384*/ v_cmp_eq_i64    s[0:1], s[0:1], 0
/*00000000038c*/ v_sub_u32       v3, s[6:7], 0, v16
/*000000000394*/ v_subb_u32      v4, vcc, 0, v17, s[6:7]
/*00000000039c*/ v_cndmask_b32   v3, v3, 0, s[0:1]
/*0000000003a4*/ v_cndmask_b32   v1, v16, v3, s[4:5]
/*0000000003ac*/ v_cndmask_b32   v2, v17, v4, s[4:5]
/*0000000003b4*/ v_readfirstlane_b32 s0, v1
/*0000000003b8*/ v_readfirstlane_b32 s1, v2
/*0000000003bc*/ s_waitcnt       lgkmcnt(0)
/*0000000003c0*/ v_add_u32       v0, vcc, v0, s2
/*0000000003c8*/ v_mov_b32       v1, s3
/*0000000003cc*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000003d0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000003d8*/ v_add_u32       v0, vcc, s8, v0
/*0000000003dc*/ v_mov_b32       v2, s9
/*0000000003e0*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000003e4*/ v_mov_b32       v2, s0
/*0000000003e8*/ v_mov_b32       v3, s1
/*0000000003ec*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000003f4*/ s_endpgm
.kernel div_x_y_ulong
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 20
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
        .arg data, "ulong*", ulong*, global, 
        .arg x, "ulong", ulong
        .arg y, "ulong", ulong
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x40
/*000000000008*/ s_load_dwordx4  s[8:11], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_cmp_eq_u64    1, s[0:1]
/*000000000018*/ s_cbranch_scc1  .L792_7
/*00000000001c*/ v_cvt_f32_u32   v1, s0
/*000000000020*/ v_cvt_f32_u32   v2, s1
/*000000000024*/ v_madmk_f32     v1, v2, 0x4f800000 /* 4.2949673e+9f */, v1
/*00000000002c*/ v_rcp_f32       v1, v1
/*000000000030*/ v_mul_f32       v1, 0x5f7ffffc /* 1.844674e+19f */, v1
/*000000000038*/ v_mul_f32       v2, 0x2f800000 /* 2.32830644e-10f */, v1
/*000000000040*/ v_trunc_f32     v2, v2
/*000000000044*/ v_madmk_f32     v1, v2, 0xcf800000 /* -4.2949673e+9f */, v1
/*00000000004c*/ v_cvt_u32_f32   v1, v1
/*000000000050*/ v_cvt_u32_f32   v2, v2
/*000000000054*/ v_sub_u32       v3, vcc, 0, s0
/*00000000005c*/ v_mov_b32       v4, s1
/*000000000060*/ v_subb_u32      v4, vcc, 0, v4, vcc
/*000000000064*/ v_mul_lo_u32    v5, v3, v2
/*00000000006c*/ v_mul_lo_u32    v6, v4, v1
/*000000000074*/ v_add_u32       v5, vcc, v5, v6
/*000000000078*/ v_mul_hi_u32    v6, v3, v1
/*000000000080*/ v_add_u32       v5, vcc, v5, v6
/*000000000084*/ v_mul_lo_u32    v6, v3, v1
/*00000000008c*/ v_mul_hi_u32    v7, v1, v6
/*000000000094*/ v_mul_lo_u32    v8, v2, v6
/*00000000009c*/ v_add_u32       v7, vcc, v7, v8
/*0000000000a0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000000a8*/ v_mul_lo_u32    v9, v1, v5
/*0000000000b0*/ v_add_u32       v7, vcc, v7, v9
/*0000000000b4*/ v_addc_u32      v7, vcc, v8, 0, vcc
/*0000000000bc*/ v_mul_hi_u32    v6, v2, v6
/*0000000000c4*/ v_add_u32       v6, vcc, v7, v6
/*0000000000c8*/ v_cndmask_b32   v7, 0, 1, vcc
/*0000000000d0*/ v_mul_hi_u32    v8, v1, v5
/*0000000000d8*/ v_add_u32       v6, vcc, v6, v8
/*0000000000dc*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000000e4*/ v_mul_lo_u32    v8, v2, v5
/*0000000000ec*/ v_add_u32       v6, vcc, v6, v8
/*0000000000f0*/ v_mul_hi_u32    v5, v2, v5
/*0000000000f8*/ v_addc_u32      v5, vcc, v7, v5, vcc
/*0000000000fc*/ v_add_u32       v1, s[2:3], v1, v6
/*000000000104*/ v_addc_u32      v6, vcc, v2, v5, s[2:3]
/*00000000010c*/ v_add_u32       v2, vcc, v2, v5
/*000000000110*/ v_mul_lo_u32    v5, v3, v6
/*000000000118*/ v_mul_lo_u32    v4, v4, v1
/*000000000120*/ v_add_u32       v4, vcc, v5, v4
/*000000000124*/ v_mul_hi_u32    v5, v3, v1
/*00000000012c*/ v_add_u32       v4, vcc, v4, v5
/*000000000130*/ v_mul_lo_u32    v3, v3, v1
/*000000000138*/ v_mul_hi_u32    v5, v1, v3
/*000000000140*/ v_mul_lo_u32    v7, v6, v3
/*000000000148*/ v_add_u32       v5, vcc, v5, v7
/*00000000014c*/ v_cndmask_b32   v7, 0, 1, vcc
/*000000000154*/ v_mul_lo_u32    v8, v1, v4
/*00000000015c*/ v_add_u32       v5, vcc, v5, v8
/*000000000160*/ v_addc_u32      v5, vcc, v7, 0, vcc
/*000000000168*/ v_mul_hi_u32    v3, v6, v3
/*000000000170*/ v_add_u32       v3, vcc, v5, v3
/*000000000174*/ v_cndmask_b32   v5, 0, 1, vcc
/*00000000017c*/ v_mul_hi_u32    v7, v1, v4
/*000000000184*/ v_add_u32       v3, vcc, v3, v7
/*000000000188*/ v_addc_u32      v5, vcc, v5, 0, vcc
/*000000000190*/ v_mul_lo_u32    v7, v6, v4
/*000000000198*/ v_add_u32       v3, vcc, v3, v7
/*00000000019c*/ v_mul_hi_u32    v4, v6, v4
/*0000000001a4*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*0000000001a8*/ v_add_u32       v1, s[12:13], v1, v3
/*0000000001b0*/ v_addc_u32      v2, vcc, v2, v4, s[2:3]
/*0000000001b8*/ v_addc_u32      v2, vcc, v2, 0, s[12:13]
/*0000000001c0*/ v_mul_hi_u32    v3, s10, v1
/*0000000001c8*/ v_mul_lo_u32    v4, s11, v1
/*0000000001d0*/ v_add_u32       v3, vcc, v3, v4
/*0000000001d4*/ v_cndmask_b32   v4, 0, 1, vcc
/*0000000001dc*/ v_mul_lo_u32    v5, s10, v2
/*0000000001e4*/ v_add_u32       v3, vcc, v3, v5
/*0000000001e8*/ v_addc_u32      v3, vcc, v4, 0, vcc
/*0000000001f0*/ v_mul_hi_u32    v1, s11, v1
/*0000000001f8*/ v_add_u32       v1, vcc, v3, v1
/*0000000001fc*/ v_cndmask_b32   v3, 0, 1, vcc
/*000000000204*/ v_mul_hi_u32    v4, s10, v2
/*00000000020c*/ v_add_u32       v1, vcc, v1, v4
/*000000000210*/ v_addc_u32      v3, vcc, v3, 0, vcc
/*000000000218*/ v_mul_lo_u32    v4, s11, v2
/*000000000220*/ v_add_u32       v1, vcc, v1, v4
/*000000000224*/ v_mul_hi_u32    v2, s11, v2
/*00000000022c*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000230*/ v_mul_lo_u32    v3, s0, v2
/*000000000238*/ v_mul_lo_u32    v4, s1, v1
/*000000000240*/ v_add_u32       v3, vcc, v3, v4
/*000000000244*/ v_mul_hi_u32    v4, s0, v1
/*00000000024c*/ v_add_u32       v3, vcc, v3, v4
/*000000000250*/ v_mul_lo_u32    v4, s0, v1
/*000000000258*/ v_sub_u32       v4, s[2:3], s10, v4
/*000000000260*/ v_mov_b32       v5, s11
/*000000000264*/ v_subb_u32      v5, vcc, v5, v3, s[2:3]
/*00000000026c*/ v_cmp_le_u32    vcc, s0, v4
/*000000000270*/ v_cndmask_b32   v6, 0, -1, vcc
/*000000000278*/ v_cmp_le_u32    vcc, s1, v5
/*00000000027c*/ v_cndmask_b32   v7, 0, -1, vcc
/*000000000284*/ v_cmp_eq_i32    vcc, s1, v5
/*000000000288*/ v_cndmask_b32   v5, v7, v6, vcc
/*00000000028c*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000290*/ s_cbranch_vccz  .L772_7
/*000000000294*/ v_sub_u32       v3, vcc, s11, v3
/*000000000298*/ v_sub_u32       v4, s[10:11], v4, s0
/*0000000002a0*/ v_mov_b32       v5, s1
/*0000000002a4*/ v_subb_u32      v3, vcc, v3, v5, s[2:3]
/*0000000002ac*/ v_subb_u32      v3, vcc, v3, 0, s[10:11]
/*0000000002b4*/ v_add_u32       v1, vcc, v1, 1
/*0000000002bc*/ v_addc_u32      v2, vcc, v2, 0, vcc
/*0000000002c4*/ v_cmp_ge_u32    s[2:3], v4, s0
/*0000000002cc*/ v_cmp_ge_u32    s[10:11], v3, s1
/*0000000002d4*/ v_cmp_eq_i32    vcc, s1, v3
/*0000000002d8*/ v_cndmask_b32   v3, 0, -1, s[10:11]
/*0000000002e0*/ v_cndmask_b32   v4, 0, -1, s[2:3]
/*0000000002e8*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000002ec*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000002f0*/ s_cbranch_vccz  .L772_7
/*0000000002f4*/ v_add_u32       v1, vcc, v1, 1
/*0000000002fc*/ v_addc_u32      v2, vcc, v2, 0, vcc
.L772_7:
/*000000000304*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*00000000030c*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000310*/ v_cndmask_b32   v2, -1, v2, vcc
/*000000000314*/ s_branch        .L800_7
.L792_7:
/*000000000318*/ v_mov_b32       v1, s10
/*00000000031c*/ v_mov_b32       v2, s11
.L800_7:
/*000000000320*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000328*/ s_lshl_b32      s2, s6, 6
/*00000000032c*/ v_add_u32       v0, vcc, s2, v0
/*000000000330*/ v_readfirstlane_b32 s2, v1
/*000000000334*/ v_readfirstlane_b32 s3, v2
/*000000000338*/ s_waitcnt       lgkmcnt(0)
/*00000000033c*/ v_add_u32       v0, vcc, v0, s0
/*000000000344*/ v_mov_b32       v1, s1
/*000000000348*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*00000000034c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000354*/ v_add_u32       v0, vcc, s8, v0
/*000000000358*/ v_mov_b32       v2, s9
/*00000000035c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000360*/ v_mov_b32       v2, s2
/*000000000364*/ v_mov_b32       v3, s3
/*000000000368*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000370*/ s_endpgm
.kernel div_x_y_float
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
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
        .arg data, "float*", float*, global, 
        .arg x, "float", float
        .arg y, "float", float
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x30
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000010*/ s_lshl_b32      s6, s6, 6
/*000000000014*/ v_add_u32       v0, vcc, s6, v0
/*000000000018*/ v_mov_b32       v1, 0x6f800000
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_cmp_gt_f32    vcc, abs(s3), v1
/*00000000002c*/ v_mov_b32       v1, 0x2f800000
/*000000000034*/ v_cndmask_b32   v1, 1.0, v1, vcc
/*000000000038*/ v_mul_f32       v2, s3, v1
/*00000000003c*/ v_rcp_f32       v2, v2
/*000000000040*/ v_mul_f32       v2, s2, v2
/*000000000044*/ v_mul_f32       v2, v2, v1
/*000000000048*/ v_add_u32       v0, vcc, v0, s4
/*000000000050*/ v_mov_b32       v1, s5
/*000000000054*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*000000000058*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000060*/ v_add_u32       v0, vcc, s0, v0
/*000000000064*/ v_mov_b32       v3, s1
/*000000000068*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000006c*/ flat_store_dword v[0:1], v2
/*000000000074*/ s_endpgm
.kernel div_x_y_double
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 17
        .vgprsnum 11
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
        .arg data, "double*", double*, global, 
        .arg x, "double", double
        .arg y, "double", double
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x40
/*000000000008*/ s_load_dwordx4  s[8:11], s[4:5], 0x30
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000018*/ s_lshl_b32      s4, s6, 6
/*00000000001c*/ v_add_u32       v8, vcc, s4, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_mov_b32       v9, s10
/*000000000028*/ v_mov_b32       v10, s11
/*00000000002c*/ v_mov_b32       v0, s0
/*000000000030*/ v_mov_b32       v1, s1
/*000000000034*/ v_div_scale_f64 v[0:1], vcc, v[0:1], v[0:1], v[9:10]
/*00000000003c*/ v_div_scale_f64 v[2:3], vcc, v[9:10], s[0:1], v[9:10]
/*000000000044*/ v_rcp_f64       v[4:5], v[0:1]
/*000000000048*/ v_fma_f64       v[6:7], -v[0:1], v[4:5], 1.0
/*000000000050*/ v_fma_f64       v[4:5], v[4:5], v[6:7], v[4:5]
/*000000000058*/ v_fma_f64       v[6:7], -v[0:1], v[4:5], 1.0
/*000000000060*/ v_fma_f64       v[4:5], v[4:5], v[6:7], v[4:5]
/*000000000068*/ v_mul_f64       v[6:7], v[2:3], v[4:5]
/*000000000070*/ v_fma_f64       v[0:1], -v[0:1], v[6:7], v[2:3]
/*000000000078*/ v_div_fmas_f64  v[0:1], v[0:1], v[4:5], v[6:7]
/*000000000080*/ v_div_fixup_f64 v[0:1], v[0:1], s[0:1], v[9:10]
/*000000000088*/ v_add_u32       v2, vcc, v8, s2
/*000000000090*/ v_mov_b32       v3, s3
/*000000000094*/ v_addc_u32      v3, vcc, 0, v3, vcc
/*000000000098*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*0000000000a0*/ v_add_u32       v2, vcc, s8, v2
/*0000000000a4*/ v_mov_b32       v4, s9
/*0000000000a8*/ v_addc_u32      v3, vcc, v4, v3, vcc
/*0000000000ac*/ flat_store_dwordx2 v[2:3], v[0:1]
/*0000000000b4*/ s_endpgm
