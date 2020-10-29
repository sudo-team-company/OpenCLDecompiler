/* Disassembling 'arith-Ellesmere.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel div_x_x
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_global_offset_x
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_load_dwordx4  s[12:15], s[4:5], 0x8
/*000000000024*/ s_lshl_b32      s4, s6, 1
/*000000000028*/ s_lshl_b32      s5, s7, 4
/*00000000002c*/ s_lshl_b32      s6, s8, 1
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_cvt_f32_u32   v3, s1
/*000000000038*/ v_rcp_f32       v3, v3
/*00000000003c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000044*/ v_cvt_u32_f32   v5, v3
/*000000000048*/ v_mad_u64_u32   v[3:4], vcc, s1, v5, 0
/*000000000050*/ v_sub_u32       v6, vcc, 0, v3
/*000000000054*/ v_cmp_lg_i32    s[8:9], 0, v4
/*00000000005c*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000064*/ v_mul_hi_u32    v3, v3, v5
/*00000000006c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000070*/ v_add_u32       v3, vcc, v5, v3
/*000000000074*/ v_cndmask_b32   v5, v3, v4, s[8:9]
/*00000000007c*/ v_mul_hi_u32    v3, v5, s0
/*000000000084*/ v_mul_lo_u32    v4, v3, s1
/*00000000008c*/ v_sub_u32       v6, vcc, s0, v4
/*000000000090*/ v_cmp_ge_u32    s[8:9], s0, v4
/*000000000098*/ v_cmp_ge_u32    s[10:11], v6, s1
/*0000000000a0*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000a4*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000ac*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000b4*/ s_cmp_lg_i32    s1, 0
/*0000000000b8*/ s_cselect_b64   s[8:9], exec, 0
/*0000000000bc*/ v_cndmask_b32   v6, -1, v3, s[8:9]
/*0000000000c4*/ s_add_u32       s0, s4, s0
/*0000000000c8*/ v_add_u32       v3, vcc, s0, v0
/*0000000000cc*/ v_mov_b32       v4, 0
/*0000000000d0*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000d8*/ v_add_u32       v3, vcc, s2, v3
/*0000000000dc*/ v_mov_b32       v7, s3
/*0000000000e0*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000e4*/ flat_store_dword v[3:4], v6
/*0000000000ec*/ v_mul_hi_u32    v0, v5, s12
/*0000000000f4*/ v_mul_lo_u32    v3, v0, s1
/*0000000000fc*/ v_sub_u32       v4, vcc, s12, v3
/*000000000100*/ v_cmp_ge_u32    s[10:11], s12, v3
/*000000000108*/ v_cmp_ge_u32    s[16:17], v4, s1
/*000000000110*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*000000000114*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*00000000011c*/ v_addc_u32      v0, vcc, v0, -1, s[10:11]
/*000000000124*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*00000000012c*/ s_add_u32       s0, s5, s12
/*000000000130*/ v_add_u32       v0, vcc, s0, v1
/*000000000134*/ v_mov_b32       v1, 0
/*000000000138*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000140*/ v_add_u32       v0, vcc, s2, v0
/*000000000144*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000148*/ flat_store_dword v[0:1], v3
/*000000000150*/ v_mul_hi_u32    v0, v5, s14
/*000000000158*/ v_mul_lo_u32    v1, v0, s1
/*000000000160*/ v_sub_u32       v3, vcc, s14, v1
/*000000000164*/ v_cmp_ge_u32    s[4:5], s14, v1
/*00000000016c*/ v_cmp_ge_u32    s[0:1], v3, s1
/*000000000174*/ s_and_b64       s[0:1], s[4:5], s[0:1]
/*000000000178*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*000000000180*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*000000000188*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000190*/ s_add_u32       s0, s6, s14
/*000000000194*/ v_add_u32       v0, vcc, s0, v2
/*000000000198*/ v_mov_b32       v1, 0
/*00000000019c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000001a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001ac*/ flat_store_dword v[0:1], v3
/*0000000001b4*/ s_endpgm
.kernel div_get_local_id_x
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 8
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[10:11], s[4:5], 0x8
/*000000000024*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s5, s6, 3
/*000000000034*/ s_lshl_b32      s6, s7, 2
/*000000000038*/ s_lshl_b32      s7, s8, 1
/*00000000003c*/ v_cvt_f32_u32   v3, s1
/*000000000040*/ v_rcp_f32       v3, v3
/*000000000044*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000004c*/ v_cvt_u32_f32   v5, v3
/*000000000050*/ v_mad_u64_u32   v[3:4], vcc, s1, v5, 0
/*000000000058*/ v_sub_u32       v6, vcc, 0, v3
/*00000000005c*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000064*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*00000000006c*/ v_mul_hi_u32    v3, v3, v5
/*000000000074*/ v_sub_u32       v4, vcc, v5, v3
/*000000000078*/ v_add_u32       v3, vcc, v5, v3
/*00000000007c*/ v_cndmask_b32   v5, v3, v4, s[8:9]
/*000000000084*/ v_mul_hi_u32    v3, v5, v0
/*00000000008c*/ v_mul_lo_u32    v4, v3, s1
/*000000000094*/ v_sub_u32       v6, vcc, v0, v4
/*000000000098*/ v_cmp_ge_u32    s[8:9], v0, v4
/*0000000000a0*/ v_cmp_ge_u32    s[12:13], v6, s1
/*0000000000a8*/ s_and_b64       s[12:13], s[8:9], s[12:13]
/*0000000000ac*/ v_addc_u32      v3, vcc, v3, 0, s[12:13]
/*0000000000b4*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000bc*/ s_cmp_lg_i32    s1, 0
/*0000000000c0*/ s_cselect_b64   s[8:9], exec, 0
/*0000000000c4*/ v_cndmask_b32   v6, -1, v3, s[8:9]
/*0000000000cc*/ s_add_u32       s0, s5, s0
/*0000000000d0*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d4*/ v_mov_b32       v4, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e0*/ v_add_u32       v3, vcc, s2, v3
/*0000000000e4*/ v_mov_b32       v7, s3
/*0000000000e8*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v6
/*0000000000f4*/ v_mul_hi_u32    v0, v5, v1
/*0000000000fc*/ v_mul_lo_u32    v3, v0, s1
/*000000000104*/ v_sub_u32       v4, vcc, v1, v3
/*000000000108*/ v_cmp_ge_u32    s[12:13], v1, v3
/*000000000110*/ v_cmp_ge_u32    s[14:15], v4, s1
/*000000000118*/ s_and_b64       s[14:15], s[12:13], s[14:15]
/*00000000011c*/ v_addc_u32      v0, vcc, v0, 0, s[14:15]
/*000000000124*/ v_addc_u32      v0, vcc, v0, -1, s[12:13]
/*00000000012c*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000134*/ s_add_u32       s0, s6, s10
/*000000000138*/ v_add_u32       v0, vcc, s0, v1
/*00000000013c*/ v_mov_b32       v1, 0
/*000000000140*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000148*/ v_add_u32       v0, vcc, s2, v0
/*00000000014c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000150*/ flat_store_dword v[0:1], v3
/*000000000158*/ v_mul_hi_u32    v0, v5, v2
/*000000000160*/ v_mul_lo_u32    v1, v0, s1
/*000000000168*/ v_sub_u32       v3, vcc, v2, v1
/*00000000016c*/ v_cmp_ge_u32    s[10:11], v2, v1
/*000000000174*/ v_cmp_ge_u32    s[0:1], v3, s1
/*00000000017c*/ s_and_b64       s[0:1], s[10:11], s[0:1]
/*000000000180*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*000000000188*/ v_addc_u32      v0, vcc, v0, -1, s[10:11]
/*000000000190*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000198*/ s_add_u32       s0, s7, s4
/*00000000019c*/ v_add_u32       v0, vcc, s0, v2
/*0000000001a0*/ v_mov_b32       v1, 0
/*0000000001a4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000001b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001b4*/ flat_store_dword v[0:1], v3
/*0000000001bc*/ s_endpgm
.kernel div_get_group_id_x
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 21
        .vgprsnum 8
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[10:11], s[4:5], 0x8
/*000000000024*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s5, s6, 1
/*000000000034*/ s_lshl_b32      s9, s7, 4
/*000000000038*/ s_lshl_b32      s11, s8, 1
/*00000000003c*/ v_cvt_f32_u32   v3, s1
/*000000000040*/ v_rcp_f32       v3, v3
/*000000000044*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000004c*/ v_cvt_u32_f32   v5, v3
/*000000000050*/ v_mad_u64_u32   v[3:4], vcc, s1, v5, 0
/*000000000058*/ v_sub_u32       v6, vcc, 0, v3
/*00000000005c*/ v_cmp_lg_i32    s[12:13], 0, v4
/*000000000064*/ v_cndmask_b32   v3, v6, v3, s[12:13]
/*00000000006c*/ v_mul_hi_u32    v3, v3, v5
/*000000000074*/ v_sub_u32       v4, vcc, v5, v3
/*000000000078*/ v_add_u32       v3, vcc, v5, v3
/*00000000007c*/ v_cndmask_b32   v5, v3, v4, s[12:13]
/*000000000084*/ v_mul_hi_u32    v3, v5, s6
/*00000000008c*/ v_mul_lo_u32    v4, v3, s1
/*000000000094*/ v_sub_u32       v6, vcc, s6, v4
/*000000000098*/ v_cmp_ge_u32    s[12:13], s6, v4
/*0000000000a0*/ v_cmp_ge_u32    s[14:15], v6, s1
/*0000000000a8*/ s_and_b64       s[14:15], s[12:13], s[14:15]
/*0000000000ac*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*0000000000b4*/ v_addc_u32      v3, vcc, v3, -1, s[12:13]
/*0000000000bc*/ s_cmp_lg_i32    s1, 0
/*0000000000c0*/ s_cselect_b64   s[12:13], exec, 0
/*0000000000c4*/ v_cndmask_b32   v6, -1, v3, s[12:13]
/*0000000000cc*/ s_add_u32       s0, s5, s0
/*0000000000d0*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d4*/ v_mov_b32       v4, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e0*/ v_add_u32       v3, vcc, s2, v3
/*0000000000e4*/ v_mov_b32       v7, s3
/*0000000000e8*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v6
/*0000000000f4*/ v_mul_hi_u32    v0, v5, s7
/*0000000000fc*/ v_mul_lo_u32    v3, v0, s1
/*000000000104*/ v_sub_u32       v4, vcc, s7, v3
/*000000000108*/ v_cmp_ge_u32    s[6:7], s7, v3
/*000000000110*/ v_cmp_ge_u32    s[14:15], v4, s1
/*000000000118*/ s_and_b64       s[14:15], s[6:7], s[14:15]
/*00000000011c*/ v_addc_u32      v0, vcc, v0, 0, s[14:15]
/*000000000124*/ v_addc_u32      v0, vcc, v0, -1, s[6:7]
/*00000000012c*/ v_cndmask_b32   v3, -1, v0, s[12:13]
/*000000000134*/ s_add_u32       s0, s9, s10
/*000000000138*/ v_add_u32       v0, vcc, s0, v1
/*00000000013c*/ v_mov_b32       v1, 0
/*000000000140*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000148*/ v_add_u32       v0, vcc, s2, v0
/*00000000014c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000150*/ flat_store_dword v[0:1], v3
/*000000000158*/ v_mul_hi_u32    v0, v5, s8
/*000000000160*/ v_mul_lo_u32    v1, v0, s1
/*000000000168*/ v_sub_u32       v3, vcc, s8, v1
/*00000000016c*/ v_cmp_ge_u32    s[6:7], s8, v1
/*000000000174*/ v_cmp_ge_u32    s[0:1], v3, s1
/*00000000017c*/ s_and_b64       s[0:1], s[6:7], s[0:1]
/*000000000180*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*000000000188*/ v_addc_u32      v0, vcc, v0, -1, s[6:7]
/*000000000190*/ v_cndmask_b32   v3, -1, v0, s[12:13]
/*000000000198*/ s_add_u32       s0, s11, s4
/*00000000019c*/ v_add_u32       v0, vcc, s0, v2
/*0000000001a0*/ v_mov_b32       v1, 0
/*0000000001a4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000001b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001b4*/ flat_store_dword v[0:1], v3
/*0000000001bc*/ s_endpgm
.kernel div_get_local_size_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x30
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ v_cvt_f32_u32   v3, s0
/*000000000010*/ v_rcp_f32       v3, v3
/*000000000014*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000001c*/ v_cvt_u32_f32   v3, v3
/*000000000020*/ v_mad_u64_u32   v[4:5], vcc, s0, v3, 0
/*000000000028*/ v_sub_u32       v6, vcc, 0, v4
/*00000000002c*/ v_cmp_lg_i32    s[2:3], 0, v5
/*000000000034*/ v_cndmask_b32   v4, v6, v4, s[2:3]
/*00000000003c*/ v_mul_hi_u32    v4, v4, v3
/*000000000044*/ v_sub_u32       v5, vcc, v3, v4
/*000000000048*/ v_add_u32       v3, vcc, v3, v4
/*00000000004c*/ v_cndmask_b32   v3, v3, v5, s[2:3]
/*000000000054*/ v_readfirstlane_b32 s1, v3
/*000000000058*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000060*/ s_load_dwordx4  s[12:15], s[4:5], 0x8
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s3, s1, 31
/*000000000070*/ s_mul_i32       s9, s3, s0
/*000000000074*/ s_sub_u32       s10, 2, s9
/*000000000078*/ s_lshr_b32      s1, s1, 30
/*00000000007c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000084*/ s_lshl_b32      s6, s6, 1
/*000000000088*/ s_cmp_le_u32    s9, 2
/*00000000008c*/ s_cselect_b64   s[16:17], exec, 0
/*000000000090*/ s_cmp_ge_u32    s10, s0
/*000000000094*/ s_cselect_b64   s[10:11], exec, 0
/*000000000098*/ s_mul_i32       s9, s1, s0
/*00000000009c*/ s_lshl_b32      s7, s7, 1
/*0000000000a0*/ s_add_u32       s2, s6, s2
/*0000000000a4*/ s_sub_u32       s6, 4, s9
/*0000000000a8*/ s_lshl_b32      s8, s8, 2
/*0000000000ac*/ v_add_u32       v4, vcc, s2, v0
/*0000000000b0*/ s_and_b64       vcc, s[16:17], s[10:11]
/*0000000000b4*/ v_mov_b32       v3, s3
/*0000000000b8*/ s_add_u32       s2, s7, s12
/*0000000000bc*/ s_cmp_le_u32    s9, 4
/*0000000000c0*/ s_cselect_b64   s[10:11], exec, 0
/*0000000000c4*/ s_cmp_ge_u32    s6, s0
/*0000000000c8*/ s_cselect_b64   s[6:7], exec, 0
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, 0, vcc
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   s[12:13], exec, 0
/*0000000000dc*/ v_add_u32       v7, vcc, s2, v1
/*0000000000e0*/ s_add_u32       s0, s8, s14
/*0000000000e4*/ v_mov_b32       v5, 0
/*0000000000e8*/ v_lshlrev_b64   v[4:5], 2, v[4:5]
/*0000000000f0*/ v_addc_u32      v0, vcc, v3, -1, s[16:17]
/*0000000000f8*/ v_add_u32       v9, vcc, s0, v2
/*0000000000fc*/ s_and_b64       s[2:3], s[10:11], s[6:7]
/*000000000100*/ v_mov_b32       v3, s1
/*000000000104*/ s_waitcnt       lgkmcnt(0)
/*000000000108*/ v_add_u32       v4, vcc, s4, v4
/*00000000010c*/ v_mov_b32       v6, s5
/*000000000110*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*000000000114*/ v_cndmask_b32   v0, -1, v0, s[12:13]
/*00000000011c*/ v_mov_b32       v8, 0
/*000000000120*/ v_lshlrev_b64   v[7:8], 2, v[7:8]
/*000000000128*/ v_addc_u32      v1, vcc, v3, 0, s[2:3]
/*000000000130*/ v_add_u32       v11, vcc, s4, v7
/*000000000134*/ v_addc_u32      v12, vcc, v6, v8, vcc
/*000000000138*/ v_mov_b32       v10, 0
/*00000000013c*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*000000000144*/ v_addc_u32      v1, vcc, v1, -1, s[10:11]
/*00000000014c*/ v_add_u32       v2, vcc, s4, v8
/*000000000150*/ v_addc_u32      v3, vcc, v6, v9, vcc
/*000000000154*/ v_cndmask_b32   v1, -1, v1, s[12:13]
/*00000000015c*/ flat_store_dword v[4:5], v0
/*000000000164*/ flat_store_dword v[11:12], v0
/*00000000016c*/ flat_store_dword v[2:3], v1
/*000000000174*/ s_endpgm
.kernel div_get_global_id_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 20
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0084
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x30
/*000000000008*/ s_lshl_b32      s1, s6, 1
/*00000000000c*/ s_lshl_b32      s2, s7, 1
/*000000000010*/ s_lshl_b32      s3, s8, 2
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ v_cvt_f32_u32   v3, s0
/*00000000001c*/ v_rcp_f32       v3, v3
/*000000000020*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000028*/ v_cvt_u32_f32   v3, v3
/*00000000002c*/ v_mad_u64_u32   v[4:5], vcc, s0, v3, 0
/*000000000034*/ v_sub_u32       v6, vcc, 0, v4
/*000000000038*/ v_cmp_lg_i32    s[6:7], 0, v5
/*000000000040*/ v_cndmask_b32   v4, v6, v4, s[6:7]
/*000000000048*/ s_load_dwordx4  s[8:11], s[4:5], 0x0
/*000000000050*/ v_mul_hi_u32    v4, v4, v3
/*000000000058*/ s_load_dwordx2  s[12:13], s[4:5], 0x10
/*000000000060*/ v_add_u32       v11, vcc, s1, v0
/*000000000064*/ v_sub_u32       v5, vcc, v3, v4
/*000000000068*/ v_add_u32       v3, vcc, v3, v4
/*00000000006c*/ s_waitcnt       lgkmcnt(0)
/*000000000070*/ v_add_u32       v4, vcc, s8, v11
/*000000000074*/ v_cndmask_b32   v3, v3, v5, s[6:7]
/*00000000007c*/ s_add_u32       s1, s2, s10
/*000000000080*/ v_mul_hi_u32    v5, v3, v4
/*000000000088*/ v_add_u32       v13, vcc, s1, v1
/*00000000008c*/ s_add_u32       s1, s3, s12
/*000000000090*/ v_mul_hi_u32    v6, v3, v13
/*000000000098*/ v_add_u32       v15, vcc, s1, v2
/*00000000009c*/ v_mul_hi_u32    v3, v3, v15
/*0000000000a4*/ v_mul_lo_u32    v7, v5, s0
/*0000000000ac*/ v_mul_lo_u32    v8, v6, s0
/*0000000000b4*/ v_mul_lo_u32    v9, v3, s0
/*0000000000bc*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*0000000000c4*/ v_sub_u32       v10, vcc, v4, v7
/*0000000000c8*/ v_cmp_ge_u32    s[4:5], v4, v7
/*0000000000d0*/ v_cmp_ge_u32    s[6:7], v10, s0
/*0000000000d8*/ v_sub_u32       v4, vcc, v13, v8
/*0000000000dc*/ s_and_b64       s[6:7], s[4:5], s[6:7]
/*0000000000e0*/ v_cmp_ge_u32    s[8:9], v13, v8
/*0000000000e8*/ v_cmp_ge_u32    s[10:11], v4, s0
/*0000000000f0*/ v_sub_u32       v4, vcc, v15, v9
/*0000000000f4*/ v_addc_u32      v5, vcc, v5, 0, s[6:7]
/*0000000000fc*/ s_cmp_lg_i32    s0, 0
/*000000000100*/ s_cselect_b64   s[6:7], exec, 0
/*000000000104*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000108*/ v_cmp_ge_u32    s[12:13], v15, v9
/*000000000110*/ v_cmp_ge_u32    s[0:1], v4, s0
/*000000000118*/ v_mov_b32       v12, 0
/*00000000011c*/ v_lshlrev_b64   v[7:8], 2, v[11:12]
/*000000000124*/ v_addc_u32      v0, vcc, v5, -1, s[4:5]
/*00000000012c*/ v_addc_u32      v4, vcc, v6, 0, s[10:11]
/*000000000134*/ s_and_b64       s[0:1], s[12:13], s[0:1]
/*000000000138*/ s_waitcnt       lgkmcnt(0)
/*00000000013c*/ v_add_u32       v11, vcc, s2, v7
/*000000000140*/ v_mov_b32       v6, s3
/*000000000144*/ v_addc_u32      v12, vcc, v6, v8, vcc
/*000000000148*/ v_cndmask_b32   v0, -1, v0, s[6:7]
/*000000000150*/ v_addc_u32      v4, vcc, v4, -1, s[8:9]
/*000000000158*/ v_mov_b32       v14, 0
/*00000000015c*/ v_lshlrev_b64   v[8:9], 2, v[13:14]
/*000000000164*/ v_addc_u32      v1, vcc, v3, 0, s[0:1]
/*00000000016c*/ v_cndmask_b32   v3, -1, v4, s[6:7]
/*000000000174*/ v_add_u32       v4, vcc, s2, v8
/*000000000178*/ v_addc_u32      v5, vcc, v6, v9, vcc
/*00000000017c*/ v_addc_u32      v1, vcc, v1, -1, s[12:13]
/*000000000184*/ v_mov_b32       v16, 0
/*000000000188*/ v_lshlrev_b64   v[9:10], 2, v[15:16]
/*000000000190*/ v_cndmask_b32   v1, -1, v1, s[6:7]
/*000000000198*/ v_add_u32       v7, vcc, s2, v9
/*00000000019c*/ v_addc_u32      v8, vcc, v6, v10, vcc
/*0000000001a0*/ flat_store_dword v[11:12], v0
/*0000000001a8*/ flat_store_dword v[4:5], v3
/*0000000001b0*/ flat_store_dword v[7:8], v1
/*0000000001b8*/ s_endpgm
.kernel div_get_global_size_x
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshl_b32      s5, s8, 4
/*000000000040*/ s_lshl_b32      s7, s9, 1
/*000000000044*/ s_lshl_b32      s8, s10, 1
/*000000000048*/ v_cvt_f32_u32   v3, s3
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v5, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s3, v5, 0
/*000000000064*/ v_sub_u32       v6, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000078*/ v_mul_hi_u32    v3, v3, v5
/*000000000080*/ v_sub_u32       v4, vcc, v5, v3
/*000000000084*/ v_add_u32       v3, vcc, v5, v3
/*000000000088*/ v_cndmask_b32   v5, v3, v4, s[10:11]
/*000000000090*/ v_mul_hi_u32    v3, v5, s0
/*000000000098*/ v_mul_lo_u32    v4, v3, s3
/*0000000000a0*/ v_sub_u32       v6, vcc, s0, v4
/*0000000000a4*/ v_cmp_ge_u32    s[10:11], s0, v4
/*0000000000ac*/ v_cmp_ge_u32    s[16:17], v6, s3
/*0000000000b4*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000c8*/ s_cmp_lg_i32    s3, 0
/*0000000000cc*/ s_cselect_b64   s[10:11], exec, 0
/*0000000000d0*/ v_cndmask_b32   v6, -1, v3, s[10:11]
/*0000000000d8*/ s_add_u32       s0, s5, s4
/*0000000000dc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000e0*/ v_mov_b32       v4, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v7, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v6
/*000000000100*/ v_mul_hi_u32    v0, v5, s1
/*000000000108*/ v_mul_lo_u32    v3, v0, s3
/*000000000110*/ v_sub_u32       v4, vcc, s1, v3
/*000000000114*/ v_cmp_ge_u32    s[0:1], s1, v3
/*00000000011c*/ v_cmp_ge_u32    s[4:5], v4, s3
/*000000000124*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000128*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000130*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000138*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*000000000140*/ s_add_u32       s0, s7, s14
/*000000000144*/ v_add_u32       v0, vcc, s0, v1
/*000000000148*/ v_mov_b32       v1, 0
/*00000000014c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000154*/ v_add_u32       v0, vcc, s12, v0
/*000000000158*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000015c*/ flat_store_dword v[0:1], v3
/*000000000164*/ v_mul_hi_u32    v0, v5, s2
/*00000000016c*/ v_mul_lo_u32    v1, v0, s3
/*000000000174*/ v_sub_u32       v3, vcc, s2, v1
/*000000000178*/ v_cmp_ge_u32    s[0:1], s2, v1
/*000000000180*/ v_cmp_ge_u32    s[2:3], v3, s3
/*000000000188*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*00000000018c*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*000000000194*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*00000000019c*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*0000000001a4*/ s_add_u32       s0, s8, s6
/*0000000001a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000001ac*/ v_mov_b32       v1, 0
/*0000000001b0*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001b8*/ v_add_u32       v0, vcc, s12, v0
/*0000000001bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001c0*/ flat_store_dword v[0:1], v3
/*0000000001c8*/ s_endpgm
.kernel div_get_num_groups_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshr_b32      s0, s0, 1
/*000000000040*/ s_lshr_b32      s1, s1, 1
/*000000000044*/ s_lshr_b32      s2, s2, 2
/*000000000048*/ s_lshl_b32      s5, s8, 1
/*00000000004c*/ s_lshl_b32      s7, s9, 1
/*000000000050*/ s_lshl_b32      s8, s10, 2
/*000000000054*/ v_cvt_f32_u32   v3, s3
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s3, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[10:11], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v5, v3, v4, s[10:11]
/*00000000009c*/ v_mul_hi_u32    v3, v5, s0
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s3
/*0000000000ac*/ v_sub_u32       v6, vcc, s0, v4
/*0000000000b0*/ v_cmp_ge_u32    s[10:11], s0, v4
/*0000000000b8*/ v_cmp_ge_u32    s[16:17], v6, s3
/*0000000000c0*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000d4*/ s_cmp_lg_i32    s3, 0
/*0000000000d8*/ s_cselect_b64   s[10:11], exec, 0
/*0000000000dc*/ v_cndmask_b32   v6, -1, v3, s[10:11]
/*0000000000e4*/ s_add_u32       s0, s5, s4
/*0000000000e8*/ v_add_u32       v3, vcc, s0, v0
/*0000000000ec*/ v_mov_b32       v4, 0
/*0000000000f0*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000f8*/ v_add_u32       v3, vcc, s12, v3
/*0000000000fc*/ v_mov_b32       v7, s13
/*000000000100*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000104*/ flat_store_dword v[3:4], v6
/*00000000010c*/ v_mul_hi_u32    v0, v5, s1
/*000000000114*/ v_mul_lo_u32    v3, v0, s3
/*00000000011c*/ v_sub_u32       v4, vcc, s1, v3
/*000000000120*/ v_cmp_ge_u32    s[0:1], s1, v3
/*000000000128*/ v_cmp_ge_u32    s[4:5], v4, s3
/*000000000130*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000134*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*00000000013c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000144*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*00000000014c*/ s_add_u32       s0, s7, s14
/*000000000150*/ v_add_u32       v0, vcc, s0, v1
/*000000000154*/ v_mov_b32       v1, 0
/*000000000158*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000160*/ v_add_u32       v0, vcc, s12, v0
/*000000000164*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000168*/ flat_store_dword v[0:1], v3
/*000000000170*/ v_mul_hi_u32    v0, v5, s2
/*000000000178*/ v_mul_lo_u32    v1, v0, s3
/*000000000180*/ v_sub_u32       v3, vcc, s2, v1
/*000000000184*/ v_cmp_ge_u32    s[0:1], s2, v1
/*00000000018c*/ v_cmp_ge_u32    s[2:3], v3, s3
/*000000000194*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*000000000198*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*0000000001a0*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*0000000001a8*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*0000000001b0*/ s_add_u32       s0, s8, s6
/*0000000001b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000001b8*/ v_mov_b32       v1, 0
/*0000000001bc*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001c4*/ v_add_u32       v0, vcc, s12, v0
/*0000000001c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001cc*/ flat_store_dword v[0:1], v3
/*0000000001d4*/ s_endpgm
.kernel div_get_work_dim_x
    .config
        .dims x
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00000090
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dword    s1, s[6:7], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ v_cvt_f32_u32   v1, s1
/*000000000034*/ v_rcp_f32       v1, v1
/*000000000038*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000040*/ v_cvt_u32_f32   v3, v1
/*000000000044*/ v_mad_u64_u32   v[1:2], vcc, s1, v3, 0
/*00000000004c*/ v_sub_u32       v4, vcc, 0, v1
/*000000000050*/ v_cmp_lg_i32    s[6:7], 0, v2
/*000000000058*/ v_cndmask_b32   v1, v4, v1, s[6:7]
/*000000000060*/ v_mul_hi_u32    v1, v1, v3
/*000000000068*/ v_sub_u32       v2, vcc, v3, v1
/*00000000006c*/ v_add_u32       v1, vcc, v3, v1
/*000000000070*/ v_cndmask_b32   v1, v1, v2, s[6:7]
/*000000000078*/ v_mul_hi_u32    v1, v1, s0
/*000000000080*/ v_mul_lo_u32    v2, v1, s1
/*000000000088*/ v_sub_u32       v3, vcc, s0, v2
/*00000000008c*/ v_cmp_ge_u32    s[6:7], s0, v2
/*000000000094*/ v_cmp_ge_u32    s[8:9], v3, s1
/*00000000009c*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*0000000000a0*/ v_addc_u32      v1, vcc, v1, 0, s[8:9]
/*0000000000a8*/ v_addc_u32      v1, vcc, v1, -1, s[6:7]
/*0000000000b0*/ s_cmp_lg_i32    s1, 0
/*0000000000b4*/ s_cselect_b64   vcc, exec, 0
/*0000000000b8*/ v_cndmask_b32   v2, -1, v1, vcc
/*0000000000bc*/ s_add_u32       s0, s3, s2
/*0000000000c0*/ v_add_u32       v0, vcc, s0, v0
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_mov_b32       v3, s5
/*0000000000d8*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000dc*/ flat_store_dword v[0:1], v2
/*0000000000e4*/ s_endpgm
.kernel div_x_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 25
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*000000000010*/ s_load_dword    s9, s[4:5], 0x38
/*000000000018*/ s_lshl_b32      s6, s6, 4
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s6, s6, s0
/*000000000024*/ v_add_u32       v3, vcc, s6, v0
/*000000000028*/ v_mov_b32       v4, 0
/*00000000002c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000034*/ v_add_u32       v0, s[12:13], s10, v3
/*00000000003c*/ s_ashr_i32      s6, s9, 31
/*000000000040*/ s_cmp_eq_u64    1, s[0:1]
/*000000000044*/ s_cbranch_scc1  .L824_9
/*000000000048*/ v_cvt_f32_u32   v3, s0
/*00000000004c*/ v_cvt_f32_u32   v5, s1
/*000000000050*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000064*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*00000000006c*/ v_trunc_f32     v5, v5
/*000000000070*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000078*/ v_cvt_u32_f32   v3, v3
/*00000000007c*/ v_cvt_u32_f32   v5, v5
/*000000000080*/ v_sub_u32       v6, vcc, 0, s0
/*000000000088*/ v_mov_b32       v7, s1
/*00000000008c*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000090*/ v_mul_lo_u32    v8, v6, v5
/*000000000098*/ v_mul_lo_u32    v9, v7, v3
/*0000000000a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a4*/ v_mul_hi_u32    v9, v6, v3
/*0000000000ac*/ v_add_u32       v8, vcc, v8, v9
/*0000000000b0*/ v_mul_lo_u32    v9, v6, v3
/*0000000000b8*/ v_mul_hi_u32    v10, v3, v9
/*0000000000c0*/ v_mul_lo_u32    v11, v5, v9
/*0000000000c8*/ v_add_u32       v10, vcc, v10, v11
/*0000000000cc*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000d4*/ v_mul_lo_u32    v12, v3, v8
/*0000000000dc*/ v_add_u32       v10, vcc, v10, v12
/*0000000000e0*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000e8*/ v_mul_hi_u32    v9, v5, v9
/*0000000000f0*/ v_add_u32       v9, vcc, v10, v9
/*0000000000f4*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000000fc*/ v_mul_hi_u32    v11, v3, v8
/*000000000104*/ v_add_u32       v9, vcc, v9, v11
/*000000000108*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000110*/ v_mul_lo_u32    v11, v5, v8
/*000000000118*/ v_add_u32       v9, vcc, v9, v11
/*00000000011c*/ v_mul_hi_u32    v8, v5, v8
/*000000000124*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*000000000128*/ v_add_u32       v3, s[14:15], v3, v9
/*000000000130*/ v_add_u32       v9, vcc, v5, v8
/*000000000134*/ v_addc_u32      v5, vcc, v5, v8, s[14:15]
/*00000000013c*/ v_mul_lo_u32    v8, v6, v5
/*000000000144*/ v_mul_lo_u32    v7, v7, v3
/*00000000014c*/ v_add_u32       v7, vcc, v8, v7
/*000000000150*/ v_mul_hi_u32    v8, v6, v3
/*000000000158*/ v_add_u32       v7, vcc, v7, v8
/*00000000015c*/ v_mul_lo_u32    v6, v6, v3
/*000000000164*/ v_mul_hi_u32    v8, v3, v6
/*00000000016c*/ v_mul_lo_u32    v10, v5, v6
/*000000000174*/ v_add_u32       v8, vcc, v8, v10
/*000000000178*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000180*/ v_mul_lo_u32    v11, v3, v7
/*000000000188*/ v_add_u32       v8, vcc, v8, v11
/*00000000018c*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000194*/ v_mul_hi_u32    v6, v5, v6
/*00000000019c*/ v_add_u32       v6, vcc, v8, v6
/*0000000001a0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000001a8*/ v_mul_hi_u32    v10, v3, v7
/*0000000001b0*/ v_add_u32       v6, vcc, v6, v10
/*0000000001b4*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001bc*/ v_mul_lo_u32    v10, v5, v7
/*0000000001c4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001c8*/ v_mul_hi_u32    v5, v5, v7
/*0000000001d0*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001d4*/ v_add_u32       v3, s[16:17], v3, v6
/*0000000001dc*/ v_addc_u32      v5, vcc, v9, v5, s[14:15]
/*0000000001e4*/ v_addc_u32      v5, vcc, v5, 0, s[16:17]
/*0000000001ec*/ v_mul_hi_u32    v6, s9, v3
/*0000000001f4*/ v_mul_lo_u32    v7, s6, v3
/*0000000001fc*/ v_add_u32       v6, vcc, v6, v7
/*000000000200*/ v_cndmask_b32   v7, 0, 1, vcc
/*000000000208*/ v_mul_lo_u32    v8, s9, v5
/*000000000210*/ v_add_u32       v6, vcc, v6, v8
/*000000000214*/ v_addc_u32      v6, vcc, v7, 0, vcc
/*00000000021c*/ v_mul_hi_u32    v3, s6, v3
/*000000000224*/ v_add_u32       v3, vcc, v6, v3
/*000000000228*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000230*/ v_mul_hi_u32    v7, s9, v5
/*000000000238*/ v_add_u32       v3, vcc, v3, v7
/*00000000023c*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*000000000244*/ v_mul_lo_u32    v7, s6, v5
/*00000000024c*/ v_add_u32       v3, vcc, v3, v7
/*000000000250*/ v_mul_hi_u32    v5, s6, v5
/*000000000258*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*00000000025c*/ v_mul_lo_u32    v5, s0, v5
/*000000000264*/ v_mul_lo_u32    v6, s1, v3
/*00000000026c*/ v_add_u32       v5, vcc, v5, v6
/*000000000270*/ v_mul_hi_u32    v6, s0, v3
/*000000000278*/ v_add_u32       v5, vcc, v5, v6
/*00000000027c*/ v_mul_lo_u32    v6, s0, v3
/*000000000284*/ v_sub_u32       v6, s[14:15], s9, v6
/*00000000028c*/ v_mov_b32       v7, s6
/*000000000290*/ v_subb_u32      v7, vcc, v7, v5, s[14:15]
/*000000000298*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000002a0*/ v_cmp_ge_u32    s[18:19], v7, s1
/*0000000002a8*/ v_cmp_eq_i32    vcc, s1, v7
/*0000000002ac*/ v_cndmask_b32   v7, 0, -1, s[18:19]
/*0000000002b4*/ v_cndmask_b32   v8, 0, -1, s[16:17]
/*0000000002bc*/ v_cndmask_b32   v7, v7, v8, vcc
/*0000000002c0*/ v_cmp_lg_u32    vcc, 0, v7
/*0000000002c4*/ s_cbranch_vccz  .L808_9
/*0000000002c8*/ v_sub_u32       v5, vcc, s6, v5
/*0000000002cc*/ v_sub_u32       v6, s[16:17], v6, s0
/*0000000002d4*/ v_mov_b32       v7, s1
/*0000000002d8*/ v_subb_u32      v5, vcc, v5, v7, s[14:15]
/*0000000002e0*/ v_subb_u32      v5, vcc, v5, 0, s[16:17]
/*0000000002e8*/ v_add_u32       v3, s[14:15], v3, 1
/*0000000002f0*/ v_cmp_ge_u32    s[14:15], v6, s0
/*0000000002f8*/ v_cmp_ge_u32    s[16:17], v5, s1
/*000000000300*/ v_cmp_eq_i32    vcc, s1, v5
/*000000000304*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*00000000030c*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*000000000314*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000318*/ v_cmp_lg_u32    vcc, 0, v5
/*00000000031c*/ s_cbranch_vccz  .L808_9
/*000000000320*/ v_add_u32       v3, s[14:15], v3, 1
.L808_9:
/*000000000328*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*000000000330*/ v_cndmask_b32   v3, -1, v3, vcc
/*000000000334*/ s_branch        .L828_9
.L824_9:
/*000000000338*/ v_mov_b32       v3, s9
.L828_9:
/*00000000033c*/ s_lshl_b32      s0, s7, 1
/*000000000340*/ s_add_u32       s0, s0, s2
/*000000000344*/ v_add_u32       v7, vcc, s0, v1
/*000000000348*/ v_mov_b32       v6, s11
/*00000000034c*/ v_addc_u32      v1, vcc, v6, v4, s[12:13]
/*000000000354*/ flat_store_dword v[0:1], v3
/*00000000035c*/ v_mov_b32       v8, 0
/*000000000360*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*000000000368*/ v_add_u32       v0, vcc, s10, v0
/*00000000036c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000370*/ s_cmp_eq_u64    1, s[2:3]
/*000000000374*/ s_cbranch_scc1  .L1640_9
/*000000000378*/ v_cvt_f32_u32   v3, s2
/*00000000037c*/ v_cvt_f32_u32   v4, s3
/*000000000380*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000388*/ v_rcp_f32       v3, v3
/*00000000038c*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000394*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*00000000039c*/ v_trunc_f32     v4, v4
/*0000000003a0*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*0000000003a8*/ v_cvt_u32_f32   v3, v3
/*0000000003ac*/ v_cvt_u32_f32   v4, v4
/*0000000003b0*/ v_sub_u32       v5, vcc, 0, s2
/*0000000003b8*/ v_mov_b32       v6, s3
/*0000000003bc*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*0000000003c0*/ v_mul_lo_u32    v7, v5, v4
/*0000000003c8*/ v_mul_lo_u32    v8, v6, v3
/*0000000003d0*/ v_add_u32       v7, vcc, v7, v8
/*0000000003d4*/ v_mul_hi_u32    v8, v5, v3
/*0000000003dc*/ v_add_u32       v7, vcc, v7, v8
/*0000000003e0*/ v_mul_lo_u32    v8, v5, v3
/*0000000003e8*/ v_mul_hi_u32    v9, v3, v8
/*0000000003f0*/ v_mul_lo_u32    v10, v4, v8
/*0000000003f8*/ v_add_u32       v9, vcc, v9, v10
/*0000000003fc*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000404*/ v_mul_lo_u32    v11, v3, v7
/*00000000040c*/ v_add_u32       v9, vcc, v9, v11
/*000000000410*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*000000000418*/ v_mul_hi_u32    v8, v4, v8
/*000000000420*/ v_add_u32       v8, vcc, v9, v8
/*000000000424*/ v_cndmask_b32   v9, 0, 1, vcc
/*00000000042c*/ v_mul_hi_u32    v10, v3, v7
/*000000000434*/ v_add_u32       v8, vcc, v8, v10
/*000000000438*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000440*/ v_mul_lo_u32    v10, v4, v7
/*000000000448*/ v_add_u32       v8, vcc, v8, v10
/*00000000044c*/ v_mul_hi_u32    v7, v4, v7
/*000000000454*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*000000000458*/ v_add_u32       v3, s[0:1], v3, v8
/*000000000460*/ v_add_u32       v8, vcc, v4, v7
/*000000000464*/ v_addc_u32      v4, vcc, v4, v7, s[0:1]
/*00000000046c*/ v_mul_lo_u32    v7, v5, v4
/*000000000474*/ v_mul_lo_u32    v6, v6, v3
/*00000000047c*/ v_add_u32       v6, vcc, v7, v6
/*000000000480*/ v_mul_hi_u32    v7, v5, v3
/*000000000488*/ v_add_u32       v6, vcc, v6, v7
/*00000000048c*/ v_mul_lo_u32    v5, v5, v3
/*000000000494*/ v_mul_hi_u32    v7, v3, v5
/*00000000049c*/ v_mul_lo_u32    v9, v4, v5
/*0000000004a4*/ v_add_u32       v7, vcc, v7, v9
/*0000000004a8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000004b0*/ v_mul_lo_u32    v10, v3, v6
/*0000000004b8*/ v_add_u32       v7, vcc, v7, v10
/*0000000004bc*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*0000000004c4*/ v_mul_hi_u32    v5, v4, v5
/*0000000004cc*/ v_add_u32       v5, vcc, v7, v5
/*0000000004d0*/ v_cndmask_b32   v7, 0, 1, vcc
/*0000000004d8*/ v_mul_hi_u32    v9, v3, v6
/*0000000004e0*/ v_add_u32       v5, vcc, v5, v9
/*0000000004e4*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004ec*/ v_mul_lo_u32    v9, v4, v6
/*0000000004f4*/ v_add_u32       v5, vcc, v5, v9
/*0000000004f8*/ v_mul_hi_u32    v4, v4, v6
/*000000000500*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000504*/ v_add_u32       v3, s[12:13], v3, v5
/*00000000050c*/ v_addc_u32      v4, vcc, v8, v4, s[0:1]
/*000000000514*/ v_addc_u32      v4, vcc, v4, 0, s[12:13]
/*00000000051c*/ v_mul_hi_u32    v5, s9, v3
/*000000000524*/ v_mul_lo_u32    v6, s6, v3
/*00000000052c*/ v_add_u32       v5, vcc, v5, v6
/*000000000530*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000538*/ v_mul_lo_u32    v7, s9, v4
/*000000000540*/ v_add_u32       v5, vcc, v5, v7
/*000000000544*/ v_addc_u32      v5, vcc, v6, 0, vcc
/*00000000054c*/ v_mul_hi_u32    v3, s6, v3
/*000000000554*/ v_add_u32       v3, vcc, v5, v3
/*000000000558*/ v_cndmask_b32   v5, 0, 1, vcc
/*000000000560*/ v_mul_hi_u32    v6, s9, v4
/*000000000568*/ v_add_u32       v3, vcc, v3, v6
/*00000000056c*/ v_addc_u32      v5, vcc, v5, 0, vcc
/*000000000574*/ v_mul_lo_u32    v6, s6, v4
/*00000000057c*/ v_add_u32       v3, vcc, v3, v6
/*000000000580*/ v_mul_hi_u32    v4, s6, v4
/*000000000588*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000058c*/ v_mul_lo_u32    v4, s2, v4
/*000000000594*/ v_mul_lo_u32    v5, s3, v3
/*00000000059c*/ v_add_u32       v4, vcc, v4, v5
/*0000000005a0*/ v_mul_hi_u32    v5, s2, v3
/*0000000005a8*/ v_add_u32       v4, vcc, v4, v5
/*0000000005ac*/ v_mul_lo_u32    v5, s2, v3
/*0000000005b4*/ v_sub_u32       v5, s[0:1], s9, v5
/*0000000005bc*/ v_mov_b32       v6, s6
/*0000000005c0*/ v_subb_u32      v6, vcc, v6, v4, s[0:1]
/*0000000005c8*/ v_cmp_ge_u32    s[12:13], v5, s2
/*0000000005d0*/ v_cmp_ge_u32    s[14:15], v6, s3
/*0000000005d8*/ v_cmp_eq_i32    vcc, s3, v6
/*0000000005dc*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*0000000005e4*/ v_cndmask_b32   v7, 0, -1, s[12:13]
/*0000000005ec*/ v_cndmask_b32   v6, v6, v7, vcc
/*0000000005f0*/ v_cmp_lg_u32    vcc, 0, v6
/*0000000005f4*/ s_cbranch_vccz  .L1624_9
/*0000000005f8*/ v_sub_u32       v4, vcc, s6, v4
/*0000000005fc*/ v_sub_u32       v5, s[12:13], v5, s2
/*000000000604*/ v_mov_b32       v6, s3
/*000000000608*/ v_subb_u32      v4, vcc, v4, v6, s[0:1]
/*000000000610*/ v_subb_u32      v4, vcc, v4, 0, s[12:13]
/*000000000618*/ v_add_u32       v3, s[0:1], v3, 1
/*000000000620*/ v_cmp_ge_u32    s[0:1], v5, s2
/*000000000628*/ v_cmp_ge_u32    s[12:13], v4, s3
/*000000000630*/ v_cmp_eq_i32    vcc, s3, v4
/*000000000634*/ v_cndmask_b32   v4, 0, -1, s[12:13]
/*00000000063c*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*000000000644*/ v_cndmask_b32   v4, v4, v5, vcc
/*000000000648*/ v_cmp_lg_u32    vcc, 0, v4
/*00000000064c*/ s_cbranch_vccz  .L1624_9
/*000000000650*/ v_add_u32       v3, s[0:1], v3, 1
.L1624_9:
/*000000000658*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*000000000660*/ v_cndmask_b32   v3, -1, v3, vcc
/*000000000664*/ s_branch        .L1644_9
.L1640_9:
/*000000000668*/ v_mov_b32       v3, s9
.L1644_9:
/*00000000066c*/ s_lshl_b32      s0, s8, 1
/*000000000670*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000678*/ flat_store_dword v[0:1], v3
/*000000000680*/ s_waitcnt       lgkmcnt(0)
/*000000000684*/ s_add_u32       s0, s0, s2
/*000000000688*/ v_add_u32       v0, vcc, s0, v2
/*00000000068c*/ v_mov_b32       v1, 0
/*000000000690*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000698*/ v_add_u32       v0, vcc, s10, v0
/*00000000069c*/ v_mov_b32       v2, s11
/*0000000006a0*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000006a4*/ s_cmp_eq_u64    1, s[2:3]
/*0000000006a8*/ s_cbranch_scc1  .L2460_9
/*0000000006ac*/ v_cvt_f32_u32   v2, s2
/*0000000006b0*/ v_cvt_f32_u32   v3, s3
/*0000000006b4*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*0000000006bc*/ v_rcp_f32       v2, v2
/*0000000006c0*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*0000000006c8*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*0000000006d0*/ v_trunc_f32     v3, v3
/*0000000006d4*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*0000000006dc*/ v_cvt_u32_f32   v2, v2
/*0000000006e0*/ v_cvt_u32_f32   v3, v3
/*0000000006e4*/ v_sub_u32       v4, vcc, 0, s2
/*0000000006ec*/ v_mov_b32       v5, s3
/*0000000006f0*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*0000000006f4*/ v_mul_lo_u32    v6, v4, v3
/*0000000006fc*/ v_mul_lo_u32    v7, v5, v2
/*000000000704*/ v_add_u32       v6, vcc, v6, v7
/*000000000708*/ v_mul_hi_u32    v7, v4, v2
/*000000000710*/ v_add_u32       v6, vcc, v6, v7
/*000000000714*/ v_mul_lo_u32    v7, v4, v2
/*00000000071c*/ v_mul_hi_u32    v8, v2, v7
/*000000000724*/ v_mul_lo_u32    v9, v3, v7
/*00000000072c*/ v_add_u32       v8, vcc, v8, v9
/*000000000730*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000738*/ v_mul_lo_u32    v10, v2, v6
/*000000000740*/ v_add_u32       v8, vcc, v8, v10
/*000000000744*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*00000000074c*/ v_mul_hi_u32    v7, v3, v7
/*000000000754*/ v_add_u32       v7, vcc, v8, v7
/*000000000758*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000760*/ v_mul_hi_u32    v9, v2, v6
/*000000000768*/ v_add_u32       v7, vcc, v7, v9
/*00000000076c*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*000000000774*/ v_mul_lo_u32    v9, v3, v6
/*00000000077c*/ v_add_u32       v7, vcc, v7, v9
/*000000000780*/ v_mul_hi_u32    v6, v3, v6
/*000000000788*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*00000000078c*/ v_add_u32       v2, s[0:1], v2, v7
/*000000000794*/ v_add_u32       v7, vcc, v3, v6
/*000000000798*/ v_addc_u32      v3, vcc, v3, v6, s[0:1]
/*0000000007a0*/ v_mul_lo_u32    v6, v4, v3
/*0000000007a8*/ v_mul_lo_u32    v5, v5, v2
/*0000000007b0*/ v_add_u32       v5, vcc, v6, v5
/*0000000007b4*/ v_mul_hi_u32    v6, v4, v2
/*0000000007bc*/ v_add_u32       v5, vcc, v5, v6
/*0000000007c0*/ v_mul_lo_u32    v4, v4, v2
/*0000000007c8*/ v_mul_hi_u32    v6, v2, v4
/*0000000007d0*/ v_mul_lo_u32    v8, v3, v4
/*0000000007d8*/ v_add_u32       v6, vcc, v6, v8
/*0000000007dc*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000007e4*/ v_mul_lo_u32    v9, v2, v5
/*0000000007ec*/ v_add_u32       v6, vcc, v6, v9
/*0000000007f0*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*0000000007f8*/ v_mul_hi_u32    v4, v3, v4
/*000000000800*/ v_add_u32       v4, vcc, v6, v4
/*000000000804*/ v_cndmask_b32   v6, 0, 1, vcc
/*00000000080c*/ v_mul_hi_u32    v8, v2, v5
/*000000000814*/ v_add_u32       v4, vcc, v4, v8
/*000000000818*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*000000000820*/ v_mul_lo_u32    v8, v3, v5
/*000000000828*/ v_add_u32       v4, vcc, v4, v8
/*00000000082c*/ v_mul_hi_u32    v3, v3, v5
/*000000000834*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*000000000838*/ v_add_u32       v2, s[4:5], v2, v4
/*000000000840*/ v_addc_u32      v3, vcc, v7, v3, s[0:1]
/*000000000848*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*000000000850*/ v_mul_hi_u32    v4, s9, v2
/*000000000858*/ v_mul_lo_u32    v5, s6, v2
/*000000000860*/ v_add_u32       v4, vcc, v4, v5
/*000000000864*/ v_cndmask_b32   v5, 0, 1, vcc
/*00000000086c*/ v_mul_lo_u32    v6, s9, v3
/*000000000874*/ v_add_u32       v4, vcc, v4, v6
/*000000000878*/ v_addc_u32      v4, vcc, v5, 0, vcc
/*000000000880*/ v_mul_hi_u32    v2, s6, v2
/*000000000888*/ v_add_u32       v2, vcc, v4, v2
/*00000000088c*/ v_cndmask_b32   v4, 0, 1, vcc
/*000000000894*/ v_mul_hi_u32    v5, s9, v3
/*00000000089c*/ v_add_u32       v2, vcc, v2, v5
/*0000000008a0*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*0000000008a8*/ v_mul_lo_u32    v5, s6, v3
/*0000000008b0*/ v_add_u32       v2, vcc, v2, v5
/*0000000008b4*/ v_mul_hi_u32    v3, s6, v3
/*0000000008bc*/ v_addc_u32      v3, vcc, v4, v3, vcc
/*0000000008c0*/ v_mul_lo_u32    v3, s2, v3
/*0000000008c8*/ v_mul_lo_u32    v4, s3, v2
/*0000000008d0*/ v_add_u32       v3, vcc, v3, v4
/*0000000008d4*/ v_mul_hi_u32    v4, s2, v2
/*0000000008dc*/ v_add_u32       v3, vcc, v3, v4
/*0000000008e0*/ v_mul_lo_u32    v4, s2, v2
/*0000000008e8*/ v_sub_u32       v4, s[0:1], s9, v4
/*0000000008f0*/ v_mov_b32       v5, s6
/*0000000008f4*/ v_subb_u32      v5, vcc, v5, v3, s[0:1]
/*0000000008fc*/ v_cmp_ge_u32    s[4:5], v4, s2
/*000000000904*/ v_cmp_ge_u32    s[8:9], v5, s3
/*00000000090c*/ v_cmp_eq_i32    vcc, s3, v5
/*000000000910*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*000000000918*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*000000000920*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000924*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000928*/ s_cbranch_vccz  .L2444_9
/*00000000092c*/ v_sub_u32       v3, vcc, s6, v3
/*000000000930*/ v_sub_u32       v4, s[4:5], v4, s2
/*000000000938*/ v_mov_b32       v5, s3
/*00000000093c*/ v_subb_u32      v3, vcc, v3, v5, s[0:1]
/*000000000944*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*00000000094c*/ v_add_u32       v2, s[0:1], v2, 1
/*000000000954*/ v_cmp_ge_u32    s[0:1], v4, s2
/*00000000095c*/ v_cmp_ge_u32    s[4:5], v3, s3
/*000000000964*/ v_cmp_eq_i32    vcc, s3, v3
/*000000000968*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*000000000970*/ v_cndmask_b32   v4, 0, -1, s[0:1]
/*000000000978*/ v_cndmask_b32   v3, v3, v4, vcc
/*00000000097c*/ v_cmp_lg_u32    vcc, 0, v3
/*000000000980*/ s_cbranch_vccz  .L2444_9
/*000000000984*/ v_add_u32       v2, s[0:1], v2, 1
.L2444_9:
/*00000000098c*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*000000000994*/ v_cndmask_b32   v2, -1, v2, vcc
/*000000000998*/ s_branch        .L2464_9
.L2460_9:
/*00000000099c*/ v_mov_b32       v2, s9
.L2464_9:
/*0000000009a0*/ flat_store_dword v[0:1], v2
/*0000000009a8*/ s_endpgm
.kernel div_get_global_offset_get_global_offset
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 25
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 1
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s6, s6, s0
/*00000000001c*/ v_add_u32       v3, vcc, s6, v0
/*000000000020*/ v_mov_b32       v4, 0
/*000000000024*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000002c*/ v_add_u32       v3, s[12:13], s10, v3
/*000000000034*/ s_cmp_eq_u64    1, s[0:1]
/*000000000038*/ s_cbranch_scc1  .L748_10
/*00000000003c*/ v_cvt_f32_u32   v0, s0
/*000000000040*/ v_cvt_f32_u32   v5, s1
/*000000000044*/ v_madmk_f32     v0, v5, 0x4f800000 /* 4.2949673e+9f */, v0
/*00000000004c*/ v_rcp_f32       v0, v0
/*000000000050*/ v_mul_f32       v0, 0x5f7ffffc /* 1.844674e+19f */, v0
/*000000000058*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v0
/*000000000060*/ v_trunc_f32     v5, v5
/*000000000064*/ v_madmk_f32     v0, v5, 0xcf800000 /* -4.2949673e+9f */, v0
/*00000000006c*/ v_cvt_u32_f32   v0, v0
/*000000000070*/ v_cvt_u32_f32   v5, v5
/*000000000074*/ v_sub_u32       v6, vcc, 0, s0
/*00000000007c*/ v_mov_b32       v7, s1
/*000000000080*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000084*/ v_mul_lo_u32    v8, v6, v5
/*00000000008c*/ v_mul_lo_u32    v9, v7, v0
/*000000000094*/ v_add_u32       v8, vcc, v8, v9
/*000000000098*/ v_mul_hi_u32    v9, v6, v0
/*0000000000a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a4*/ v_mul_lo_u32    v9, v6, v0
/*0000000000ac*/ v_mul_hi_u32    v10, v0, v9
/*0000000000b4*/ v_mul_lo_u32    v11, v5, v9
/*0000000000bc*/ v_add_u32       v10, vcc, v10, v11
/*0000000000c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000c8*/ v_mul_lo_u32    v12, v0, v8
/*0000000000d0*/ v_add_u32       v10, vcc, v10, v12
/*0000000000d4*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000dc*/ v_mul_hi_u32    v9, v5, v9
/*0000000000e4*/ v_add_u32       v9, vcc, v10, v9
/*0000000000e8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000000f0*/ v_mul_hi_u32    v11, v0, v8
/*0000000000f8*/ v_add_u32       v9, vcc, v9, v11
/*0000000000fc*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000104*/ v_mul_lo_u32    v11, v5, v8
/*00000000010c*/ v_add_u32       v9, vcc, v9, v11
/*000000000110*/ v_mul_hi_u32    v8, v5, v8
/*000000000118*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*00000000011c*/ v_add_u32       v0, s[14:15], v0, v9
/*000000000124*/ v_add_u32       v9, vcc, v5, v8
/*000000000128*/ v_addc_u32      v5, vcc, v5, v8, s[14:15]
/*000000000130*/ v_mul_lo_u32    v8, v6, v5
/*000000000138*/ v_mul_lo_u32    v7, v7, v0
/*000000000140*/ v_add_u32       v7, vcc, v8, v7
/*000000000144*/ v_mul_hi_u32    v8, v6, v0
/*00000000014c*/ v_add_u32       v7, vcc, v7, v8
/*000000000150*/ v_mul_lo_u32    v6, v6, v0
/*000000000158*/ v_mul_hi_u32    v8, v0, v6
/*000000000160*/ v_mul_lo_u32    v10, v5, v6
/*000000000168*/ v_add_u32       v8, vcc, v8, v10
/*00000000016c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000174*/ v_mul_lo_u32    v11, v0, v7
/*00000000017c*/ v_add_u32       v8, vcc, v8, v11
/*000000000180*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000188*/ v_mul_hi_u32    v6, v5, v6
/*000000000190*/ v_add_u32       v6, vcc, v8, v6
/*000000000194*/ v_cndmask_b32   v8, 0, 1, vcc
/*00000000019c*/ v_mul_hi_u32    v10, v0, v7
/*0000000001a4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001a8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001b0*/ v_mul_lo_u32    v10, v5, v7
/*0000000001b8*/ v_add_u32       v6, vcc, v6, v10
/*0000000001bc*/ v_mul_hi_u32    v5, v5, v7
/*0000000001c4*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001c8*/ v_add_u32       v0, s[16:17], v0, v6
/*0000000001d0*/ v_addc_u32      v5, vcc, v9, v5, s[14:15]
/*0000000001d8*/ v_addc_u32      v5, vcc, v5, 0, s[16:17]
/*0000000001e0*/ v_mul_hi_u32    v0, s0, v0
/*0000000001e8*/ v_mul_lo_u32    v6, s0, v5
/*0000000001f0*/ v_add_u32       v0, vcc, v0, v6
/*0000000001f4*/ v_addc_u32      v0, vcc, 0, 0, vcc
/*0000000001fc*/ v_mul_hi_u32    v5, s0, v5
/*000000000204*/ v_add_u32       v0, vcc, v0, v5
/*000000000208*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000210*/ v_add_u32       v5, vcc, 0, v5
/*000000000214*/ v_mul_lo_u32    v5, s0, v5
/*00000000021c*/ v_mul_lo_u32    v6, s1, v0
/*000000000224*/ v_add_u32       v5, vcc, v5, v6
/*000000000228*/ v_mul_hi_u32    v6, s0, v0
/*000000000230*/ v_add_u32       v5, vcc, v5, v6
/*000000000234*/ v_mul_lo_u32    v6, s0, v0
/*00000000023c*/ v_sub_u32       v6, s[14:15], s0, v6
/*000000000244*/ v_subb_u32      v7, vcc, 0, v5, s[14:15]
/*00000000024c*/ v_cmp_ge_u32    s[16:17], v6, s0
/*000000000254*/ v_cmp_ge_u32    s[18:19], v7, s1
/*00000000025c*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000260*/ v_cndmask_b32   v7, 0, -1, s[18:19]
/*000000000268*/ v_cndmask_b32   v8, 0, -1, s[16:17]
/*000000000270*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000274*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000278*/ s_cbranch_vccz  .L732_10
/*00000000027c*/ v_sub_u32       v5, vcc, 0, v5
/*000000000280*/ v_sub_u32       v6, s[16:17], v6, s0
/*000000000288*/ v_mov_b32       v7, s1
/*00000000028c*/ v_subb_u32      v5, vcc, v5, v7, s[14:15]
/*000000000294*/ v_subb_u32      v5, vcc, v5, 0, s[16:17]
/*00000000029c*/ v_add_u32       v0, s[14:15], v0, 1
/*0000000002a4*/ v_cmp_ge_u32    s[14:15], v6, s0
/*0000000002ac*/ v_cmp_ge_u32    s[16:17], v5, s1
/*0000000002b4*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002b8*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*0000000002c0*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*0000000002c8*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002cc*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002d0*/ s_cbranch_vccz  .L732_10
/*0000000002d4*/ v_add_u32       v0, s[14:15], v0, 1
.L732_10:
/*0000000002dc*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002e4*/ v_cndmask_b32   v5, -1, v0, vcc
/*0000000002e8*/ s_branch        .L752_10
.L748_10:
/*0000000002ec*/ v_mov_b32       v5, s0
.L752_10:
/*0000000002f0*/ s_lshl_b32      s0, s7, 4
/*0000000002f4*/ s_add_u32       s0, s0, s2
/*0000000002f8*/ v_add_u32       v0, vcc, s0, v1
/*0000000002fc*/ v_mov_b32       v1, 0
/*000000000300*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000308*/ v_mov_b32       v6, s11
/*00000000030c*/ v_addc_u32      v4, vcc, v6, v4, s[12:13]
/*000000000314*/ flat_store_dword v[3:4], v5
/*00000000031c*/ v_add_u32       v0, vcc, s10, v0
/*000000000320*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000324*/ s_cmp_eq_u64    1, s[2:3]
/*000000000328*/ s_cbranch_scc1  .L1500_10
/*00000000032c*/ v_cvt_f32_u32   v3, s2
/*000000000330*/ v_cvt_f32_u32   v4, s3
/*000000000334*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000033c*/ v_rcp_f32       v3, v3
/*000000000340*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000348*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000350*/ v_trunc_f32     v4, v4
/*000000000354*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000035c*/ v_cvt_u32_f32   v3, v3
/*000000000360*/ v_cvt_u32_f32   v4, v4
/*000000000364*/ v_sub_u32       v5, vcc, 0, s2
/*00000000036c*/ v_mov_b32       v6, s3
/*000000000370*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000374*/ v_mul_lo_u32    v7, v5, v4
/*00000000037c*/ v_mul_lo_u32    v8, v6, v3
/*000000000384*/ v_add_u32       v7, vcc, v7, v8
/*000000000388*/ v_mul_hi_u32    v8, v5, v3
/*000000000390*/ v_add_u32       v7, vcc, v7, v8
/*000000000394*/ v_mul_lo_u32    v8, v5, v3
/*00000000039c*/ v_mul_hi_u32    v9, v3, v8
/*0000000003a4*/ v_mul_lo_u32    v10, v4, v8
/*0000000003ac*/ v_add_u32       v9, vcc, v9, v10
/*0000000003b0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003b8*/ v_mul_lo_u32    v11, v3, v7
/*0000000003c0*/ v_add_u32       v9, vcc, v9, v11
/*0000000003c4*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003cc*/ v_mul_hi_u32    v8, v4, v8
/*0000000003d4*/ v_add_u32       v8, vcc, v9, v8
/*0000000003d8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000003e0*/ v_mul_hi_u32    v10, v3, v7
/*0000000003e8*/ v_add_u32       v8, vcc, v8, v10
/*0000000003ec*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000003f4*/ v_mul_lo_u32    v10, v4, v7
/*0000000003fc*/ v_add_u32       v8, vcc, v8, v10
/*000000000400*/ v_mul_hi_u32    v7, v4, v7
/*000000000408*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*00000000040c*/ v_add_u32       v3, s[0:1], v3, v8
/*000000000414*/ v_add_u32       v8, vcc, v4, v7
/*000000000418*/ v_addc_u32      v4, vcc, v4, v7, s[0:1]
/*000000000420*/ v_mul_lo_u32    v7, v5, v4
/*000000000428*/ v_mul_lo_u32    v6, v6, v3
/*000000000430*/ v_add_u32       v6, vcc, v7, v6
/*000000000434*/ v_mul_hi_u32    v7, v5, v3
/*00000000043c*/ v_add_u32       v6, vcc, v6, v7
/*000000000440*/ v_mul_lo_u32    v5, v5, v3
/*000000000448*/ v_mul_hi_u32    v7, v3, v5
/*000000000450*/ v_mul_lo_u32    v9, v4, v5
/*000000000458*/ v_add_u32       v7, vcc, v7, v9
/*00000000045c*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000464*/ v_mul_lo_u32    v10, v3, v6
/*00000000046c*/ v_add_u32       v7, vcc, v7, v10
/*000000000470*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000478*/ v_mul_hi_u32    v5, v4, v5
/*000000000480*/ v_add_u32       v5, vcc, v7, v5
/*000000000484*/ v_cndmask_b32   v7, 0, 1, vcc
/*00000000048c*/ v_mul_hi_u32    v9, v3, v6
/*000000000494*/ v_add_u32       v5, vcc, v5, v9
/*000000000498*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004a0*/ v_mul_lo_u32    v9, v4, v6
/*0000000004a8*/ v_add_u32       v5, vcc, v5, v9
/*0000000004ac*/ v_mul_hi_u32    v4, v4, v6
/*0000000004b4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004b8*/ v_add_u32       v3, s[6:7], v3, v5
/*0000000004c0*/ v_addc_u32      v4, vcc, v8, v4, s[0:1]
/*0000000004c8*/ v_addc_u32      v4, vcc, v4, 0, s[6:7]
/*0000000004d0*/ v_mul_hi_u32    v3, s2, v3
/*0000000004d8*/ v_mul_lo_u32    v5, s2, v4
/*0000000004e0*/ v_add_u32       v3, vcc, v3, v5
/*0000000004e4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000004ec*/ v_mul_hi_u32    v4, s2, v4
/*0000000004f4*/ v_add_u32       v3, vcc, v3, v4
/*0000000004f8*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000500*/ v_add_u32       v4, vcc, 0, v4
/*000000000504*/ v_mul_lo_u32    v4, s2, v4
/*00000000050c*/ v_mul_lo_u32    v5, s3, v3
/*000000000514*/ v_add_u32       v4, vcc, v4, v5
/*000000000518*/ v_mul_hi_u32    v5, s2, v3
/*000000000520*/ v_add_u32       v4, vcc, v4, v5
/*000000000524*/ v_mul_lo_u32    v5, s2, v3
/*00000000052c*/ v_sub_u32       v5, s[0:1], s2, v5
/*000000000534*/ v_subb_u32      v6, vcc, 0, v4, s[0:1]
/*00000000053c*/ v_cmp_ge_u32    s[6:7], v5, s2
/*000000000544*/ v_cmp_ge_u32    s[12:13], v6, s3
/*00000000054c*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000550*/ v_cndmask_b32   v6, 0, -1, s[12:13]
/*000000000558*/ v_cndmask_b32   v7, 0, -1, s[6:7]
/*000000000560*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000564*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000568*/ s_cbranch_vccz  .L1484_10
/*00000000056c*/ v_sub_u32       v4, vcc, 0, v4
/*000000000570*/ v_sub_u32       v5, s[6:7], v5, s2
/*000000000578*/ v_mov_b32       v6, s3
/*00000000057c*/ v_subb_u32      v4, vcc, v4, v6, s[0:1]
/*000000000584*/ v_subb_u32      v4, vcc, v4, 0, s[6:7]
/*00000000058c*/ v_add_u32       v3, s[0:1], v3, 1
/*000000000594*/ v_cmp_ge_u32    s[0:1], v5, s2
/*00000000059c*/ v_cmp_ge_u32    s[6:7], v4, s3
/*0000000005a4*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005a8*/ v_cndmask_b32   v4, 0, -1, s[6:7]
/*0000000005b0*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000005b8*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005bc*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005c0*/ s_cbranch_vccz  .L1484_10
/*0000000005c4*/ v_add_u32       v3, s[0:1], v3, 1
.L1484_10:
/*0000000005cc*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005d4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005d8*/ s_branch        .L1504_10
.L1500_10:
/*0000000005dc*/ v_mov_b32       v3, s2
.L1504_10:
/*0000000005e0*/ s_lshl_b32      s0, s8, 1
/*0000000005e4*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*0000000005ec*/ flat_store_dword v[0:1], v3
/*0000000005f4*/ s_waitcnt       lgkmcnt(0)
/*0000000005f8*/ s_add_u32       s0, s0, s2
/*0000000005fc*/ v_add_u32       v0, vcc, s0, v2
/*000000000600*/ v_mov_b32       v1, 0
/*000000000604*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000060c*/ v_add_u32       v0, vcc, s10, v0
/*000000000610*/ v_mov_b32       v2, s11
/*000000000614*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000618*/ s_cmp_eq_u64    1, s[2:3]
/*00000000061c*/ s_cbranch_scc1  .L2256_10
/*000000000620*/ v_cvt_f32_u32   v2, s2
/*000000000624*/ v_cvt_f32_u32   v3, s3
/*000000000628*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000630*/ v_rcp_f32       v2, v2
/*000000000634*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*00000000063c*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*000000000644*/ v_trunc_f32     v3, v3
/*000000000648*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000650*/ v_cvt_u32_f32   v2, v2
/*000000000654*/ v_cvt_u32_f32   v3, v3
/*000000000658*/ v_sub_u32       v4, vcc, 0, s2
/*000000000660*/ v_mov_b32       v5, s3
/*000000000664*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000668*/ v_mul_lo_u32    v6, v4, v3
/*000000000670*/ v_mul_lo_u32    v7, v5, v2
/*000000000678*/ v_add_u32       v6, vcc, v6, v7
/*00000000067c*/ v_mul_hi_u32    v7, v4, v2
/*000000000684*/ v_add_u32       v6, vcc, v6, v7
/*000000000688*/ v_mul_lo_u32    v7, v4, v2
/*000000000690*/ v_mul_hi_u32    v8, v2, v7
/*000000000698*/ v_mul_lo_u32    v9, v3, v7
/*0000000006a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000006a4*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006ac*/ v_mul_lo_u32    v10, v2, v6
/*0000000006b4*/ v_add_u32       v8, vcc, v8, v10
/*0000000006b8*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006c0*/ v_mul_hi_u32    v7, v3, v7
/*0000000006c8*/ v_add_u32       v7, vcc, v8, v7
/*0000000006cc*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006d4*/ v_mul_hi_u32    v9, v2, v6
/*0000000006dc*/ v_add_u32       v7, vcc, v7, v9
/*0000000006e0*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000006e8*/ v_mul_lo_u32    v9, v3, v6
/*0000000006f0*/ v_add_u32       v7, vcc, v7, v9
/*0000000006f4*/ v_mul_hi_u32    v6, v3, v6
/*0000000006fc*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000700*/ v_add_u32       v2, s[0:1], v2, v7
/*000000000708*/ v_add_u32       v7, vcc, v3, v6
/*00000000070c*/ v_addc_u32      v3, vcc, v3, v6, s[0:1]
/*000000000714*/ v_mul_lo_u32    v6, v4, v3
/*00000000071c*/ v_mul_lo_u32    v5, v5, v2
/*000000000724*/ v_add_u32       v5, vcc, v6, v5
/*000000000728*/ v_mul_hi_u32    v6, v4, v2
/*000000000730*/ v_add_u32       v5, vcc, v5, v6
/*000000000734*/ v_mul_lo_u32    v4, v4, v2
/*00000000073c*/ v_mul_hi_u32    v6, v2, v4
/*000000000744*/ v_mul_lo_u32    v8, v3, v4
/*00000000074c*/ v_add_u32       v6, vcc, v6, v8
/*000000000750*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000758*/ v_mul_lo_u32    v9, v2, v5
/*000000000760*/ v_add_u32       v6, vcc, v6, v9
/*000000000764*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*00000000076c*/ v_mul_hi_u32    v4, v3, v4
/*000000000774*/ v_add_u32       v4, vcc, v6, v4
/*000000000778*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000780*/ v_mul_hi_u32    v8, v2, v5
/*000000000788*/ v_add_u32       v4, vcc, v4, v8
/*00000000078c*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*000000000794*/ v_mul_lo_u32    v8, v3, v5
/*00000000079c*/ v_add_u32       v4, vcc, v4, v8
/*0000000007a0*/ v_mul_hi_u32    v3, v3, v5
/*0000000007a8*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007ac*/ v_add_u32       v2, s[4:5], v2, v4
/*0000000007b4*/ v_addc_u32      v3, vcc, v7, v3, s[0:1]
/*0000000007bc*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*0000000007c4*/ v_mul_hi_u32    v2, s2, v2
/*0000000007cc*/ v_mul_lo_u32    v4, s2, v3
/*0000000007d4*/ v_add_u32       v2, vcc, v2, v4
/*0000000007d8*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*0000000007e0*/ v_mul_hi_u32    v3, s2, v3
/*0000000007e8*/ v_add_u32       v2, vcc, v2, v3
/*0000000007ec*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000007f4*/ v_add_u32       v3, vcc, 0, v3
/*0000000007f8*/ v_mul_lo_u32    v3, s2, v3
/*000000000800*/ v_mul_lo_u32    v4, s3, v2
/*000000000808*/ v_add_u32       v3, vcc, v3, v4
/*00000000080c*/ v_mul_hi_u32    v4, s2, v2
/*000000000814*/ v_add_u32       v3, vcc, v3, v4
/*000000000818*/ v_mul_lo_u32    v4, s2, v2
/*000000000820*/ v_sub_u32       v4, s[0:1], s2, v4
/*000000000828*/ v_subb_u32      v5, vcc, 0, v3, s[0:1]
/*000000000830*/ v_cmp_ge_u32    s[4:5], v4, s2
/*000000000838*/ v_cmp_ge_u32    s[6:7], v5, s3
/*000000000840*/ v_cmp_eq_i32    vcc, s3, v5
/*000000000844*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*00000000084c*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*000000000854*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000858*/ v_cmp_lg_u32    vcc, 0, v5
/*00000000085c*/ s_cbranch_vccz  .L2240_10
/*000000000860*/ v_sub_u32       v3, vcc, 0, v3
/*000000000864*/ v_sub_u32       v4, s[4:5], v4, s2
/*00000000086c*/ v_mov_b32       v5, s3
/*000000000870*/ v_subb_u32      v3, vcc, v3, v5, s[0:1]
/*000000000878*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*000000000880*/ v_add_u32       v2, s[0:1], v2, 1
/*000000000888*/ v_cmp_ge_u32    s[0:1], v4, s2
/*000000000890*/ v_cmp_ge_u32    s[4:5], v3, s3
/*000000000898*/ v_cmp_eq_i32    vcc, s3, v3
/*00000000089c*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008a4*/ v_cndmask_b32   v4, 0, -1, s[0:1]
/*0000000008ac*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008b0*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008b4*/ s_cbranch_vccz  .L2240_10
/*0000000008b8*/ v_add_u32       v2, s[0:1], v2, 1
.L2240_10:
/*0000000008c0*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000008c8*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008cc*/ s_branch        .L2260_10
.L2256_10:
/*0000000008d0*/ v_mov_b32       v2, s2
.L2260_10:
/*0000000008d4*/ flat_store_dword v[0:1], v2
/*0000000008dc*/ s_endpgm
.kernel div_get_local_id_get_global_offset
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 28
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 3
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s6, s6, s0
/*00000000001c*/ v_add_u32       v3, vcc, s6, v0
/*000000000020*/ v_mov_b32       v4, 0
/*000000000024*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000002c*/ v_add_u32       v3, s[12:13], s10, v3
/*000000000034*/ v_cmp_lg_i64    vcc, 1, s[0:1]
/*00000000003c*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000040*/ v_cvt_f32_u32   v5, s0
/*000000000044*/ s_cbranch_execz .L760_11
/*000000000048*/ v_cvt_f32_u32   v6, s1
/*00000000004c*/ v_madmk_f32     v5, v6, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000054*/ v_rcp_f32       v5, v5
/*000000000058*/ v_mul_f32       v5, 0x5f7ffffc /* 1.844674e+19f */, v5
/*000000000060*/ v_mul_f32       v6, 0x2f800000 /* 2.32830644e-10f */, v5
/*000000000068*/ v_trunc_f32     v6, v6
/*00000000006c*/ v_madmk_f32     v5, v6, 0xcf800000 /* -4.2949673e+9f */, v5
/*000000000074*/ v_cvt_u32_f32   v5, v5
/*000000000078*/ v_cvt_u32_f32   v6, v6
/*00000000007c*/ v_sub_u32       v7, vcc, 0, s0
/*000000000084*/ v_mov_b32       v8, s1
/*000000000088*/ v_subb_u32      v8, vcc, 0, v8, vcc
/*00000000008c*/ v_mul_lo_u32    v9, v7, v6
/*000000000094*/ v_mul_lo_u32    v10, v8, v5
/*00000000009c*/ v_add_u32       v9, vcc, v9, v10
/*0000000000a0*/ v_mul_hi_u32    v10, v7, v5
/*0000000000a8*/ v_add_u32       v9, vcc, v9, v10
/*0000000000ac*/ v_mul_lo_u32    v10, v7, v5
/*0000000000b4*/ v_mul_hi_u32    v11, v5, v10
/*0000000000bc*/ v_mul_lo_u32    v12, v6, v10
/*0000000000c4*/ v_add_u32       v11, vcc, v11, v12
/*0000000000c8*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000000d0*/ v_mul_lo_u32    v13, v5, v9
/*0000000000d8*/ v_add_u32       v11, vcc, v11, v13
/*0000000000dc*/ v_addc_u32      v11, vcc, v12, 0, vcc
/*0000000000e4*/ v_mul_hi_u32    v10, v6, v10
/*0000000000ec*/ v_add_u32       v10, vcc, v11, v10
/*0000000000f0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000f8*/ v_mul_hi_u32    v12, v5, v9
/*000000000100*/ v_add_u32       v10, vcc, v10, v12
/*000000000104*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*00000000010c*/ v_mul_lo_u32    v12, v6, v9
/*000000000114*/ v_add_u32       v10, vcc, v10, v12
/*000000000118*/ v_mul_hi_u32    v9, v6, v9
/*000000000120*/ v_addc_u32      v9, vcc, v11, v9, vcc
/*000000000124*/ v_add_u32       v5, s[16:17], v5, v10
/*00000000012c*/ v_add_u32       v10, vcc, v6, v9
/*000000000130*/ v_addc_u32      v6, vcc, v6, v9, s[16:17]
/*000000000138*/ v_mul_lo_u32    v9, v7, v6
/*000000000140*/ v_mul_lo_u32    v8, v8, v5
/*000000000148*/ v_add_u32       v8, vcc, v9, v8
/*00000000014c*/ v_mul_hi_u32    v9, v7, v5
/*000000000154*/ v_add_u32       v8, vcc, v8, v9
/*000000000158*/ v_mul_lo_u32    v7, v7, v5
/*000000000160*/ v_mul_hi_u32    v9, v5, v7
/*000000000168*/ v_mul_lo_u32    v11, v6, v7
/*000000000170*/ v_add_u32       v9, vcc, v9, v11
/*000000000174*/ v_cndmask_b32   v11, 0, 1, vcc
/*00000000017c*/ v_mul_lo_u32    v12, v5, v8
/*000000000184*/ v_add_u32       v9, vcc, v9, v12
/*000000000188*/ v_addc_u32      v9, vcc, v11, 0, vcc
/*000000000190*/ v_mul_hi_u32    v7, v6, v7
/*000000000198*/ v_add_u32       v7, vcc, v9, v7
/*00000000019c*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000001a4*/ v_mul_hi_u32    v11, v5, v8
/*0000000001ac*/ v_add_u32       v7, vcc, v7, v11
/*0000000001b0*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000001b8*/ v_mul_lo_u32    v11, v6, v8
/*0000000001c0*/ v_add_u32       v7, vcc, v7, v11
/*0000000001c4*/ v_mul_hi_u32    v6, v6, v8
/*0000000001cc*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*0000000001d0*/ v_add_u32       v5, s[18:19], v5, v7
/*0000000001d8*/ v_addc_u32      v6, vcc, v10, v6, s[16:17]
/*0000000001e0*/ v_addc_u32      v6, vcc, v6, 0, s[18:19]
/*0000000001e8*/ v_mul_hi_u32    v5, v0, v5
/*0000000001f0*/ v_mul_lo_u32    v7, v0, v6
/*0000000001f8*/ v_add_u32       v5, vcc, v5, v7
/*0000000001fc*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000204*/ v_mul_hi_u32    v6, v0, v6
/*00000000020c*/ v_add_u32       v5, vcc, v5, v6
/*000000000210*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000218*/ v_add_u32       v6, vcc, 0, v6
/*00000000021c*/ v_mul_lo_u32    v6, s0, v6
/*000000000224*/ v_mul_lo_u32    v7, s1, v5
/*00000000022c*/ v_add_u32       v6, vcc, v6, v7
/*000000000230*/ v_mul_hi_u32    v7, s0, v5
/*000000000238*/ v_add_u32       v6, vcc, v6, v7
/*00000000023c*/ v_mul_lo_u32    v7, s0, v5
/*000000000244*/ v_sub_u32       v0, s[16:17], v0, v7
/*00000000024c*/ v_subb_u32      v7, vcc, 0, v6, s[16:17]
/*000000000254*/ v_cmp_ge_u32    s[18:19], v0, s0
/*00000000025c*/ v_cmp_ge_u32    s[20:21], v7, s1
/*000000000264*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000268*/ v_cndmask_b32   v7, 0, -1, s[20:21]
/*000000000270*/ v_cndmask_b32   v8, 0, -1, s[18:19]
/*000000000278*/ v_cndmask_b32   v7, v7, v8, vcc
/*00000000027c*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000280*/ s_and_saveexec_b64 s[18:19], vcc
/*000000000284*/ v_sub_u32       v6, vcc, 0, v6
/*000000000288*/ s_cbranch_execz .L744_11
/*00000000028c*/ v_sub_u32       v0, s[20:21], v0, s0
/*000000000294*/ v_mov_b32       v7, s1
/*000000000298*/ v_subb_u32      v6, vcc, v6, v7, s[16:17]
/*0000000002a0*/ v_subb_u32      v6, vcc, v6, 0, s[20:21]
/*0000000002a8*/ v_add_u32       v5, s[16:17], v5, 1
/*0000000002b0*/ v_cmp_ge_u32    s[16:17], v0, s0
/*0000000002b8*/ v_cmp_ge_u32    s[20:21], v6, s1
/*0000000002c0*/ v_cmp_eq_i32    vcc, s1, v6
/*0000000002c4*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*0000000002cc*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*0000000002d4*/ v_cndmask_b32   v0, v0, v6, vcc
/*0000000002d8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002dc*/ v_add_u32       v0, s[16:17], v5, 1
/*0000000002e4*/ v_cndmask_b32   v5, v5, v0, vcc
.L744_11:
/*0000000002e8*/ s_mov_b64       exec, s[18:19]
/*0000000002ec*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002f4*/ v_cndmask_b32   v0, -1, v5, vcc
.L760_11:
/*0000000002f8*/ s_mov_b64       exec, s[14:15]
/*0000000002fc*/ s_lshl_b32      s0, s7, 2
/*000000000300*/ s_add_u32       s0, s0, s2
/*000000000304*/ v_add_u32       v5, vcc, s0, v1
/*000000000308*/ v_mov_b32       v6, s11
/*00000000030c*/ v_addc_u32      v4, vcc, v6, v4, s[12:13]
/*000000000314*/ flat_store_dword v[3:4], v0
/*00000000031c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000324*/ v_mov_b32       v6, 0
/*000000000328*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000330*/ v_add_u32       v0, s[4:5], s10, v3
/*000000000338*/ v_cmp_lg_i64    vcc, 1, s[2:3]
/*000000000340*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000344*/ v_cvt_f32_u32   v3, s2
/*000000000348*/ s_cbranch_execz .L1532_11
/*00000000034c*/ v_cvt_f32_u32   v5, s3
/*000000000350*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000358*/ v_rcp_f32       v3, v3
/*00000000035c*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000364*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*00000000036c*/ v_trunc_f32     v5, v5
/*000000000370*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000378*/ v_cvt_u32_f32   v3, v3
/*00000000037c*/ v_cvt_u32_f32   v5, v5
/*000000000380*/ v_sub_u32       v6, vcc, 0, s2
/*000000000388*/ v_mov_b32       v7, s3
/*00000000038c*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000390*/ v_mul_lo_u32    v8, v6, v5
/*000000000398*/ v_mul_lo_u32    v9, v7, v3
/*0000000003a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000003a4*/ v_mul_hi_u32    v9, v6, v3
/*0000000003ac*/ v_add_u32       v8, vcc, v8, v9
/*0000000003b0*/ v_mul_lo_u32    v9, v6, v3
/*0000000003b8*/ v_mul_hi_u32    v10, v3, v9
/*0000000003c0*/ v_mul_lo_u32    v11, v5, v9
/*0000000003c8*/ v_add_u32       v10, vcc, v10, v11
/*0000000003cc*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000003d4*/ v_mul_lo_u32    v12, v3, v8
/*0000000003dc*/ v_add_u32       v10, vcc, v10, v12
/*0000000003e0*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000003e8*/ v_mul_hi_u32    v9, v5, v9
/*0000000003f0*/ v_add_u32       v9, vcc, v10, v9
/*0000000003f4*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003fc*/ v_mul_hi_u32    v11, v3, v8
/*000000000404*/ v_add_u32       v9, vcc, v9, v11
/*000000000408*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000410*/ v_mul_lo_u32    v11, v5, v8
/*000000000418*/ v_add_u32       v9, vcc, v9, v11
/*00000000041c*/ v_mul_hi_u32    v8, v5, v8
/*000000000424*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*000000000428*/ v_add_u32       v3, s[12:13], v3, v9
/*000000000430*/ v_add_u32       v9, vcc, v5, v8
/*000000000434*/ v_addc_u32      v5, vcc, v5, v8, s[12:13]
/*00000000043c*/ v_mul_lo_u32    v8, v6, v5
/*000000000444*/ v_mul_lo_u32    v7, v7, v3
/*00000000044c*/ v_add_u32       v7, vcc, v8, v7
/*000000000450*/ v_mul_hi_u32    v8, v6, v3
/*000000000458*/ v_add_u32       v7, vcc, v7, v8
/*00000000045c*/ v_mul_lo_u32    v6, v6, v3
/*000000000464*/ v_mul_hi_u32    v8, v3, v6
/*00000000046c*/ v_mul_lo_u32    v10, v5, v6
/*000000000474*/ v_add_u32       v8, vcc, v8, v10
/*000000000478*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000480*/ v_mul_lo_u32    v11, v3, v7
/*000000000488*/ v_add_u32       v8, vcc, v8, v11
/*00000000048c*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000494*/ v_mul_hi_u32    v6, v5, v6
/*00000000049c*/ v_add_u32       v6, vcc, v8, v6
/*0000000004a0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000004a8*/ v_mul_hi_u32    v10, v3, v7
/*0000000004b0*/ v_add_u32       v6, vcc, v6, v10
/*0000000004b4*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000004bc*/ v_mul_lo_u32    v10, v5, v7
/*0000000004c4*/ v_add_u32       v6, vcc, v6, v10
/*0000000004c8*/ v_mul_hi_u32    v5, v5, v7
/*0000000004d0*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000004d4*/ v_add_u32       v3, s[14:15], v3, v6
/*0000000004dc*/ v_addc_u32      v5, vcc, v9, v5, s[12:13]
/*0000000004e4*/ v_addc_u32      v5, vcc, v5, 0, s[14:15]
/*0000000004ec*/ v_mul_hi_u32    v3, v1, v3
/*0000000004f4*/ v_mul_lo_u32    v6, v1, v5
/*0000000004fc*/ v_add_u32       v3, vcc, v3, v6
/*000000000500*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000508*/ v_mul_hi_u32    v5, v1, v5
/*000000000510*/ v_add_u32       v3, vcc, v3, v5
/*000000000514*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*00000000051c*/ v_add_u32       v5, vcc, 0, v5
/*000000000520*/ v_mul_lo_u32    v5, s2, v5
/*000000000528*/ v_mul_lo_u32    v6, s3, v3
/*000000000530*/ v_add_u32       v5, vcc, v5, v6
/*000000000534*/ v_mul_hi_u32    v6, s2, v3
/*00000000053c*/ v_add_u32       v5, vcc, v5, v6
/*000000000540*/ v_mul_lo_u32    v6, s2, v3
/*000000000548*/ v_sub_u32       v1, s[12:13], v1, v6
/*000000000550*/ v_subb_u32      v6, vcc, 0, v5, s[12:13]
/*000000000558*/ v_cmp_ge_u32    s[14:15], v1, s2
/*000000000560*/ v_cmp_ge_u32    s[16:17], v6, s3
/*000000000568*/ v_cmp_eq_i32    vcc, s3, v6
/*00000000056c*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*000000000574*/ v_cndmask_b32   v7, 0, -1, s[14:15]
/*00000000057c*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000580*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000584*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000588*/ v_sub_u32       v5, vcc, 0, v5
/*00000000058c*/ s_cbranch_execz .L1516_11
/*000000000590*/ v_sub_u32       v1, s[16:17], v1, s2
/*000000000598*/ v_mov_b32       v6, s3
/*00000000059c*/ v_subb_u32      v5, vcc, v5, v6, s[12:13]
/*0000000005a4*/ v_subb_u32      v5, vcc, v5, 0, s[16:17]
/*0000000005ac*/ v_add_u32       v3, s[12:13], v3, 1
/*0000000005b4*/ v_cmp_ge_u32    s[12:13], v1, s2
/*0000000005bc*/ v_cmp_ge_u32    s[16:17], v5, s3
/*0000000005c4*/ v_cmp_eq_i32    vcc, s3, v5
/*0000000005c8*/ v_cndmask_b32   v1, 0, -1, s[16:17]
/*0000000005d0*/ v_cndmask_b32   v5, 0, -1, s[12:13]
/*0000000005d8*/ v_cndmask_b32   v1, v1, v5, vcc
/*0000000005dc*/ v_cmp_lg_u32    vcc, 0, v1
/*0000000005e0*/ v_add_u32       v1, s[12:13], v3, 1
/*0000000005e8*/ v_cndmask_b32   v3, v3, v1, vcc
.L1516_11:
/*0000000005ec*/ s_mov_b64       exec, s[14:15]
/*0000000005f0*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005f8*/ v_cndmask_b32   v3, -1, v3, vcc
.L1532_11:
/*0000000005fc*/ s_andn2_b64     exec, s[6:7], exec
/*000000000600*/ v_mov_b32       v3, v1
/*000000000604*/ s_mov_b64       exec, s[6:7]
/*000000000608*/ s_lshl_b32      s2, s8, 1
/*00000000060c*/ s_waitcnt       lgkmcnt(0)
/*000000000610*/ s_add_u32       s2, s2, s0
/*000000000614*/ v_add_u32       v7, vcc, s2, v2
/*000000000618*/ v_mov_b32       v6, s11
/*00000000061c*/ v_addc_u32      v1, vcc, v6, v4, s[4:5]
/*000000000624*/ flat_store_dword v[0:1], v3
/*00000000062c*/ v_mov_b32       v8, 0
/*000000000630*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*000000000638*/ v_add_u32       v0, vcc, s10, v0
/*00000000063c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000640*/ v_cmp_lg_i64    vcc, 1, s[0:1]
/*000000000648*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000064c*/ v_cvt_f32_u32   v3, s0
/*000000000650*/ s_cbranch_execz .L2308_11
/*000000000654*/ v_cvt_f32_u32   v4, s1
/*000000000658*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000660*/ v_rcp_f32       v3, v3
/*000000000664*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*00000000066c*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000674*/ v_trunc_f32     v4, v4
/*000000000678*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000680*/ v_cvt_u32_f32   v3, v3
/*000000000684*/ v_cvt_u32_f32   v4, v4
/*000000000688*/ v_sub_u32       v5, vcc, 0, s0
/*000000000690*/ v_mov_b32       v6, s1
/*000000000694*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000698*/ v_mul_lo_u32    v7, v5, v4
/*0000000006a0*/ v_mul_lo_u32    v8, v6, v3
/*0000000006a8*/ v_add_u32       v7, vcc, v7, v8
/*0000000006ac*/ v_mul_hi_u32    v8, v5, v3
/*0000000006b4*/ v_add_u32       v7, vcc, v7, v8
/*0000000006b8*/ v_mul_lo_u32    v8, v5, v3
/*0000000006c0*/ v_mul_hi_u32    v9, v3, v8
/*0000000006c8*/ v_mul_lo_u32    v10, v4, v8
/*0000000006d0*/ v_add_u32       v9, vcc, v9, v10
/*0000000006d4*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000006dc*/ v_mul_lo_u32    v11, v3, v7
/*0000000006e4*/ v_add_u32       v9, vcc, v9, v11
/*0000000006e8*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000006f0*/ v_mul_hi_u32    v8, v4, v8
/*0000000006f8*/ v_add_u32       v8, vcc, v9, v8
/*0000000006fc*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000704*/ v_mul_hi_u32    v10, v3, v7
/*00000000070c*/ v_add_u32       v8, vcc, v8, v10
/*000000000710*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000718*/ v_mul_lo_u32    v10, v4, v7
/*000000000720*/ v_add_u32       v8, vcc, v8, v10
/*000000000724*/ v_mul_hi_u32    v7, v4, v7
/*00000000072c*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*000000000730*/ v_add_u32       v3, s[4:5], v3, v8
/*000000000738*/ v_add_u32       v8, vcc, v4, v7
/*00000000073c*/ v_addc_u32      v4, vcc, v4, v7, s[4:5]
/*000000000744*/ v_mul_lo_u32    v7, v5, v4
/*00000000074c*/ v_mul_lo_u32    v6, v6, v3
/*000000000754*/ v_add_u32       v6, vcc, v7, v6
/*000000000758*/ v_mul_hi_u32    v7, v5, v3
/*000000000760*/ v_add_u32       v6, vcc, v6, v7
/*000000000764*/ v_mul_lo_u32    v5, v5, v3
/*00000000076c*/ v_mul_hi_u32    v7, v3, v5
/*000000000774*/ v_mul_lo_u32    v9, v4, v5
/*00000000077c*/ v_add_u32       v7, vcc, v7, v9
/*000000000780*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000788*/ v_mul_lo_u32    v10, v3, v6
/*000000000790*/ v_add_u32       v7, vcc, v7, v10
/*000000000794*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*00000000079c*/ v_mul_hi_u32    v5, v4, v5
/*0000000007a4*/ v_add_u32       v5, vcc, v7, v5
/*0000000007a8*/ v_cndmask_b32   v7, 0, 1, vcc
/*0000000007b0*/ v_mul_hi_u32    v9, v3, v6
/*0000000007b8*/ v_add_u32       v5, vcc, v5, v9
/*0000000007bc*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000007c4*/ v_mul_lo_u32    v9, v4, v6
/*0000000007cc*/ v_add_u32       v5, vcc, v5, v9
/*0000000007d0*/ v_mul_hi_u32    v4, v4, v6
/*0000000007d8*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000007dc*/ v_add_u32       v3, s[6:7], v3, v5
/*0000000007e4*/ v_addc_u32      v4, vcc, v8, v4, s[4:5]
/*0000000007ec*/ v_addc_u32      v4, vcc, v4, 0, s[6:7]
/*0000000007f4*/ v_mul_hi_u32    v3, v2, v3
/*0000000007fc*/ v_mul_lo_u32    v5, v2, v4
/*000000000804*/ v_add_u32       v3, vcc, v3, v5
/*000000000808*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000810*/ v_mul_hi_u32    v4, v2, v4
/*000000000818*/ v_add_u32       v3, vcc, v3, v4
/*00000000081c*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000824*/ v_add_u32       v4, vcc, 0, v4
/*000000000828*/ v_mul_lo_u32    v4, s0, v4
/*000000000830*/ v_mul_lo_u32    v5, s1, v3
/*000000000838*/ v_add_u32       v4, vcc, v4, v5
/*00000000083c*/ v_mul_hi_u32    v5, s0, v3
/*000000000844*/ v_add_u32       v4, vcc, v4, v5
/*000000000848*/ v_mul_lo_u32    v5, s0, v3
/*000000000850*/ v_sub_u32       v2, s[4:5], v2, v5
/*000000000858*/ v_subb_u32      v5, vcc, 0, v4, s[4:5]
/*000000000860*/ v_cmp_ge_u32    s[6:7], v2, s0
/*000000000868*/ v_cmp_ge_u32    s[8:9], v5, s1
/*000000000870*/ v_cmp_eq_i32    vcc, s1, v5
/*000000000874*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*00000000087c*/ v_cndmask_b32   v6, 0, -1, s[6:7]
/*000000000884*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000888*/ v_cmp_lg_u32    vcc, 0, v5
/*00000000088c*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000890*/ v_sub_u32       v4, vcc, 0, v4
/*000000000894*/ s_cbranch_execz .L2292_11
/*000000000898*/ v_sub_u32       v2, s[8:9], v2, s0
/*0000000008a0*/ v_mov_b32       v5, s1
/*0000000008a4*/ v_subb_u32      v4, vcc, v4, v5, s[4:5]
/*0000000008ac*/ v_subb_u32      v4, vcc, v4, 0, s[8:9]
/*0000000008b4*/ v_add_u32       v3, s[4:5], v3, 1
/*0000000008bc*/ v_cmp_ge_u32    s[4:5], v2, s0
/*0000000008c4*/ v_cmp_ge_u32    s[8:9], v4, s1
/*0000000008cc*/ v_cmp_eq_i32    vcc, s1, v4
/*0000000008d0*/ v_cndmask_b32   v2, 0, -1, s[8:9]
/*0000000008d8*/ v_cndmask_b32   v4, 0, -1, s[4:5]
/*0000000008e0*/ v_cndmask_b32   v2, v2, v4, vcc
/*0000000008e4*/ v_cmp_lg_u32    vcc, 0, v2
/*0000000008e8*/ v_add_u32       v2, s[4:5], v3, 1
/*0000000008f0*/ v_cndmask_b32   v3, v3, v2, vcc
.L2292_11:
/*0000000008f4*/ s_mov_b64       exec, s[6:7]
/*0000000008f8*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*000000000900*/ v_cndmask_b32   v2, -1, v3, vcc
.L2308_11:
/*000000000904*/ s_mov_b64       exec, s[2:3]
/*000000000908*/ flat_store_dword v[0:1], v2
/*000000000910*/ s_endpgm
.kernel div_get_group_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 25
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s9, s6, 1
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s9, s9, s0
/*00000000001c*/ v_add_u32       v3, vcc, s9, v0
/*000000000020*/ v_mov_b32       v4, 0
/*000000000024*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000002c*/ v_add_u32       v0, s[12:13], s10, v3
/*000000000034*/ s_cmp_eq_u64    1, s[0:1]
/*000000000038*/ s_cbranch_scc1  .L748_12
/*00000000003c*/ v_cvt_f32_u32   v3, s0
/*000000000040*/ v_cvt_f32_u32   v5, s1
/*000000000044*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000058*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000060*/ v_trunc_f32     v5, v5
/*000000000064*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000006c*/ v_cvt_u32_f32   v3, v3
/*000000000070*/ v_cvt_u32_f32   v5, v5
/*000000000074*/ v_sub_u32       v6, vcc, 0, s0
/*00000000007c*/ v_mov_b32       v7, s1
/*000000000080*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000084*/ v_mul_lo_u32    v8, v6, v5
/*00000000008c*/ v_mul_lo_u32    v9, v7, v3
/*000000000094*/ v_add_u32       v8, vcc, v8, v9
/*000000000098*/ v_mul_hi_u32    v9, v6, v3
/*0000000000a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a4*/ v_mul_lo_u32    v9, v6, v3
/*0000000000ac*/ v_mul_hi_u32    v10, v3, v9
/*0000000000b4*/ v_mul_lo_u32    v11, v5, v9
/*0000000000bc*/ v_add_u32       v10, vcc, v10, v11
/*0000000000c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000c8*/ v_mul_lo_u32    v12, v3, v8
/*0000000000d0*/ v_add_u32       v10, vcc, v10, v12
/*0000000000d4*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000dc*/ v_mul_hi_u32    v9, v5, v9
/*0000000000e4*/ v_add_u32       v9, vcc, v10, v9
/*0000000000e8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000000f0*/ v_mul_hi_u32    v11, v3, v8
/*0000000000f8*/ v_add_u32       v9, vcc, v9, v11
/*0000000000fc*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000104*/ v_mul_lo_u32    v11, v5, v8
/*00000000010c*/ v_add_u32       v9, vcc, v9, v11
/*000000000110*/ v_mul_hi_u32    v8, v5, v8
/*000000000118*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*00000000011c*/ v_add_u32       v3, s[14:15], v3, v9
/*000000000124*/ v_add_u32       v9, vcc, v5, v8
/*000000000128*/ v_addc_u32      v5, vcc, v5, v8, s[14:15]
/*000000000130*/ v_mul_lo_u32    v8, v6, v5
/*000000000138*/ v_mul_lo_u32    v7, v7, v3
/*000000000140*/ v_add_u32       v7, vcc, v8, v7
/*000000000144*/ v_mul_hi_u32    v8, v6, v3
/*00000000014c*/ v_add_u32       v7, vcc, v7, v8
/*000000000150*/ v_mul_lo_u32    v6, v6, v3
/*000000000158*/ v_mul_hi_u32    v8, v3, v6
/*000000000160*/ v_mul_lo_u32    v10, v5, v6
/*000000000168*/ v_add_u32       v8, vcc, v8, v10
/*00000000016c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000174*/ v_mul_lo_u32    v11, v3, v7
/*00000000017c*/ v_add_u32       v8, vcc, v8, v11
/*000000000180*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000188*/ v_mul_hi_u32    v6, v5, v6
/*000000000190*/ v_add_u32       v6, vcc, v8, v6
/*000000000194*/ v_cndmask_b32   v8, 0, 1, vcc
/*00000000019c*/ v_mul_hi_u32    v10, v3, v7
/*0000000001a4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001a8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001b0*/ v_mul_lo_u32    v10, v5, v7
/*0000000001b8*/ v_add_u32       v6, vcc, v6, v10
/*0000000001bc*/ v_mul_hi_u32    v5, v5, v7
/*0000000001c4*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001c8*/ v_add_u32       v3, s[16:17], v3, v6
/*0000000001d0*/ v_addc_u32      v5, vcc, v9, v5, s[14:15]
/*0000000001d8*/ v_addc_u32      v5, vcc, v5, 0, s[16:17]
/*0000000001e0*/ v_mul_hi_u32    v3, s6, v3
/*0000000001e8*/ v_mul_lo_u32    v6, s6, v5
/*0000000001f0*/ v_add_u32       v3, vcc, v3, v6
/*0000000001f4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000001fc*/ v_mul_hi_u32    v5, s6, v5
/*000000000204*/ v_add_u32       v3, vcc, v3, v5
/*000000000208*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000210*/ v_add_u32       v5, vcc, 0, v5
/*000000000214*/ v_mul_lo_u32    v5, s0, v5
/*00000000021c*/ v_mul_lo_u32    v6, s1, v3
/*000000000224*/ v_add_u32       v5, vcc, v5, v6
/*000000000228*/ v_mul_hi_u32    v6, s0, v3
/*000000000230*/ v_add_u32       v5, vcc, v5, v6
/*000000000234*/ v_mul_lo_u32    v6, s0, v3
/*00000000023c*/ v_sub_u32       v6, s[14:15], s6, v6
/*000000000244*/ v_subb_u32      v7, vcc, 0, v5, s[14:15]
/*00000000024c*/ v_cmp_ge_u32    s[16:17], v6, s0
/*000000000254*/ v_cmp_ge_u32    s[18:19], v7, s1
/*00000000025c*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000260*/ v_cndmask_b32   v7, 0, -1, s[18:19]
/*000000000268*/ v_cndmask_b32   v8, 0, -1, s[16:17]
/*000000000270*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000274*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000278*/ s_cbranch_vccz  .L732_12
/*00000000027c*/ v_sub_u32       v5, vcc, 0, v5
/*000000000280*/ v_sub_u32       v6, s[16:17], v6, s0
/*000000000288*/ v_mov_b32       v7, s1
/*00000000028c*/ v_subb_u32      v5, vcc, v5, v7, s[14:15]
/*000000000294*/ v_subb_u32      v5, vcc, v5, 0, s[16:17]
/*00000000029c*/ v_add_u32       v3, s[14:15], v3, 1
/*0000000002a4*/ v_cmp_ge_u32    s[14:15], v6, s0
/*0000000002ac*/ v_cmp_ge_u32    s[16:17], v5, s1
/*0000000002b4*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002b8*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*0000000002c0*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*0000000002c8*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002cc*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002d0*/ s_cbranch_vccz  .L732_12
/*0000000002d4*/ v_add_u32       v3, s[14:15], v3, 1
.L732_12:
/*0000000002dc*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002e4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000002e8*/ s_branch        .L752_12
.L748_12:
/*0000000002ec*/ v_mov_b32       v3, s6
.L752_12:
/*0000000002f0*/ s_lshl_b32      s0, s7, 4
/*0000000002f4*/ s_add_u32       s0, s0, s2
/*0000000002f8*/ v_add_u32       v5, vcc, s0, v1
/*0000000002fc*/ v_mov_b32       v1, s11
/*000000000300*/ v_addc_u32      v1, vcc, v1, v4, s[12:13]
/*000000000308*/ flat_store_dword v[0:1], v3
/*000000000310*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000318*/ v_mov_b32       v6, 0
/*00000000031c*/ v_lshlrev_b64   v[0:1], 2, v[5:6]
/*000000000324*/ v_add_u32       v0, s[4:5], s10, v0
/*00000000032c*/ s_cmp_eq_u64    1, s[2:3]
/*000000000330*/ s_cbranch_scc1  .L1508_12
/*000000000334*/ v_cvt_f32_u32   v3, s2
/*000000000338*/ v_cvt_f32_u32   v4, s3
/*00000000033c*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000344*/ v_rcp_f32       v3, v3
/*000000000348*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000350*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000358*/ v_trunc_f32     v4, v4
/*00000000035c*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000364*/ v_cvt_u32_f32   v3, v3
/*000000000368*/ v_cvt_u32_f32   v4, v4
/*00000000036c*/ v_sub_u32       v5, vcc, 0, s2
/*000000000374*/ v_mov_b32       v6, s3
/*000000000378*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*00000000037c*/ v_mul_lo_u32    v7, v5, v4
/*000000000384*/ v_mul_lo_u32    v8, v6, v3
/*00000000038c*/ v_add_u32       v7, vcc, v7, v8
/*000000000390*/ v_mul_hi_u32    v8, v5, v3
/*000000000398*/ v_add_u32       v7, vcc, v7, v8
/*00000000039c*/ v_mul_lo_u32    v8, v5, v3
/*0000000003a4*/ v_mul_hi_u32    v9, v3, v8
/*0000000003ac*/ v_mul_lo_u32    v10, v4, v8
/*0000000003b4*/ v_add_u32       v9, vcc, v9, v10
/*0000000003b8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003c0*/ v_mul_lo_u32    v11, v3, v7
/*0000000003c8*/ v_add_u32       v9, vcc, v9, v11
/*0000000003cc*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003d4*/ v_mul_hi_u32    v8, v4, v8
/*0000000003dc*/ v_add_u32       v8, vcc, v9, v8
/*0000000003e0*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000003e8*/ v_mul_hi_u32    v10, v3, v7
/*0000000003f0*/ v_add_u32       v8, vcc, v8, v10
/*0000000003f4*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000003fc*/ v_mul_lo_u32    v10, v4, v7
/*000000000404*/ v_add_u32       v8, vcc, v8, v10
/*000000000408*/ v_mul_hi_u32    v7, v4, v7
/*000000000410*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*000000000414*/ v_add_u32       v3, s[12:13], v3, v8
/*00000000041c*/ v_add_u32       v8, vcc, v4, v7
/*000000000420*/ v_addc_u32      v4, vcc, v4, v7, s[12:13]
/*000000000428*/ v_mul_lo_u32    v7, v5, v4
/*000000000430*/ v_mul_lo_u32    v6, v6, v3
/*000000000438*/ v_add_u32       v6, vcc, v7, v6
/*00000000043c*/ v_mul_hi_u32    v7, v5, v3
/*000000000444*/ v_add_u32       v6, vcc, v6, v7
/*000000000448*/ v_mul_lo_u32    v5, v5, v3
/*000000000450*/ v_mul_hi_u32    v7, v3, v5
/*000000000458*/ v_mul_lo_u32    v9, v4, v5
/*000000000460*/ v_add_u32       v7, vcc, v7, v9
/*000000000464*/ v_cndmask_b32   v9, 0, 1, vcc
/*00000000046c*/ v_mul_lo_u32    v10, v3, v6
/*000000000474*/ v_add_u32       v7, vcc, v7, v10
/*000000000478*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000480*/ v_mul_hi_u32    v5, v4, v5
/*000000000488*/ v_add_u32       v5, vcc, v7, v5
/*00000000048c*/ v_cndmask_b32   v7, 0, 1, vcc
/*000000000494*/ v_mul_hi_u32    v9, v3, v6
/*00000000049c*/ v_add_u32       v5, vcc, v5, v9
/*0000000004a0*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004a8*/ v_mul_lo_u32    v9, v4, v6
/*0000000004b0*/ v_add_u32       v5, vcc, v5, v9
/*0000000004b4*/ v_mul_hi_u32    v4, v4, v6
/*0000000004bc*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004c0*/ v_add_u32       v3, s[14:15], v3, v5
/*0000000004c8*/ v_addc_u32      v4, vcc, v8, v4, s[12:13]
/*0000000004d0*/ v_addc_u32      v4, vcc, v4, 0, s[14:15]
/*0000000004d8*/ v_mul_hi_u32    v3, s7, v3
/*0000000004e0*/ v_mul_lo_u32    v5, s7, v4
/*0000000004e8*/ v_add_u32       v3, vcc, v3, v5
/*0000000004ec*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000004f4*/ v_mul_hi_u32    v4, s7, v4
/*0000000004fc*/ v_add_u32       v3, vcc, v3, v4
/*000000000500*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000508*/ v_add_u32       v4, vcc, 0, v4
/*00000000050c*/ v_mul_lo_u32    v4, s2, v4
/*000000000514*/ v_mul_lo_u32    v5, s3, v3
/*00000000051c*/ v_add_u32       v4, vcc, v4, v5
/*000000000520*/ v_mul_hi_u32    v5, s2, v3
/*000000000528*/ v_add_u32       v4, vcc, v4, v5
/*00000000052c*/ v_mul_lo_u32    v5, s2, v3
/*000000000534*/ v_sub_u32       v5, s[12:13], s7, v5
/*00000000053c*/ v_subb_u32      v6, vcc, 0, v4, s[12:13]
/*000000000544*/ v_cmp_ge_u32    s[6:7], v5, s2
/*00000000054c*/ v_cmp_ge_u32    s[14:15], v6, s3
/*000000000554*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000558*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*000000000560*/ v_cndmask_b32   v7, 0, -1, s[6:7]
/*000000000568*/ v_cndmask_b32   v6, v6, v7, vcc
/*00000000056c*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000570*/ s_cbranch_vccz  .L1492_12
/*000000000574*/ v_sub_u32       v4, vcc, 0, v4
/*000000000578*/ v_sub_u32       v5, s[6:7], v5, s2
/*000000000580*/ v_mov_b32       v6, s3
/*000000000584*/ v_subb_u32      v4, vcc, v4, v6, s[12:13]
/*00000000058c*/ v_subb_u32      v4, vcc, v4, 0, s[6:7]
/*000000000594*/ v_add_u32       v3, s[6:7], v3, 1
/*00000000059c*/ v_cmp_ge_u32    s[6:7], v5, s2
/*0000000005a4*/ v_cmp_ge_u32    s[12:13], v4, s3
/*0000000005ac*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005b0*/ v_cndmask_b32   v4, 0, -1, s[12:13]
/*0000000005b8*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*0000000005c0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005c4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005c8*/ s_cbranch_vccz  .L1492_12
/*0000000005cc*/ v_add_u32       v3, s[6:7], v3, 1
.L1492_12:
/*0000000005d4*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005dc*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005e0*/ s_branch        .L1512_12
.L1508_12:
/*0000000005e4*/ v_mov_b32       v3, s7
.L1512_12:
/*0000000005e8*/ s_lshl_b32      s2, s8, 1
/*0000000005ec*/ s_waitcnt       lgkmcnt(0)
/*0000000005f0*/ s_add_u32       s2, s2, s0
/*0000000005f4*/ v_add_u32       v2, vcc, s2, v2
/*0000000005f8*/ v_mov_b32       v4, s11
/*0000000005fc*/ v_addc_u32      v1, vcc, v4, v1, s[4:5]
/*000000000604*/ flat_store_dword v[0:1], v3
/*00000000060c*/ v_mov_b32       v3, 0
/*000000000610*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*000000000618*/ v_add_u32       v0, vcc, s10, v0
/*00000000061c*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*000000000620*/ s_cmp_eq_u64    1, s[0:1]
/*000000000624*/ s_cbranch_scc1  .L2264_12
/*000000000628*/ v_cvt_f32_u32   v2, s0
/*00000000062c*/ v_cvt_f32_u32   v3, s1
/*000000000630*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000638*/ v_rcp_f32       v2, v2
/*00000000063c*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*000000000644*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*00000000064c*/ v_trunc_f32     v3, v3
/*000000000650*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000658*/ v_cvt_u32_f32   v2, v2
/*00000000065c*/ v_cvt_u32_f32   v3, v3
/*000000000660*/ v_sub_u32       v4, vcc, 0, s0
/*000000000668*/ v_mov_b32       v5, s1
/*00000000066c*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000670*/ v_mul_lo_u32    v6, v4, v3
/*000000000678*/ v_mul_lo_u32    v7, v5, v2
/*000000000680*/ v_add_u32       v6, vcc, v6, v7
/*000000000684*/ v_mul_hi_u32    v7, v4, v2
/*00000000068c*/ v_add_u32       v6, vcc, v6, v7
/*000000000690*/ v_mul_lo_u32    v7, v4, v2
/*000000000698*/ v_mul_hi_u32    v8, v2, v7
/*0000000006a0*/ v_mul_lo_u32    v9, v3, v7
/*0000000006a8*/ v_add_u32       v8, vcc, v8, v9
/*0000000006ac*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006b4*/ v_mul_lo_u32    v10, v2, v6
/*0000000006bc*/ v_add_u32       v8, vcc, v8, v10
/*0000000006c0*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006c8*/ v_mul_hi_u32    v7, v3, v7
/*0000000006d0*/ v_add_u32       v7, vcc, v8, v7
/*0000000006d4*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006dc*/ v_mul_hi_u32    v9, v2, v6
/*0000000006e4*/ v_add_u32       v7, vcc, v7, v9
/*0000000006e8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000006f0*/ v_mul_lo_u32    v9, v3, v6
/*0000000006f8*/ v_add_u32       v7, vcc, v7, v9
/*0000000006fc*/ v_mul_hi_u32    v6, v3, v6
/*000000000704*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000708*/ v_add_u32       v2, s[2:3], v2, v7
/*000000000710*/ v_add_u32       v7, vcc, v3, v6
/*000000000714*/ v_addc_u32      v3, vcc, v3, v6, s[2:3]
/*00000000071c*/ v_mul_lo_u32    v6, v4, v3
/*000000000724*/ v_mul_lo_u32    v5, v5, v2
/*00000000072c*/ v_add_u32       v5, vcc, v6, v5
/*000000000730*/ v_mul_hi_u32    v6, v4, v2
/*000000000738*/ v_add_u32       v5, vcc, v5, v6
/*00000000073c*/ v_mul_lo_u32    v4, v4, v2
/*000000000744*/ v_mul_hi_u32    v6, v2, v4
/*00000000074c*/ v_mul_lo_u32    v8, v3, v4
/*000000000754*/ v_add_u32       v6, vcc, v6, v8
/*000000000758*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000760*/ v_mul_lo_u32    v9, v2, v5
/*000000000768*/ v_add_u32       v6, vcc, v6, v9
/*00000000076c*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*000000000774*/ v_mul_hi_u32    v4, v3, v4
/*00000000077c*/ v_add_u32       v4, vcc, v6, v4
/*000000000780*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000788*/ v_mul_hi_u32    v8, v2, v5
/*000000000790*/ v_add_u32       v4, vcc, v4, v8
/*000000000794*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*00000000079c*/ v_mul_lo_u32    v8, v3, v5
/*0000000007a4*/ v_add_u32       v4, vcc, v4, v8
/*0000000007a8*/ v_mul_hi_u32    v3, v3, v5
/*0000000007b0*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007b4*/ v_add_u32       v2, s[4:5], v2, v4
/*0000000007bc*/ v_addc_u32      v3, vcc, v7, v3, s[2:3]
/*0000000007c4*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*0000000007cc*/ v_mul_hi_u32    v2, s8, v2
/*0000000007d4*/ v_mul_lo_u32    v4, s8, v3
/*0000000007dc*/ v_add_u32       v2, vcc, v2, v4
/*0000000007e0*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*0000000007e8*/ v_mul_hi_u32    v3, s8, v3
/*0000000007f0*/ v_add_u32       v2, vcc, v2, v3
/*0000000007f4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000007fc*/ v_add_u32       v3, vcc, 0, v3
/*000000000800*/ v_mul_lo_u32    v3, s0, v3
/*000000000808*/ v_mul_lo_u32    v4, s1, v2
/*000000000810*/ v_add_u32       v3, vcc, v3, v4
/*000000000814*/ v_mul_hi_u32    v4, s0, v2
/*00000000081c*/ v_add_u32       v3, vcc, v3, v4
/*000000000820*/ v_mul_lo_u32    v4, s0, v2
/*000000000828*/ v_sub_u32       v4, s[2:3], s8, v4
/*000000000830*/ v_subb_u32      v5, vcc, 0, v3, s[2:3]
/*000000000838*/ v_cmp_ge_u32    s[4:5], v4, s0
/*000000000840*/ v_cmp_ge_u32    s[6:7], v5, s1
/*000000000848*/ v_cmp_eq_i32    vcc, s1, v5
/*00000000084c*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*000000000854*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*00000000085c*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000860*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000864*/ s_cbranch_vccz  .L2248_12
/*000000000868*/ v_sub_u32       v3, vcc, 0, v3
/*00000000086c*/ v_sub_u32       v4, s[4:5], v4, s0
/*000000000874*/ v_mov_b32       v5, s1
/*000000000878*/ v_subb_u32      v3, vcc, v3, v5, s[2:3]
/*000000000880*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*000000000888*/ v_add_u32       v2, s[2:3], v2, 1
/*000000000890*/ v_cmp_ge_u32    s[2:3], v4, s0
/*000000000898*/ v_cmp_ge_u32    s[4:5], v3, s1
/*0000000008a0*/ v_cmp_eq_i32    vcc, s1, v3
/*0000000008a4*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008ac*/ v_cndmask_b32   v4, 0, -1, s[2:3]
/*0000000008b4*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008b8*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008bc*/ s_cbranch_vccz  .L2248_12
/*0000000008c0*/ v_add_u32       v2, s[2:3], v2, 1
.L2248_12:
/*0000000008c8*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000008d0*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008d4*/ s_branch        .L2268_12
.L2264_12:
/*0000000008d8*/ v_mov_b32       v2, s8
.L2268_12:
/*0000000008dc*/ flat_store_dword v[0:1], v2
/*0000000008e4*/ s_endpgm
.kernel div_get_local_size_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 1
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s6, s6, s0
/*00000000001c*/ v_add_u32       v3, vcc, s6, v0
/*000000000020*/ v_mov_b32       v4, 0
/*000000000024*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000002c*/ v_add_u32       v0, s[12:13], s10, v3
/*000000000034*/ s_cmp_eq_u64    1, s[0:1]
/*000000000038*/ s_cbranch_scc1  .L748_13
/*00000000003c*/ v_cvt_f32_u32   v3, s0
/*000000000040*/ v_cvt_f32_u32   v5, s1
/*000000000044*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000058*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000060*/ v_trunc_f32     v5, v5
/*000000000064*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000006c*/ v_cvt_u32_f32   v3, v3
/*000000000070*/ v_cvt_u32_f32   v5, v5
/*000000000074*/ v_sub_u32       v6, vcc, 0, s0
/*00000000007c*/ v_mov_b32       v7, s1
/*000000000080*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000084*/ v_mul_lo_u32    v8, v6, v5
/*00000000008c*/ v_mul_lo_u32    v9, v7, v3
/*000000000094*/ v_add_u32       v8, vcc, v8, v9
/*000000000098*/ v_mul_hi_u32    v9, v6, v3
/*0000000000a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a4*/ v_mul_lo_u32    v9, v6, v3
/*0000000000ac*/ v_mul_hi_u32    v10, v3, v9
/*0000000000b4*/ v_mul_lo_u32    v11, v5, v9
/*0000000000bc*/ v_add_u32       v10, vcc, v10, v11
/*0000000000c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000c8*/ v_mul_lo_u32    v12, v3, v8
/*0000000000d0*/ v_add_u32       v10, vcc, v10, v12
/*0000000000d4*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000dc*/ v_mul_hi_u32    v9, v5, v9
/*0000000000e4*/ v_add_u32       v9, vcc, v10, v9
/*0000000000e8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000000f0*/ v_mul_hi_u32    v11, v3, v8
/*0000000000f8*/ v_add_u32       v9, vcc, v9, v11
/*0000000000fc*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000104*/ v_mul_lo_u32    v11, v5, v8
/*00000000010c*/ v_add_u32       v9, vcc, v9, v11
/*000000000110*/ v_mul_hi_u32    v8, v5, v8
/*000000000118*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*00000000011c*/ v_add_u32       v3, s[14:15], v3, v9
/*000000000124*/ v_add_u32       v9, vcc, v5, v8
/*000000000128*/ v_addc_u32      v5, vcc, v5, v8, s[14:15]
/*000000000130*/ v_mul_lo_u32    v8, v6, v5
/*000000000138*/ v_mul_lo_u32    v7, v7, v3
/*000000000140*/ v_add_u32       v7, vcc, v8, v7
/*000000000144*/ v_mul_hi_u32    v8, v6, v3
/*00000000014c*/ v_add_u32       v7, vcc, v7, v8
/*000000000150*/ v_mul_lo_u32    v6, v6, v3
/*000000000158*/ v_mul_hi_u32    v8, v3, v6
/*000000000160*/ v_mul_lo_u32    v10, v5, v6
/*000000000168*/ v_add_u32       v8, vcc, v8, v10
/*00000000016c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000174*/ v_mul_lo_u32    v11, v3, v7
/*00000000017c*/ v_add_u32       v8, vcc, v8, v11
/*000000000180*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000188*/ v_mul_hi_u32    v6, v5, v6
/*000000000190*/ v_add_u32       v6, vcc, v8, v6
/*000000000194*/ v_cndmask_b32   v8, 0, 1, vcc
/*00000000019c*/ v_mul_hi_u32    v10, v3, v7
/*0000000001a4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001a8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001b0*/ v_mul_lo_u32    v10, v5, v7
/*0000000001b8*/ v_add_u32       v6, vcc, v6, v10
/*0000000001bc*/ v_mul_hi_u32    v5, v5, v7
/*0000000001c4*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001c8*/ v_add_u32       v3, s[16:17], v3, v6
/*0000000001d0*/ v_addc_u32      v5, vcc, v9, v5, s[14:15]
/*0000000001d8*/ v_addc_u32      v5, vcc, v5, 0, s[16:17]
/*0000000001e0*/ v_mul_hi_u32    v3, 2, v3
/*0000000001e8*/ v_mul_lo_u32    v6, 2, v5
/*0000000001f0*/ v_add_u32       v3, vcc, v3, v6
/*0000000001f4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000001fc*/ v_mul_hi_u32    v5, 2, v5
/*000000000204*/ v_add_u32       v3, vcc, v3, v5
/*000000000208*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000210*/ v_add_u32       v5, vcc, 0, v5
/*000000000214*/ v_mul_lo_u32    v5, s0, v5
/*00000000021c*/ v_mul_lo_u32    v6, s1, v3
/*000000000224*/ v_add_u32       v5, vcc, v5, v6
/*000000000228*/ v_mul_hi_u32    v6, s0, v3
/*000000000230*/ v_add_u32       v5, vcc, v5, v6
/*000000000234*/ v_mul_lo_u32    v6, s0, v3
/*00000000023c*/ v_sub_u32       v6, s[14:15], 2, v6
/*000000000244*/ v_subb_u32      v7, vcc, 0, v5, s[14:15]
/*00000000024c*/ v_cmp_ge_u32    s[16:17], v6, s0
/*000000000254*/ v_cmp_ge_u32    s[18:19], v7, s1
/*00000000025c*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000260*/ v_cndmask_b32   v7, 0, -1, s[18:19]
/*000000000268*/ v_cndmask_b32   v8, 0, -1, s[16:17]
/*000000000270*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000274*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000278*/ s_cbranch_vccz  .L732_13
/*00000000027c*/ v_sub_u32       v5, vcc, 0, v5
/*000000000280*/ v_sub_u32       v6, s[16:17], v6, s0
/*000000000288*/ v_mov_b32       v7, s1
/*00000000028c*/ v_subb_u32      v5, vcc, v5, v7, s[14:15]
/*000000000294*/ v_subb_u32      v5, vcc, v5, 0, s[16:17]
/*00000000029c*/ v_add_u32       v3, s[14:15], v3, 1
/*0000000002a4*/ v_cmp_ge_u32    s[14:15], v6, s0
/*0000000002ac*/ v_cmp_ge_u32    s[16:17], v5, s1
/*0000000002b4*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002b8*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*0000000002c0*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*0000000002c8*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002cc*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002d0*/ s_cbranch_vccz  .L732_13
/*0000000002d4*/ v_add_u32       v3, s[14:15], v3, 1
.L732_13:
/*0000000002dc*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002e4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000002e8*/ s_branch        .L752_13
.L748_13:
/*0000000002ec*/ v_mov_b32       v3, 2
.L752_13:
/*0000000002f0*/ s_lshl_b32      s0, s7, 1
/*0000000002f4*/ s_add_u32       s0, s0, s2
/*0000000002f8*/ v_add_u32       v7, vcc, s0, v1
/*0000000002fc*/ v_mov_b32       v6, s11
/*000000000300*/ v_addc_u32      v1, vcc, v6, v4, s[12:13]
/*000000000308*/ flat_store_dword v[0:1], v3
/*000000000310*/ v_mov_b32       v8, 0
/*000000000314*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000031c*/ v_add_u32       v0, vcc, s10, v0
/*000000000320*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000324*/ s_cmp_eq_u64    1, s[2:3]
/*000000000328*/ s_cbranch_scc1  .L1500_13
/*00000000032c*/ v_cvt_f32_u32   v3, s2
/*000000000330*/ v_cvt_f32_u32   v4, s3
/*000000000334*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000033c*/ v_rcp_f32       v3, v3
/*000000000340*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000348*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000350*/ v_trunc_f32     v4, v4
/*000000000354*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000035c*/ v_cvt_u32_f32   v3, v3
/*000000000360*/ v_cvt_u32_f32   v4, v4
/*000000000364*/ v_sub_u32       v5, vcc, 0, s2
/*00000000036c*/ v_mov_b32       v6, s3
/*000000000370*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000374*/ v_mul_lo_u32    v7, v5, v4
/*00000000037c*/ v_mul_lo_u32    v8, v6, v3
/*000000000384*/ v_add_u32       v7, vcc, v7, v8
/*000000000388*/ v_mul_hi_u32    v8, v5, v3
/*000000000390*/ v_add_u32       v7, vcc, v7, v8
/*000000000394*/ v_mul_lo_u32    v8, v5, v3
/*00000000039c*/ v_mul_hi_u32    v9, v3, v8
/*0000000003a4*/ v_mul_lo_u32    v10, v4, v8
/*0000000003ac*/ v_add_u32       v9, vcc, v9, v10
/*0000000003b0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003b8*/ v_mul_lo_u32    v11, v3, v7
/*0000000003c0*/ v_add_u32       v9, vcc, v9, v11
/*0000000003c4*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003cc*/ v_mul_hi_u32    v8, v4, v8
/*0000000003d4*/ v_add_u32       v8, vcc, v9, v8
/*0000000003d8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000003e0*/ v_mul_hi_u32    v10, v3, v7
/*0000000003e8*/ v_add_u32       v8, vcc, v8, v10
/*0000000003ec*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000003f4*/ v_mul_lo_u32    v10, v4, v7
/*0000000003fc*/ v_add_u32       v8, vcc, v8, v10
/*000000000400*/ v_mul_hi_u32    v7, v4, v7
/*000000000408*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*00000000040c*/ v_add_u32       v3, s[0:1], v3, v8
/*000000000414*/ v_add_u32       v8, vcc, v4, v7
/*000000000418*/ v_addc_u32      v4, vcc, v4, v7, s[0:1]
/*000000000420*/ v_mul_lo_u32    v7, v5, v4
/*000000000428*/ v_mul_lo_u32    v6, v6, v3
/*000000000430*/ v_add_u32       v6, vcc, v7, v6
/*000000000434*/ v_mul_hi_u32    v7, v5, v3
/*00000000043c*/ v_add_u32       v6, vcc, v6, v7
/*000000000440*/ v_mul_lo_u32    v5, v5, v3
/*000000000448*/ v_mul_hi_u32    v7, v3, v5
/*000000000450*/ v_mul_lo_u32    v9, v4, v5
/*000000000458*/ v_add_u32       v7, vcc, v7, v9
/*00000000045c*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000464*/ v_mul_lo_u32    v10, v3, v6
/*00000000046c*/ v_add_u32       v7, vcc, v7, v10
/*000000000470*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000478*/ v_mul_hi_u32    v5, v4, v5
/*000000000480*/ v_add_u32       v5, vcc, v7, v5
/*000000000484*/ v_cndmask_b32   v7, 0, 1, vcc
/*00000000048c*/ v_mul_hi_u32    v9, v3, v6
/*000000000494*/ v_add_u32       v5, vcc, v5, v9
/*000000000498*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004a0*/ v_mul_lo_u32    v9, v4, v6
/*0000000004a8*/ v_add_u32       v5, vcc, v5, v9
/*0000000004ac*/ v_mul_hi_u32    v4, v4, v6
/*0000000004b4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004b8*/ v_add_u32       v3, s[6:7], v3, v5
/*0000000004c0*/ v_addc_u32      v4, vcc, v8, v4, s[0:1]
/*0000000004c8*/ v_addc_u32      v4, vcc, v4, 0, s[6:7]
/*0000000004d0*/ v_mul_hi_u32    v3, 2, v3
/*0000000004d8*/ v_mul_lo_u32    v5, 2, v4
/*0000000004e0*/ v_add_u32       v3, vcc, v3, v5
/*0000000004e4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000004ec*/ v_mul_hi_u32    v4, 2, v4
/*0000000004f4*/ v_add_u32       v3, vcc, v3, v4
/*0000000004f8*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000500*/ v_add_u32       v4, vcc, 0, v4
/*000000000504*/ v_mul_lo_u32    v4, s2, v4
/*00000000050c*/ v_mul_lo_u32    v5, s3, v3
/*000000000514*/ v_add_u32       v4, vcc, v4, v5
/*000000000518*/ v_mul_hi_u32    v5, s2, v3
/*000000000520*/ v_add_u32       v4, vcc, v4, v5
/*000000000524*/ v_mul_lo_u32    v5, s2, v3
/*00000000052c*/ v_sub_u32       v5, s[0:1], 2, v5
/*000000000534*/ v_subb_u32      v6, vcc, 0, v4, s[0:1]
/*00000000053c*/ v_cmp_ge_u32    s[6:7], v5, s2
/*000000000544*/ v_cmp_ge_u32    s[12:13], v6, s3
/*00000000054c*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000550*/ v_cndmask_b32   v6, 0, -1, s[12:13]
/*000000000558*/ v_cndmask_b32   v7, 0, -1, s[6:7]
/*000000000560*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000564*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000568*/ s_cbranch_vccz  .L1484_13
/*00000000056c*/ v_sub_u32       v4, vcc, 0, v4
/*000000000570*/ v_sub_u32       v5, s[6:7], v5, s2
/*000000000578*/ v_mov_b32       v6, s3
/*00000000057c*/ v_subb_u32      v4, vcc, v4, v6, s[0:1]
/*000000000584*/ v_subb_u32      v4, vcc, v4, 0, s[6:7]
/*00000000058c*/ v_add_u32       v3, s[0:1], v3, 1
/*000000000594*/ v_cmp_ge_u32    s[0:1], v5, s2
/*00000000059c*/ v_cmp_ge_u32    s[6:7], v4, s3
/*0000000005a4*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005a8*/ v_cndmask_b32   v4, 0, -1, s[6:7]
/*0000000005b0*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000005b8*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005bc*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005c0*/ s_cbranch_vccz  .L1484_13
/*0000000005c4*/ v_add_u32       v3, s[0:1], v3, 1
.L1484_13:
/*0000000005cc*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005d4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005d8*/ s_branch        .L1504_13
.L1500_13:
/*0000000005dc*/ v_mov_b32       v3, 2
.L1504_13:
/*0000000005e0*/ s_lshl_b32      s0, s8, 2
/*0000000005e4*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*0000000005ec*/ flat_store_dword v[0:1], v3
/*0000000005f4*/ s_waitcnt       lgkmcnt(0)
/*0000000005f8*/ s_add_u32       s0, s0, s2
/*0000000005fc*/ v_add_u32       v0, vcc, s0, v2
/*000000000600*/ v_mov_b32       v1, 0
/*000000000604*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000060c*/ v_add_u32       v0, vcc, s10, v0
/*000000000610*/ v_mov_b32       v2, s11
/*000000000614*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000618*/ s_cmp_eq_u64    1, s[2:3]
/*00000000061c*/ s_cbranch_scc1  .L2256_13
/*000000000620*/ v_cvt_f32_u32   v2, s2
/*000000000624*/ v_cvt_f32_u32   v3, s3
/*000000000628*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000630*/ v_rcp_f32       v2, v2
/*000000000634*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*00000000063c*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*000000000644*/ v_trunc_f32     v3, v3
/*000000000648*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000650*/ v_cvt_u32_f32   v2, v2
/*000000000654*/ v_cvt_u32_f32   v3, v3
/*000000000658*/ v_sub_u32       v4, vcc, 0, s2
/*000000000660*/ v_mov_b32       v5, s3
/*000000000664*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000668*/ v_mul_lo_u32    v6, v4, v3
/*000000000670*/ v_mul_lo_u32    v7, v5, v2
/*000000000678*/ v_add_u32       v6, vcc, v6, v7
/*00000000067c*/ v_mul_hi_u32    v7, v4, v2
/*000000000684*/ v_add_u32       v6, vcc, v6, v7
/*000000000688*/ v_mul_lo_u32    v7, v4, v2
/*000000000690*/ v_mul_hi_u32    v8, v2, v7
/*000000000698*/ v_mul_lo_u32    v9, v3, v7
/*0000000006a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000006a4*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006ac*/ v_mul_lo_u32    v10, v2, v6
/*0000000006b4*/ v_add_u32       v8, vcc, v8, v10
/*0000000006b8*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006c0*/ v_mul_hi_u32    v7, v3, v7
/*0000000006c8*/ v_add_u32       v7, vcc, v8, v7
/*0000000006cc*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006d4*/ v_mul_hi_u32    v9, v2, v6
/*0000000006dc*/ v_add_u32       v7, vcc, v7, v9
/*0000000006e0*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000006e8*/ v_mul_lo_u32    v9, v3, v6
/*0000000006f0*/ v_add_u32       v7, vcc, v7, v9
/*0000000006f4*/ v_mul_hi_u32    v6, v3, v6
/*0000000006fc*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000700*/ v_add_u32       v2, s[0:1], v2, v7
/*000000000708*/ v_add_u32       v7, vcc, v3, v6
/*00000000070c*/ v_addc_u32      v3, vcc, v3, v6, s[0:1]
/*000000000714*/ v_mul_lo_u32    v6, v4, v3
/*00000000071c*/ v_mul_lo_u32    v5, v5, v2
/*000000000724*/ v_add_u32       v5, vcc, v6, v5
/*000000000728*/ v_mul_hi_u32    v6, v4, v2
/*000000000730*/ v_add_u32       v5, vcc, v5, v6
/*000000000734*/ v_mul_lo_u32    v4, v4, v2
/*00000000073c*/ v_mul_hi_u32    v6, v2, v4
/*000000000744*/ v_mul_lo_u32    v8, v3, v4
/*00000000074c*/ v_add_u32       v6, vcc, v6, v8
/*000000000750*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000758*/ v_mul_lo_u32    v9, v2, v5
/*000000000760*/ v_add_u32       v6, vcc, v6, v9
/*000000000764*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*00000000076c*/ v_mul_hi_u32    v4, v3, v4
/*000000000774*/ v_add_u32       v4, vcc, v6, v4
/*000000000778*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000780*/ v_mul_hi_u32    v8, v2, v5
/*000000000788*/ v_add_u32       v4, vcc, v4, v8
/*00000000078c*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*000000000794*/ v_mul_lo_u32    v8, v3, v5
/*00000000079c*/ v_add_u32       v4, vcc, v4, v8
/*0000000007a0*/ v_mul_hi_u32    v3, v3, v5
/*0000000007a8*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007ac*/ v_add_u32       v2, s[4:5], v2, v4
/*0000000007b4*/ v_addc_u32      v3, vcc, v7, v3, s[0:1]
/*0000000007bc*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*0000000007c4*/ v_mul_hi_u32    v2, 4, v2
/*0000000007cc*/ v_mul_lo_u32    v4, 4, v3
/*0000000007d4*/ v_add_u32       v2, vcc, v2, v4
/*0000000007d8*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*0000000007e0*/ v_mul_hi_u32    v3, 4, v3
/*0000000007e8*/ v_add_u32       v2, vcc, v2, v3
/*0000000007ec*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000007f4*/ v_add_u32       v3, vcc, 0, v3
/*0000000007f8*/ v_mul_lo_u32    v3, s2, v3
/*000000000800*/ v_mul_lo_u32    v4, s3, v2
/*000000000808*/ v_add_u32       v3, vcc, v3, v4
/*00000000080c*/ v_mul_hi_u32    v4, s2, v2
/*000000000814*/ v_add_u32       v3, vcc, v3, v4
/*000000000818*/ v_mul_lo_u32    v4, s2, v2
/*000000000820*/ v_sub_u32       v4, s[0:1], 4, v4
/*000000000828*/ v_subb_u32      v5, vcc, 0, v3, s[0:1]
/*000000000830*/ v_cmp_ge_u32    s[4:5], v4, s2
/*000000000838*/ v_cmp_ge_u32    s[6:7], v5, s3
/*000000000840*/ v_cmp_eq_i32    vcc, s3, v5
/*000000000844*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*00000000084c*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*000000000854*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000858*/ v_cmp_lg_u32    vcc, 0, v5
/*00000000085c*/ s_cbranch_vccz  .L2240_13
/*000000000860*/ v_sub_u32       v3, vcc, 0, v3
/*000000000864*/ v_sub_u32       v4, s[4:5], v4, s2
/*00000000086c*/ v_mov_b32       v5, s3
/*000000000870*/ v_subb_u32      v3, vcc, v3, v5, s[0:1]
/*000000000878*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*000000000880*/ v_add_u32       v2, s[0:1], v2, 1
/*000000000888*/ v_cmp_ge_u32    s[0:1], v4, s2
/*000000000890*/ v_cmp_ge_u32    s[4:5], v3, s3
/*000000000898*/ v_cmp_eq_i32    vcc, s3, v3
/*00000000089c*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008a4*/ v_cndmask_b32   v4, 0, -1, s[0:1]
/*0000000008ac*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008b0*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008b4*/ s_cbranch_vccz  .L2240_13
/*0000000008b8*/ v_add_u32       v2, s[0:1], v2, 1
.L2240_13:
/*0000000008c0*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000008c8*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008cc*/ s_branch        .L2260_13
.L2256_13:
/*0000000008d0*/ v_mov_b32       v2, 4
.L2260_13:
/*0000000008d4*/ flat_store_dword v[0:1], v2
/*0000000008dc*/ s_endpgm
.kernel div_get_global_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 1
/*000000000014*/ v_add_u32       v6, vcc, s6, v0
/*000000000018*/ s_lshl_b32      s6, s7, 1
/*00000000001c*/ v_mov_b32       v7, 0
/*000000000020*/ v_lshlrev_b64   v[3:4], 2, v[6:7]
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_add_u32       s6, s6, s2
/*000000000030*/ v_add_u32       v14, vcc, s6, v1
/*000000000034*/ v_add_u32       v3, vcc, s10, v3
/*000000000038*/ v_mov_b32       v5, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000040*/ v_add_u32       v0, vcc, s0, v6
/*000000000044*/ v_cmp_lg_i64    vcc, 1, s[0:1]
/*00000000004c*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000050*/ v_cvt_f32_u32   v5, s0
/*000000000054*/ s_cbranch_execz .L776_14
/*000000000058*/ v_cvt_f32_u32   v6, s1
/*00000000005c*/ v_madmk_f32     v5, v6, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000064*/ v_rcp_f32       v5, v5
/*000000000068*/ v_mul_f32       v5, 0x5f7ffffc /* 1.844674e+19f */, v5
/*000000000070*/ v_mul_f32       v6, 0x2f800000 /* 2.32830644e-10f */, v5
/*000000000078*/ v_trunc_f32     v6, v6
/*00000000007c*/ v_madmk_f32     v5, v6, 0xcf800000 /* -4.2949673e+9f */, v5
/*000000000084*/ v_cvt_u32_f32   v5, v5
/*000000000088*/ v_cvt_u32_f32   v6, v6
/*00000000008c*/ v_sub_u32       v7, vcc, 0, s0
/*000000000094*/ v_mov_b32       v8, s1
/*000000000098*/ v_subb_u32      v8, vcc, 0, v8, vcc
/*00000000009c*/ v_mul_lo_u32    v9, v7, v6
/*0000000000a4*/ v_mul_lo_u32    v10, v8, v5
/*0000000000ac*/ v_add_u32       v9, vcc, v9, v10
/*0000000000b0*/ v_mul_hi_u32    v10, v7, v5
/*0000000000b8*/ v_add_u32       v9, vcc, v9, v10
/*0000000000bc*/ v_mul_lo_u32    v10, v7, v5
/*0000000000c4*/ v_mul_hi_u32    v11, v5, v10
/*0000000000cc*/ v_mul_lo_u32    v12, v6, v10
/*0000000000d4*/ v_add_u32       v11, vcc, v11, v12
/*0000000000d8*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000000e0*/ v_mul_lo_u32    v13, v5, v9
/*0000000000e8*/ v_add_u32       v11, vcc, v11, v13
/*0000000000ec*/ v_addc_u32      v11, vcc, v12, 0, vcc
/*0000000000f4*/ v_mul_hi_u32    v10, v6, v10
/*0000000000fc*/ v_add_u32       v10, vcc, v11, v10
/*000000000100*/ v_cndmask_b32   v11, 0, 1, vcc
/*000000000108*/ v_mul_hi_u32    v12, v5, v9
/*000000000110*/ v_add_u32       v10, vcc, v10, v12
/*000000000114*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*00000000011c*/ v_mul_lo_u32    v12, v6, v9
/*000000000124*/ v_add_u32       v10, vcc, v10, v12
/*000000000128*/ v_mul_hi_u32    v9, v6, v9
/*000000000130*/ v_addc_u32      v9, vcc, v11, v9, vcc
/*000000000134*/ v_add_u32       v5, s[12:13], v5, v10
/*00000000013c*/ v_add_u32       v10, vcc, v6, v9
/*000000000140*/ v_addc_u32      v6, vcc, v6, v9, s[12:13]
/*000000000148*/ v_mul_lo_u32    v9, v7, v6
/*000000000150*/ v_mul_lo_u32    v8, v8, v5
/*000000000158*/ v_add_u32       v8, vcc, v9, v8
/*00000000015c*/ v_mul_hi_u32    v9, v7, v5
/*000000000164*/ v_add_u32       v8, vcc, v8, v9
/*000000000168*/ v_mul_lo_u32    v7, v7, v5
/*000000000170*/ v_mul_hi_u32    v9, v5, v7
/*000000000178*/ v_mul_lo_u32    v11, v6, v7
/*000000000180*/ v_add_u32       v9, vcc, v9, v11
/*000000000184*/ v_cndmask_b32   v11, 0, 1, vcc
/*00000000018c*/ v_mul_lo_u32    v12, v5, v8
/*000000000194*/ v_add_u32       v9, vcc, v9, v12
/*000000000198*/ v_addc_u32      v9, vcc, v11, 0, vcc
/*0000000001a0*/ v_mul_hi_u32    v7, v6, v7
/*0000000001a8*/ v_add_u32       v7, vcc, v9, v7
/*0000000001ac*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000001b4*/ v_mul_hi_u32    v11, v5, v8
/*0000000001bc*/ v_add_u32       v7, vcc, v7, v11
/*0000000001c0*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000001c8*/ v_mul_lo_u32    v11, v6, v8
/*0000000001d0*/ v_add_u32       v7, vcc, v7, v11
/*0000000001d4*/ v_mul_hi_u32    v6, v6, v8
/*0000000001dc*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*0000000001e0*/ v_add_u32       v5, s[14:15], v5, v7
/*0000000001e8*/ v_addc_u32      v6, vcc, v10, v6, s[12:13]
/*0000000001f0*/ v_addc_u32      v6, vcc, v6, 0, s[14:15]
/*0000000001f8*/ v_mul_hi_u32    v5, v0, v5
/*000000000200*/ v_mul_lo_u32    v7, v0, v6
/*000000000208*/ v_add_u32       v5, vcc, v5, v7
/*00000000020c*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000214*/ v_mul_hi_u32    v6, v0, v6
/*00000000021c*/ v_add_u32       v5, vcc, v5, v6
/*000000000220*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000228*/ v_add_u32       v6, vcc, 0, v6
/*00000000022c*/ v_mul_lo_u32    v6, s0, v6
/*000000000234*/ v_mul_lo_u32    v7, s1, v5
/*00000000023c*/ v_add_u32       v6, vcc, v6, v7
/*000000000240*/ v_mul_hi_u32    v7, s0, v5
/*000000000248*/ v_add_u32       v6, vcc, v6, v7
/*00000000024c*/ v_mul_lo_u32    v7, s0, v5
/*000000000254*/ v_sub_u32       v0, s[12:13], v0, v7
/*00000000025c*/ v_subb_u32      v7, vcc, 0, v6, s[12:13]
/*000000000264*/ v_cmp_ge_u32    s[14:15], v0, s0
/*00000000026c*/ v_cmp_ge_u32    s[16:17], v7, s1
/*000000000274*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000278*/ v_cndmask_b32   v7, 0, -1, s[16:17]
/*000000000280*/ v_cndmask_b32   v8, 0, -1, s[14:15]
/*000000000288*/ v_cndmask_b32   v7, v7, v8, vcc
/*00000000028c*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000290*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000294*/ v_sub_u32       v6, vcc, 0, v6
/*000000000298*/ s_cbranch_execz .L760_14
/*00000000029c*/ v_sub_u32       v0, s[16:17], v0, s0
/*0000000002a4*/ v_mov_b32       v7, s1
/*0000000002a8*/ v_subb_u32      v6, vcc, v6, v7, s[12:13]
/*0000000002b0*/ v_subb_u32      v6, vcc, v6, 0, s[16:17]
/*0000000002b8*/ v_add_u32       v5, s[12:13], v5, 1
/*0000000002c0*/ v_cmp_ge_u32    s[12:13], v0, s0
/*0000000002c8*/ v_cmp_ge_u32    s[16:17], v6, s1
/*0000000002d0*/ v_cmp_eq_i32    vcc, s1, v6
/*0000000002d4*/ v_cndmask_b32   v0, 0, -1, s[16:17]
/*0000000002dc*/ v_cndmask_b32   v6, 0, -1, s[12:13]
/*0000000002e4*/ v_cndmask_b32   v0, v0, v6, vcc
/*0000000002e8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002ec*/ v_add_u32       v0, s[12:13], v5, 1
/*0000000002f4*/ v_cndmask_b32   v5, v5, v0, vcc
.L760_14:
/*0000000002f8*/ s_mov_b64       exec, s[14:15]
/*0000000002fc*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*000000000304*/ v_cndmask_b32   v0, -1, v5, vcc
.L776_14:
/*000000000308*/ s_mov_b64       exec, s[6:7]
/*00000000030c*/ flat_store_dword v[3:4], v0
/*000000000314*/ v_mov_b32       v15, 0
/*000000000318*/ v_lshlrev_b64   v[3:4], 2, v[14:15]
/*000000000320*/ v_add_u32       v15, vcc, s10, v3
/*000000000324*/ v_mov_b32       v3, s11
/*000000000328*/ v_addc_u32      v16, vcc, v3, v4, vcc
/*00000000032c*/ v_cmp_lg_i64    vcc, 1, s[2:3]
/*000000000334*/ s_and_b64       exec, s[6:7], vcc
/*000000000338*/ v_cvt_f32_u32   v0, s2
/*00000000033c*/ s_cbranch_execz .L1520_14
/*000000000340*/ v_cvt_f32_u32   v5, s3
/*000000000344*/ v_madmk_f32     v0, v5, 0x4f800000 /* 4.2949673e+9f */, v0
/*00000000034c*/ v_rcp_f32       v0, v0
/*000000000350*/ v_mul_f32       v0, 0x5f7ffffc /* 1.844674e+19f */, v0
/*000000000358*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v0
/*000000000360*/ v_trunc_f32     v5, v5
/*000000000364*/ v_madmk_f32     v0, v5, 0xcf800000 /* -4.2949673e+9f */, v0
/*00000000036c*/ v_cvt_u32_f32   v0, v0
/*000000000370*/ v_cvt_u32_f32   v5, v5
/*000000000374*/ v_sub_u32       v6, vcc, 0, s2
/*00000000037c*/ v_mov_b32       v7, s3
/*000000000380*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000384*/ v_mul_lo_u32    v8, v6, v5
/*00000000038c*/ v_mul_lo_u32    v9, v7, v0
/*000000000394*/ v_add_u32       v8, vcc, v8, v9
/*000000000398*/ v_mul_hi_u32    v9, v6, v0
/*0000000003a0*/ v_add_u32       v8, vcc, v8, v9
/*0000000003a4*/ v_mul_lo_u32    v9, v6, v0
/*0000000003ac*/ v_mul_hi_u32    v10, v0, v9
/*0000000003b4*/ v_mul_lo_u32    v11, v5, v9
/*0000000003bc*/ v_add_u32       v10, vcc, v10, v11
/*0000000003c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000003c8*/ v_mul_lo_u32    v12, v0, v8
/*0000000003d0*/ v_add_u32       v10, vcc, v10, v12
/*0000000003d4*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000003dc*/ v_mul_hi_u32    v9, v5, v9
/*0000000003e4*/ v_add_u32       v9, vcc, v10, v9
/*0000000003e8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003f0*/ v_mul_hi_u32    v11, v0, v8
/*0000000003f8*/ v_add_u32       v9, vcc, v9, v11
/*0000000003fc*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000404*/ v_mul_lo_u32    v11, v5, v8
/*00000000040c*/ v_add_u32       v9, vcc, v9, v11
/*000000000410*/ v_mul_hi_u32    v8, v5, v8
/*000000000418*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*00000000041c*/ v_add_u32       v0, s[0:1], v0, v9
/*000000000424*/ v_add_u32       v9, vcc, v5, v8
/*000000000428*/ v_addc_u32      v5, vcc, v5, v8, s[0:1]
/*000000000430*/ v_mul_lo_u32    v8, v6, v5
/*000000000438*/ v_mul_lo_u32    v7, v7, v0
/*000000000440*/ v_add_u32       v7, vcc, v8, v7
/*000000000444*/ v_mul_hi_u32    v8, v6, v0
/*00000000044c*/ v_add_u32       v7, vcc, v7, v8
/*000000000450*/ v_mul_lo_u32    v6, v6, v0
/*000000000458*/ v_mul_hi_u32    v8, v0, v6
/*000000000460*/ v_mul_lo_u32    v10, v5, v6
/*000000000468*/ v_add_u32       v8, vcc, v8, v10
/*00000000046c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000474*/ v_mul_lo_u32    v11, v0, v7
/*00000000047c*/ v_add_u32       v8, vcc, v8, v11
/*000000000480*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000488*/ v_mul_hi_u32    v6, v5, v6
/*000000000490*/ v_add_u32       v6, vcc, v8, v6
/*000000000494*/ v_cndmask_b32   v8, 0, 1, vcc
/*00000000049c*/ v_mul_hi_u32    v10, v0, v7
/*0000000004a4*/ v_add_u32       v6, vcc, v6, v10
/*0000000004a8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000004b0*/ v_mul_lo_u32    v10, v5, v7
/*0000000004b8*/ v_add_u32       v6, vcc, v6, v10
/*0000000004bc*/ v_mul_hi_u32    v5, v5, v7
/*0000000004c4*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000004c8*/ v_add_u32       v0, s[12:13], v0, v6
/*0000000004d0*/ v_addc_u32      v5, vcc, v9, v5, s[0:1]
/*0000000004d8*/ v_addc_u32      v5, vcc, v5, 0, s[12:13]
/*0000000004e0*/ v_mul_hi_u32    v0, v14, v0
/*0000000004e8*/ v_mul_lo_u32    v6, v14, v5
/*0000000004f0*/ v_add_u32       v0, vcc, v0, v6
/*0000000004f4*/ v_addc_u32      v0, vcc, 0, 0, vcc
/*0000000004fc*/ v_mul_hi_u32    v5, v14, v5
/*000000000504*/ v_add_u32       v0, vcc, v0, v5
/*000000000508*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000510*/ v_add_u32       v5, vcc, 0, v5
/*000000000514*/ v_mul_lo_u32    v5, s2, v5
/*00000000051c*/ v_mul_lo_u32    v6, s3, v0
/*000000000524*/ v_add_u32       v5, vcc, v5, v6
/*000000000528*/ v_mul_hi_u32    v6, s2, v0
/*000000000530*/ v_add_u32       v5, vcc, v5, v6
/*000000000534*/ v_mul_lo_u32    v6, s2, v0
/*00000000053c*/ v_sub_u32       v1, s[0:1], v14, v6
/*000000000544*/ v_subb_u32      v6, vcc, 0, v5, s[0:1]
/*00000000054c*/ v_cmp_ge_u32    s[12:13], v1, s2
/*000000000554*/ v_cmp_ge_u32    s[14:15], v6, s3
/*00000000055c*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000560*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*000000000568*/ v_cndmask_b32   v7, 0, -1, s[12:13]
/*000000000570*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000574*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000578*/ s_and_saveexec_b64 s[12:13], vcc
/*00000000057c*/ v_sub_u32       v5, vcc, 0, v5
/*000000000580*/ s_cbranch_execz .L1504_14
/*000000000584*/ v_sub_u32       v1, s[14:15], v1, s2
/*00000000058c*/ v_mov_b32       v6, s3
/*000000000590*/ v_subb_u32      v5, vcc, v5, v6, s[0:1]
/*000000000598*/ v_subb_u32      v5, vcc, v5, 0, s[14:15]
/*0000000005a0*/ v_add_u32       v0, s[0:1], v0, 1
/*0000000005a8*/ v_cmp_ge_u32    s[0:1], v1, s2
/*0000000005b0*/ v_cmp_ge_u32    s[14:15], v5, s3
/*0000000005b8*/ v_cmp_eq_i32    vcc, s3, v5
/*0000000005bc*/ v_cndmask_b32   v1, 0, -1, s[14:15]
/*0000000005c4*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000005cc*/ v_cndmask_b32   v1, v1, v5, vcc
/*0000000005d0*/ v_cmp_lg_u32    vcc, 0, v1
/*0000000005d4*/ v_add_u32       v1, s[0:1], v0, 1
/*0000000005dc*/ v_cndmask_b32   v0, v0, v1, vcc
.L1504_14:
/*0000000005e0*/ s_mov_b64       exec, s[12:13]
/*0000000005e4*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005ec*/ v_cndmask_b32   v14, -1, v0, vcc
.L1520_14:
/*0000000005f0*/ s_mov_b64       exec, s[6:7]
/*0000000005f4*/ s_lshl_b32      s0, s8, 2
/*0000000005f8*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000600*/ flat_store_dword v[15:16], v14
/*000000000608*/ s_waitcnt       lgkmcnt(0)
/*00000000060c*/ s_add_u32       s0, s0, s2
/*000000000610*/ v_add_u32       v0, vcc, s0, v2
/*000000000614*/ v_mov_b32       v1, 0
/*000000000618*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*000000000620*/ v_add_u32       v1, vcc, s10, v1
/*000000000624*/ v_mov_b32       v3, s11
/*000000000628*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*00000000062c*/ v_cmp_lg_i64    vcc, 1, s[2:3]
/*000000000634*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000638*/ v_cvt_f32_u32   v3, s2
/*00000000063c*/ s_cbranch_execz .L2288_14
/*000000000640*/ v_cvt_f32_u32   v4, s3
/*000000000644*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000064c*/ v_rcp_f32       v3, v3
/*000000000650*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000658*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000660*/ v_trunc_f32     v4, v4
/*000000000664*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000066c*/ v_cvt_u32_f32   v3, v3
/*000000000670*/ v_cvt_u32_f32   v4, v4
/*000000000674*/ v_sub_u32       v5, vcc, 0, s2
/*00000000067c*/ v_mov_b32       v6, s3
/*000000000680*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000684*/ v_mul_lo_u32    v7, v5, v4
/*00000000068c*/ v_mul_lo_u32    v8, v6, v3
/*000000000694*/ v_add_u32       v7, vcc, v7, v8
/*000000000698*/ v_mul_hi_u32    v8, v5, v3
/*0000000006a0*/ v_add_u32       v7, vcc, v7, v8
/*0000000006a4*/ v_mul_lo_u32    v8, v5, v3
/*0000000006ac*/ v_mul_hi_u32    v9, v3, v8
/*0000000006b4*/ v_mul_lo_u32    v10, v4, v8
/*0000000006bc*/ v_add_u32       v9, vcc, v9, v10
/*0000000006c0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000006c8*/ v_mul_lo_u32    v11, v3, v7
/*0000000006d0*/ v_add_u32       v9, vcc, v9, v11
/*0000000006d4*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000006dc*/ v_mul_hi_u32    v8, v4, v8
/*0000000006e4*/ v_add_u32       v8, vcc, v9, v8
/*0000000006e8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006f0*/ v_mul_hi_u32    v10, v3, v7
/*0000000006f8*/ v_add_u32       v8, vcc, v8, v10
/*0000000006fc*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000704*/ v_mul_lo_u32    v10, v4, v7
/*00000000070c*/ v_add_u32       v8, vcc, v8, v10
/*000000000710*/ v_mul_hi_u32    v7, v4, v7
/*000000000718*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*00000000071c*/ v_add_u32       v3, s[4:5], v3, v8
/*000000000724*/ v_add_u32       v8, vcc, v4, v7
/*000000000728*/ v_addc_u32      v4, vcc, v4, v7, s[4:5]
/*000000000730*/ v_mul_lo_u32    v7, v5, v4
/*000000000738*/ v_mul_lo_u32    v6, v6, v3
/*000000000740*/ v_add_u32       v6, vcc, v7, v6
/*000000000744*/ v_mul_hi_u32    v7, v5, v3
/*00000000074c*/ v_add_u32       v6, vcc, v6, v7
/*000000000750*/ v_mul_lo_u32    v5, v5, v3
/*000000000758*/ v_mul_hi_u32    v7, v3, v5
/*000000000760*/ v_mul_lo_u32    v9, v4, v5
/*000000000768*/ v_add_u32       v7, vcc, v7, v9
/*00000000076c*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000774*/ v_mul_lo_u32    v10, v3, v6
/*00000000077c*/ v_add_u32       v7, vcc, v7, v10
/*000000000780*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000788*/ v_mul_hi_u32    v5, v4, v5
/*000000000790*/ v_add_u32       v5, vcc, v7, v5
/*000000000794*/ v_cndmask_b32   v7, 0, 1, vcc
/*00000000079c*/ v_mul_hi_u32    v9, v3, v6
/*0000000007a4*/ v_add_u32       v5, vcc, v5, v9
/*0000000007a8*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000007b0*/ v_mul_lo_u32    v9, v4, v6
/*0000000007b8*/ v_add_u32       v5, vcc, v5, v9
/*0000000007bc*/ v_mul_hi_u32    v4, v4, v6
/*0000000007c4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000007c8*/ v_add_u32       v3, s[6:7], v3, v5
/*0000000007d0*/ v_addc_u32      v4, vcc, v8, v4, s[4:5]
/*0000000007d8*/ v_addc_u32      v4, vcc, v4, 0, s[6:7]
/*0000000007e0*/ v_mul_hi_u32    v3, v0, v3
/*0000000007e8*/ v_mul_lo_u32    v5, v0, v4
/*0000000007f0*/ v_add_u32       v3, vcc, v3, v5
/*0000000007f4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000007fc*/ v_mul_hi_u32    v4, v0, v4
/*000000000804*/ v_add_u32       v3, vcc, v3, v4
/*000000000808*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000810*/ v_add_u32       v4, vcc, 0, v4
/*000000000814*/ v_mul_lo_u32    v4, s2, v4
/*00000000081c*/ v_mul_lo_u32    v5, s3, v3
/*000000000824*/ v_add_u32       v4, vcc, v4, v5
/*000000000828*/ v_mul_hi_u32    v5, s2, v3
/*000000000830*/ v_add_u32       v4, vcc, v4, v5
/*000000000834*/ v_mul_lo_u32    v5, s2, v3
/*00000000083c*/ v_sub_u32       v0, s[4:5], v0, v5
/*000000000844*/ v_subb_u32      v5, vcc, 0, v4, s[4:5]
/*00000000084c*/ v_cmp_ge_u32    s[6:7], v0, s2
/*000000000854*/ v_cmp_ge_u32    s[8:9], v5, s3
/*00000000085c*/ v_cmp_eq_i32    vcc, s3, v5
/*000000000860*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*000000000868*/ v_cndmask_b32   v6, 0, -1, s[6:7]
/*000000000870*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000874*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000878*/ s_and_saveexec_b64 s[6:7], vcc
/*00000000087c*/ v_sub_u32       v4, vcc, 0, v4
/*000000000880*/ s_cbranch_execz .L2272_14
/*000000000884*/ v_sub_u32       v0, s[8:9], v0, s2
/*00000000088c*/ v_mov_b32       v5, s3
/*000000000890*/ v_subb_u32      v4, vcc, v4, v5, s[4:5]
/*000000000898*/ v_subb_u32      v4, vcc, v4, 0, s[8:9]
/*0000000008a0*/ v_add_u32       v3, s[4:5], v3, 1
/*0000000008a8*/ v_cmp_ge_u32    s[4:5], v0, s2
/*0000000008b0*/ v_cmp_ge_u32    s[8:9], v4, s3
/*0000000008b8*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000008bc*/ v_cndmask_b32   v0, 0, -1, s[8:9]
/*0000000008c4*/ v_cndmask_b32   v4, 0, -1, s[4:5]
/*0000000008cc*/ v_cndmask_b32   v0, v0, v4, vcc
/*0000000008d0*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000008d4*/ v_add_u32       v0, s[4:5], v3, 1
/*0000000008dc*/ v_cndmask_b32   v3, v3, v0, vcc
.L2272_14:
/*0000000008e0*/ s_mov_b64       exec, s[6:7]
/*0000000008e4*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000008ec*/ v_cndmask_b32   v0, -1, v3, vcc
.L2288_14:
/*0000000008f0*/ s_mov_b64       exec, s[0:1]
/*0000000008f4*/ flat_store_dword v[1:2], v0
/*0000000008fc*/ s_endpgm
.kernel div_get_global_size_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 29
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000010*/ s_lshl_b32      s8, s8, 4
/*000000000014*/ s_waitcnt       lgkmcnt(0)
/*000000000018*/ s_add_u32       s8, s8, s0
/*00000000001c*/ v_add_u32       v3, vcc, s8, v0
/*000000000020*/ v_mov_b32       v4, 0
/*000000000024*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000002c*/ v_add_u32       v0, s[14:15], s12, v3
/*000000000034*/ s_load_dwordx2  s[16:17], s[4:5], 0xc
/*00000000003c*/ s_cmp_eq_u64    1, s[0:1]
/*000000000040*/ s_cbranch_scc1  .L760_15
/*000000000044*/ v_cvt_f32_u32   v3, s0
/*000000000048*/ v_cvt_f32_u32   v5, s1
/*00000000004c*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000054*/ v_rcp_f32       v3, v3
/*000000000058*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000060*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000068*/ v_trunc_f32     v5, v5
/*00000000006c*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000074*/ v_cvt_u32_f32   v3, v3
/*000000000078*/ v_cvt_u32_f32   v5, v5
/*00000000007c*/ v_sub_u32       v6, vcc, 0, s0
/*000000000084*/ v_mov_b32       v7, s1
/*000000000088*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*00000000008c*/ v_mul_lo_u32    v8, v6, v5
/*000000000094*/ v_mul_lo_u32    v9, v7, v3
/*00000000009c*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a0*/ v_mul_hi_u32    v9, v6, v3
/*0000000000a8*/ v_add_u32       v8, vcc, v8, v9
/*0000000000ac*/ v_mul_lo_u32    v9, v6, v3
/*0000000000b4*/ v_mul_hi_u32    v10, v3, v9
/*0000000000bc*/ v_mul_lo_u32    v11, v5, v9
/*0000000000c4*/ v_add_u32       v10, vcc, v10, v11
/*0000000000c8*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000d0*/ v_mul_lo_u32    v12, v3, v8
/*0000000000d8*/ v_add_u32       v10, vcc, v10, v12
/*0000000000dc*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000e4*/ v_mul_hi_u32    v9, v5, v9
/*0000000000ec*/ v_add_u32       v9, vcc, v10, v9
/*0000000000f0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000000f8*/ v_mul_hi_u32    v11, v3, v8
/*000000000100*/ v_add_u32       v9, vcc, v9, v11
/*000000000104*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*00000000010c*/ v_mul_lo_u32    v11, v5, v8
/*000000000114*/ v_add_u32       v9, vcc, v9, v11
/*000000000118*/ v_mul_hi_u32    v8, v5, v8
/*000000000120*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*000000000124*/ v_add_u32       v3, s[18:19], v3, v9
/*00000000012c*/ v_add_u32       v9, vcc, v5, v8
/*000000000130*/ v_addc_u32      v5, vcc, v5, v8, s[18:19]
/*000000000138*/ v_mul_lo_u32    v8, v6, v5
/*000000000140*/ v_mul_lo_u32    v7, v7, v3
/*000000000148*/ v_add_u32       v7, vcc, v8, v7
/*00000000014c*/ v_mul_hi_u32    v8, v6, v3
/*000000000154*/ v_add_u32       v7, vcc, v7, v8
/*000000000158*/ v_mul_lo_u32    v6, v6, v3
/*000000000160*/ v_mul_hi_u32    v8, v3, v6
/*000000000168*/ v_mul_lo_u32    v10, v5, v6
/*000000000170*/ v_add_u32       v8, vcc, v8, v10
/*000000000174*/ v_cndmask_b32   v10, 0, 1, vcc
/*00000000017c*/ v_mul_lo_u32    v11, v3, v7
/*000000000184*/ v_add_u32       v8, vcc, v8, v11
/*000000000188*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000190*/ v_mul_hi_u32    v6, v5, v6
/*000000000198*/ v_add_u32       v6, vcc, v8, v6
/*00000000019c*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000001a4*/ v_mul_hi_u32    v10, v3, v7
/*0000000001ac*/ v_add_u32       v6, vcc, v6, v10
/*0000000001b0*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001b8*/ v_mul_lo_u32    v10, v5, v7
/*0000000001c0*/ v_add_u32       v6, vcc, v6, v10
/*0000000001c4*/ v_mul_hi_u32    v5, v5, v7
/*0000000001cc*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001d0*/ v_add_u32       v3, s[20:21], v3, v6
/*0000000001d8*/ v_addc_u32      v5, vcc, v9, v5, s[18:19]
/*0000000001e0*/ v_addc_u32      v5, vcc, v5, 0, s[20:21]
/*0000000001e8*/ s_waitcnt       lgkmcnt(0)
/*0000000001ec*/ v_mul_hi_u32    v3, s16, v3
/*0000000001f4*/ v_mul_lo_u32    v6, s16, v5
/*0000000001fc*/ v_add_u32       v3, vcc, v3, v6
/*000000000200*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000208*/ v_mul_hi_u32    v5, s16, v5
/*000000000210*/ v_add_u32       v3, vcc, v3, v5
/*000000000214*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*00000000021c*/ v_add_u32       v5, vcc, 0, v5
/*000000000220*/ v_mul_lo_u32    v5, s0, v5
/*000000000228*/ v_mul_lo_u32    v6, s1, v3
/*000000000230*/ v_add_u32       v5, vcc, v5, v6
/*000000000234*/ v_mul_hi_u32    v6, s0, v3
/*00000000023c*/ v_add_u32       v5, vcc, v5, v6
/*000000000240*/ v_mul_lo_u32    v6, s0, v3
/*000000000248*/ v_sub_u32       v6, s[18:19], s16, v6
/*000000000250*/ v_subb_u32      v7, vcc, 0, v5, s[18:19]
/*000000000258*/ v_cmp_ge_u32    s[20:21], v6, s0
/*000000000260*/ v_cmp_ge_u32    s[22:23], v7, s1
/*000000000268*/ v_cmp_eq_i32    vcc, s1, v7
/*00000000026c*/ v_cndmask_b32   v7, 0, -1, s[22:23]
/*000000000274*/ v_cndmask_b32   v8, 0, -1, s[20:21]
/*00000000027c*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000280*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000284*/ s_cbranch_vccz  .L744_15
/*000000000288*/ v_sub_u32       v5, vcc, 0, v5
/*00000000028c*/ v_sub_u32       v6, s[20:21], v6, s0
/*000000000294*/ v_mov_b32       v7, s1
/*000000000298*/ v_subb_u32      v5, vcc, v5, v7, s[18:19]
/*0000000002a0*/ v_subb_u32      v5, vcc, v5, 0, s[20:21]
/*0000000002a8*/ v_add_u32       v3, s[18:19], v3, 1
/*0000000002b0*/ v_cmp_ge_u32    s[18:19], v6, s0
/*0000000002b8*/ v_cmp_ge_u32    s[20:21], v5, s1
/*0000000002c0*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002c4*/ v_cndmask_b32   v5, 0, -1, s[20:21]
/*0000000002cc*/ v_cndmask_b32   v6, 0, -1, s[18:19]
/*0000000002d4*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002d8*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002dc*/ s_cbranch_vccz  .L744_15
/*0000000002e0*/ v_add_u32       v3, s[18:19], v3, 1
.L744_15:
/*0000000002e8*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002f0*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000002f4*/ s_branch        .L768_15
.L760_15:
/*0000000002f8*/ s_waitcnt       lgkmcnt(0)
/*0000000002fc*/ v_mov_b32       v3, s16
.L768_15:
/*000000000300*/ s_lshl_b32      s0, s9, 1
/*000000000304*/ s_add_u32       s0, s0, s2
/*000000000308*/ v_add_u32       v5, vcc, s0, v1
/*00000000030c*/ v_mov_b32       v1, s13
/*000000000310*/ v_addc_u32      v1, vcc, v1, v4, s[14:15]
/*000000000318*/ flat_store_dword v[0:1], v3
/*000000000320*/ s_load_dwordx2  s[0:1], s[6:7], 0x10
/*000000000328*/ v_mov_b32       v6, 0
/*00000000032c*/ v_lshlrev_b64   v[0:1], 2, v[5:6]
/*000000000334*/ v_add_u32       v0, s[6:7], s12, v0
/*00000000033c*/ s_cmp_eq_u64    1, s[2:3]
/*000000000340*/ s_cbranch_scc1  .L1524_15
/*000000000344*/ v_cvt_f32_u32   v3, s2
/*000000000348*/ v_cvt_f32_u32   v4, s3
/*00000000034c*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000354*/ v_rcp_f32       v3, v3
/*000000000358*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000360*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000368*/ v_trunc_f32     v4, v4
/*00000000036c*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000374*/ v_cvt_u32_f32   v3, v3
/*000000000378*/ v_cvt_u32_f32   v4, v4
/*00000000037c*/ v_sub_u32       v5, vcc, 0, s2
/*000000000384*/ v_mov_b32       v6, s3
/*000000000388*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*00000000038c*/ v_mul_lo_u32    v7, v5, v4
/*000000000394*/ v_mul_lo_u32    v8, v6, v3
/*00000000039c*/ v_add_u32       v7, vcc, v7, v8
/*0000000003a0*/ v_mul_hi_u32    v8, v5, v3
/*0000000003a8*/ v_add_u32       v7, vcc, v7, v8
/*0000000003ac*/ v_mul_lo_u32    v8, v5, v3
/*0000000003b4*/ v_mul_hi_u32    v9, v3, v8
/*0000000003bc*/ v_mul_lo_u32    v10, v4, v8
/*0000000003c4*/ v_add_u32       v9, vcc, v9, v10
/*0000000003c8*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003d0*/ v_mul_lo_u32    v11, v3, v7
/*0000000003d8*/ v_add_u32       v9, vcc, v9, v11
/*0000000003dc*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003e4*/ v_mul_hi_u32    v8, v4, v8
/*0000000003ec*/ v_add_u32       v8, vcc, v9, v8
/*0000000003f0*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000003f8*/ v_mul_hi_u32    v10, v3, v7
/*000000000400*/ v_add_u32       v8, vcc, v8, v10
/*000000000404*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*00000000040c*/ v_mul_lo_u32    v10, v4, v7
/*000000000414*/ v_add_u32       v8, vcc, v8, v10
/*000000000418*/ v_mul_hi_u32    v7, v4, v7
/*000000000420*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*000000000424*/ v_add_u32       v3, s[8:9], v3, v8
/*00000000042c*/ v_add_u32       v8, vcc, v4, v7
/*000000000430*/ v_addc_u32      v4, vcc, v4, v7, s[8:9]
/*000000000438*/ v_mul_lo_u32    v7, v5, v4
/*000000000440*/ v_mul_lo_u32    v6, v6, v3
/*000000000448*/ v_add_u32       v6, vcc, v7, v6
/*00000000044c*/ v_mul_hi_u32    v7, v5, v3
/*000000000454*/ v_add_u32       v6, vcc, v6, v7
/*000000000458*/ v_mul_lo_u32    v5, v5, v3
/*000000000460*/ v_mul_hi_u32    v7, v3, v5
/*000000000468*/ v_mul_lo_u32    v9, v4, v5
/*000000000470*/ v_add_u32       v7, vcc, v7, v9
/*000000000474*/ v_cndmask_b32   v9, 0, 1, vcc
/*00000000047c*/ v_mul_lo_u32    v10, v3, v6
/*000000000484*/ v_add_u32       v7, vcc, v7, v10
/*000000000488*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000490*/ v_mul_hi_u32    v5, v4, v5
/*000000000498*/ v_add_u32       v5, vcc, v7, v5
/*00000000049c*/ v_cndmask_b32   v7, 0, 1, vcc
/*0000000004a4*/ v_mul_hi_u32    v9, v3, v6
/*0000000004ac*/ v_add_u32       v5, vcc, v5, v9
/*0000000004b0*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004b8*/ v_mul_lo_u32    v9, v4, v6
/*0000000004c0*/ v_add_u32       v5, vcc, v5, v9
/*0000000004c4*/ v_mul_hi_u32    v4, v4, v6
/*0000000004cc*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004d0*/ v_add_u32       v3, s[14:15], v3, v5
/*0000000004d8*/ v_addc_u32      v4, vcc, v8, v4, s[8:9]
/*0000000004e0*/ v_addc_u32      v4, vcc, v4, 0, s[14:15]
/*0000000004e8*/ v_mul_hi_u32    v3, s17, v3
/*0000000004f0*/ v_mul_lo_u32    v5, s17, v4
/*0000000004f8*/ v_add_u32       v3, vcc, v3, v5
/*0000000004fc*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000504*/ v_mul_hi_u32    v4, s17, v4
/*00000000050c*/ v_add_u32       v3, vcc, v3, v4
/*000000000510*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000518*/ v_add_u32       v4, vcc, 0, v4
/*00000000051c*/ v_mul_lo_u32    v4, s2, v4
/*000000000524*/ v_mul_lo_u32    v5, s3, v3
/*00000000052c*/ v_add_u32       v4, vcc, v4, v5
/*000000000530*/ v_mul_hi_u32    v5, s2, v3
/*000000000538*/ v_add_u32       v4, vcc, v4, v5
/*00000000053c*/ v_mul_lo_u32    v5, s2, v3
/*000000000544*/ v_sub_u32       v5, s[8:9], s17, v5
/*00000000054c*/ v_subb_u32      v6, vcc, 0, v4, s[8:9]
/*000000000554*/ v_cmp_ge_u32    s[14:15], v5, s2
/*00000000055c*/ v_cmp_ge_u32    s[16:17], v6, s3
/*000000000564*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000568*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*000000000570*/ v_cndmask_b32   v7, 0, -1, s[14:15]
/*000000000578*/ v_cndmask_b32   v6, v6, v7, vcc
/*00000000057c*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000580*/ s_cbranch_vccz  .L1508_15
/*000000000584*/ v_sub_u32       v4, vcc, 0, v4
/*000000000588*/ v_sub_u32       v5, s[14:15], v5, s2
/*000000000590*/ v_mov_b32       v6, s3
/*000000000594*/ v_subb_u32      v4, vcc, v4, v6, s[8:9]
/*00000000059c*/ v_subb_u32      v4, vcc, v4, 0, s[14:15]
/*0000000005a4*/ v_add_u32       v3, s[8:9], v3, 1
/*0000000005ac*/ v_cmp_ge_u32    s[8:9], v5, s2
/*0000000005b4*/ v_cmp_ge_u32    s[14:15], v4, s3
/*0000000005bc*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005c0*/ v_cndmask_b32   v4, 0, -1, s[14:15]
/*0000000005c8*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*0000000005d0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005d4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005d8*/ s_cbranch_vccz  .L1508_15
/*0000000005dc*/ v_add_u32       v3, s[8:9], v3, 1
.L1508_15:
/*0000000005e4*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005ec*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005f0*/ s_branch        .L1528_15
.L1524_15:
/*0000000005f4*/ v_mov_b32       v3, s17
.L1528_15:
/*0000000005f8*/ s_lshl_b32      s2, s10, 1
/*0000000005fc*/ s_waitcnt       lgkmcnt(0)
/*000000000600*/ s_add_u32       s2, s2, s0
/*000000000604*/ v_add_u32       v2, vcc, s2, v2
/*000000000608*/ v_mov_b32       v4, s13
/*00000000060c*/ v_addc_u32      v1, vcc, v4, v1, s[6:7]
/*000000000614*/ flat_store_dword v[0:1], v3
/*00000000061c*/ v_mov_b32       v3, 0
/*000000000620*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*000000000628*/ v_add_u32       v0, vcc, s12, v0
/*00000000062c*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*000000000630*/ s_load_dword    s2, s[4:5], 0x14
/*000000000638*/ s_cmp_eq_u64    1, s[0:1]
/*00000000063c*/ s_cbranch_scc1  .L2292_15
/*000000000640*/ v_cvt_f32_u32   v2, s0
/*000000000644*/ v_cvt_f32_u32   v3, s1
/*000000000648*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000650*/ v_rcp_f32       v2, v2
/*000000000654*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*00000000065c*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*000000000664*/ v_trunc_f32     v3, v3
/*000000000668*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000670*/ v_cvt_u32_f32   v2, v2
/*000000000674*/ v_cvt_u32_f32   v3, v3
/*000000000678*/ v_sub_u32       v4, vcc, 0, s0
/*000000000680*/ v_mov_b32       v5, s1
/*000000000684*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000688*/ v_mul_lo_u32    v6, v4, v3
/*000000000690*/ v_mul_lo_u32    v7, v5, v2
/*000000000698*/ v_add_u32       v6, vcc, v6, v7
/*00000000069c*/ v_mul_hi_u32    v7, v4, v2
/*0000000006a4*/ v_add_u32       v6, vcc, v6, v7
/*0000000006a8*/ v_mul_lo_u32    v7, v4, v2
/*0000000006b0*/ v_mul_hi_u32    v8, v2, v7
/*0000000006b8*/ v_mul_lo_u32    v9, v3, v7
/*0000000006c0*/ v_add_u32       v8, vcc, v8, v9
/*0000000006c4*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006cc*/ v_mul_lo_u32    v10, v2, v6
/*0000000006d4*/ v_add_u32       v8, vcc, v8, v10
/*0000000006d8*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006e0*/ v_mul_hi_u32    v7, v3, v7
/*0000000006e8*/ v_add_u32       v7, vcc, v8, v7
/*0000000006ec*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006f4*/ v_mul_hi_u32    v9, v2, v6
/*0000000006fc*/ v_add_u32       v7, vcc, v7, v9
/*000000000700*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*000000000708*/ v_mul_lo_u32    v9, v3, v6
/*000000000710*/ v_add_u32       v7, vcc, v7, v9
/*000000000714*/ v_mul_hi_u32    v6, v3, v6
/*00000000071c*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000720*/ v_add_u32       v2, s[4:5], v2, v7
/*000000000728*/ v_add_u32       v7, vcc, v3, v6
/*00000000072c*/ v_addc_u32      v3, vcc, v3, v6, s[4:5]
/*000000000734*/ v_mul_lo_u32    v6, v4, v3
/*00000000073c*/ v_mul_lo_u32    v5, v5, v2
/*000000000744*/ v_add_u32       v5, vcc, v6, v5
/*000000000748*/ v_mul_hi_u32    v6, v4, v2
/*000000000750*/ v_add_u32       v5, vcc, v5, v6
/*000000000754*/ v_mul_lo_u32    v4, v4, v2
/*00000000075c*/ v_mul_hi_u32    v6, v2, v4
/*000000000764*/ v_mul_lo_u32    v8, v3, v4
/*00000000076c*/ v_add_u32       v6, vcc, v6, v8
/*000000000770*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000778*/ v_mul_lo_u32    v9, v2, v5
/*000000000780*/ v_add_u32       v6, vcc, v6, v9
/*000000000784*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*00000000078c*/ v_mul_hi_u32    v4, v3, v4
/*000000000794*/ v_add_u32       v4, vcc, v6, v4
/*000000000798*/ v_cndmask_b32   v6, 0, 1, vcc
/*0000000007a0*/ v_mul_hi_u32    v8, v2, v5
/*0000000007a8*/ v_add_u32       v4, vcc, v4, v8
/*0000000007ac*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*0000000007b4*/ v_mul_lo_u32    v8, v3, v5
/*0000000007bc*/ v_add_u32       v4, vcc, v4, v8
/*0000000007c0*/ v_mul_hi_u32    v3, v3, v5
/*0000000007c8*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007cc*/ v_add_u32       v2, s[6:7], v2, v4
/*0000000007d4*/ v_addc_u32      v3, vcc, v7, v3, s[4:5]
/*0000000007dc*/ v_addc_u32      v3, vcc, v3, 0, s[6:7]
/*0000000007e4*/ s_waitcnt       lgkmcnt(0)
/*0000000007e8*/ v_mul_hi_u32    v2, s2, v2
/*0000000007f0*/ v_mul_lo_u32    v4, s2, v3
/*0000000007f8*/ v_add_u32       v2, vcc, v2, v4
/*0000000007fc*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*000000000804*/ v_mul_hi_u32    v3, s2, v3
/*00000000080c*/ v_add_u32       v2, vcc, v2, v3
/*000000000810*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000818*/ v_add_u32       v3, vcc, 0, v3
/*00000000081c*/ v_mul_lo_u32    v3, s0, v3
/*000000000824*/ v_mul_lo_u32    v4, s1, v2
/*00000000082c*/ v_add_u32       v3, vcc, v3, v4
/*000000000830*/ v_mul_hi_u32    v4, s0, v2
/*000000000838*/ v_add_u32       v3, vcc, v3, v4
/*00000000083c*/ v_mul_lo_u32    v4, s0, v2
/*000000000844*/ v_sub_u32       v4, s[4:5], s2, v4
/*00000000084c*/ v_subb_u32      v5, vcc, 0, v3, s[4:5]
/*000000000854*/ v_cmp_ge_u32    s[2:3], v4, s0
/*00000000085c*/ v_cmp_ge_u32    s[6:7], v5, s1
/*000000000864*/ v_cmp_eq_i32    vcc, s1, v5
/*000000000868*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*000000000870*/ v_cndmask_b32   v6, 0, -1, s[2:3]
/*000000000878*/ v_cndmask_b32   v5, v5, v6, vcc
/*00000000087c*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000880*/ s_cbranch_vccz  .L2276_15
/*000000000884*/ v_sub_u32       v3, vcc, 0, v3
/*000000000888*/ v_sub_u32       v4, s[2:3], v4, s0
/*000000000890*/ v_mov_b32       v5, s1
/*000000000894*/ v_subb_u32      v3, vcc, v3, v5, s[4:5]
/*00000000089c*/ v_subb_u32      v3, vcc, v3, 0, s[2:3]
/*0000000008a4*/ v_add_u32       v2, s[2:3], v2, 1
/*0000000008ac*/ v_cmp_ge_u32    s[2:3], v4, s0
/*0000000008b4*/ v_cmp_ge_u32    s[4:5], v3, s1
/*0000000008bc*/ v_cmp_eq_i32    vcc, s1, v3
/*0000000008c0*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008c8*/ v_cndmask_b32   v4, 0, -1, s[2:3]
/*0000000008d0*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008d4*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008d8*/ s_cbranch_vccz  .L2276_15
/*0000000008dc*/ v_add_u32       v2, s[2:3], v2, 1
.L2276_15:
/*0000000008e4*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000008ec*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008f0*/ s_branch        .L2300_15
.L2292_15:
/*0000000008f4*/ s_waitcnt       lgkmcnt(0)
/*0000000008f8*/ v_mov_b32       v2, s2
.L2300_15:
/*0000000008fc*/ flat_store_dword v[0:1], v2
/*000000000904*/ s_endpgm
.kernel div_get_num_groups_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dword    s4, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[14:15], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s5, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s5, s5, s0
/*00000000002c*/ v_add_u32       v3, vcc, s5, v0
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000003c*/ s_lshr_b32      s5, s12, 1
/*000000000040*/ s_lshr_b32      s8, s13, 1
/*000000000044*/ s_lshr_b32      s4, s4, 2
/*000000000048*/ v_add_u32       v0, s[12:13], s14, v3
/*000000000050*/ s_cmp_eq_u64    1, s[0:1]
/*000000000054*/ s_cbranch_scc1  .L776_16
/*000000000058*/ v_cvt_f32_u32   v3, s0
/*00000000005c*/ v_cvt_f32_u32   v5, s1
/*000000000060*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000068*/ v_rcp_f32       v3, v3
/*00000000006c*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000074*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*00000000007c*/ v_trunc_f32     v5, v5
/*000000000080*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000088*/ v_cvt_u32_f32   v3, v3
/*00000000008c*/ v_cvt_u32_f32   v5, v5
/*000000000090*/ v_sub_u32       v6, vcc, 0, s0
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*0000000000a0*/ v_mul_lo_u32    v8, v6, v5
/*0000000000a8*/ v_mul_lo_u32    v9, v7, v3
/*0000000000b0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000b4*/ v_mul_hi_u32    v9, v6, v3
/*0000000000bc*/ v_add_u32       v8, vcc, v8, v9
/*0000000000c0*/ v_mul_lo_u32    v9, v6, v3
/*0000000000c8*/ v_mul_hi_u32    v10, v3, v9
/*0000000000d0*/ v_mul_lo_u32    v11, v5, v9
/*0000000000d8*/ v_add_u32       v10, vcc, v10, v11
/*0000000000dc*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000e4*/ v_mul_lo_u32    v12, v3, v8
/*0000000000ec*/ v_add_u32       v10, vcc, v10, v12
/*0000000000f0*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000f8*/ v_mul_hi_u32    v9, v5, v9
/*000000000100*/ v_add_u32       v9, vcc, v10, v9
/*000000000104*/ v_cndmask_b32   v10, 0, 1, vcc
/*00000000010c*/ v_mul_hi_u32    v11, v3, v8
/*000000000114*/ v_add_u32       v9, vcc, v9, v11
/*000000000118*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000120*/ v_mul_lo_u32    v11, v5, v8
/*000000000128*/ v_add_u32       v9, vcc, v9, v11
/*00000000012c*/ v_mul_hi_u32    v8, v5, v8
/*000000000134*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*000000000138*/ v_add_u32       v3, s[16:17], v3, v9
/*000000000140*/ v_add_u32       v9, vcc, v5, v8
/*000000000144*/ v_addc_u32      v5, vcc, v5, v8, s[16:17]
/*00000000014c*/ v_mul_lo_u32    v8, v6, v5
/*000000000154*/ v_mul_lo_u32    v7, v7, v3
/*00000000015c*/ v_add_u32       v7, vcc, v8, v7
/*000000000160*/ v_mul_hi_u32    v8, v6, v3
/*000000000168*/ v_add_u32       v7, vcc, v7, v8
/*00000000016c*/ v_mul_lo_u32    v6, v6, v3
/*000000000174*/ v_mul_hi_u32    v8, v3, v6
/*00000000017c*/ v_mul_lo_u32    v10, v5, v6
/*000000000184*/ v_add_u32       v8, vcc, v8, v10
/*000000000188*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000190*/ v_mul_lo_u32    v11, v3, v7
/*000000000198*/ v_add_u32       v8, vcc, v8, v11
/*00000000019c*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*0000000001a4*/ v_mul_hi_u32    v6, v5, v6
/*0000000001ac*/ v_add_u32       v6, vcc, v8, v6
/*0000000001b0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000001b8*/ v_mul_hi_u32    v10, v3, v7
/*0000000001c0*/ v_add_u32       v6, vcc, v6, v10
/*0000000001c4*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001cc*/ v_mul_lo_u32    v10, v5, v7
/*0000000001d4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001d8*/ v_mul_hi_u32    v5, v5, v7
/*0000000001e0*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001e4*/ v_add_u32       v3, s[18:19], v3, v6
/*0000000001ec*/ v_addc_u32      v5, vcc, v9, v5, s[16:17]
/*0000000001f4*/ v_addc_u32      v5, vcc, v5, 0, s[18:19]
/*0000000001fc*/ v_mul_hi_u32    v3, s5, v3
/*000000000204*/ v_mul_lo_u32    v6, s5, v5
/*00000000020c*/ v_add_u32       v3, vcc, v3, v6
/*000000000210*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000218*/ v_mul_hi_u32    v5, s5, v5
/*000000000220*/ v_add_u32       v3, vcc, v3, v5
/*000000000224*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*00000000022c*/ v_add_u32       v5, vcc, 0, v5
/*000000000230*/ v_mul_lo_u32    v5, s0, v5
/*000000000238*/ v_mul_lo_u32    v6, s1, v3
/*000000000240*/ v_add_u32       v5, vcc, v5, v6
/*000000000244*/ v_mul_hi_u32    v6, s0, v3
/*00000000024c*/ v_add_u32       v5, vcc, v5, v6
/*000000000250*/ v_mul_lo_u32    v6, s0, v3
/*000000000258*/ v_sub_u32       v6, s[16:17], s5, v6
/*000000000260*/ v_subb_u32      v7, vcc, 0, v5, s[16:17]
/*000000000268*/ v_cmp_ge_u32    s[18:19], v6, s0
/*000000000270*/ v_cmp_ge_u32    s[20:21], v7, s1
/*000000000278*/ v_cmp_eq_i32    vcc, s1, v7
/*00000000027c*/ v_cndmask_b32   v7, 0, -1, s[20:21]
/*000000000284*/ v_cndmask_b32   v8, 0, -1, s[18:19]
/*00000000028c*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000290*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000294*/ s_cbranch_vccz  .L760_16
/*000000000298*/ v_sub_u32       v5, vcc, 0, v5
/*00000000029c*/ v_sub_u32       v6, s[18:19], v6, s0
/*0000000002a4*/ v_mov_b32       v7, s1
/*0000000002a8*/ v_subb_u32      v5, vcc, v5, v7, s[16:17]
/*0000000002b0*/ v_subb_u32      v5, vcc, v5, 0, s[18:19]
/*0000000002b8*/ v_add_u32       v3, s[16:17], v3, 1
/*0000000002c0*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000002c8*/ v_cmp_ge_u32    s[18:19], v5, s1
/*0000000002d0*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002d4*/ v_cndmask_b32   v5, 0, -1, s[18:19]
/*0000000002dc*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*0000000002e4*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002e8*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002ec*/ s_cbranch_vccz  .L760_16
/*0000000002f0*/ v_add_u32       v3, s[16:17], v3, 1
.L760_16:
/*0000000002f8*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*000000000300*/ v_cndmask_b32   v3, -1, v3, vcc
/*000000000304*/ s_branch        .L780_16
.L776_16:
/*000000000308*/ v_mov_b32       v3, s5
.L780_16:
/*00000000030c*/ s_lshl_b32      s0, s9, 1
/*000000000310*/ s_add_u32       s0, s0, s2
/*000000000314*/ v_add_u32       v5, vcc, s0, v1
/*000000000318*/ v_mov_b32       v1, s15
/*00000000031c*/ v_addc_u32      v1, vcc, v1, v4, s[12:13]
/*000000000324*/ flat_store_dword v[0:1], v3
/*00000000032c*/ s_load_dwordx2  s[0:1], s[6:7], 0x10
/*000000000334*/ v_mov_b32       v6, 0
/*000000000338*/ v_lshlrev_b64   v[0:1], 2, v[5:6]
/*000000000340*/ v_add_u32       v0, s[6:7], s14, v0
/*000000000348*/ s_cmp_eq_u64    1, s[2:3]
/*00000000034c*/ s_cbranch_scc1  .L1536_16
/*000000000350*/ v_cvt_f32_u32   v3, s2
/*000000000354*/ v_cvt_f32_u32   v4, s3
/*000000000358*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000360*/ v_rcp_f32       v3, v3
/*000000000364*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*00000000036c*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000374*/ v_trunc_f32     v4, v4
/*000000000378*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000380*/ v_cvt_u32_f32   v3, v3
/*000000000384*/ v_cvt_u32_f32   v4, v4
/*000000000388*/ v_sub_u32       v5, vcc, 0, s2
/*000000000390*/ v_mov_b32       v6, s3
/*000000000394*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000398*/ v_mul_lo_u32    v7, v5, v4
/*0000000003a0*/ v_mul_lo_u32    v8, v6, v3
/*0000000003a8*/ v_add_u32       v7, vcc, v7, v8
/*0000000003ac*/ v_mul_hi_u32    v8, v5, v3
/*0000000003b4*/ v_add_u32       v7, vcc, v7, v8
/*0000000003b8*/ v_mul_lo_u32    v8, v5, v3
/*0000000003c0*/ v_mul_hi_u32    v9, v3, v8
/*0000000003c8*/ v_mul_lo_u32    v10, v4, v8
/*0000000003d0*/ v_add_u32       v9, vcc, v9, v10
/*0000000003d4*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003dc*/ v_mul_lo_u32    v11, v3, v7
/*0000000003e4*/ v_add_u32       v9, vcc, v9, v11
/*0000000003e8*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003f0*/ v_mul_hi_u32    v8, v4, v8
/*0000000003f8*/ v_add_u32       v8, vcc, v9, v8
/*0000000003fc*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000404*/ v_mul_hi_u32    v10, v3, v7
/*00000000040c*/ v_add_u32       v8, vcc, v8, v10
/*000000000410*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000418*/ v_mul_lo_u32    v10, v4, v7
/*000000000420*/ v_add_u32       v8, vcc, v8, v10
/*000000000424*/ v_mul_hi_u32    v7, v4, v7
/*00000000042c*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*000000000430*/ v_add_u32       v3, s[12:13], v3, v8
/*000000000438*/ v_add_u32       v8, vcc, v4, v7
/*00000000043c*/ v_addc_u32      v4, vcc, v4, v7, s[12:13]
/*000000000444*/ v_mul_lo_u32    v7, v5, v4
/*00000000044c*/ v_mul_lo_u32    v6, v6, v3
/*000000000454*/ v_add_u32       v6, vcc, v7, v6
/*000000000458*/ v_mul_hi_u32    v7, v5, v3
/*000000000460*/ v_add_u32       v6, vcc, v6, v7
/*000000000464*/ v_mul_lo_u32    v5, v5, v3
/*00000000046c*/ v_mul_hi_u32    v7, v3, v5
/*000000000474*/ v_mul_lo_u32    v9, v4, v5
/*00000000047c*/ v_add_u32       v7, vcc, v7, v9
/*000000000480*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000488*/ v_mul_lo_u32    v10, v3, v6
/*000000000490*/ v_add_u32       v7, vcc, v7, v10
/*000000000494*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*00000000049c*/ v_mul_hi_u32    v5, v4, v5
/*0000000004a4*/ v_add_u32       v5, vcc, v7, v5
/*0000000004a8*/ v_cndmask_b32   v7, 0, 1, vcc
/*0000000004b0*/ v_mul_hi_u32    v9, v3, v6
/*0000000004b8*/ v_add_u32       v5, vcc, v5, v9
/*0000000004bc*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004c4*/ v_mul_lo_u32    v9, v4, v6
/*0000000004cc*/ v_add_u32       v5, vcc, v5, v9
/*0000000004d0*/ v_mul_hi_u32    v4, v4, v6
/*0000000004d8*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004dc*/ v_add_u32       v3, s[16:17], v3, v5
/*0000000004e4*/ v_addc_u32      v4, vcc, v8, v4, s[12:13]
/*0000000004ec*/ v_addc_u32      v4, vcc, v4, 0, s[16:17]
/*0000000004f4*/ v_mul_hi_u32    v3, s8, v3
/*0000000004fc*/ v_mul_lo_u32    v5, s8, v4
/*000000000504*/ v_add_u32       v3, vcc, v3, v5
/*000000000508*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000510*/ v_mul_hi_u32    v4, s8, v4
/*000000000518*/ v_add_u32       v3, vcc, v3, v4
/*00000000051c*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000524*/ v_add_u32       v4, vcc, 0, v4
/*000000000528*/ v_mul_lo_u32    v4, s2, v4
/*000000000530*/ v_mul_lo_u32    v5, s3, v3
/*000000000538*/ v_add_u32       v4, vcc, v4, v5
/*00000000053c*/ v_mul_hi_u32    v5, s2, v3
/*000000000544*/ v_add_u32       v4, vcc, v4, v5
/*000000000548*/ v_mul_lo_u32    v5, s2, v3
/*000000000550*/ v_sub_u32       v5, s[12:13], s8, v5
/*000000000558*/ v_subb_u32      v6, vcc, 0, v4, s[12:13]
/*000000000560*/ v_cmp_ge_u32    s[8:9], v5, s2
/*000000000568*/ v_cmp_ge_u32    s[16:17], v6, s3
/*000000000570*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000574*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*00000000057c*/ v_cndmask_b32   v7, 0, -1, s[8:9]
/*000000000584*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000588*/ v_cmp_lg_u32    vcc, 0, v6
/*00000000058c*/ s_cbranch_vccz  .L1520_16
/*000000000590*/ v_sub_u32       v4, vcc, 0, v4
/*000000000594*/ v_sub_u32       v5, s[8:9], v5, s2
/*00000000059c*/ v_mov_b32       v6, s3
/*0000000005a0*/ v_subb_u32      v4, vcc, v4, v6, s[12:13]
/*0000000005a8*/ v_subb_u32      v4, vcc, v4, 0, s[8:9]
/*0000000005b0*/ v_add_u32       v3, s[8:9], v3, 1
/*0000000005b8*/ v_cmp_ge_u32    s[8:9], v5, s2
/*0000000005c0*/ v_cmp_ge_u32    s[12:13], v4, s3
/*0000000005c8*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005cc*/ v_cndmask_b32   v4, 0, -1, s[12:13]
/*0000000005d4*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*0000000005dc*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005e0*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005e4*/ s_cbranch_vccz  .L1520_16
/*0000000005e8*/ v_add_u32       v3, s[8:9], v3, 1
.L1520_16:
/*0000000005f0*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005f8*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005fc*/ s_branch        .L1540_16
.L1536_16:
/*000000000600*/ v_mov_b32       v3, s8
.L1540_16:
/*000000000604*/ s_lshl_b32      s2, s10, 2
/*000000000608*/ s_waitcnt       lgkmcnt(0)
/*00000000060c*/ s_add_u32       s2, s2, s0
/*000000000610*/ v_add_u32       v2, vcc, s2, v2
/*000000000614*/ v_mov_b32       v4, s15
/*000000000618*/ v_addc_u32      v1, vcc, v4, v1, s[6:7]
/*000000000620*/ flat_store_dword v[0:1], v3
/*000000000628*/ v_mov_b32       v3, 0
/*00000000062c*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*000000000634*/ v_add_u32       v0, vcc, s14, v0
/*000000000638*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*00000000063c*/ s_cmp_eq_u64    1, s[0:1]
/*000000000640*/ s_cbranch_scc1  .L2292_16
/*000000000644*/ v_cvt_f32_u32   v2, s0
/*000000000648*/ v_cvt_f32_u32   v3, s1
/*00000000064c*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000654*/ v_rcp_f32       v2, v2
/*000000000658*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*000000000660*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*000000000668*/ v_trunc_f32     v3, v3
/*00000000066c*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000674*/ v_cvt_u32_f32   v2, v2
/*000000000678*/ v_cvt_u32_f32   v3, v3
/*00000000067c*/ v_sub_u32       v4, vcc, 0, s0
/*000000000684*/ v_mov_b32       v5, s1
/*000000000688*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*00000000068c*/ v_mul_lo_u32    v6, v4, v3
/*000000000694*/ v_mul_lo_u32    v7, v5, v2
/*00000000069c*/ v_add_u32       v6, vcc, v6, v7
/*0000000006a0*/ v_mul_hi_u32    v7, v4, v2
/*0000000006a8*/ v_add_u32       v6, vcc, v6, v7
/*0000000006ac*/ v_mul_lo_u32    v7, v4, v2
/*0000000006b4*/ v_mul_hi_u32    v8, v2, v7
/*0000000006bc*/ v_mul_lo_u32    v9, v3, v7
/*0000000006c4*/ v_add_u32       v8, vcc, v8, v9
/*0000000006c8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006d0*/ v_mul_lo_u32    v10, v2, v6
/*0000000006d8*/ v_add_u32       v8, vcc, v8, v10
/*0000000006dc*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006e4*/ v_mul_hi_u32    v7, v3, v7
/*0000000006ec*/ v_add_u32       v7, vcc, v8, v7
/*0000000006f0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006f8*/ v_mul_hi_u32    v9, v2, v6
/*000000000700*/ v_add_u32       v7, vcc, v7, v9
/*000000000704*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*00000000070c*/ v_mul_lo_u32    v9, v3, v6
/*000000000714*/ v_add_u32       v7, vcc, v7, v9
/*000000000718*/ v_mul_hi_u32    v6, v3, v6
/*000000000720*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000724*/ v_add_u32       v2, s[2:3], v2, v7
/*00000000072c*/ v_add_u32       v7, vcc, v3, v6
/*000000000730*/ v_addc_u32      v3, vcc, v3, v6, s[2:3]
/*000000000738*/ v_mul_lo_u32    v6, v4, v3
/*000000000740*/ v_mul_lo_u32    v5, v5, v2
/*000000000748*/ v_add_u32       v5, vcc, v6, v5
/*00000000074c*/ v_mul_hi_u32    v6, v4, v2
/*000000000754*/ v_add_u32       v5, vcc, v5, v6
/*000000000758*/ v_mul_lo_u32    v4, v4, v2
/*000000000760*/ v_mul_hi_u32    v6, v2, v4
/*000000000768*/ v_mul_lo_u32    v8, v3, v4
/*000000000770*/ v_add_u32       v6, vcc, v6, v8
/*000000000774*/ v_cndmask_b32   v8, 0, 1, vcc
/*00000000077c*/ v_mul_lo_u32    v9, v2, v5
/*000000000784*/ v_add_u32       v6, vcc, v6, v9
/*000000000788*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*000000000790*/ v_mul_hi_u32    v4, v3, v4
/*000000000798*/ v_add_u32       v4, vcc, v6, v4
/*00000000079c*/ v_cndmask_b32   v6, 0, 1, vcc
/*0000000007a4*/ v_mul_hi_u32    v8, v2, v5
/*0000000007ac*/ v_add_u32       v4, vcc, v4, v8
/*0000000007b0*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*0000000007b8*/ v_mul_lo_u32    v8, v3, v5
/*0000000007c0*/ v_add_u32       v4, vcc, v4, v8
/*0000000007c4*/ v_mul_hi_u32    v3, v3, v5
/*0000000007cc*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007d0*/ v_add_u32       v2, s[6:7], v2, v4
/*0000000007d8*/ v_addc_u32      v3, vcc, v7, v3, s[2:3]
/*0000000007e0*/ v_addc_u32      v3, vcc, v3, 0, s[6:7]
/*0000000007e8*/ v_mul_hi_u32    v2, s4, v2
/*0000000007f0*/ v_mul_lo_u32    v4, s4, v3
/*0000000007f8*/ v_add_u32       v2, vcc, v2, v4
/*0000000007fc*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*000000000804*/ v_mul_hi_u32    v3, s4, v3
/*00000000080c*/ v_add_u32       v2, vcc, v2, v3
/*000000000810*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000818*/ v_add_u32       v3, vcc, 0, v3
/*00000000081c*/ v_mul_lo_u32    v3, s0, v3
/*000000000824*/ v_mul_lo_u32    v4, s1, v2
/*00000000082c*/ v_add_u32       v3, vcc, v3, v4
/*000000000830*/ v_mul_hi_u32    v4, s0, v2
/*000000000838*/ v_add_u32       v3, vcc, v3, v4
/*00000000083c*/ v_mul_lo_u32    v4, s0, v2
/*000000000844*/ v_sub_u32       v4, s[2:3], s4, v4
/*00000000084c*/ v_subb_u32      v5, vcc, 0, v3, s[2:3]
/*000000000854*/ v_cmp_ge_u32    s[4:5], v4, s0
/*00000000085c*/ v_cmp_ge_u32    s[6:7], v5, s1
/*000000000864*/ v_cmp_eq_i32    vcc, s1, v5
/*000000000868*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*000000000870*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*000000000878*/ v_cndmask_b32   v5, v5, v6, vcc
/*00000000087c*/ v_cmp_lg_u32    vcc, 0, v5
/*000000000880*/ s_cbranch_vccz  .L2276_16
/*000000000884*/ v_sub_u32       v3, vcc, 0, v3
/*000000000888*/ v_sub_u32       v4, s[4:5], v4, s0
/*000000000890*/ v_mov_b32       v5, s1
/*000000000894*/ v_subb_u32      v3, vcc, v3, v5, s[2:3]
/*00000000089c*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*0000000008a4*/ v_add_u32       v2, s[2:3], v2, 1
/*0000000008ac*/ v_cmp_ge_u32    s[2:3], v4, s0
/*0000000008b4*/ v_cmp_ge_u32    s[4:5], v3, s1
/*0000000008bc*/ v_cmp_eq_i32    vcc, s1, v3
/*0000000008c0*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008c8*/ v_cndmask_b32   v4, 0, -1, s[2:3]
/*0000000008d0*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008d4*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008d8*/ s_cbranch_vccz  .L2276_16
/*0000000008dc*/ v_add_u32       v2, s[2:3], v2, 1
.L2276_16:
/*0000000008e4*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000008ec*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008f0*/ s_branch        .L2296_16
.L2292_16:
/*0000000008f4*/ v_mov_b32       v2, s4
.L2296_16:
/*0000000008f8*/ flat_store_dword v[0:1], v2
/*000000000900*/ s_endpgm
.kernel div_get_work_dim_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dword    s4, s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000018*/ s_lshl_b32      s5, s8, 1
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s5, s5, s0
/*000000000024*/ v_add_u32       v3, vcc, s5, v0
/*000000000028*/ v_mov_b32       v4, 0
/*00000000002c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000034*/ s_bfe_u32       s4, s4, 0x20010
/*00000000003c*/ v_add_u32       v0, s[14:15], s12, v3
/*000000000044*/ s_cmp_eq_u64    1, s[0:1]
/*000000000048*/ s_cbranch_scc1  .L764_17
/*00000000004c*/ v_cvt_f32_u32   v3, s0
/*000000000050*/ v_cvt_f32_u32   v5, s1
/*000000000054*/ v_madmk_f32     v3, v5, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000005c*/ v_rcp_f32       v3, v3
/*000000000060*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000068*/ v_mul_f32       v5, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000070*/ v_trunc_f32     v5, v5
/*000000000074*/ v_madmk_f32     v3, v5, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000007c*/ v_cvt_u32_f32   v3, v3
/*000000000080*/ v_cvt_u32_f32   v5, v5
/*000000000084*/ v_sub_u32       v6, vcc, 0, s0
/*00000000008c*/ v_mov_b32       v7, s1
/*000000000090*/ v_subb_u32      v7, vcc, 0, v7, vcc
/*000000000094*/ v_mul_lo_u32    v8, v6, v5
/*00000000009c*/ v_mul_lo_u32    v9, v7, v3
/*0000000000a4*/ v_add_u32       v8, vcc, v8, v9
/*0000000000a8*/ v_mul_hi_u32    v9, v6, v3
/*0000000000b0*/ v_add_u32       v8, vcc, v8, v9
/*0000000000b4*/ v_mul_lo_u32    v9, v6, v3
/*0000000000bc*/ v_mul_hi_u32    v10, v3, v9
/*0000000000c4*/ v_mul_lo_u32    v11, v5, v9
/*0000000000cc*/ v_add_u32       v10, vcc, v10, v11
/*0000000000d0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000000d8*/ v_mul_lo_u32    v12, v3, v8
/*0000000000e0*/ v_add_u32       v10, vcc, v10, v12
/*0000000000e4*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*0000000000ec*/ v_mul_hi_u32    v9, v5, v9
/*0000000000f4*/ v_add_u32       v9, vcc, v10, v9
/*0000000000f8*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000100*/ v_mul_hi_u32    v11, v3, v8
/*000000000108*/ v_add_u32       v9, vcc, v9, v11
/*00000000010c*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000114*/ v_mul_lo_u32    v11, v5, v8
/*00000000011c*/ v_add_u32       v9, vcc, v9, v11
/*000000000120*/ v_mul_hi_u32    v8, v5, v8
/*000000000128*/ v_addc_u32      v8, vcc, v10, v8, vcc
/*00000000012c*/ v_add_u32       v3, s[16:17], v3, v9
/*000000000134*/ v_add_u32       v9, vcc, v5, v8
/*000000000138*/ v_addc_u32      v5, vcc, v5, v8, s[16:17]
/*000000000140*/ v_mul_lo_u32    v8, v6, v5
/*000000000148*/ v_mul_lo_u32    v7, v7, v3
/*000000000150*/ v_add_u32       v7, vcc, v8, v7
/*000000000154*/ v_mul_hi_u32    v8, v6, v3
/*00000000015c*/ v_add_u32       v7, vcc, v7, v8
/*000000000160*/ v_mul_lo_u32    v6, v6, v3
/*000000000168*/ v_mul_hi_u32    v8, v3, v6
/*000000000170*/ v_mul_lo_u32    v10, v5, v6
/*000000000178*/ v_add_u32       v8, vcc, v8, v10
/*00000000017c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000184*/ v_mul_lo_u32    v11, v3, v7
/*00000000018c*/ v_add_u32       v8, vcc, v8, v11
/*000000000190*/ v_addc_u32      v8, vcc, v10, 0, vcc
/*000000000198*/ v_mul_hi_u32    v6, v5, v6
/*0000000001a0*/ v_add_u32       v6, vcc, v8, v6
/*0000000001a4*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000001ac*/ v_mul_hi_u32    v10, v3, v7
/*0000000001b4*/ v_add_u32       v6, vcc, v6, v10
/*0000000001b8*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000001c0*/ v_mul_lo_u32    v10, v5, v7
/*0000000001c8*/ v_add_u32       v6, vcc, v6, v10
/*0000000001cc*/ v_mul_hi_u32    v5, v5, v7
/*0000000001d4*/ v_addc_u32      v5, vcc, v8, v5, vcc
/*0000000001d8*/ v_add_u32       v3, s[18:19], v3, v6
/*0000000001e0*/ v_addc_u32      v5, vcc, v9, v5, s[16:17]
/*0000000001e8*/ v_addc_u32      v5, vcc, v5, 0, s[18:19]
/*0000000001f0*/ v_mul_hi_u32    v3, s4, v3
/*0000000001f8*/ v_mul_lo_u32    v6, s4, v5
/*000000000200*/ v_add_u32       v3, vcc, v3, v6
/*000000000204*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*00000000020c*/ v_mul_hi_u32    v5, s4, v5
/*000000000214*/ v_add_u32       v3, vcc, v3, v5
/*000000000218*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000220*/ v_add_u32       v5, vcc, 0, v5
/*000000000224*/ v_mul_lo_u32    v5, s0, v5
/*00000000022c*/ v_mul_lo_u32    v6, s1, v3
/*000000000234*/ v_add_u32       v5, vcc, v5, v6
/*000000000238*/ v_mul_hi_u32    v6, s0, v3
/*000000000240*/ v_add_u32       v5, vcc, v5, v6
/*000000000244*/ v_mul_lo_u32    v6, s0, v3
/*00000000024c*/ v_sub_u32       v6, s[16:17], s4, v6
/*000000000254*/ v_subb_u32      v7, vcc, 0, v5, s[16:17]
/*00000000025c*/ v_cmp_ge_u32    s[18:19], v6, s0
/*000000000264*/ v_cmp_ge_u32    s[20:21], v7, s1
/*00000000026c*/ v_cmp_eq_i32    vcc, s1, v7
/*000000000270*/ v_cndmask_b32   v7, 0, -1, s[20:21]
/*000000000278*/ v_cndmask_b32   v8, 0, -1, s[18:19]
/*000000000280*/ v_cndmask_b32   v7, v7, v8, vcc
/*000000000284*/ v_cmp_lg_u32    vcc, 0, v7
/*000000000288*/ s_cbranch_vccz  .L748_17
/*00000000028c*/ v_sub_u32       v5, vcc, 0, v5
/*000000000290*/ v_sub_u32       v6, s[18:19], v6, s0
/*000000000298*/ v_mov_b32       v7, s1
/*00000000029c*/ v_subb_u32      v5, vcc, v5, v7, s[16:17]
/*0000000002a4*/ v_subb_u32      v5, vcc, v5, 0, s[18:19]
/*0000000002ac*/ v_add_u32       v3, s[16:17], v3, 1
/*0000000002b4*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000002bc*/ v_cmp_ge_u32    s[18:19], v5, s1
/*0000000002c4*/ v_cmp_eq_i32    vcc, s1, v5
/*0000000002c8*/ v_cndmask_b32   v5, 0, -1, s[18:19]
/*0000000002d0*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*0000000002d8*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002dc*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002e0*/ s_cbranch_vccz  .L748_17
/*0000000002e4*/ v_add_u32       v3, s[16:17], v3, 1
.L748_17:
/*0000000002ec*/ v_cmp_lg_i64    vcc, 0, s[0:1]
/*0000000002f4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000002f8*/ s_branch        .L768_17
.L764_17:
/*0000000002fc*/ v_mov_b32       v3, s4
.L768_17:
/*000000000300*/ s_lshl_b32      s0, s9, 1
/*000000000304*/ s_add_u32       s0, s0, s2
/*000000000308*/ v_add_u32       v7, vcc, s0, v1
/*00000000030c*/ v_mov_b32       v6, s13
/*000000000310*/ v_addc_u32      v1, vcc, v6, v4, s[14:15]
/*000000000318*/ flat_store_dword v[0:1], v3
/*000000000320*/ v_mov_b32       v8, 0
/*000000000324*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000032c*/ v_add_u32       v0, vcc, s12, v0
/*000000000330*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000334*/ s_cmp_eq_u64    1, s[2:3]
/*000000000338*/ s_cbranch_scc1  .L1516_17
/*00000000033c*/ v_cvt_f32_u32   v3, s2
/*000000000340*/ v_cvt_f32_u32   v4, s3
/*000000000344*/ v_madmk_f32     v3, v4, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000034c*/ v_rcp_f32       v3, v3
/*000000000350*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*000000000358*/ v_mul_f32       v4, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000360*/ v_trunc_f32     v4, v4
/*000000000364*/ v_madmk_f32     v3, v4, 0xcf800000 /* -4.2949673e+9f */, v3
/*00000000036c*/ v_cvt_u32_f32   v3, v3
/*000000000370*/ v_cvt_u32_f32   v4, v4
/*000000000374*/ v_sub_u32       v5, vcc, 0, s2
/*00000000037c*/ v_mov_b32       v6, s3
/*000000000380*/ v_subb_u32      v6, vcc, 0, v6, vcc
/*000000000384*/ v_mul_lo_u32    v7, v5, v4
/*00000000038c*/ v_mul_lo_u32    v8, v6, v3
/*000000000394*/ v_add_u32       v7, vcc, v7, v8
/*000000000398*/ v_mul_hi_u32    v8, v5, v3
/*0000000003a0*/ v_add_u32       v7, vcc, v7, v8
/*0000000003a4*/ v_mul_lo_u32    v8, v5, v3
/*0000000003ac*/ v_mul_hi_u32    v9, v3, v8
/*0000000003b4*/ v_mul_lo_u32    v10, v4, v8
/*0000000003bc*/ v_add_u32       v9, vcc, v9, v10
/*0000000003c0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000003c8*/ v_mul_lo_u32    v11, v3, v7
/*0000000003d0*/ v_add_u32       v9, vcc, v9, v11
/*0000000003d4*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*0000000003dc*/ v_mul_hi_u32    v8, v4, v8
/*0000000003e4*/ v_add_u32       v8, vcc, v9, v8
/*0000000003e8*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000003f0*/ v_mul_hi_u32    v10, v3, v7
/*0000000003f8*/ v_add_u32       v8, vcc, v8, v10
/*0000000003fc*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000404*/ v_mul_lo_u32    v10, v4, v7
/*00000000040c*/ v_add_u32       v8, vcc, v8, v10
/*000000000410*/ v_mul_hi_u32    v7, v4, v7
/*000000000418*/ v_addc_u32      v7, vcc, v9, v7, vcc
/*00000000041c*/ v_add_u32       v3, s[0:1], v3, v8
/*000000000424*/ v_add_u32       v8, vcc, v4, v7
/*000000000428*/ v_addc_u32      v4, vcc, v4, v7, s[0:1]
/*000000000430*/ v_mul_lo_u32    v7, v5, v4
/*000000000438*/ v_mul_lo_u32    v6, v6, v3
/*000000000440*/ v_add_u32       v6, vcc, v7, v6
/*000000000444*/ v_mul_hi_u32    v7, v5, v3
/*00000000044c*/ v_add_u32       v6, vcc, v6, v7
/*000000000450*/ v_mul_lo_u32    v5, v5, v3
/*000000000458*/ v_mul_hi_u32    v7, v3, v5
/*000000000460*/ v_mul_lo_u32    v9, v4, v5
/*000000000468*/ v_add_u32       v7, vcc, v7, v9
/*00000000046c*/ v_cndmask_b32   v9, 0, 1, vcc
/*000000000474*/ v_mul_lo_u32    v10, v3, v6
/*00000000047c*/ v_add_u32       v7, vcc, v7, v10
/*000000000480*/ v_addc_u32      v7, vcc, v9, 0, vcc
/*000000000488*/ v_mul_hi_u32    v5, v4, v5
/*000000000490*/ v_add_u32       v5, vcc, v7, v5
/*000000000494*/ v_cndmask_b32   v7, 0, 1, vcc
/*00000000049c*/ v_mul_hi_u32    v9, v3, v6
/*0000000004a4*/ v_add_u32       v5, vcc, v5, v9
/*0000000004a8*/ v_addc_u32      v7, vcc, v7, 0, vcc
/*0000000004b0*/ v_mul_lo_u32    v9, v4, v6
/*0000000004b8*/ v_add_u32       v5, vcc, v5, v9
/*0000000004bc*/ v_mul_hi_u32    v4, v4, v6
/*0000000004c4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000004c8*/ v_add_u32       v3, s[8:9], v3, v5
/*0000000004d0*/ v_addc_u32      v4, vcc, v8, v4, s[0:1]
/*0000000004d8*/ v_addc_u32      v4, vcc, v4, 0, s[8:9]
/*0000000004e0*/ v_mul_hi_u32    v3, s4, v3
/*0000000004e8*/ v_mul_lo_u32    v5, s4, v4
/*0000000004f0*/ v_add_u32       v3, vcc, v3, v5
/*0000000004f4*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000004fc*/ v_mul_hi_u32    v4, s4, v4
/*000000000504*/ v_add_u32       v3, vcc, v3, v4
/*000000000508*/ v_addc_u32      v4, vcc, 0, 0, vcc
/*000000000510*/ v_add_u32       v4, vcc, 0, v4
/*000000000514*/ v_mul_lo_u32    v4, s2, v4
/*00000000051c*/ v_mul_lo_u32    v5, s3, v3
/*000000000524*/ v_add_u32       v4, vcc, v4, v5
/*000000000528*/ v_mul_hi_u32    v5, s2, v3
/*000000000530*/ v_add_u32       v4, vcc, v4, v5
/*000000000534*/ v_mul_lo_u32    v5, s2, v3
/*00000000053c*/ v_sub_u32       v5, s[0:1], s4, v5
/*000000000544*/ v_subb_u32      v6, vcc, 0, v4, s[0:1]
/*00000000054c*/ v_cmp_ge_u32    s[8:9], v5, s2
/*000000000554*/ v_cmp_ge_u32    s[14:15], v6, s3
/*00000000055c*/ v_cmp_eq_i32    vcc, s3, v6
/*000000000560*/ v_cndmask_b32   v6, 0, -1, s[14:15]
/*000000000568*/ v_cndmask_b32   v7, 0, -1, s[8:9]
/*000000000570*/ v_cndmask_b32   v6, v6, v7, vcc
/*000000000574*/ v_cmp_lg_u32    vcc, 0, v6
/*000000000578*/ s_cbranch_vccz  .L1500_17
/*00000000057c*/ v_sub_u32       v4, vcc, 0, v4
/*000000000580*/ v_sub_u32       v5, s[8:9], v5, s2
/*000000000588*/ v_mov_b32       v6, s3
/*00000000058c*/ v_subb_u32      v4, vcc, v4, v6, s[0:1]
/*000000000594*/ v_subb_u32      v4, vcc, v4, 0, s[8:9]
/*00000000059c*/ v_add_u32       v3, s[0:1], v3, 1
/*0000000005a4*/ v_cmp_ge_u32    s[0:1], v5, s2
/*0000000005ac*/ v_cmp_ge_u32    s[8:9], v4, s3
/*0000000005b4*/ v_cmp_eq_i32    vcc, s3, v4
/*0000000005b8*/ v_cndmask_b32   v4, 0, -1, s[8:9]
/*0000000005c0*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000005c8*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005cc*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005d0*/ s_cbranch_vccz  .L1500_17
/*0000000005d4*/ v_add_u32       v3, s[0:1], v3, 1
.L1500_17:
/*0000000005dc*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000005e4*/ v_cndmask_b32   v3, -1, v3, vcc
/*0000000005e8*/ s_branch        .L1520_17
.L1516_17:
/*0000000005ec*/ v_mov_b32       v3, s4
.L1520_17:
/*0000000005f0*/ s_lshl_b32      s0, s10, 2
/*0000000005f4*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*0000000005fc*/ flat_store_dword v[0:1], v3
/*000000000604*/ s_waitcnt       lgkmcnt(0)
/*000000000608*/ s_add_u32       s0, s0, s2
/*00000000060c*/ v_add_u32       v0, vcc, s0, v2
/*000000000610*/ v_mov_b32       v1, 0
/*000000000614*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000061c*/ v_add_u32       v0, vcc, s12, v0
/*000000000620*/ v_mov_b32       v2, s13
/*000000000624*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000628*/ s_cmp_eq_u64    1, s[2:3]
/*00000000062c*/ s_cbranch_scc1  .L2272_17
/*000000000630*/ v_cvt_f32_u32   v2, s2
/*000000000634*/ v_cvt_f32_u32   v3, s3
/*000000000638*/ v_madmk_f32     v2, v3, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000640*/ v_rcp_f32       v2, v2
/*000000000644*/ v_mul_f32       v2, 0x5f7ffffc /* 1.844674e+19f */, v2
/*00000000064c*/ v_mul_f32       v3, 0x2f800000 /* 2.32830644e-10f */, v2
/*000000000654*/ v_trunc_f32     v3, v3
/*000000000658*/ v_madmk_f32     v2, v3, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000660*/ v_cvt_u32_f32   v2, v2
/*000000000664*/ v_cvt_u32_f32   v3, v3
/*000000000668*/ v_sub_u32       v4, vcc, 0, s2
/*000000000670*/ v_mov_b32       v5, s3
/*000000000674*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000678*/ v_mul_lo_u32    v6, v4, v3
/*000000000680*/ v_mul_lo_u32    v7, v5, v2
/*000000000688*/ v_add_u32       v6, vcc, v6, v7
/*00000000068c*/ v_mul_hi_u32    v7, v4, v2
/*000000000694*/ v_add_u32       v6, vcc, v6, v7
/*000000000698*/ v_mul_lo_u32    v7, v4, v2
/*0000000006a0*/ v_mul_hi_u32    v8, v2, v7
/*0000000006a8*/ v_mul_lo_u32    v9, v3, v7
/*0000000006b0*/ v_add_u32       v8, vcc, v8, v9
/*0000000006b4*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000006bc*/ v_mul_lo_u32    v10, v2, v6
/*0000000006c4*/ v_add_u32       v8, vcc, v8, v10
/*0000000006c8*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000006d0*/ v_mul_hi_u32    v7, v3, v7
/*0000000006d8*/ v_add_u32       v7, vcc, v8, v7
/*0000000006dc*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000006e4*/ v_mul_hi_u32    v9, v2, v6
/*0000000006ec*/ v_add_u32       v7, vcc, v7, v9
/*0000000006f0*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000006f8*/ v_mul_lo_u32    v9, v3, v6
/*000000000700*/ v_add_u32       v7, vcc, v7, v9
/*000000000704*/ v_mul_hi_u32    v6, v3, v6
/*00000000070c*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000710*/ v_add_u32       v2, s[0:1], v2, v7
/*000000000718*/ v_add_u32       v7, vcc, v3, v6
/*00000000071c*/ v_addc_u32      v3, vcc, v3, v6, s[0:1]
/*000000000724*/ v_mul_lo_u32    v6, v4, v3
/*00000000072c*/ v_mul_lo_u32    v5, v5, v2
/*000000000734*/ v_add_u32       v5, vcc, v6, v5
/*000000000738*/ v_mul_hi_u32    v6, v4, v2
/*000000000740*/ v_add_u32       v5, vcc, v5, v6
/*000000000744*/ v_mul_lo_u32    v4, v4, v2
/*00000000074c*/ v_mul_hi_u32    v6, v2, v4
/*000000000754*/ v_mul_lo_u32    v8, v3, v4
/*00000000075c*/ v_add_u32       v6, vcc, v6, v8
/*000000000760*/ v_cndmask_b32   v8, 0, 1, vcc
/*000000000768*/ v_mul_lo_u32    v9, v2, v5
/*000000000770*/ v_add_u32       v6, vcc, v6, v9
/*000000000774*/ v_addc_u32      v6, vcc, v8, 0, vcc
/*00000000077c*/ v_mul_hi_u32    v4, v3, v4
/*000000000784*/ v_add_u32       v4, vcc, v6, v4
/*000000000788*/ v_cndmask_b32   v6, 0, 1, vcc
/*000000000790*/ v_mul_hi_u32    v8, v2, v5
/*000000000798*/ v_add_u32       v4, vcc, v4, v8
/*00000000079c*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*0000000007a4*/ v_mul_lo_u32    v8, v3, v5
/*0000000007ac*/ v_add_u32       v4, vcc, v4, v8
/*0000000007b0*/ v_mul_hi_u32    v3, v3, v5
/*0000000007b8*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*0000000007bc*/ v_add_u32       v2, s[6:7], v2, v4
/*0000000007c4*/ v_addc_u32      v3, vcc, v7, v3, s[0:1]
/*0000000007cc*/ v_addc_u32      v3, vcc, v3, 0, s[6:7]
/*0000000007d4*/ v_mul_hi_u32    v2, s4, v2
/*0000000007dc*/ v_mul_lo_u32    v4, s4, v3
/*0000000007e4*/ v_add_u32       v2, vcc, v2, v4
/*0000000007e8*/ v_addc_u32      v2, vcc, 0, 0, vcc
/*0000000007f0*/ v_mul_hi_u32    v3, s4, v3
/*0000000007f8*/ v_add_u32       v2, vcc, v2, v3
/*0000000007fc*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*000000000804*/ v_add_u32       v3, vcc, 0, v3
/*000000000808*/ v_mul_lo_u32    v3, s2, v3
/*000000000810*/ v_mul_lo_u32    v4, s3, v2
/*000000000818*/ v_add_u32       v3, vcc, v3, v4
/*00000000081c*/ v_mul_hi_u32    v4, s2, v2
/*000000000824*/ v_add_u32       v3, vcc, v3, v4
/*000000000828*/ v_mul_lo_u32    v4, s2, v2
/*000000000830*/ v_sub_u32       v4, s[0:1], s4, v4
/*000000000838*/ v_subb_u32      v5, vcc, 0, v3, s[0:1]
/*000000000840*/ v_cmp_ge_u32    s[4:5], v4, s2
/*000000000848*/ v_cmp_ge_u32    s[6:7], v5, s3
/*000000000850*/ v_cmp_eq_i32    vcc, s3, v5
/*000000000854*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*00000000085c*/ v_cndmask_b32   v6, 0, -1, s[4:5]
/*000000000864*/ v_cndmask_b32   v5, v5, v6, vcc
/*000000000868*/ v_cmp_lg_u32    vcc, 0, v5
/*00000000086c*/ s_cbranch_vccz  .L2256_17
/*000000000870*/ v_sub_u32       v3, vcc, 0, v3
/*000000000874*/ v_sub_u32       v4, s[4:5], v4, s2
/*00000000087c*/ v_mov_b32       v5, s3
/*000000000880*/ v_subb_u32      v3, vcc, v3, v5, s[0:1]
/*000000000888*/ v_subb_u32      v3, vcc, v3, 0, s[4:5]
/*000000000890*/ v_add_u32       v2, s[0:1], v2, 1
/*000000000898*/ v_cmp_ge_u32    s[0:1], v4, s2
/*0000000008a0*/ v_cmp_ge_u32    s[4:5], v3, s3
/*0000000008a8*/ v_cmp_eq_i32    vcc, s3, v3
/*0000000008ac*/ v_cndmask_b32   v3, 0, -1, s[4:5]
/*0000000008b4*/ v_cndmask_b32   v4, 0, -1, s[0:1]
/*0000000008bc*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008c0*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008c4*/ s_cbranch_vccz  .L2256_17
/*0000000008c8*/ v_add_u32       v2, s[0:1], v2, 1
.L2256_17:
/*0000000008d0*/ v_cmp_lg_i64    vcc, 0, s[2:3]
/*0000000008d8*/ v_cndmask_b32   v2, -1, v2, vcc
/*0000000008dc*/ s_branch        .L2276_17
.L2272_17:
/*0000000008e0*/ v_mov_b32       v2, s4
.L2276_17:
/*0000000008e4*/ flat_store_dword v[0:1], v2
/*0000000008ec*/ s_endpgm
.kernel div_x_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ v_mul_hi_u32    v6, v6, v3
/*00000000007c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000084*/ v_sub_u32       v8, vcc, 0, v10
/*000000000088*/ v_cmp_lg_i32    s[10:11], 0, v11
/*000000000090*/ s_load_dword    s9, s[4:5], 0x38
/*000000000098*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a0*/ v_cndmask_b32   v8, v8, v10, s[10:11]
/*0000000000a8*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b0*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000b4*/ v_add_u32       v3, vcc, v3, v6
/*0000000000b8*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000c0*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000c4*/ v_add_u32       v4, vcc, v4, v7
/*0000000000c8*/ s_waitcnt       lgkmcnt(0)
/*0000000000cc*/ v_mul_hi_u32    v3, v3, s9
/*0000000000d4*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000dc*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000e0*/ v_add_u32       v5, vcc, v5, v8
/*0000000000e4*/ s_nop           0x0
/*0000000000e8*/ v_mul_hi_u32    v4, v4, s9
/*0000000000f0*/ v_cndmask_b32   v5, v5, v6, s[10:11]
/*0000000000f8*/ v_mul_hi_u32    v5, v5, s9
/*000000000100*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000108*/ v_mul_lo_u32    v6, v3, v0
/*000000000110*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*000000000118*/ v_mul_lo_u32    v7, v4, v1
/*000000000120*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000128*/ v_mul_lo_u32    v8, v5, v2
/*000000000130*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000138*/ s_waitcnt       lgkmcnt(0)
/*00000000013c*/ s_lshl_b32      s1, s6, 4
/*000000000140*/ v_sub_u32       v9, vcc, s9, v6
/*000000000144*/ s_lshl_b32      s3, s7, 1
/*000000000148*/ v_cmp_ge_u32    s[6:7], s9, v6
/*000000000150*/ v_cmp_ge_u32    s[12:13], v9, v0
/*000000000158*/ s_add_u32       s0, s1, s0
/*00000000015c*/ v_sub_u32       v6, vcc, s9, v7
/*000000000160*/ s_lshl_b32      s1, s8, 1
/*000000000164*/ s_and_b64       s[12:13], s[6:7], s[12:13]
/*000000000168*/ v_add_u32       v9, vcc, s0, v0
/*00000000016c*/ v_cmp_ge_u32    s[14:15], s9, v7
/*000000000174*/ v_cmp_ge_u32    s[16:17], v6, v1
/*00000000017c*/ s_add_u32       s0, s3, s2
/*000000000180*/ v_sub_u32       v6, vcc, s9, v8
/*000000000184*/ v_addc_u32      v3, vcc, v3, 0, s[12:13]
/*00000000018c*/ s_and_b64       s[2:3], s[14:15], s[16:17]
/*000000000190*/ v_add_u32       v11, vcc, s0, v1
/*000000000194*/ v_cmp_ge_u32    s[8:9], s9, v8
/*00000000019c*/ v_cmp_ge_u32    s[12:13], v6, v2
/*0000000001a4*/ s_add_u32       s0, s1, s10
/*0000000001a8*/ v_addc_u32      v3, vcc, v3, -1, s[6:7]
/*0000000001b0*/ v_cmp_lg_i32    s[6:7], v0, 0
/*0000000001b8*/ v_mov_b32       v10, 0
/*0000000001bc*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001c4*/ v_addc_u32      v0, vcc, v4, 0, s[2:3]
/*0000000001cc*/ s_and_b64       s[2:3], s[8:9], s[12:13]
/*0000000001d0*/ v_add_u32       v13, vcc, s0, v2
/*0000000001d4*/ v_cndmask_b32   v3, -1, v3, s[6:7]
/*0000000001dc*/ v_add_u32       v15, vcc, s4, v8
/*0000000001e0*/ v_mov_b32       v8, s5
/*0000000001e4*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001e8*/ v_addc_u32      v0, vcc, v0, -1, s[14:15]
/*0000000001f0*/ v_cmp_lg_i32    s[0:1], v1, 0
/*0000000001f8*/ v_mov_b32       v12, 0
/*0000000001fc*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*000000000204*/ v_addc_u32      v1, vcc, v5, 0, s[2:3]
/*00000000020c*/ v_cndmask_b32   v0, -1, v0, s[0:1]
/*000000000214*/ v_add_u32       v5, vcc, s4, v10
/*000000000218*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*00000000021c*/ v_addc_u32      v1, vcc, v1, -1, s[8:9]
/*000000000224*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000228*/ v_mov_b32       v14, 0
/*00000000022c*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*000000000234*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000238*/ v_add_u32       v7, vcc, s4, v10
/*00000000023c*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000240*/ flat_store_dword v[15:16], v3
/*000000000248*/ flat_store_dword v[5:6], v0
/*000000000250*/ flat_store_dword v[7:8], v1
/*000000000258*/ s_endpgm
.kernel div_get_global_offset_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ v_mul_hi_u32    v6, v6, v3
/*00000000007c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000084*/ v_sub_u32       v8, vcc, 0, v10
/*000000000088*/ v_cmp_lg_i32    s[10:11], 0, v11
/*000000000090*/ s_load_dwordx2  s[12:13], s[4:5], 0x0
/*000000000098*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a0*/ v_cndmask_b32   v8, v8, v10, s[10:11]
/*0000000000a8*/ s_load_dwordx2  s[14:15], s[4:5], 0x8
/*0000000000b0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b8*/ s_load_dwordx2  s[16:17], s[4:5], 0x10
/*0000000000c0*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000c4*/ v_add_u32       v3, vcc, v3, v6
/*0000000000c8*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000d0*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000d4*/ v_add_u32       v4, vcc, v4, v7
/*0000000000d8*/ s_waitcnt       lgkmcnt(0)
/*0000000000dc*/ v_mul_hi_u32    v3, v3, s12
/*0000000000e4*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000ec*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000f0*/ v_add_u32       v5, vcc, v5, v8
/*0000000000f4*/ v_mul_hi_u32    v4, v4, s14
/*0000000000fc*/ v_cndmask_b32   v5, v5, v6, s[10:11]
/*000000000104*/ v_mul_hi_u32    v5, v5, s16
/*00000000010c*/ v_mul_lo_u32    v6, v3, v0
/*000000000114*/ v_mul_lo_u32    v7, v4, v1
/*00000000011c*/ v_mul_lo_u32    v8, v5, v2
/*000000000124*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*00000000012c*/ s_lshl_b32      s2, s6, 1
/*000000000130*/ v_sub_u32       v9, vcc, s12, v6
/*000000000134*/ s_lshl_b32      s3, s7, 4
/*000000000138*/ s_add_u32       s2, s2, s12
/*00000000013c*/ v_cmp_ge_u32    s[4:5], s12, v6
/*000000000144*/ v_cmp_ge_u32    s[6:7], v9, v0
/*00000000014c*/ v_sub_u32       v6, vcc, s14, v7
/*000000000150*/ s_lshl_b32      s8, s8, 1
/*000000000154*/ v_add_u32       v9, vcc, s2, v0
/*000000000158*/ s_and_b64       s[6:7], s[4:5], s[6:7]
/*00000000015c*/ v_cmp_ge_u32    s[10:11], s14, v7
/*000000000164*/ v_cmp_ge_u32    s[12:13], v6, v1
/*00000000016c*/ s_add_u32       s2, s3, s14
/*000000000170*/ v_sub_u32       v6, vcc, s16, v8
/*000000000174*/ v_addc_u32      v3, vcc, v3, 0, s[6:7]
/*00000000017c*/ s_and_b64       s[6:7], s[10:11], s[12:13]
/*000000000180*/ v_add_u32       v11, vcc, s2, v1
/*000000000184*/ v_cmp_ge_u32    s[2:3], s16, v8
/*00000000018c*/ v_cmp_ge_u32    s[12:13], v6, v2
/*000000000194*/ s_add_u32       s8, s8, s16
/*000000000198*/ v_addc_u32      v3, vcc, v3, -1, s[4:5]
/*0000000001a0*/ v_cmp_lg_i32    s[4:5], v0, 0
/*0000000001a8*/ v_mov_b32       v10, 0
/*0000000001ac*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001b4*/ v_addc_u32      v0, vcc, v4, 0, s[6:7]
/*0000000001bc*/ s_and_b64       s[6:7], s[2:3], s[12:13]
/*0000000001c0*/ v_add_u32       v13, vcc, s8, v2
/*0000000001c4*/ v_cndmask_b32   v3, -1, v3, s[4:5]
/*0000000001cc*/ s_waitcnt       lgkmcnt(0)
/*0000000001d0*/ v_add_u32       v15, vcc, s0, v8
/*0000000001d4*/ v_mov_b32       v8, s1
/*0000000001d8*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001dc*/ v_addc_u32      v0, vcc, v0, -1, s[10:11]
/*0000000001e4*/ v_cmp_lg_i32    s[4:5], v1, 0
/*0000000001ec*/ v_mov_b32       v12, 0
/*0000000001f0*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*0000000001f8*/ v_addc_u32      v1, vcc, v5, 0, s[6:7]
/*000000000200*/ v_cndmask_b32   v0, -1, v0, s[4:5]
/*000000000208*/ v_add_u32       v5, vcc, s0, v10
/*00000000020c*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*000000000210*/ v_addc_u32      v1, vcc, v1, -1, s[2:3]
/*000000000218*/ v_cmp_lg_i32    vcc, 0, v2
/*00000000021c*/ v_mov_b32       v14, 0
/*000000000220*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*000000000228*/ v_cndmask_b32   v1, -1, v1, vcc
/*00000000022c*/ v_add_u32       v7, vcc, s0, v10
/*000000000230*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000234*/ flat_store_dword v[15:16], v3
/*00000000023c*/ flat_store_dword v[5:6], v0
/*000000000244*/ flat_store_dword v[7:8], v1
/*00000000024c*/ s_endpgm
.kernel div_get_local_id_get_local_id
    .config
        .dims xyz
        .cws 8, 4, 2
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_get_group_id_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ v_mul_hi_u32    v6, v6, v3
/*00000000007c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000084*/ v_sub_u32       v8, vcc, 0, v10
/*000000000088*/ v_cmp_lg_i32    s[10:11], 0, v11
/*000000000090*/ v_mul_hi_u32    v7, v7, v4
/*000000000098*/ v_cndmask_b32   v8, v8, v10, s[10:11]
/*0000000000a0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000a8*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000ac*/ v_add_u32       v3, vcc, v3, v6
/*0000000000b0*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000b8*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000bc*/ v_add_u32       v4, vcc, v4, v7
/*0000000000c0*/ v_mul_hi_u32    v3, v3, s6
/*0000000000c8*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000d0*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000d4*/ v_add_u32       v5, vcc, v5, v8
/*0000000000d8*/ v_mul_hi_u32    v4, v4, s7
/*0000000000e0*/ v_cndmask_b32   v5, v5, v6, s[10:11]
/*0000000000e8*/ v_mul_hi_u32    v5, v5, s8
/*0000000000f0*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*0000000000f8*/ v_mul_lo_u32    v6, v3, v0
/*000000000100*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*000000000108*/ v_mul_lo_u32    v7, v4, v1
/*000000000110*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000118*/ v_mul_lo_u32    v8, v5, v2
/*000000000120*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000128*/ s_waitcnt       lgkmcnt(0)
/*00000000012c*/ s_lshl_b32      s1, s6, 1
/*000000000130*/ v_sub_u32       v9, vcc, s6, v6
/*000000000134*/ s_lshl_b32      s3, s7, 4
/*000000000138*/ s_add_u32       s0, s1, s0
/*00000000013c*/ v_cmp_ge_u32    s[12:13], s6, v6
/*000000000144*/ v_cmp_ge_u32    s[14:15], v9, v0
/*00000000014c*/ v_sub_u32       v6, vcc, s7, v7
/*000000000150*/ s_lshl_b32      s1, s8, 1
/*000000000154*/ v_add_u32       v9, vcc, s0, v0
/*000000000158*/ s_and_b64       s[14:15], s[12:13], s[14:15]
/*00000000015c*/ v_cmp_ge_u32    s[6:7], s7, v7
/*000000000164*/ v_cmp_ge_u32    s[16:17], v6, v1
/*00000000016c*/ s_add_u32       s0, s3, s2
/*000000000170*/ v_sub_u32       v6, vcc, s8, v8
/*000000000174*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*00000000017c*/ s_and_b64       s[2:3], s[6:7], s[16:17]
/*000000000180*/ v_add_u32       v11, vcc, s0, v1
/*000000000184*/ v_cmp_ge_u32    s[8:9], s8, v8
/*00000000018c*/ v_cmp_ge_u32    s[14:15], v6, v2
/*000000000194*/ s_add_u32       s0, s1, s10
/*000000000198*/ v_addc_u32      v3, vcc, v3, -1, s[12:13]
/*0000000001a0*/ v_cmp_lg_i32    s[10:11], v0, 0
/*0000000001a8*/ v_mov_b32       v10, 0
/*0000000001ac*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001b4*/ v_addc_u32      v0, vcc, v4, 0, s[2:3]
/*0000000001bc*/ s_and_b64       s[2:3], s[8:9], s[14:15]
/*0000000001c0*/ v_add_u32       v13, vcc, s0, v2
/*0000000001c4*/ v_cndmask_b32   v3, -1, v3, s[10:11]
/*0000000001cc*/ v_add_u32       v15, vcc, s4, v8
/*0000000001d0*/ v_mov_b32       v8, s5
/*0000000001d4*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001d8*/ v_addc_u32      v0, vcc, v0, -1, s[6:7]
/*0000000001e0*/ v_cmp_lg_i32    s[0:1], v1, 0
/*0000000001e8*/ v_mov_b32       v12, 0
/*0000000001ec*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*0000000001f4*/ v_addc_u32      v1, vcc, v5, 0, s[2:3]
/*0000000001fc*/ v_cndmask_b32   v0, -1, v0, s[0:1]
/*000000000204*/ v_add_u32       v5, vcc, s4, v10
/*000000000208*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*00000000020c*/ v_addc_u32      v1, vcc, v1, -1, s[8:9]
/*000000000214*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000218*/ v_mov_b32       v14, 0
/*00000000021c*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*000000000224*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000228*/ v_add_u32       v7, vcc, s4, v10
/*00000000022c*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000230*/ flat_store_dword v[15:16], v3
/*000000000238*/ flat_store_dword v[5:6], v0
/*000000000240*/ flat_store_dword v[7:8], v1
/*000000000248*/ s_endpgm
.kernel div_get_local_size_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 19
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0084
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ v_cvt_f32_u32   v3, v0
/*00000000000c*/ v_cvt_f32_u32   v4, v1
/*000000000010*/ v_rcp_f32       v5, v3
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ v_rcp_f32       v6, v4
/*000000000020*/ v_cvt_f32_u32   v7, v2
/*000000000024*/ v_rcp_f32       v8, v7
/*000000000028*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s1, s6, 1
/*000000000038*/ s_lshl_b32      s3, s7, 1
/*00000000003c*/ v_mul_f32       v5, 2.0, v5
/*000000000040*/ s_add_u32       s0, s1, s0
/*000000000044*/ s_lshl_b32      s1, s8, 2
/*000000000048*/ v_mul_f32       v6, 2.0, v6
/*00000000004c*/ v_trunc_f32     v5, v5
/*000000000050*/ v_add_u32       v11, vcc, s0, v0
/*000000000054*/ s_add_u32       s0, s3, s2
/*000000000058*/ v_trunc_f32     v6, v6
/*00000000005c*/ v_mad_f32       v9, -v5, v3, 2.0
/*000000000064*/ v_mul_f32       v8, 4.0, v8
/*000000000068*/ s_add_u32       s1, s1, s10
/*00000000006c*/ v_add_u32       v13, vcc, s0, v1
/*000000000070*/ v_mad_f32       v10, -v6, v4, 2.0
/*000000000078*/ v_cmp_ge_f32    s[2:3], abs(v9), abs(v3)
/*000000000080*/ v_trunc_f32     v3, v8
/*000000000084*/ v_cvt_u32_f32   v5, v5
/*000000000088*/ v_add_u32       v15, vcc, s1, v2
/*00000000008c*/ v_mov_b32       v12, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[11:12]
/*000000000098*/ v_cmp_ge_f32    s[0:1], abs(v10), abs(v4)
/*0000000000a0*/ v_mad_f32       v0, -v3, v7, 4.0
/*0000000000a8*/ v_cvt_u32_f32   v4, v6
/*0000000000ac*/ v_addc_u32      v5, vcc, v5, 0, s[2:3]
/*0000000000b4*/ v_add_u32       v17, vcc, s4, v8
/*0000000000b8*/ v_mov_b32       v8, s5
/*0000000000bc*/ v_addc_u32      v18, vcc, v8, v9, vcc
/*0000000000c0*/ v_mov_b32       v14, 0
/*0000000000c4*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*0000000000cc*/ v_cmp_ge_f32    s[2:3], abs(v0), abs(v7)
/*0000000000d4*/ v_addc_u32      v0, vcc, v4, 0, s[0:1]
/*0000000000dc*/ v_cvt_u32_f32   v1, v3
/*0000000000e0*/ v_add_u32       v3, vcc, s4, v10
/*0000000000e4*/ v_addc_u32      v4, vcc, v8, v11, vcc
/*0000000000e8*/ v_mov_b32       v16, 0
/*0000000000ec*/ v_lshlrev_b64   v[10:11], 2, v[15:16]
/*0000000000f4*/ v_addc_u32      v1, vcc, v1, 0, s[2:3]
/*0000000000fc*/ v_add_u32       v6, vcc, s4, v10
/*000000000100*/ v_addc_u32      v7, vcc, v8, v11, vcc
/*000000000104*/ flat_store_dword v[17:18], v5
/*00000000010c*/ flat_store_dword v[3:4], v0
/*000000000114*/ flat_store_dword v[6:7], v1
/*00000000011c*/ s_endpgm
.kernel div_get_global_id_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 18
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*00000000007c*/ v_mul_hi_u32    v6, v6, v3
/*000000000084*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*00000000008c*/ v_sub_u32       v8, vcc, 0, v10
/*000000000090*/ v_cmp_lg_i32    s[10:11], 0, v11
/*000000000098*/ s_load_dwordx2  s[16:17], s[4:5], 0x10
/*0000000000a0*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a8*/ v_cndmask_b32   v8, v8, v10, s[10:11]
/*0000000000b0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b8*/ s_lshl_b32      s6, s6, 1
/*0000000000bc*/ v_add_u32       v9, vcc, s6, v0
/*0000000000c0*/ s_lshl_b32      s6, s7, 1
/*0000000000c4*/ v_sub_u32       v10, vcc, v3, v6
/*0000000000c8*/ v_add_u32       v3, vcc, v3, v6
/*0000000000cc*/ s_lshl_b32      s7, s8, 2
/*0000000000d0*/ s_waitcnt       lgkmcnt(0)
/*0000000000d4*/ v_add_u32       v6, vcc, s12, v9
/*0000000000d8*/ v_cndmask_b32   v3, v3, v10, s[0:1]
/*0000000000e0*/ s_add_u32       s0, s6, s14
/*0000000000e4*/ v_sub_u32       v10, vcc, v4, v7
/*0000000000e8*/ v_add_u32       v4, vcc, v4, v7
/*0000000000ec*/ v_mul_hi_u32    v3, v3, v6
/*0000000000f4*/ v_add_u32       v14, vcc, s0, v1
/*0000000000f8*/ v_cndmask_b32   v4, v4, v10, s[2:3]
/*000000000100*/ s_add_u32       s0, s7, s16
/*000000000104*/ v_sub_u32       v10, vcc, v5, v8
/*000000000108*/ v_add_u32       v5, vcc, v5, v8
/*00000000010c*/ v_mul_hi_u32    v4, v4, v14
/*000000000114*/ v_add_u32       v16, vcc, s0, v2
/*000000000118*/ v_cndmask_b32   v5, v5, v10, s[10:11]
/*000000000120*/ v_mul_hi_u32    v5, v5, v16
/*000000000128*/ v_mul_lo_u32    v10, v3, v0
/*000000000130*/ v_mul_lo_u32    v11, v4, v1
/*000000000138*/ v_mul_lo_u32    v12, v5, v2
/*000000000140*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000148*/ v_sub_u32       v13, vcc, v6, v10
/*00000000014c*/ v_cmp_ge_u32    s[2:3], v6, v10
/*000000000154*/ v_cmp_ge_u32    s[4:5], v13, v0
/*00000000015c*/ v_sub_u32       v6, vcc, v14, v11
/*000000000160*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*000000000164*/ v_cmp_ge_u32    s[6:7], v14, v11
/*00000000016c*/ v_cmp_ge_u32    s[8:9], v6, v1
/*000000000174*/ v_sub_u32       v6, vcc, v16, v12
/*000000000178*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*000000000180*/ s_and_b64       s[4:5], s[6:7], s[8:9]
/*000000000184*/ v_cmp_ge_u32    s[8:9], v16, v12
/*00000000018c*/ v_cmp_ge_u32    s[10:11], v6, v2
/*000000000194*/ v_mov_b32       v10, 0
/*000000000198*/ v_lshlrev_b64   v[9:10], 2, v[9:10]
/*0000000001a0*/ v_addc_u32      v3, vcc, v3, -1, s[2:3]
/*0000000001a8*/ v_cmp_lg_i32    s[2:3], v0, 0
/*0000000001b0*/ v_addc_u32      v0, vcc, v4, 0, s[4:5]
/*0000000001b8*/ s_and_b64       s[4:5], s[8:9], s[10:11]
/*0000000001bc*/ s_waitcnt       lgkmcnt(0)
/*0000000001c0*/ v_add_u32       v8, vcc, s0, v9
/*0000000001c4*/ v_mov_b32       v6, s1
/*0000000001c8*/ v_addc_u32      v9, vcc, v6, v10, vcc
/*0000000001cc*/ v_cndmask_b32   v3, -1, v3, s[2:3]
/*0000000001d4*/ v_addc_u32      v0, vcc, v0, -1, s[6:7]
/*0000000001dc*/ v_cmp_lg_i32    s[2:3], v1, 0
/*0000000001e4*/ v_mov_b32       v15, 0
/*0000000001e8*/ v_lshlrev_b64   v[10:11], 2, v[14:15]
/*0000000001f0*/ v_addc_u32      v1, vcc, v5, 0, s[4:5]
/*0000000001f8*/ v_cndmask_b32   v0, -1, v0, s[2:3]
/*000000000200*/ v_add_u32       v4, vcc, s0, v10
/*000000000204*/ v_addc_u32      v5, vcc, v6, v11, vcc
/*000000000208*/ v_addc_u32      v1, vcc, v1, -1, s[8:9]
/*000000000210*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000214*/ v_mov_b32       v17, 0
/*000000000218*/ v_lshlrev_b64   v[10:11], 2, v[16:17]
/*000000000220*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000224*/ v_add_u32       v10, vcc, s0, v10
/*000000000228*/ v_addc_u32      v11, vcc, v6, v11, vcc
/*00000000022c*/ flat_store_dword v[8:9], v3
/*000000000234*/ flat_store_dword v[4:5], v0
/*00000000023c*/ flat_store_dword v[10:11], v1
/*000000000244*/ s_endpgm
.kernel div_get_global_size_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ v_mul_hi_u32    v6, v6, v3
/*00000000007c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000084*/ v_sub_u32       v8, vcc, 0, v10
/*000000000088*/ v_cmp_lg_i32    s[12:13], 0, v11
/*000000000090*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000098*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a0*/ v_cndmask_b32   v8, v8, v10, s[12:13]
/*0000000000a8*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b0*/ s_load_dword    s4, s[4:5], 0x14
/*0000000000b8*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000bc*/ v_add_u32       v3, vcc, v3, v6
/*0000000000c0*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000c8*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000cc*/ v_add_u32       v4, vcc, v4, v7
/*0000000000d0*/ s_waitcnt       lgkmcnt(0)
/*0000000000d4*/ v_mul_hi_u32    v3, v3, s14
/*0000000000dc*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000e4*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000e8*/ v_add_u32       v5, vcc, v5, v8
/*0000000000ec*/ s_nop           0x0
/*0000000000f0*/ v_mul_hi_u32    v4, v4, s15
/*0000000000f8*/ v_cndmask_b32   v5, v5, v6, s[12:13]
/*000000000100*/ v_mul_hi_u32    v5, v5, s4
/*000000000108*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000110*/ v_mul_lo_u32    v6, v3, v0
/*000000000118*/ s_load_dwordx2  s[2:3], s[6:7], 0x8
/*000000000120*/ v_mul_lo_u32    v7, v4, v1
/*000000000128*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000130*/ v_mul_lo_u32    v8, v5, v2
/*000000000138*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000140*/ s_waitcnt       lgkmcnt(0)
/*000000000144*/ s_lshl_b32      s1, s8, 4
/*000000000148*/ v_sub_u32       v9, vcc, s14, v6
/*00000000014c*/ s_lshl_b32      s3, s9, 1
/*000000000150*/ s_add_u32       s0, s1, s0
/*000000000154*/ v_cmp_ge_u32    s[8:9], s14, v6
/*00000000015c*/ v_cmp_ge_u32    s[16:17], v9, v0
/*000000000164*/ v_sub_u32       v6, vcc, s15, v7
/*000000000168*/ s_lshl_b32      s1, s10, 1
/*00000000016c*/ v_add_u32       v9, vcc, s0, v0
/*000000000170*/ s_and_b64       s[10:11], s[8:9], s[16:17]
/*000000000174*/ v_cmp_ge_u32    s[14:15], s15, v7
/*00000000017c*/ v_cmp_ge_u32    s[16:17], v6, v1
/*000000000184*/ s_add_u32       s0, s3, s2
/*000000000188*/ v_sub_u32       v6, vcc, s4, v8
/*00000000018c*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*000000000194*/ s_and_b64       s[2:3], s[14:15], s[16:17]
/*000000000198*/ v_add_u32       v11, vcc, s0, v1
/*00000000019c*/ v_cmp_ge_u32    s[4:5], s4, v8
/*0000000001a4*/ v_cmp_ge_u32    s[10:11], v6, v2
/*0000000001ac*/ s_add_u32       s0, s1, s12
/*0000000001b0*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000001b8*/ v_cmp_lg_i32    s[8:9], v0, 0
/*0000000001c0*/ v_mov_b32       v10, 0
/*0000000001c4*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001cc*/ v_addc_u32      v0, vcc, v4, 0, s[2:3]
/*0000000001d4*/ s_and_b64       s[2:3], s[4:5], s[10:11]
/*0000000001d8*/ v_add_u32       v13, vcc, s0, v2
/*0000000001dc*/ v_cndmask_b32   v3, -1, v3, s[8:9]
/*0000000001e4*/ v_add_u32       v15, vcc, s6, v8
/*0000000001e8*/ v_mov_b32       v8, s7
/*0000000001ec*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001f0*/ v_addc_u32      v0, vcc, v0, -1, s[14:15]
/*0000000001f8*/ v_cmp_lg_i32    s[0:1], v1, 0
/*000000000200*/ v_mov_b32       v12, 0
/*000000000204*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*00000000020c*/ v_addc_u32      v1, vcc, v5, 0, s[2:3]
/*000000000214*/ v_cndmask_b32   v0, -1, v0, s[0:1]
/*00000000021c*/ v_add_u32       v5, vcc, s6, v10
/*000000000220*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*000000000224*/ v_addc_u32      v1, vcc, v1, -1, s[4:5]
/*00000000022c*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000230*/ v_mov_b32       v14, 0
/*000000000234*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*00000000023c*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000240*/ v_add_u32       v7, vcc, s6, v10
/*000000000244*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000248*/ flat_store_dword v[15:16], v3
/*000000000250*/ flat_store_dword v[5:6], v0
/*000000000258*/ flat_store_dword v[7:8], v1
/*000000000260*/ s_endpgm
.kernel div_get_num_groups_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*00000000007c*/ v_mul_hi_u32    v6, v6, v3
/*000000000084*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*00000000008c*/ v_sub_u32       v8, vcc, 0, v10
/*000000000090*/ v_cmp_lg_i32    s[14:15], 0, v11
/*000000000098*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a0*/ v_cndmask_b32   v8, v8, v10, s[14:15]
/*0000000000a8*/ s_load_dword    s4, s[4:5], 0x14
/*0000000000b0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b8*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000bc*/ v_add_u32       v3, vcc, v3, v6
/*0000000000c0*/ s_waitcnt       lgkmcnt(0)
/*0000000000c4*/ s_lshr_b32      s5, s12, 1
/*0000000000c8*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000d0*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000d4*/ v_add_u32       v4, vcc, v4, v7
/*0000000000d8*/ s_lshr_b32      s0, s13, 1
/*0000000000dc*/ v_mul_hi_u32    v3, v3, s5
/*0000000000e4*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000ec*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000f0*/ v_add_u32       v5, vcc, v5, v8
/*0000000000f4*/ s_lshr_b32      s1, s4, 2
/*0000000000f8*/ v_mul_hi_u32    v4, v4, s0
/*000000000100*/ v_cndmask_b32   v5, v5, v6, s[14:15]
/*000000000108*/ v_mul_hi_u32    v5, v5, s1
/*000000000110*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000118*/ v_mul_lo_u32    v6, v3, v0
/*000000000120*/ s_load_dwordx2  s[12:13], s[6:7], 0x8
/*000000000128*/ v_mul_lo_u32    v7, v4, v1
/*000000000130*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000138*/ v_mul_lo_u32    v8, v5, v2
/*000000000140*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000148*/ s_waitcnt       lgkmcnt(0)
/*00000000014c*/ s_lshl_b32      s3, s8, 1
/*000000000150*/ v_sub_u32       v9, vcc, s5, v6
/*000000000154*/ s_lshl_b32      s4, s9, 1
/*000000000158*/ s_add_u32       s2, s3, s2
/*00000000015c*/ v_cmp_ge_u32    s[8:9], s5, v6
/*000000000164*/ v_cmp_ge_u32    s[16:17], v9, v0
/*00000000016c*/ v_sub_u32       v6, vcc, s0, v7
/*000000000170*/ s_lshl_b32      s3, s10, 2
/*000000000174*/ v_add_u32       v9, vcc, s2, v0
/*000000000178*/ s_and_b64       s[10:11], s[8:9], s[16:17]
/*00000000017c*/ v_cmp_ge_u32    s[16:17], s0, v7
/*000000000184*/ v_cmp_ge_u32    s[18:19], v6, v1
/*00000000018c*/ s_add_u32       s0, s4, s12
/*000000000190*/ v_sub_u32       v6, vcc, s1, v8
/*000000000194*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*00000000019c*/ s_and_b64       s[4:5], s[16:17], s[18:19]
/*0000000001a0*/ v_add_u32       v11, vcc, s0, v1
/*0000000001a4*/ v_cmp_ge_u32    s[0:1], s1, v8
/*0000000001ac*/ v_cmp_ge_u32    s[10:11], v6, v2
/*0000000001b4*/ s_add_u32       s2, s3, s14
/*0000000001b8*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000001c0*/ v_cmp_lg_i32    s[8:9], v0, 0
/*0000000001c8*/ v_mov_b32       v10, 0
/*0000000001cc*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001d4*/ v_addc_u32      v0, vcc, v4, 0, s[4:5]
/*0000000001dc*/ s_and_b64       s[4:5], s[0:1], s[10:11]
/*0000000001e0*/ v_add_u32       v13, vcc, s2, v2
/*0000000001e4*/ v_cndmask_b32   v3, -1, v3, s[8:9]
/*0000000001ec*/ v_add_u32       v15, vcc, s6, v8
/*0000000001f0*/ v_mov_b32       v8, s7
/*0000000001f4*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001f8*/ v_addc_u32      v0, vcc, v0, -1, s[16:17]
/*000000000200*/ v_cmp_lg_i32    s[2:3], v1, 0
/*000000000208*/ v_mov_b32       v12, 0
/*00000000020c*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*000000000214*/ v_addc_u32      v1, vcc, v5, 0, s[4:5]
/*00000000021c*/ v_cndmask_b32   v0, -1, v0, s[2:3]
/*000000000224*/ v_add_u32       v5, vcc, s6, v10
/*000000000228*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*00000000022c*/ v_addc_u32      v1, vcc, v1, -1, s[0:1]
/*000000000234*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000238*/ v_mov_b32       v14, 0
/*00000000023c*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*000000000244*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000248*/ v_add_u32       v7, vcc, s6, v10
/*00000000024c*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000250*/ flat_store_dword v[15:16], v3
/*000000000258*/ flat_store_dword v[5:6], v0
/*000000000260*/ flat_store_dword v[7:8], v1
/*000000000268*/ s_endpgm
.kernel div_get_work_dim_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ v_cvt_f32_u32   v3, v0
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, v1
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, v2
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, v0, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, v1, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, v2, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ s_load_dword    s4, s[4:5], 0x0
/*00000000007c*/ v_mul_hi_u32    v6, v6, v3
/*000000000084*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*00000000008c*/ v_sub_u32       v8, vcc, 0, v10
/*000000000090*/ v_cmp_lg_i32    s[12:13], 0, v11
/*000000000098*/ v_mul_hi_u32    v7, v7, v4
/*0000000000a0*/ v_cndmask_b32   v8, v8, v10, s[12:13]
/*0000000000a8*/ v_mul_hi_u32    v8, v8, v5
/*0000000000b0*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000b4*/ v_add_u32       v3, vcc, v3, v6
/*0000000000b8*/ s_waitcnt       lgkmcnt(0)
/*0000000000bc*/ s_bfe_u32       s4, s4, 0x20010
/*0000000000c4*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000cc*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000d0*/ v_add_u32       v4, vcc, v4, v7
/*0000000000d4*/ v_mul_hi_u32    v3, v3, s4
/*0000000000dc*/ v_cndmask_b32   v4, v4, v6, s[2:3]
/*0000000000e4*/ v_sub_u32       v6, vcc, v5, v8
/*0000000000e8*/ v_add_u32       v5, vcc, v5, v8
/*0000000000ec*/ s_nop           0x0
/*0000000000f0*/ v_mul_hi_u32    v4, v4, s4
/*0000000000f8*/ v_cndmask_b32   v5, v5, v6, s[12:13]
/*000000000100*/ v_mul_hi_u32    v5, v5, s4
/*000000000108*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000110*/ v_mul_lo_u32    v6, v3, v0
/*000000000118*/ s_load_dwordx2  s[2:3], s[6:7], 0x8
/*000000000120*/ v_mul_lo_u32    v7, v4, v1
/*000000000128*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000130*/ v_mul_lo_u32    v8, v5, v2
/*000000000138*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000140*/ s_waitcnt       lgkmcnt(0)
/*000000000144*/ s_lshl_b32      s1, s8, 1
/*000000000148*/ v_sub_u32       v9, vcc, s4, v6
/*00000000014c*/ s_lshl_b32      s3, s9, 1
/*000000000150*/ v_cmp_ge_u32    s[8:9], s4, v6
/*000000000158*/ v_cmp_ge_u32    s[14:15], v9, v0
/*000000000160*/ s_add_u32       s0, s1, s0
/*000000000164*/ v_sub_u32       v6, vcc, s4, v7
/*000000000168*/ s_lshl_b32      s1, s10, 2
/*00000000016c*/ s_and_b64       s[10:11], s[8:9], s[14:15]
/*000000000170*/ v_add_u32       v9, vcc, s0, v0
/*000000000174*/ v_cmp_ge_u32    s[14:15], s4, v7
/*00000000017c*/ v_cmp_ge_u32    s[16:17], v6, v1
/*000000000184*/ s_add_u32       s0, s3, s2
/*000000000188*/ v_sub_u32       v6, vcc, s4, v8
/*00000000018c*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*000000000194*/ s_and_b64       s[2:3], s[14:15], s[16:17]
/*000000000198*/ v_add_u32       v11, vcc, s0, v1
/*00000000019c*/ v_cmp_ge_u32    s[4:5], s4, v8
/*0000000001a4*/ v_cmp_ge_u32    s[10:11], v6, v2
/*0000000001ac*/ s_add_u32       s0, s1, s12
/*0000000001b0*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000001b8*/ v_cmp_lg_i32    s[8:9], v0, 0
/*0000000001c0*/ v_mov_b32       v10, 0
/*0000000001c4*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*0000000001cc*/ v_addc_u32      v0, vcc, v4, 0, s[2:3]
/*0000000001d4*/ s_and_b64       s[2:3], s[4:5], s[10:11]
/*0000000001d8*/ v_add_u32       v13, vcc, s0, v2
/*0000000001dc*/ v_cndmask_b32   v3, -1, v3, s[8:9]
/*0000000001e4*/ v_add_u32       v15, vcc, s6, v8
/*0000000001e8*/ v_mov_b32       v8, s7
/*0000000001ec*/ v_addc_u32      v16, vcc, v8, v9, vcc
/*0000000001f0*/ v_addc_u32      v0, vcc, v0, -1, s[14:15]
/*0000000001f8*/ v_cmp_lg_i32    s[0:1], v1, 0
/*000000000200*/ v_mov_b32       v12, 0
/*000000000204*/ v_lshlrev_b64   v[10:11], 2, v[11:12]
/*00000000020c*/ v_addc_u32      v1, vcc, v5, 0, s[2:3]
/*000000000214*/ v_cndmask_b32   v0, -1, v0, s[0:1]
/*00000000021c*/ v_add_u32       v5, vcc, s6, v10
/*000000000220*/ v_addc_u32      v6, vcc, v8, v11, vcc
/*000000000224*/ v_addc_u32      v1, vcc, v1, -1, s[4:5]
/*00000000022c*/ v_cmp_lg_i32    vcc, 0, v2
/*000000000230*/ v_mov_b32       v14, 0
/*000000000234*/ v_lshlrev_b64   v[10:11], 2, v[13:14]
/*00000000023c*/ v_cndmask_b32   v1, -1, v1, vcc
/*000000000240*/ v_add_u32       v7, vcc, s6, v10
/*000000000244*/ v_addc_u32      v8, vcc, v8, v11, vcc
/*000000000248*/ flat_store_dword v[15:16], v3
/*000000000250*/ flat_store_dword v[5:6], v0
/*000000000258*/ flat_store_dword v[7:8], v1
/*000000000260*/ s_endpgm
.kernel div_x_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 7
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[10:11], s[4:5], 0x8
/*000000000024*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s5, s6, 4
/*000000000034*/ s_lshl_b32      s9, s7, 1
/*000000000038*/ s_lshl_b32      s11, s8, 1
/*00000000003c*/ v_cvt_f32_u32   v3, s6
/*000000000040*/ v_rcp_f32       v3, v3
/*000000000044*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000004c*/ v_cvt_u32_f32   v5, v3
/*000000000050*/ v_mad_u64_u32   v[3:4], vcc, s6, v5, 0
/*000000000058*/ v_sub_u32       v6, vcc, 0, v3
/*00000000005c*/ v_cmp_lg_i32    s[12:13], 0, v4
/*000000000064*/ v_cndmask_b32   v3, v6, v3, s[12:13]
/*00000000006c*/ v_mul_hi_u32    v3, v3, v5
/*000000000074*/ v_sub_u32       v4, vcc, v5, v3
/*000000000078*/ v_add_u32       v3, vcc, v5, v3
/*00000000007c*/ v_cndmask_b32   v3, v3, v4, s[12:13]
/*000000000084*/ v_mul_hi_u32    v3, v3, s1
/*00000000008c*/ v_mul_lo_u32    v4, v3, s6
/*000000000094*/ v_sub_u32       v5, vcc, s1, v4
/*000000000098*/ v_cmp_ge_u32    s[12:13], s1, v4
/*0000000000a0*/ v_cmp_ge_u32    s[14:15], v5, s6
/*0000000000a8*/ s_and_b64       s[14:15], s[12:13], s[14:15]
/*0000000000ac*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*0000000000b4*/ v_addc_u32      v3, vcc, v3, -1, s[12:13]
/*0000000000bc*/ s_cmp_lg_i32    s6, 0
/*0000000000c0*/ s_cselect_b64   vcc, exec, 0
/*0000000000c4*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000c8*/ s_add_u32       s0, s5, s0
/*0000000000cc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d0*/ v_mov_b32       v4, 0
/*0000000000d4*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000dc*/ v_add_u32       v3, vcc, s2, v3
/*0000000000e0*/ v_mov_b32       v6, s3
/*0000000000e4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000e8*/ flat_store_dword v[3:4], v5
/*0000000000f0*/ v_cvt_f32_u32   v0, s7
/*0000000000f4*/ v_rcp_f32       v0, v0
/*0000000000f8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000100*/ v_cvt_u32_f32   v0, v0
/*000000000104*/ v_mad_u64_u32   v[3:4], vcc, s7, v0, 0
/*00000000010c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000110*/ v_cmp_lg_i32    s[12:13], 0, v4
/*000000000118*/ v_cndmask_b32   v3, v5, v3, s[12:13]
/*000000000120*/ v_mul_hi_u32    v3, v3, v0
/*000000000128*/ v_sub_u32       v4, vcc, v0, v3
/*00000000012c*/ v_add_u32       v0, vcc, v0, v3
/*000000000130*/ v_cndmask_b32   v0, v0, v4, s[12:13]
/*000000000138*/ v_mul_hi_u32    v0, v0, s1
/*000000000140*/ v_mul_lo_u32    v3, v0, s7
/*000000000148*/ v_sub_u32       v4, vcc, s1, v3
/*00000000014c*/ v_cmp_ge_u32    s[12:13], s1, v3
/*000000000154*/ v_cmp_ge_u32    s[14:15], v4, s7
/*00000000015c*/ s_and_b64       s[14:15], s[12:13], s[14:15]
/*000000000160*/ v_addc_u32      v0, vcc, v0, 0, s[14:15]
/*000000000168*/ v_addc_u32      v0, vcc, v0, -1, s[12:13]
/*000000000170*/ s_cmp_lg_i32    s7, 0
/*000000000174*/ s_cselect_b64   vcc, exec, 0
/*000000000178*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000017c*/ s_add_u32       s0, s9, s10
/*000000000180*/ v_add_u32       v0, vcc, s0, v1
/*000000000184*/ v_mov_b32       v1, 0
/*000000000188*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000190*/ v_add_u32       v0, vcc, s2, v0
/*000000000194*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000198*/ flat_store_dword v[0:1], v3
/*0000000001a0*/ v_cvt_f32_u32   v0, s8
/*0000000001a4*/ v_rcp_f32       v0, v0
/*0000000001a8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b0*/ v_cvt_u32_f32   v3, v0
/*0000000001b4*/ v_mad_u64_u32   v[0:1], vcc, s8, v3, 0
/*0000000001bc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c0*/ v_cmp_lg_i32    s[6:7], 0, v1
/*0000000001c8*/ v_cndmask_b32   v0, v4, v0, s[6:7]
/*0000000001d0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001d8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001dc*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e0*/ v_cndmask_b32   v0, v0, v1, s[6:7]
/*0000000001e8*/ v_mul_hi_u32    v0, v0, s1
/*0000000001f0*/ v_mul_lo_u32    v1, v0, s8
/*0000000001f8*/ v_sub_u32       v3, vcc, s1, v1
/*0000000001fc*/ v_cmp_ge_u32    s[0:1], s1, v1
/*000000000204*/ v_cmp_ge_u32    s[6:7], v3, s8
/*00000000020c*/ s_and_b64       s[6:7], s[0:1], s[6:7]
/*000000000210*/ v_addc_u32      v0, vcc, v0, 0, s[6:7]
/*000000000218*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000220*/ s_cmp_lg_i32    s8, 0
/*000000000224*/ s_cselect_b64   vcc, exec, 0
/*000000000228*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000022c*/ s_add_u32       s0, s11, s4
/*000000000230*/ v_add_u32       v0, vcc, s0, v2
/*000000000234*/ v_mov_b32       v1, 0
/*000000000238*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000240*/ v_add_u32       v0, vcc, s2, v0
/*000000000244*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000248*/ flat_store_dword v[0:1], v3
/*000000000250*/ s_endpgm
.kernel div_get_global_offset_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 20
        .vgprsnum 9
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[10:11], s[4:5], 0x8
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s6, 1
/*000000000028*/ s_lshl_b32      s5, s7, 4
/*00000000002c*/ s_lshl_b32      s9, s8, 1
/*000000000030*/ s_add_u32       s1, s1, s0
/*000000000034*/ v_add_u32       v7, vcc, s1, v0
/*000000000038*/ v_cvt_f32_u32   v3, s6
/*00000000003c*/ v_rcp_f32       v3, v3
/*000000000040*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000048*/ v_cvt_u32_f32   v5, v3
/*00000000004c*/ v_mad_u64_u32   v[3:4], vcc, s6, v5, 0
/*000000000054*/ v_sub_u32       v6, vcc, 0, v3
/*000000000058*/ v_cmp_lg_i32    s[12:13], 0, v4
/*000000000060*/ v_cndmask_b32   v3, v6, v3, s[12:13]
/*000000000068*/ v_mul_hi_u32    v3, v3, v5
/*000000000070*/ v_sub_u32       v4, vcc, v5, v3
/*000000000074*/ v_add_u32       v3, vcc, v5, v3
/*000000000078*/ v_cndmask_b32   v3, v3, v4, s[12:13]
/*000000000080*/ v_mul_hi_u32    v3, v3, s0
/*000000000088*/ v_mul_lo_u32    v4, v3, s6
/*000000000090*/ v_sub_u32       v5, vcc, s0, v4
/*000000000094*/ v_cmp_ge_u32    s[0:1], s0, v4
/*00000000009c*/ v_cmp_ge_u32    s[12:13], v5, s6
/*0000000000a4*/ s_and_b64       s[12:13], s[0:1], s[12:13]
/*0000000000a8*/ v_addc_u32      v3, vcc, v3, 0, s[12:13]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, -1, s[0:1]
/*0000000000b8*/ s_cmp_lg_i32    s6, 0
/*0000000000bc*/ s_cselect_b64   vcc, exec, 0
/*0000000000c0*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000c4*/ v_mov_b32       v8, 0
/*0000000000c8*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000d0*/ v_add_u32       v3, vcc, s2, v3
/*0000000000d4*/ v_mov_b32       v6, s3
/*0000000000d8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000dc*/ flat_store_dword v[3:4], v5
/*0000000000e4*/ v_cvt_f32_u32   v0, s7
/*0000000000e8*/ v_rcp_f32       v0, v0
/*0000000000ec*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000000f4*/ v_cvt_u32_f32   v0, v0
/*0000000000f8*/ v_mad_u64_u32   v[3:4], vcc, s7, v0, 0
/*000000000100*/ v_sub_u32       v5, vcc, 0, v3
/*000000000104*/ v_cmp_lg_i32    s[0:1], 0, v4
/*00000000010c*/ v_cndmask_b32   v3, v5, v3, s[0:1]
/*000000000114*/ v_mul_hi_u32    v3, v3, v0
/*00000000011c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000120*/ v_add_u32       v0, vcc, v0, v3
/*000000000124*/ v_cndmask_b32   v0, v0, v4, s[0:1]
/*00000000012c*/ v_mul_hi_u32    v0, v0, s10
/*000000000134*/ v_mul_lo_u32    v3, v0, s7
/*00000000013c*/ v_sub_u32       v4, vcc, s10, v3
/*000000000140*/ v_cmp_ge_u32    s[0:1], s10, v3
/*000000000148*/ v_cmp_ge_u32    s[12:13], v4, s7
/*000000000150*/ s_and_b64       s[12:13], s[0:1], s[12:13]
/*000000000154*/ v_addc_u32      v0, vcc, v0, 0, s[12:13]
/*00000000015c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000164*/ s_cmp_lg_i32    s7, 0
/*000000000168*/ s_cselect_b64   vcc, exec, 0
/*00000000016c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000170*/ s_add_u32       s0, s5, s10
/*000000000174*/ v_add_u32       v0, vcc, s0, v1
/*000000000178*/ v_mov_b32       v1, 0
/*00000000017c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000184*/ v_add_u32       v0, vcc, s2, v0
/*000000000188*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000018c*/ flat_store_dword v[0:1], v3
/*000000000194*/ v_cvt_f32_u32   v0, s8
/*000000000198*/ v_rcp_f32       v0, v0
/*00000000019c*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001a4*/ v_cvt_u32_f32   v3, v0
/*0000000001a8*/ v_mad_u64_u32   v[0:1], vcc, s8, v3, 0
/*0000000001b0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001b4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001bc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001c4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001cc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001d0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001d4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001dc*/ v_mul_hi_u32    v0, v0, s4
/*0000000001e4*/ v_mul_lo_u32    v1, v0, s8
/*0000000001ec*/ v_sub_u32       v3, vcc, s4, v1
/*0000000001f0*/ v_cmp_ge_u32    s[0:1], s4, v1
/*0000000001f8*/ v_cmp_ge_u32    s[6:7], v3, s8
/*000000000200*/ s_and_b64       s[6:7], s[0:1], s[6:7]
/*000000000204*/ v_addc_u32      v0, vcc, v0, 0, s[6:7]
/*00000000020c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000214*/ s_cmp_lg_i32    s8, 0
/*000000000218*/ s_cselect_b64   vcc, exec, 0
/*00000000021c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000220*/ s_add_u32       s0, s9, s4
/*000000000224*/ v_add_u32       v0, vcc, s0, v2
/*000000000228*/ v_mov_b32       v1, 0
/*00000000022c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000234*/ v_add_u32       v0, vcc, s2, v0
/*000000000238*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000023c*/ flat_store_dword v[0:1], v3
/*000000000244*/ s_endpgm
.kernel div_get_local_id_get_group_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 20
        .vgprsnum 8
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
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[10:11], s[4:5], 0x8
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s6, 3
/*000000000028*/ s_lshl_b32      s5, s7, 2
/*00000000002c*/ s_lshl_b32      s9, s8, 1
/*000000000030*/ s_add_u32       s0, s1, s0
/*000000000034*/ v_add_u32       v5, vcc, s0, v0
/*000000000038*/ v_cvt_f32_u32   v3, s6
/*00000000003c*/ v_rcp_f32       v3, v3
/*000000000040*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000048*/ v_cvt_u32_f32   v6, v3
/*00000000004c*/ v_mad_u64_u32   v[3:4], vcc, s6, v6, 0
/*000000000054*/ v_sub_u32       v7, vcc, 0, v3
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v4
/*000000000060*/ v_cndmask_b32   v3, v7, v3, s[0:1]
/*000000000068*/ v_mul_hi_u32    v3, v3, v6
/*000000000070*/ v_sub_u32       v4, vcc, v6, v3
/*000000000074*/ v_add_u32       v3, vcc, v6, v3
/*000000000078*/ v_cndmask_b32   v3, v3, v4, s[0:1]
/*000000000080*/ v_mul_hi_u32    v3, v3, v0
/*000000000088*/ v_mul_lo_u32    v4, v3, s6
/*000000000090*/ v_sub_u32       v6, vcc, v0, v4
/*000000000094*/ v_cmp_ge_u32    s[0:1], v0, v4
/*00000000009c*/ v_cmp_ge_u32    s[12:13], v6, s6
/*0000000000a4*/ s_and_b64       s[12:13], s[0:1], s[12:13]
/*0000000000a8*/ v_addc_u32      v0, vcc, v3, 0, s[12:13]
/*0000000000b0*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*0000000000b8*/ s_cmp_lg_i32    s6, 0
/*0000000000bc*/ s_cselect_b64   vcc, exec, 0
/*0000000000c0*/ v_cndmask_b32   v0, -1, v0, vcc
/*0000000000c4*/ v_mov_b32       v6, 0
/*0000000000c8*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*0000000000d0*/ v_add_u32       v3, vcc, s2, v3
/*0000000000d4*/ v_mov_b32       v5, s3
/*0000000000d8*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*0000000000dc*/ flat_store_dword v[3:4], v0
/*0000000000e4*/ v_cvt_f32_u32   v0, s7
/*0000000000e8*/ v_rcp_f32       v0, v0
/*0000000000ec*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000000f4*/ v_cvt_u32_f32   v0, v0
/*0000000000f8*/ v_mad_u64_u32   v[3:4], vcc, s7, v0, 0
/*000000000100*/ v_sub_u32       v6, vcc, 0, v3
/*000000000104*/ v_cmp_lg_i32    s[0:1], 0, v4
/*00000000010c*/ v_cndmask_b32   v3, v6, v3, s[0:1]
/*000000000114*/ v_mul_hi_u32    v3, v3, v0
/*00000000011c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000120*/ v_add_u32       v0, vcc, v0, v3
/*000000000124*/ v_cndmask_b32   v0, v0, v4, s[0:1]
/*00000000012c*/ v_mul_hi_u32    v0, v0, v1
/*000000000134*/ v_mul_lo_u32    v3, v0, s7
/*00000000013c*/ v_sub_u32       v4, vcc, v1, v3
/*000000000140*/ v_cmp_ge_u32    s[0:1], v1, v3
/*000000000148*/ v_cmp_ge_u32    s[12:13], v4, s7
/*000000000150*/ s_and_b64       s[12:13], s[0:1], s[12:13]
/*000000000154*/ v_addc_u32      v0, vcc, v0, 0, s[12:13]
/*00000000015c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000164*/ s_cmp_lg_i32    s7, 0
/*000000000168*/ s_cselect_b64   vcc, exec, 0
/*00000000016c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000170*/ s_add_u32       s0, s5, s10
/*000000000174*/ v_add_u32       v0, vcc, s0, v1
/*000000000178*/ v_mov_b32       v1, 0
/*00000000017c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000184*/ v_add_u32       v0, vcc, s2, v0
/*000000000188*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000018c*/ flat_store_dword v[0:1], v3
/*000000000194*/ v_cvt_f32_u32   v0, s8
/*000000000198*/ v_rcp_f32       v0, v0
/*00000000019c*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001a4*/ v_cvt_u32_f32   v3, v0
/*0000000001a8*/ v_mad_u64_u32   v[0:1], vcc, s8, v3, 0
/*0000000001b0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001b4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001bc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001c4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001cc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001d0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001d4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001dc*/ v_mul_hi_u32    v0, v0, v2
/*0000000001e4*/ v_mul_lo_u32    v1, v0, s8
/*0000000001ec*/ v_sub_u32       v3, vcc, v2, v1
/*0000000001f0*/ v_cmp_ge_u32    s[0:1], v2, v1
/*0000000001f8*/ v_cmp_ge_u32    s[6:7], v3, s8
/*000000000200*/ s_and_b64       s[6:7], s[0:1], s[6:7]
/*000000000204*/ v_addc_u32      v0, vcc, v0, 0, s[6:7]
/*00000000020c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000214*/ s_cmp_lg_i32    s8, 0
/*000000000218*/ s_cselect_b64   vcc, exec, 0
/*00000000021c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000220*/ s_add_u32       s0, s9, s4
/*000000000224*/ v_add_u32       v0, vcc, s0, v2
/*000000000228*/ v_mov_b32       v1, 0
/*00000000022c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000234*/ v_add_u32       v0, vcc, s2, v0
/*000000000238*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000023c*/ flat_store_dword v[0:1], v3
/*000000000244*/ s_endpgm
.kernel div_get_group_id_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_get_local_size_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 32
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0103
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ v_cvt_f32_u32   v3, s6
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, s7
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, s8
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, s6, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, s7, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, s8, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ v_mul_hi_u32    v6, v6, v3
/*00000000007c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000084*/ v_sub_u32       v8, vcc, 0, v10
/*000000000088*/ v_cmp_lg_i32    s[10:11], 0, v11
/*000000000090*/ v_mul_hi_u32    v7, v7, v4
/*000000000098*/ v_cndmask_b32   v8, v8, v10, s[10:11]
/*0000000000a0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000a8*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000ac*/ v_add_u32       v3, vcc, v3, v6
/*0000000000b0*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000b8*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000bc*/ v_add_u32       v4, vcc, v4, v7
/*0000000000c0*/ v_readfirstlane_b32 s0, v3
/*0000000000c4*/ v_cndmask_b32   v3, v4, v6, s[2:3]
/*0000000000cc*/ v_sub_u32       v4, vcc, v5, v8
/*0000000000d0*/ v_add_u32       v5, vcc, v5, v8
/*0000000000d4*/ v_readfirstlane_b32 s1, v3
/*0000000000d8*/ v_cndmask_b32   v3, v5, v4, s[10:11]
/*0000000000e0*/ v_readfirstlane_b32 s2, v3
/*0000000000e4*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*0000000000ec*/ s_lshr_b32      s0, s0, 31
/*0000000000f0*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*0000000000f8*/ s_mul_i32       s3, s0, s6
/*0000000000fc*/ s_lshr_b32      s1, s1, 31
/*000000000100*/ s_sub_u32       s9, 2, s3
/*000000000104*/ s_waitcnt       lgkmcnt(0)
/*000000000108*/ s_mul_i32       s11, s1, s7
/*00000000010c*/ s_lshr_b32      s2, s2, 30
/*000000000110*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000118*/ s_lshl_b32      s13, s6, 1
/*00000000011c*/ s_cmp_le_u32    s3, 2
/*000000000120*/ s_cselect_b64   s[16:17], exec, 0
/*000000000124*/ s_cmp_ge_u32    s9, s6
/*000000000128*/ s_cselect_b64   s[18:19], exec, 0
/*00000000012c*/ s_sub_u32       s3, 2, s11
/*000000000130*/ s_mul_i32       s9, s2, s8
/*000000000134*/ s_lshl_b32      s15, s7, 1
/*000000000138*/ s_add_u32       s12, s13, s12
/*00000000013c*/ s_cmp_le_u32    s11, 2
/*000000000140*/ s_cselect_b64   s[20:21], exec, 0
/*000000000144*/ s_cmp_ge_u32    s3, s7
/*000000000148*/ s_cselect_b64   s[22:23], exec, 0
/*00000000014c*/ s_sub_u32       s3, 4, s9
/*000000000150*/ s_lshl_b32      s11, s8, 2
/*000000000154*/ v_add_u32       v5, vcc, s12, v0
/*000000000158*/ s_add_u32       s12, s15, s14
/*00000000015c*/ s_and_b64       s[14:15], s[16:17], s[18:19]
/*000000000160*/ v_mov_b32       v3, s0
/*000000000164*/ s_cmp_le_u32    s9, 4
/*000000000168*/ s_cselect_b64   s[18:19], exec, 0
/*00000000016c*/ s_cmp_ge_u32    s3, s8
/*000000000170*/ s_cselect_b64   s[24:25], exec, 0
/*000000000174*/ v_add_u32       v8, vcc, s12, v1
/*000000000178*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*000000000180*/ s_cmp_lg_i32    s6, 0
/*000000000184*/ s_cselect_b64   s[12:13], exec, 0
/*000000000188*/ s_and_b64       s[14:15], s[20:21], s[22:23]
/*00000000018c*/ v_mov_b32       v4, s1
/*000000000190*/ s_add_u32       s0, s11, s10
/*000000000194*/ v_mov_b32       v6, 0
/*000000000198*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*0000000001a0*/ v_addc_u32      v0, vcc, v3, -1, s[16:17]
/*0000000001a8*/ v_addc_u32      v3, vcc, v4, 0, s[14:15]
/*0000000001b0*/ s_cmp_lg_i32    s7, 0
/*0000000001b4*/ s_cselect_b64   s[6:7], exec, 0
/*0000000001b8*/ v_add_u32       v10, vcc, s0, v2
/*0000000001bc*/ s_and_b64       s[0:1], s[18:19], s[24:25]
/*0000000001c0*/ v_mov_b32       v4, s2
/*0000000001c4*/ s_waitcnt       lgkmcnt(0)
/*0000000001c8*/ v_add_u32       v5, vcc, s4, v5
/*0000000001cc*/ v_mov_b32       v7, s5
/*0000000001d0*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*0000000001d4*/ v_cndmask_b32   v0, -1, v0, s[12:13]
/*0000000001dc*/ v_mov_b32       v9, 0
/*0000000001e0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000001e8*/ v_addc_u32      v1, vcc, v3, -1, s[20:21]
/*0000000001f0*/ v_addc_u32      v3, vcc, v4, 0, s[0:1]
/*0000000001f8*/ s_cmp_lg_i32    s8, 0
/*0000000001fc*/ s_cselect_b64   s[0:1], exec, 0
/*000000000200*/ v_add_u32       v12, vcc, s4, v8
/*000000000204*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000208*/ v_cndmask_b32   v1, -1, v1, s[6:7]
/*000000000210*/ v_mov_b32       v11, 0
/*000000000214*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*00000000021c*/ v_addc_u32      v2, vcc, v3, -1, s[18:19]
/*000000000224*/ v_add_u32       v3, vcc, s4, v9
/*000000000228*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*00000000022c*/ v_cndmask_b32   v2, -1, v2, s[0:1]
/*000000000234*/ flat_store_dword v[5:6], v0
/*00000000023c*/ flat_store_dword v[12:13], v1
/*000000000244*/ flat_store_dword v[3:4], v2
/*00000000024c*/ s_endpgm
.kernel div_get_global_id_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ v_cvt_f32_u32   v3, s6
/*000000000004*/ v_rcp_f32       v3, v3
/*000000000008*/ v_cvt_f32_u32   v4, s7
/*00000000000c*/ v_rcp_f32       v4, v4
/*000000000010*/ v_cvt_f32_u32   v5, s8
/*000000000014*/ v_rcp_f32       v5, v5
/*000000000018*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000020*/ v_cvt_u32_f32   v3, v3
/*000000000024*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000002c*/ v_mad_u64_u32   v[6:7], vcc, s6, v3, 0
/*000000000034*/ v_cvt_u32_f32   v4, v4
/*000000000038*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000040*/ v_mad_u64_u32   v[8:9], vcc, s7, v4, 0
/*000000000048*/ v_cvt_u32_f32   v5, v5
/*00000000004c*/ v_mad_u64_u32   v[10:11], vcc, s8, v5, 0
/*000000000054*/ v_sub_u32       v12, vcc, 0, v6
/*000000000058*/ v_cmp_lg_i32    s[0:1], 0, v7
/*000000000060*/ v_cndmask_b32   v6, v12, v6, s[0:1]
/*000000000068*/ v_sub_u32       v7, vcc, 0, v8
/*00000000006c*/ v_cmp_lg_i32    s[2:3], 0, v9
/*000000000074*/ s_load_dwordx2  s[10:11], s[4:5], 0x0
/*00000000007c*/ s_load_dwordx2  s[12:13], s[4:5], 0x8
/*000000000084*/ v_mul_hi_u32    v6, v6, v3
/*00000000008c*/ v_cndmask_b32   v7, v7, v8, s[2:3]
/*000000000094*/ v_sub_u32       v8, vcc, 0, v10
/*000000000098*/ v_cmp_lg_i32    s[14:15], 0, v11
/*0000000000a0*/ s_load_dwordx2  s[16:17], s[4:5], 0x10
/*0000000000a8*/ v_mul_hi_u32    v7, v7, v4
/*0000000000b0*/ v_cndmask_b32   v8, v8, v10, s[14:15]
/*0000000000b8*/ v_mul_hi_u32    v8, v8, v5
/*0000000000c0*/ s_lshl_b32      s9, s6, 1
/*0000000000c4*/ v_add_u32       v11, vcc, s9, v0
/*0000000000c8*/ s_lshl_b32      s9, s7, 1
/*0000000000cc*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000d0*/ v_add_u32       v3, vcc, v3, v6
/*0000000000d4*/ s_waitcnt       lgkmcnt(0)
/*0000000000d8*/ s_lshl_b32      s11, s8, 2
/*0000000000dc*/ v_add_u32       v6, vcc, s10, v11
/*0000000000e0*/ v_cndmask_b32   v3, v3, v9, s[0:1]
/*0000000000e8*/ s_add_u32       s0, s9, s12
/*0000000000ec*/ v_sub_u32       v9, vcc, v4, v7
/*0000000000f0*/ v_add_u32       v4, vcc, v4, v7
/*0000000000f4*/ v_mul_hi_u32    v3, v3, v6
/*0000000000fc*/ v_add_u32       v13, vcc, s0, v1
/*000000000100*/ v_cndmask_b32   v4, v4, v9, s[2:3]
/*000000000108*/ s_add_u32       s0, s11, s16
/*00000000010c*/ v_sub_u32       v7, vcc, v5, v8
/*000000000110*/ v_add_u32       v5, vcc, v5, v8
/*000000000114*/ v_mul_hi_u32    v4, v4, v13
/*00000000011c*/ v_add_u32       v15, vcc, s0, v2
/*000000000120*/ v_cndmask_b32   v5, v5, v7, s[14:15]
/*000000000128*/ v_mul_hi_u32    v5, v5, v15
/*000000000130*/ v_mul_lo_u32    v7, v3, s6
/*000000000138*/ v_mul_lo_u32    v8, v4, s7
/*000000000140*/ v_mul_lo_u32    v9, v5, s8
/*000000000148*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000150*/ v_sub_u32       v10, vcc, v6, v7
/*000000000154*/ v_cmp_ge_u32    s[2:3], v6, v7
/*00000000015c*/ v_cmp_ge_u32    s[4:5], v10, s6
/*000000000164*/ v_sub_u32       v6, vcc, v13, v8
/*000000000168*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*00000000016c*/ v_cmp_ge_u32    s[10:11], v13, v8
/*000000000174*/ v_cmp_ge_u32    s[12:13], v6, s7
/*00000000017c*/ v_sub_u32       v6, vcc, v15, v9
/*000000000180*/ v_addc_u32      v3, vcc, v3, 0, s[4:5]
/*000000000188*/ s_cmp_lg_i32    s6, 0
/*00000000018c*/ s_cselect_b64   s[4:5], exec, 0
/*000000000190*/ s_and_b64       s[12:13], s[10:11], s[12:13]
/*000000000194*/ v_cmp_ge_u32    s[14:15], v15, v9
/*00000000019c*/ v_cmp_ge_u32    s[16:17], v6, s8
/*0000000001a4*/ v_mov_b32       v12, 0
/*0000000001a8*/ v_lshlrev_b64   v[6:7], 2, v[11:12]
/*0000000001b0*/ v_addc_u32      v0, vcc, v3, -1, s[2:3]
/*0000000001b8*/ v_addc_u32      v3, vcc, v4, 0, s[12:13]
/*0000000001c0*/ s_cmp_lg_i32    s7, 0
/*0000000001c4*/ s_cselect_b64   s[2:3], exec, 0
/*0000000001c8*/ s_and_b64       s[6:7], s[14:15], s[16:17]
/*0000000001cc*/ s_waitcnt       lgkmcnt(0)
/*0000000001d0*/ v_add_u32       v11, vcc, s0, v6
/*0000000001d4*/ v_mov_b32       v6, s1
/*0000000001d8*/ v_addc_u32      v12, vcc, v6, v7, vcc
/*0000000001dc*/ v_cndmask_b32   v0, -1, v0, s[4:5]
/*0000000001e4*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000001ec*/ v_mov_b32       v14, 0
/*0000000001f0*/ v_lshlrev_b64   v[8:9], 2, v[13:14]
/*0000000001f8*/ v_addc_u32      v1, vcc, v5, 0, s[6:7]
/*000000000200*/ s_cmp_lg_i32    s8, 0
/*000000000204*/ s_cselect_b64   s[4:5], exec, 0
/*000000000208*/ v_cndmask_b32   v3, -1, v3, s[2:3]
/*000000000210*/ v_add_u32       v4, vcc, s0, v8
/*000000000214*/ v_addc_u32      v5, vcc, v6, v9, vcc
/*000000000218*/ v_addc_u32      v1, vcc, v1, -1, s[14:15]
/*000000000220*/ v_mov_b32       v16, 0
/*000000000224*/ v_lshlrev_b64   v[9:10], 2, v[15:16]
/*00000000022c*/ v_cndmask_b32   v1, -1, v1, s[4:5]
/*000000000234*/ v_add_u32       v7, vcc, s0, v9
/*000000000238*/ v_addc_u32      v8, vcc, v6, v10, vcc
/*00000000023c*/ flat_store_dword v[11:12], v0
/*000000000244*/ flat_store_dword v[4:5], v3
/*00000000024c*/ flat_store_dword v[7:8], v1
/*000000000254*/ s_endpgm
.kernel div_get_global_size_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_lshl_b32      s3, s8, 4
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ s_add_u32       s3, s3, s4
/*000000000044*/ v_add_u32       v7, vcc, s3, v0
/*000000000048*/ v_cvt_f32_u32   v3, s8
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v5, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s8, v5, 0
/*000000000064*/ v_sub_u32       v6, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000078*/ v_mul_hi_u32    v3, v3, v5
/*000000000080*/ v_sub_u32       v4, vcc, v5, v3
/*000000000084*/ v_add_u32       v3, vcc, v5, v3
/*000000000088*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*000000000090*/ v_mul_hi_u32    v3, v3, s0
/*000000000098*/ v_mul_lo_u32    v4, v3, s8
/*0000000000a0*/ v_sub_u32       v5, vcc, s0, v4
/*0000000000a4*/ v_cmp_ge_u32    s[16:17], s0, v4
/*0000000000ac*/ v_cmp_ge_u32    s[18:19], v5, s8
/*0000000000b4*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000c8*/ s_cmp_lg_i32    s8, 0
/*0000000000cc*/ s_cselect_b64   vcc, exec, 0
/*0000000000d0*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000d4*/ v_mov_b32       v8, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000e0*/ v_add_u32       v3, vcc, s12, v3
/*0000000000e4*/ v_mov_b32       v6, s13
/*0000000000e8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v5
/*0000000000f4*/ v_cvt_f32_u32   v0, s9
/*0000000000f8*/ v_rcp_f32       v0, v0
/*0000000000fc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000104*/ v_cvt_u32_f32   v0, v0
/*000000000108*/ v_mad_u64_u32   v[3:4], vcc, s9, v0, 0
/*000000000110*/ v_sub_u32       v5, vcc, 0, v3
/*000000000114*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000011c*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000124*/ v_mul_hi_u32    v3, v3, v0
/*00000000012c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000130*/ v_add_u32       v0, vcc, v0, v3
/*000000000134*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*00000000013c*/ v_mul_hi_u32    v0, v0, s1
/*000000000144*/ v_mul_lo_u32    v3, v0, s9
/*00000000014c*/ v_sub_u32       v4, vcc, s1, v3
/*000000000150*/ v_cmp_ge_u32    s[0:1], s1, v3
/*000000000158*/ v_cmp_ge_u32    s[16:17], v4, s9
/*000000000160*/ s_and_b64       s[16:17], s[0:1], s[16:17]
/*000000000164*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000174*/ s_cmp_lg_i32    s9, 0
/*000000000178*/ s_cselect_b64   vcc, exec, 0
/*00000000017c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000180*/ s_add_u32       s0, s5, s14
/*000000000184*/ v_add_u32       v0, vcc, s0, v1
/*000000000188*/ v_mov_b32       v1, 0
/*00000000018c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000194*/ v_add_u32       v0, vcc, s12, v0
/*000000000198*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000019c*/ flat_store_dword v[0:1], v3
/*0000000001a4*/ v_cvt_f32_u32   v0, s10
/*0000000001a8*/ v_rcp_f32       v0, v0
/*0000000001ac*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b4*/ v_cvt_u32_f32   v3, v0
/*0000000001b8*/ v_mad_u64_u32   v[0:1], vcc, s10, v3, 0
/*0000000001c0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001cc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001d4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001dc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001ec*/ v_mul_hi_u32    v0, v0, s2
/*0000000001f4*/ v_mul_lo_u32    v1, v0, s10
/*0000000001fc*/ v_sub_u32       v3, vcc, s2, v1
/*000000000200*/ v_cmp_ge_u32    s[0:1], s2, v1
/*000000000208*/ v_cmp_ge_u32    s[2:3], v3, s10
/*000000000210*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*000000000214*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000224*/ s_cmp_lg_i32    s10, 0
/*000000000228*/ s_cselect_b64   vcc, exec, 0
/*00000000022c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000230*/ s_add_u32       s0, s7, s6
/*000000000234*/ v_add_u32       v0, vcc, s0, v2
/*000000000238*/ v_mov_b32       v1, 0
/*00000000023c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000244*/ v_add_u32       v0, vcc, s12, v0
/*000000000248*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000024c*/ flat_store_dword v[0:1], v3
/*000000000254*/ s_endpgm
.kernel div_get_num_groups_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 1
/*000000000038*/ s_lshr_b32      s1, s1, 1
/*00000000003c*/ s_lshr_b32      s2, s2, 2
/*000000000040*/ s_lshl_b32      s3, s8, 1
/*000000000044*/ s_lshl_b32      s5, s9, 1
/*000000000048*/ s_lshl_b32      s7, s10, 2
/*00000000004c*/ s_add_u32       s3, s3, s4
/*000000000050*/ v_add_u32       v7, vcc, s3, v0
/*000000000054*/ v_cvt_f32_u32   v3, s8
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s8, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s0
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s8
/*0000000000ac*/ v_sub_u32       v5, vcc, s0, v4
/*0000000000b0*/ v_cmp_ge_u32    s[16:17], s0, v4
/*0000000000b8*/ v_cmp_ge_u32    s[18:19], v5, s8
/*0000000000c0*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000d4*/ s_cmp_lg_i32    s8, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ v_mov_b32       v8, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v6, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v5
/*000000000100*/ v_cvt_f32_u32   v0, s9
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s9, v0, 0
/*00000000011c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*000000000148*/ v_mul_hi_u32    v0, v0, s1
/*000000000150*/ v_mul_lo_u32    v3, v0, s9
/*000000000158*/ v_sub_u32       v4, vcc, s1, v3
/*00000000015c*/ v_cmp_ge_u32    s[0:1], s1, v3
/*000000000164*/ v_cmp_ge_u32    s[16:17], v4, s9
/*00000000016c*/ s_and_b64       s[16:17], s[0:1], s[16:17]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000180*/ s_cmp_lg_i32    s9, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s5, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s10
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s10, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, s2
/*000000000200*/ v_mul_lo_u32    v1, v0, s10
/*000000000208*/ v_sub_u32       v3, vcc, s2, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], s2, v1
/*000000000214*/ v_cmp_ge_u32    s[2:3], v3, s10
/*00000000021c*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s10, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s7, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_work_dim_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x8
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000034*/ s_lshl_b32      s1, s8, 1
/*000000000038*/ s_lshl_b32      s3, s9, 1
/*00000000003c*/ s_lshl_b32      s7, s10, 2
/*000000000040*/ v_cvt_f32_u32   v3, s8
/*000000000044*/ v_rcp_f32       v3, v3
/*000000000048*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000050*/ v_cvt_u32_f32   v5, v3
/*000000000054*/ v_mad_u64_u32   v[3:4], vcc, s8, v5, 0
/*00000000005c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000060*/ v_cmp_lg_i32    s[14:15], 0, v4
/*000000000068*/ v_cndmask_b32   v3, v6, v3, s[14:15]
/*000000000070*/ v_mul_hi_u32    v3, v3, v5
/*000000000078*/ v_sub_u32       v4, vcc, v5, v3
/*00000000007c*/ v_add_u32       v3, vcc, v5, v3
/*000000000080*/ v_cndmask_b32   v3, v3, v4, s[14:15]
/*000000000088*/ v_mul_hi_u32    v3, v3, s0
/*000000000090*/ v_mul_lo_u32    v4, v3, s8
/*000000000098*/ v_sub_u32       v5, vcc, s0, v4
/*00000000009c*/ v_cmp_ge_u32    s[14:15], s0, v4
/*0000000000a4*/ v_cmp_ge_u32    s[16:17], v5, s8
/*0000000000ac*/ s_and_b64       s[16:17], s[14:15], s[16:17]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, -1, s[14:15]
/*0000000000c0*/ s_cmp_lg_i32    s8, 0
/*0000000000c4*/ s_cselect_b64   vcc, exec, 0
/*0000000000c8*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000cc*/ s_add_u32       s1, s1, s2
/*0000000000d0*/ v_add_u32       v3, vcc, s1, v0
/*0000000000d4*/ v_mov_b32       v4, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e0*/ v_add_u32       v3, vcc, s4, v3
/*0000000000e4*/ v_mov_b32       v6, s5
/*0000000000e8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v5
/*0000000000f4*/ v_cvt_f32_u32   v0, s9
/*0000000000f8*/ v_rcp_f32       v0, v0
/*0000000000fc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000104*/ v_cvt_u32_f32   v0, v0
/*000000000108*/ v_mad_u64_u32   v[3:4], vcc, s9, v0, 0
/*000000000110*/ v_sub_u32       v5, vcc, 0, v3
/*000000000114*/ v_cmp_lg_i32    s[14:15], 0, v4
/*00000000011c*/ v_cndmask_b32   v3, v5, v3, s[14:15]
/*000000000124*/ v_mul_hi_u32    v3, v3, v0
/*00000000012c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000130*/ v_add_u32       v0, vcc, v0, v3
/*000000000134*/ v_cndmask_b32   v0, v0, v4, s[14:15]
/*00000000013c*/ v_mul_hi_u32    v0, v0, s0
/*000000000144*/ v_mul_lo_u32    v3, v0, s9
/*00000000014c*/ v_sub_u32       v4, vcc, s0, v3
/*000000000150*/ v_cmp_ge_u32    s[14:15], s0, v3
/*000000000158*/ v_cmp_ge_u32    s[16:17], v4, s9
/*000000000160*/ s_and_b64       s[16:17], s[14:15], s[16:17]
/*000000000164*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, -1, s[14:15]
/*000000000174*/ s_cmp_lg_i32    s9, 0
/*000000000178*/ s_cselect_b64   vcc, exec, 0
/*00000000017c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000180*/ s_add_u32       s1, s3, s12
/*000000000184*/ v_add_u32       v0, vcc, s1, v1
/*000000000188*/ v_mov_b32       v1, 0
/*00000000018c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000194*/ v_add_u32       v0, vcc, s4, v0
/*000000000198*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000019c*/ flat_store_dword v[0:1], v3
/*0000000001a4*/ v_cvt_f32_u32   v0, s10
/*0000000001a8*/ v_rcp_f32       v0, v0
/*0000000001ac*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b4*/ v_cvt_u32_f32   v3, v0
/*0000000001b8*/ v_mad_u64_u32   v[0:1], vcc, s10, v3, 0
/*0000000001c0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c4*/ v_cmp_lg_i32    s[2:3], 0, v1
/*0000000001cc*/ v_cndmask_b32   v0, v4, v0, s[2:3]
/*0000000001d4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001dc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e4*/ v_cndmask_b32   v0, v0, v1, s[2:3]
/*0000000001ec*/ v_mul_hi_u32    v0, v0, s0
/*0000000001f4*/ v_mul_lo_u32    v1, v0, s10
/*0000000001fc*/ v_sub_u32       v3, vcc, s0, v1
/*000000000200*/ v_cmp_ge_u32    s[0:1], s0, v1
/*000000000208*/ v_cmp_ge_u32    s[2:3], v3, s10
/*000000000210*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*000000000214*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000224*/ s_cmp_lg_i32    s10, 0
/*000000000228*/ s_cselect_b64   vcc, exec, 0
/*00000000022c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000230*/ s_add_u32       s0, s7, s6
/*000000000234*/ v_add_u32       v0, vcc, s0, v2
/*000000000238*/ v_mov_b32       v1, 0
/*00000000023c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000244*/ v_add_u32       v0, vcc, s4, v0
/*000000000248*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000024c*/ flat_store_dword v[0:1], v3
/*000000000254*/ s_endpgm
.kernel div_x_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 20
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dword    s12, s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_ashr_i32      s13, s12, 31
/*000000000034*/ s_lshl_b32      s7, s8, 1
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s6, s2
/*000000000040*/ v_add_u32       v6, vcc, s0, v1
/*000000000044*/ s_lshr_b64      s[2:3], s[12:13], 4
/*000000000048*/ s_add_u32       s3, s7, s10
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ s_lshr_b64      s[0:1], s[12:13], 1
/*00000000005c*/ v_add_u32       v8, vcc, s3, v2
/*000000000060*/ v_add_u32       v10, vcc, s4, v3
/*000000000064*/ v_mov_b32       v3, s5
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s2
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ v_mov_b32       v9, 0
/*00000000008c*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000094*/ v_add_u32       v8, vcc, s4, v8
/*000000000098*/ v_addc_u32      v9, vcc, v3, v9, vcc
/*00000000009c*/ flat_store_dword v[10:11], v5
/*0000000000a4*/ flat_store_dword v[1:2], v7
/*0000000000ac*/ flat_store_dword v[8:9], v7
/*0000000000b4*/ s_endpgm
.kernel div_get_global_offset_get_local_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s1, v1
/*000000000038*/ s_add_u32       s1, s6, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ s_lshr_b32      s0, s0, 1
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_lshr_b32      s0, s2, 4
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_lshr_b32      s0, s10, 1
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel div_get_local_id_get_local_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v5, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v6, 0
/*000000000040*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*000000000048*/ v_add_u32       v10, vcc, s0, v2
/*00000000004c*/ v_add_u32       v5, vcc, s4, v5
/*000000000050*/ v_mov_b32       v7, s5
/*000000000054*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000058*/ v_lshrrev_b32   v0, 3, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_lshrrev_b32   v1, 2, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_lshrrev_b32   v2, 1, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel div_get_group_id_get_local_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ s_lshr_b32      s1, s6, 1
/*00000000004c*/ v_add_u32       v8, vcc, s0, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_lshr_b32      s0, s7, 4
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_lshr_b32      s0, s8, 1
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel div_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_get_global_id_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0084
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ v_add_u32       v5, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ s_add_u32       s2, s3, s2
/*000000000030*/ v_add_u32       v10, vcc, s2, v1
/*000000000034*/ s_add_u32       s1, s1, s10
/*000000000038*/ v_mov_b32       v6, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000044*/ v_add_u32       v0, vcc, s0, v5
/*000000000048*/ v_add_u32       v13, vcc, s1, v2
/*00000000004c*/ v_add_u32       v3, vcc, s4, v3
/*000000000050*/ v_mov_b32       v5, s5
/*000000000054*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000058*/ v_lshrrev_b32   v0, 1, v0
/*00000000005c*/ v_mov_b32       v11, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000068*/ v_add_u32       v15, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v16, vcc, v5, v9, vcc
/*000000000070*/ v_lshrrev_b64   v[6:7], 1, v[10:11]
/*000000000078*/ v_mov_b32       v14, 0
/*00000000007c*/ v_lshlrev_b64   v[11:12], 2, v[13:14]
/*000000000084*/ v_add_u32       v1, vcc, s4, v11
/*000000000088*/ v_addc_u32      v2, vcc, v5, v12, vcc
/*00000000008c*/ v_lshrrev_b64   v[9:10], 2, v[13:14]
/*000000000094*/ flat_store_dword v[3:4], v0
/*00000000009c*/ flat_store_dword v[15:16], v6
/*0000000000a4*/ flat_store_dword v[1:2], v9
/*0000000000ac*/ s_endpgm
.kernel div_get_global_size_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s8, 4
/*000000000028*/ s_load_dword    s3, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s1, s0
/*000000000038*/ s_lshl_b32      s1, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s4, s2
/*000000000044*/ v_add_u32       v6, vcc, s0, v1
/*000000000048*/ s_add_u32       s0, s1, s12
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ s_lshr_b32      s1, s14, 4
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_lshr_b32      s0, s15, 1
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_lshr_b32      s0, s3, 1
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel div_get_num_groups_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x14
/*000000000024*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s6, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s6, s2
/*000000000044*/ s_lshr_b32      s2, s12, 1
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s14
/*000000000050*/ s_lshr_b32      s3, s13, 1
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ s_lshr_b32      s2, s2, 1
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_lshr_b32      s1, s3, 1
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_lshr_b32      s0, s0, 2
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel div_get_work_dim_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0083
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*00000000001c*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s9, 1
/*000000000030*/ s_add_u32       s0, s3, s0
/*000000000034*/ s_lshl_b32      s3, s10, 2
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s5, s2
/*000000000040*/ s_bfe_u32       s1, s1, 0x20010
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s4
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ s_lshr_b32      s2, s1, 1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s2
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v9, 0
/*00000000008c*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*000000000094*/ s_lshr_b32      s0, s1, 2
/*000000000098*/ v_add_u32       v12, vcc, s6, v7
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*0000000000a0*/ v_mov_b32       v7, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[12:13], v7
/*0000000000bc*/ s_endpgm
.kernel div_x_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 28
        .vgprsnum 18
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*000000000010*/ s_load_dword    s9, s[4:5], 0x38
/*000000000018*/ s_lshl_b32      s6, s6, 4
/*00000000001c*/ v_add_u32       v0, vcc, s6, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_add_u32       v3, vcc, s0, v0
/*000000000028*/ v_mov_b32       v4, 0
/*00000000002c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000034*/ v_add_u32       v3, s[12:13], s10, v3
/*00000000003c*/ v_add_u32       v6, vcc, v0, s0
/*000000000044*/ v_mov_b32       v5, s1
/*000000000048*/ v_addc_u32      v7, vcc, 0, v5, vcc
/*00000000004c*/ s_ashr_i32      s0, s9, 31
/*000000000050*/ v_cmp_lg_i64    vcc, 1, v[6:7]
/*000000000054*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000058*/ v_cvt_f32_u32   v8, v6
/*00000000005c*/ s_cbranch_execz .L832_45
/*000000000060*/ v_cvt_f32_u32   v9, v7
/*000000000064*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*00000000006c*/ v_rcp_f32       v8, v8
/*000000000070*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*000000000078*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000080*/ v_trunc_f32     v9, v9
/*000000000084*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*00000000008c*/ v_cvt_u32_f32   v8, v8
/*000000000090*/ v_cvt_u32_f32   v9, v9
/*000000000094*/ v_sub_u32       v10, vcc, 0, v6
/*000000000098*/ v_subb_u32      v11, vcc, 0, v7, vcc
/*00000000009c*/ v_mul_lo_u32    v12, v10, v9
/*0000000000a4*/ v_mul_lo_u32    v13, v11, v8
/*0000000000ac*/ v_add_u32       v12, vcc, v12, v13
/*0000000000b0*/ v_mul_hi_u32    v13, v10, v8
/*0000000000b8*/ v_add_u32       v12, vcc, v12, v13
/*0000000000bc*/ v_mul_lo_u32    v13, v10, v8
/*0000000000c4*/ v_mul_hi_u32    v14, v8, v13
/*0000000000cc*/ v_mul_lo_u32    v15, v9, v13
/*0000000000d4*/ v_add_u32       v14, vcc, v14, v15
/*0000000000d8*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000e0*/ v_mul_lo_u32    v16, v8, v12
/*0000000000e8*/ v_add_u32       v14, vcc, v14, v16
/*0000000000ec*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000f4*/ v_mul_hi_u32    v13, v9, v13
/*0000000000fc*/ v_add_u32       v13, vcc, v14, v13
/*000000000100*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000108*/ v_mul_hi_u32    v15, v8, v12
/*000000000110*/ v_add_u32       v13, vcc, v13, v15
/*000000000114*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*00000000011c*/ v_mul_lo_u32    v15, v9, v12
/*000000000124*/ v_add_u32       v13, vcc, v13, v15
/*000000000128*/ v_mul_hi_u32    v12, v9, v12
/*000000000130*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000134*/ v_add_u32       v8, s[16:17], v8, v13
/*00000000013c*/ v_add_u32       v13, vcc, v9, v12
/*000000000140*/ v_addc_u32      v9, vcc, v9, v12, s[16:17]
/*000000000148*/ v_mul_lo_u32    v12, v10, v9
/*000000000150*/ v_mul_lo_u32    v11, v11, v8
/*000000000158*/ v_add_u32       v11, vcc, v12, v11
/*00000000015c*/ v_mul_hi_u32    v12, v10, v8
/*000000000164*/ v_add_u32       v11, vcc, v11, v12
/*000000000168*/ v_mul_lo_u32    v10, v10, v8
/*000000000170*/ v_mul_hi_u32    v12, v8, v10
/*000000000178*/ v_mul_lo_u32    v14, v9, v10
/*000000000180*/ v_add_u32       v12, vcc, v12, v14
/*000000000184*/ v_cndmask_b32   v14, 0, 1, vcc
/*00000000018c*/ v_mul_lo_u32    v15, v8, v11
/*000000000194*/ v_add_u32       v12, vcc, v12, v15
/*000000000198*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*0000000001a0*/ v_mul_hi_u32    v10, v9, v10
/*0000000001a8*/ v_add_u32       v10, vcc, v12, v10
/*0000000001ac*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001b4*/ v_mul_hi_u32    v14, v8, v11
/*0000000001bc*/ v_add_u32       v10, vcc, v10, v14
/*0000000001c0*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001c8*/ v_mul_lo_u32    v14, v9, v11
/*0000000001d0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001d4*/ v_mul_hi_u32    v9, v9, v11
/*0000000001dc*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001e0*/ v_add_u32       v8, s[18:19], v8, v10
/*0000000001e8*/ v_addc_u32      v9, vcc, v13, v9, s[16:17]
/*0000000001f0*/ v_addc_u32      v9, vcc, v9, 0, s[18:19]
/*0000000001f8*/ v_mul_hi_u32    v10, s9, v8
/*000000000200*/ v_mul_lo_u32    v11, s0, v8
/*000000000208*/ v_add_u32       v10, vcc, v10, v11
/*00000000020c*/ v_cndmask_b32   v11, 0, 1, vcc
/*000000000214*/ v_mul_lo_u32    v12, s9, v9
/*00000000021c*/ v_add_u32       v10, vcc, v10, v12
/*000000000220*/ v_addc_u32      v10, vcc, v11, 0, vcc
/*000000000228*/ v_mul_hi_u32    v8, s0, v8
/*000000000230*/ v_add_u32       v8, vcc, v10, v8
/*000000000234*/ v_cndmask_b32   v10, 0, 1, vcc
/*00000000023c*/ v_mul_hi_u32    v11, s9, v9
/*000000000244*/ v_add_u32       v8, vcc, v8, v11
/*000000000248*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000250*/ v_mul_lo_u32    v11, s0, v9
/*000000000258*/ v_add_u32       v8, vcc, v8, v11
/*00000000025c*/ v_mul_hi_u32    v9, s0, v9
/*000000000264*/ v_addc_u32      v9, vcc, v10, v9, vcc
/*000000000268*/ v_mul_lo_u32    v9, v6, v9
/*000000000270*/ v_mul_lo_u32    v10, v7, v8
/*000000000278*/ v_add_u32       v9, vcc, v9, v10
/*00000000027c*/ v_mul_hi_u32    v10, v6, v8
/*000000000284*/ v_add_u32       v9, vcc, v9, v10
/*000000000288*/ v_mul_lo_u32    v10, v6, v8
/*000000000290*/ v_sub_u32       v10, s[16:17], s9, v10
/*000000000298*/ v_mov_b32       v11, s0
/*00000000029c*/ v_subb_u32      v11, vcc, v11, v9, s[16:17]
/*0000000002a4*/ v_cmp_ge_u32    s[18:19], v10, v6
/*0000000002ac*/ v_cmp_ge_u32    s[20:21], v11, v7
/*0000000002b4*/ v_cmp_eq_i32    vcc, v11, v7
/*0000000002b8*/ v_cndmask_b32   v11, 0, -1, s[20:21]
/*0000000002c0*/ v_cndmask_b32   v12, 0, -1, s[18:19]
/*0000000002c8*/ v_cndmask_b32   v11, v11, v12, vcc
/*0000000002cc*/ v_cmp_lg_u32    vcc, 0, v11
/*0000000002d0*/ s_and_saveexec_b64 s[18:19], vcc
/*0000000002d4*/ v_sub_u32       v9, vcc, s0, v9
/*0000000002d8*/ s_cbranch_execz .L820_45
/*0000000002dc*/ v_sub_u32       v10, s[20:21], v10, v6
/*0000000002e4*/ v_subb_u32      v9, vcc, v9, v7, s[16:17]
/*0000000002ec*/ v_subb_u32      v9, vcc, v9, 0, s[20:21]
/*0000000002f4*/ v_cmp_ge_u32    s[16:17], v10, v6
/*0000000002fc*/ v_cmp_ge_u32    s[20:21], v9, v7
/*000000000304*/ v_cmp_eq_i32    vcc, v9, v7
/*000000000308*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*000000000310*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*000000000318*/ v_add_u32       v8, s[16:17], v8, 1
/*000000000320*/ v_cndmask_b32   v0, v0, v5, vcc
/*000000000324*/ v_cmp_lg_u32    vcc, 0, v0
/*000000000328*/ v_add_u32       v0, s[16:17], v8, 1
/*000000000330*/ v_cndmask_b32   v8, v8, v0, vcc
.L820_45:
/*000000000334*/ s_mov_b64       exec, s[18:19]
/*000000000338*/ v_cmp_lg_i64    vcc, 0, v[6:7]
/*00000000033c*/ v_cndmask_b32   v0, -1, v8, vcc
.L832_45:
/*000000000340*/ s_andn2_b64     exec, s[14:15], exec
/*000000000344*/ v_mov_b32       v0, s9
/*000000000348*/ s_mov_b64       exec, s[14:15]
/*00000000034c*/ s_lshl_b32      s1, s7, 1
/*000000000350*/ v_add_u32       v1, vcc, s1, v1
/*000000000354*/ v_add_u32       v5, vcc, s2, v1
/*000000000358*/ v_mov_b32       v6, s11
/*00000000035c*/ v_addc_u32      v4, vcc, v6, v4, s[12:13]
/*000000000364*/ flat_store_dword v[3:4], v0
/*00000000036c*/ v_mov_b32       v6, 0
/*000000000370*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000378*/ v_add_u32       v16, s[6:7], s10, v3
/*000000000380*/ v_add_u32       v5, vcc, v1, s2
/*000000000388*/ v_mov_b32       v3, s3
/*00000000038c*/ v_addc_u32      v6, vcc, 0, v3, vcc
/*000000000390*/ v_cmp_lg_i64    vcc, 1, v[5:6]
/*000000000394*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000398*/ v_cvt_f32_u32   v7, v5
/*00000000039c*/ s_cbranch_execz .L1664_45
/*0000000003a0*/ v_cvt_f32_u32   v8, v6
/*0000000003a4*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*0000000003ac*/ v_rcp_f32       v7, v7
/*0000000003b0*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*0000000003b8*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*0000000003c0*/ v_trunc_f32     v8, v8
/*0000000003c4*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*0000000003cc*/ v_cvt_u32_f32   v7, v7
/*0000000003d0*/ v_cvt_u32_f32   v8, v8
/*0000000003d4*/ v_sub_u32       v9, vcc, 0, v5
/*0000000003d8*/ v_subb_u32      v10, vcc, 0, v6, vcc
/*0000000003dc*/ v_mul_lo_u32    v11, v9, v8
/*0000000003e4*/ v_mul_lo_u32    v12, v10, v7
/*0000000003ec*/ v_add_u32       v11, vcc, v11, v12
/*0000000003f0*/ v_mul_hi_u32    v12, v9, v7
/*0000000003f8*/ v_add_u32       v11, vcc, v11, v12
/*0000000003fc*/ v_mul_lo_u32    v12, v9, v7
/*000000000404*/ v_mul_hi_u32    v13, v7, v12
/*00000000040c*/ v_mul_lo_u32    v14, v8, v12
/*000000000414*/ v_add_u32       v13, vcc, v13, v14
/*000000000418*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000420*/ v_mul_lo_u32    v15, v7, v11
/*000000000428*/ v_add_u32       v13, vcc, v13, v15
/*00000000042c*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*000000000434*/ v_mul_hi_u32    v12, v8, v12
/*00000000043c*/ v_add_u32       v12, vcc, v13, v12
/*000000000440*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000448*/ v_mul_hi_u32    v14, v7, v11
/*000000000450*/ v_add_u32       v12, vcc, v12, v14
/*000000000454*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*00000000045c*/ v_mul_lo_u32    v14, v8, v11
/*000000000464*/ v_add_u32       v12, vcc, v12, v14
/*000000000468*/ v_mul_hi_u32    v11, v8, v11
/*000000000470*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000474*/ v_add_u32       v7, s[12:13], v7, v12
/*00000000047c*/ v_add_u32       v12, vcc, v8, v11
/*000000000480*/ v_addc_u32      v8, vcc, v8, v11, s[12:13]
/*000000000488*/ v_mul_lo_u32    v11, v9, v8
/*000000000490*/ v_mul_lo_u32    v10, v10, v7
/*000000000498*/ v_add_u32       v10, vcc, v11, v10
/*00000000049c*/ v_mul_hi_u32    v11, v9, v7
/*0000000004a4*/ v_add_u32       v10, vcc, v10, v11
/*0000000004a8*/ v_mul_lo_u32    v9, v9, v7
/*0000000004b0*/ v_mul_hi_u32    v11, v7, v9
/*0000000004b8*/ v_mul_lo_u32    v13, v8, v9
/*0000000004c0*/ v_add_u32       v11, vcc, v11, v13
/*0000000004c4*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000004cc*/ v_mul_lo_u32    v14, v7, v10
/*0000000004d4*/ v_add_u32       v11, vcc, v11, v14
/*0000000004d8*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000004e0*/ v_mul_hi_u32    v9, v8, v9
/*0000000004e8*/ v_add_u32       v9, vcc, v11, v9
/*0000000004ec*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004f4*/ v_mul_hi_u32    v13, v7, v10
/*0000000004fc*/ v_add_u32       v9, vcc, v9, v13
/*000000000500*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*000000000508*/ v_mul_lo_u32    v13, v8, v10
/*000000000510*/ v_add_u32       v9, vcc, v9, v13
/*000000000514*/ v_mul_hi_u32    v8, v8, v10
/*00000000051c*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*000000000520*/ v_add_u32       v7, s[14:15], v7, v9
/*000000000528*/ v_addc_u32      v8, vcc, v12, v8, s[12:13]
/*000000000530*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*000000000538*/ v_mul_hi_u32    v9, s9, v7
/*000000000540*/ v_mul_lo_u32    v10, s0, v7
/*000000000548*/ v_add_u32       v9, vcc, v9, v10
/*00000000054c*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000554*/ v_mul_lo_u32    v11, s9, v8
/*00000000055c*/ v_add_u32       v9, vcc, v9, v11
/*000000000560*/ v_addc_u32      v9, vcc, v10, 0, vcc
/*000000000568*/ v_mul_hi_u32    v7, s0, v7
/*000000000570*/ v_add_u32       v7, vcc, v9, v7
/*000000000574*/ v_cndmask_b32   v9, 0, 1, vcc
/*00000000057c*/ v_mul_hi_u32    v10, s9, v8
/*000000000584*/ v_add_u32       v7, vcc, v7, v10
/*000000000588*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*000000000590*/ v_mul_lo_u32    v10, s0, v8
/*000000000598*/ v_add_u32       v7, vcc, v7, v10
/*00000000059c*/ v_mul_hi_u32    v8, s0, v8
/*0000000005a4*/ v_addc_u32      v8, vcc, v9, v8, vcc
/*0000000005a8*/ v_mul_lo_u32    v8, v5, v8
/*0000000005b0*/ v_mul_lo_u32    v9, v6, v7
/*0000000005b8*/ v_add_u32       v8, vcc, v8, v9
/*0000000005bc*/ v_mul_hi_u32    v9, v5, v7
/*0000000005c4*/ v_add_u32       v8, vcc, v8, v9
/*0000000005c8*/ v_mul_lo_u32    v9, v5, v7
/*0000000005d0*/ v_sub_u32       v9, s[12:13], s9, v9
/*0000000005d8*/ v_mov_b32       v10, s0
/*0000000005dc*/ v_subb_u32      v10, vcc, v10, v8, s[12:13]
/*0000000005e4*/ v_cmp_ge_u32    s[14:15], v9, v5
/*0000000005ec*/ v_cmp_ge_u32    s[16:17], v10, v6
/*0000000005f4*/ v_cmp_eq_i32    vcc, v10, v6
/*0000000005f8*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*000000000600*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*000000000608*/ v_cndmask_b32   v10, v10, v11, vcc
/*00000000060c*/ v_cmp_lg_u32    vcc, 0, v10
/*000000000610*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000614*/ v_sub_u32       v8, vcc, s0, v8
/*000000000618*/ s_cbranch_execz .L1652_45
/*00000000061c*/ v_sub_u32       v9, s[16:17], v9, v5
/*000000000624*/ v_subb_u32      v8, vcc, v8, v6, s[12:13]
/*00000000062c*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*000000000634*/ v_cmp_ge_u32    s[12:13], v9, v5
/*00000000063c*/ v_cmp_ge_u32    s[16:17], v8, v6
/*000000000644*/ v_cmp_eq_i32    vcc, v8, v6
/*000000000648*/ v_cndmask_b32   v1, 0, -1, s[16:17]
/*000000000650*/ v_cndmask_b32   v3, 0, -1, s[12:13]
/*000000000658*/ v_add_u32       v7, s[12:13], v7, 1
/*000000000660*/ v_cndmask_b32   v1, v1, v3, vcc
/*000000000664*/ v_cmp_lg_u32    vcc, 0, v1
/*000000000668*/ v_add_u32       v1, s[12:13], v7, 1
/*000000000670*/ v_cndmask_b32   v7, v7, v1, vcc
.L1652_45:
/*000000000674*/ s_mov_b64       exec, s[14:15]
/*000000000678*/ v_cmp_lg_i64    vcc, 0, v[5:6]
/*00000000067c*/ v_cndmask_b32   v1, -1, v7, vcc
.L1664_45:
/*000000000680*/ s_andn2_b64     exec, s[2:3], exec
/*000000000684*/ v_mov_b32       v1, s9
/*000000000688*/ s_mov_b64       exec, s[2:3]
/*00000000068c*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000694*/ s_lshl_b32      s1, s8, 1
/*000000000698*/ v_add_u32       v2, vcc, s1, v2
/*00000000069c*/ s_waitcnt       lgkmcnt(0)
/*0000000006a0*/ v_add_u32       v0, vcc, s2, v2
/*0000000006a4*/ v_mov_b32       v5, s11
/*0000000006a8*/ v_addc_u32      v17, vcc, v5, v4, s[6:7]
/*0000000006b0*/ flat_store_dword v[16:17], v1
/*0000000006b8*/ v_mov_b32       v1, 0
/*0000000006bc*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000006c4*/ v_add_u32       v0, vcc, s10, v0
/*0000000006c8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000006cc*/ v_add_u32       v4, vcc, v2, s2
/*0000000006d4*/ v_mov_b32       v3, s3
/*0000000006d8*/ v_addc_u32      v5, vcc, 0, v3, vcc
/*0000000006dc*/ v_cmp_lg_i64    vcc, 1, v[4:5]
/*0000000006e0*/ s_and_saveexec_b64 s[2:3], vcc
/*0000000006e4*/ v_cvt_f32_u32   v6, v4
/*0000000006e8*/ s_cbranch_execz .L2508_45
/*0000000006ec*/ v_cvt_f32_u32   v7, v5
/*0000000006f0*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*0000000006f8*/ v_rcp_f32       v6, v6
/*0000000006fc*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000704*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*00000000070c*/ v_trunc_f32     v7, v7
/*000000000710*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*000000000718*/ v_cvt_u32_f32   v6, v6
/*00000000071c*/ v_cvt_u32_f32   v7, v7
/*000000000720*/ v_sub_u32       v8, vcc, 0, v4
/*000000000724*/ v_subb_u32      v9, vcc, 0, v5, vcc
/*000000000728*/ v_mul_lo_u32    v10, v8, v7
/*000000000730*/ v_mul_lo_u32    v11, v9, v6
/*000000000738*/ v_add_u32       v10, vcc, v10, v11
/*00000000073c*/ v_mul_hi_u32    v11, v8, v6
/*000000000744*/ v_add_u32       v10, vcc, v10, v11
/*000000000748*/ v_mul_lo_u32    v11, v8, v6
/*000000000750*/ v_mul_hi_u32    v12, v6, v11
/*000000000758*/ v_mul_lo_u32    v13, v7, v11
/*000000000760*/ v_add_u32       v12, vcc, v12, v13
/*000000000764*/ v_cndmask_b32   v13, 0, 1, vcc
/*00000000076c*/ v_mul_lo_u32    v14, v6, v10
/*000000000774*/ v_add_u32       v12, vcc, v12, v14
/*000000000778*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*000000000780*/ v_mul_hi_u32    v11, v7, v11
/*000000000788*/ v_add_u32       v11, vcc, v12, v11
/*00000000078c*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000794*/ v_mul_hi_u32    v13, v6, v10
/*00000000079c*/ v_add_u32       v11, vcc, v11, v13
/*0000000007a0*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000007a8*/ v_mul_lo_u32    v13, v7, v10
/*0000000007b0*/ v_add_u32       v11, vcc, v11, v13
/*0000000007b4*/ v_mul_hi_u32    v10, v7, v10
/*0000000007bc*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*0000000007c0*/ v_add_u32       v6, s[4:5], v6, v11
/*0000000007c8*/ v_add_u32       v11, vcc, v7, v10
/*0000000007cc*/ v_addc_u32      v7, vcc, v7, v10, s[4:5]
/*0000000007d4*/ v_mul_lo_u32    v10, v8, v7
/*0000000007dc*/ v_mul_lo_u32    v9, v9, v6
/*0000000007e4*/ v_add_u32       v9, vcc, v10, v9
/*0000000007e8*/ v_mul_hi_u32    v10, v8, v6
/*0000000007f0*/ v_add_u32       v9, vcc, v9, v10
/*0000000007f4*/ v_mul_lo_u32    v8, v8, v6
/*0000000007fc*/ v_mul_hi_u32    v10, v6, v8
/*000000000804*/ v_mul_lo_u32    v12, v7, v8
/*00000000080c*/ v_add_u32       v10, vcc, v10, v12
/*000000000810*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000818*/ v_mul_lo_u32    v13, v6, v9
/*000000000820*/ v_add_u32       v10, vcc, v10, v13
/*000000000824*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*00000000082c*/ v_mul_hi_u32    v8, v7, v8
/*000000000834*/ v_add_u32       v8, vcc, v10, v8
/*000000000838*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000840*/ v_mul_hi_u32    v12, v6, v9
/*000000000848*/ v_add_u32       v8, vcc, v8, v12
/*00000000084c*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*000000000854*/ v_mul_lo_u32    v12, v7, v9
/*00000000085c*/ v_add_u32       v8, vcc, v8, v12
/*000000000860*/ v_mul_hi_u32    v7, v7, v9
/*000000000868*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*00000000086c*/ v_add_u32       v6, s[6:7], v6, v8
/*000000000874*/ v_addc_u32      v7, vcc, v11, v7, s[4:5]
/*00000000087c*/ v_addc_u32      v7, vcc, v7, 0, s[6:7]
/*000000000884*/ v_mul_hi_u32    v8, s9, v6
/*00000000088c*/ v_mul_lo_u32    v9, s0, v6
/*000000000894*/ v_add_u32       v8, vcc, v8, v9
/*000000000898*/ v_cndmask_b32   v9, 0, 1, vcc
/*0000000008a0*/ v_mul_lo_u32    v10, s9, v7
/*0000000008a8*/ v_add_u32       v8, vcc, v8, v10
/*0000000008ac*/ v_addc_u32      v8, vcc, v9, 0, vcc
/*0000000008b4*/ v_mul_hi_u32    v6, s0, v6
/*0000000008bc*/ v_add_u32       v6, vcc, v8, v6
/*0000000008c0*/ v_cndmask_b32   v8, 0, 1, vcc
/*0000000008c8*/ v_mul_hi_u32    v9, s9, v7
/*0000000008d0*/ v_add_u32       v6, vcc, v6, v9
/*0000000008d4*/ v_addc_u32      v8, vcc, v8, 0, vcc
/*0000000008dc*/ v_mul_lo_u32    v9, s0, v7
/*0000000008e4*/ v_add_u32       v6, vcc, v6, v9
/*0000000008e8*/ v_mul_hi_u32    v7, s0, v7
/*0000000008f0*/ v_addc_u32      v7, vcc, v8, v7, vcc
/*0000000008f4*/ v_mul_lo_u32    v7, v4, v7
/*0000000008fc*/ v_mul_lo_u32    v8, v5, v6
/*000000000904*/ v_add_u32       v7, vcc, v7, v8
/*000000000908*/ v_mul_hi_u32    v8, v4, v6
/*000000000910*/ v_add_u32       v7, vcc, v7, v8
/*000000000914*/ v_mul_lo_u32    v8, v4, v6
/*00000000091c*/ v_sub_u32       v8, s[4:5], s9, v8
/*000000000924*/ v_mov_b32       v9, s0
/*000000000928*/ v_subb_u32      v9, vcc, v9, v7, s[4:5]
/*000000000930*/ v_cmp_ge_u32    s[6:7], v8, v4
/*000000000938*/ v_cmp_ge_u32    s[10:11], v9, v5
/*000000000940*/ v_cmp_eq_i32    vcc, v9, v5
/*000000000944*/ v_cndmask_b32   v9, 0, -1, s[10:11]
/*00000000094c*/ v_cndmask_b32   v10, 0, -1, s[6:7]
/*000000000954*/ v_cndmask_b32   v9, v9, v10, vcc
/*000000000958*/ v_cmp_lg_u32    vcc, 0, v9
/*00000000095c*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000960*/ v_sub_u32       v7, vcc, s0, v7
/*000000000964*/ s_cbranch_execz .L2496_45
/*000000000968*/ v_sub_u32       v8, s[0:1], v8, v4
/*000000000970*/ v_subb_u32      v7, vcc, v7, v5, s[4:5]
/*000000000978*/ v_subb_u32      v7, vcc, v7, 0, s[0:1]
/*000000000980*/ v_cmp_ge_u32    s[0:1], v8, v4
/*000000000988*/ v_cmp_ge_u32    s[4:5], v7, v5
/*000000000990*/ v_cmp_eq_i32    vcc, v7, v5
/*000000000994*/ v_cndmask_b32   v2, 0, -1, s[4:5]
/*00000000099c*/ v_cndmask_b32   v3, 0, -1, s[0:1]
/*0000000009a4*/ v_add_u32       v6, s[0:1], v6, 1
/*0000000009ac*/ v_cndmask_b32   v2, v2, v3, vcc
/*0000000009b0*/ v_cmp_lg_u32    vcc, 0, v2
/*0000000009b4*/ v_add_u32       v2, s[0:1], v6, 1
/*0000000009bc*/ v_cndmask_b32   v6, v6, v2, vcc
.L2496_45:
/*0000000009c0*/ s_mov_b64       exec, s[6:7]
/*0000000009c4*/ v_cmp_lg_i64    vcc, 0, v[4:5]
/*0000000009c8*/ v_cndmask_b32   v2, -1, v6, vcc
.L2508_45:
/*0000000009cc*/ s_andn2_b64     exec, s[2:3], exec
/*0000000009d0*/ v_mov_b32       v2, s9
/*0000000009d4*/ s_mov_b64       exec, s[2:3]
/*0000000009d8*/ flat_store_dword v[0:1], v2
/*0000000009e0*/ s_endpgm
.kernel div_get_global_offset_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 28
        .vgprsnum 18
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 1
/*000000000014*/ v_add_u32       v0, vcc, s6, v0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ v_add_u32       v3, vcc, s0, v0
/*000000000020*/ v_add_u32       v5, vcc, v0, s0
/*000000000028*/ v_mov_b32       v4, s1
/*00000000002c*/ v_addc_u32      v6, vcc, 0, v4, vcc
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000003c*/ v_add_u32       v3, s[12:13], s10, v3
/*000000000044*/ v_cmp_lg_i64    vcc, 1, v[5:6]
/*000000000048*/ s_and_saveexec_b64 s[14:15], vcc
/*00000000004c*/ v_cvt_f32_u32   v8, v5
/*000000000050*/ s_cbranch_execz .L756_46
/*000000000054*/ v_cvt_f32_u32   v9, v6
/*000000000058*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000060*/ v_rcp_f32       v8, v8
/*000000000064*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*00000000006c*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000074*/ v_trunc_f32     v9, v9
/*000000000078*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000080*/ v_cvt_u32_f32   v8, v8
/*000000000084*/ v_cvt_u32_f32   v9, v9
/*000000000088*/ v_sub_u32       v10, vcc, 0, v5
/*00000000008c*/ v_subb_u32      v11, vcc, 0, v6, vcc
/*000000000090*/ v_mul_lo_u32    v12, v10, v9
/*000000000098*/ v_mul_lo_u32    v13, v11, v8
/*0000000000a0*/ v_add_u32       v12, vcc, v12, v13
/*0000000000a4*/ v_mul_hi_u32    v13, v10, v8
/*0000000000ac*/ v_add_u32       v12, vcc, v12, v13
/*0000000000b0*/ v_mul_lo_u32    v13, v10, v8
/*0000000000b8*/ v_mul_hi_u32    v14, v8, v13
/*0000000000c0*/ v_mul_lo_u32    v15, v9, v13
/*0000000000c8*/ v_add_u32       v14, vcc, v14, v15
/*0000000000cc*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000d4*/ v_mul_lo_u32    v16, v8, v12
/*0000000000dc*/ v_add_u32       v14, vcc, v14, v16
/*0000000000e0*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000e8*/ v_mul_hi_u32    v13, v9, v13
/*0000000000f0*/ v_add_u32       v13, vcc, v14, v13
/*0000000000f4*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000000fc*/ v_mul_hi_u32    v15, v8, v12
/*000000000104*/ v_add_u32       v13, vcc, v13, v15
/*000000000108*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*000000000110*/ v_mul_lo_u32    v15, v9, v12
/*000000000118*/ v_add_u32       v13, vcc, v13, v15
/*00000000011c*/ v_mul_hi_u32    v12, v9, v12
/*000000000124*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000128*/ v_add_u32       v8, s[16:17], v8, v13
/*000000000130*/ v_add_u32       v13, vcc, v9, v12
/*000000000134*/ v_addc_u32      v9, vcc, v9, v12, s[16:17]
/*00000000013c*/ v_mul_lo_u32    v12, v10, v9
/*000000000144*/ v_mul_lo_u32    v11, v11, v8
/*00000000014c*/ v_add_u32       v11, vcc, v12, v11
/*000000000150*/ v_mul_hi_u32    v12, v10, v8
/*000000000158*/ v_add_u32       v11, vcc, v11, v12
/*00000000015c*/ v_mul_lo_u32    v10, v10, v8
/*000000000164*/ v_mul_hi_u32    v12, v8, v10
/*00000000016c*/ v_mul_lo_u32    v14, v9, v10
/*000000000174*/ v_add_u32       v12, vcc, v12, v14
/*000000000178*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000180*/ v_mul_lo_u32    v15, v8, v11
/*000000000188*/ v_add_u32       v12, vcc, v12, v15
/*00000000018c*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*000000000194*/ v_mul_hi_u32    v10, v9, v10
/*00000000019c*/ v_add_u32       v10, vcc, v12, v10
/*0000000001a0*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001a8*/ v_mul_hi_u32    v14, v8, v11
/*0000000001b0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001b4*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001bc*/ v_mul_lo_u32    v14, v9, v11
/*0000000001c4*/ v_add_u32       v10, vcc, v10, v14
/*0000000001c8*/ v_mul_hi_u32    v9, v9, v11
/*0000000001d0*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001d4*/ v_add_u32       v8, s[18:19], v8, v10
/*0000000001dc*/ v_addc_u32      v9, vcc, v13, v9, s[16:17]
/*0000000001e4*/ v_addc_u32      v9, vcc, v9, 0, s[18:19]
/*0000000001ec*/ v_mul_hi_u32    v8, s0, v8
/*0000000001f4*/ v_mul_lo_u32    v10, s0, v9
/*0000000001fc*/ v_add_u32       v8, vcc, v8, v10
/*000000000200*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000208*/ v_mul_hi_u32    v9, s0, v9
/*000000000210*/ v_add_u32       v8, vcc, v8, v9
/*000000000214*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*00000000021c*/ v_add_u32       v9, vcc, 0, v9
/*000000000220*/ v_mul_lo_u32    v9, v5, v9
/*000000000228*/ v_mul_lo_u32    v10, v6, v8
/*000000000230*/ v_add_u32       v9, vcc, v9, v10
/*000000000234*/ v_mul_hi_u32    v10, v5, v8
/*00000000023c*/ v_add_u32       v9, vcc, v9, v10
/*000000000240*/ v_mul_lo_u32    v10, v5, v8
/*000000000248*/ v_sub_u32       v10, s[16:17], s0, v10
/*000000000250*/ v_subb_u32      v11, vcc, 0, v9, s[16:17]
/*000000000258*/ v_cmp_ge_u32    s[18:19], v10, v5
/*000000000260*/ v_cmp_ge_u32    s[20:21], v11, v6
/*000000000268*/ v_cmp_eq_i32    vcc, v11, v6
/*00000000026c*/ v_cndmask_b32   v11, 0, -1, s[20:21]
/*000000000274*/ v_cndmask_b32   v12, 0, -1, s[18:19]
/*00000000027c*/ v_cndmask_b32   v11, v11, v12, vcc
/*000000000280*/ v_cmp_lg_u32    vcc, 0, v11
/*000000000284*/ s_and_saveexec_b64 s[18:19], vcc
/*000000000288*/ v_sub_u32       v9, vcc, 0, v9
/*00000000028c*/ s_cbranch_execz .L744_46
/*000000000290*/ v_sub_u32       v10, s[20:21], v10, v5
/*000000000298*/ v_subb_u32      v9, vcc, v9, v6, s[16:17]
/*0000000002a0*/ v_subb_u32      v9, vcc, v9, 0, s[20:21]
/*0000000002a8*/ v_cmp_ge_u32    s[16:17], v10, v5
/*0000000002b0*/ v_cmp_ge_u32    s[20:21], v9, v6
/*0000000002b8*/ v_cmp_eq_i32    vcc, v9, v6
/*0000000002bc*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*0000000002c4*/ v_cndmask_b32   v7, 0, -1, s[16:17]
/*0000000002cc*/ v_add_u32       v8, s[16:17], v8, 1
/*0000000002d4*/ v_cndmask_b32   v0, v0, v7, vcc
/*0000000002d8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002dc*/ v_add_u32       v0, s[16:17], v8, 1
/*0000000002e4*/ v_cndmask_b32   v8, v8, v0, vcc
.L744_46:
/*0000000002e8*/ s_mov_b64       exec, s[18:19]
/*0000000002ec*/ v_cmp_lg_i64    vcc, 0, v[5:6]
/*0000000002f0*/ v_cndmask_b32   v5, -1, v8, vcc
.L756_46:
/*0000000002f4*/ s_andn2_b64     exec, s[14:15], exec
/*0000000002f8*/ v_mov_b32       v5, s0
/*0000000002fc*/ s_mov_b64       exec, s[14:15]
/*000000000300*/ s_lshl_b32      s0, s7, 4
/*000000000304*/ v_add_u32       v0, vcc, s0, v1
/*000000000308*/ v_add_u32       v8, vcc, s2, v0
/*00000000030c*/ v_mov_b32       v6, s11
/*000000000310*/ v_addc_u32      v4, vcc, v6, v4, s[12:13]
/*000000000318*/ v_add_u32       v16, vcc, v0, s2
/*000000000320*/ v_mov_b32       v0, s3
/*000000000324*/ v_addc_u32      v17, vcc, 0, v0, vcc
/*000000000328*/ v_mov_b32       v9, 0
/*00000000032c*/ v_lshlrev_b64   v[0:1], 2, v[8:9]
/*000000000334*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*00000000033c*/ flat_store_dword v[3:4], v5
/*000000000344*/ v_add_u32       v0, s[4:5], s10, v0
/*00000000034c*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000350*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000354*/ v_cvt_f32_u32   v5, v16
/*000000000358*/ s_cbranch_execz .L1532_46
/*00000000035c*/ v_cvt_f32_u32   v8, v17
/*000000000360*/ v_madmk_f32     v5, v8, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000368*/ v_rcp_f32       v5, v5
/*00000000036c*/ v_mul_f32       v5, 0x5f7ffffc /* 1.844674e+19f */, v5
/*000000000374*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v5
/*00000000037c*/ v_trunc_f32     v8, v8
/*000000000380*/ v_madmk_f32     v5, v8, 0xcf800000 /* -4.2949673e+9f */, v5
/*000000000388*/ v_cvt_u32_f32   v5, v5
/*00000000038c*/ v_cvt_u32_f32   v8, v8
/*000000000390*/ v_sub_u32       v9, vcc, 0, v16
/*000000000394*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*000000000398*/ v_mul_lo_u32    v11, v9, v8
/*0000000003a0*/ v_mul_lo_u32    v12, v10, v5
/*0000000003a8*/ v_add_u32       v11, vcc, v11, v12
/*0000000003ac*/ v_mul_hi_u32    v12, v9, v5
/*0000000003b4*/ v_add_u32       v11, vcc, v11, v12
/*0000000003b8*/ v_mul_lo_u32    v12, v9, v5
/*0000000003c0*/ v_mul_hi_u32    v13, v5, v12
/*0000000003c8*/ v_mul_lo_u32    v14, v8, v12
/*0000000003d0*/ v_add_u32       v13, vcc, v13, v14
/*0000000003d4*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000003dc*/ v_mul_lo_u32    v15, v5, v11
/*0000000003e4*/ v_add_u32       v13, vcc, v13, v15
/*0000000003e8*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*0000000003f0*/ v_mul_hi_u32    v12, v8, v12
/*0000000003f8*/ v_add_u32       v12, vcc, v13, v12
/*0000000003fc*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000404*/ v_mul_hi_u32    v14, v5, v11
/*00000000040c*/ v_add_u32       v12, vcc, v12, v14
/*000000000410*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000418*/ v_mul_lo_u32    v14, v8, v11
/*000000000420*/ v_add_u32       v12, vcc, v12, v14
/*000000000424*/ v_mul_hi_u32    v11, v8, v11
/*00000000042c*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000430*/ v_add_u32       v5, s[12:13], v5, v12
/*000000000438*/ v_add_u32       v12, vcc, v8, v11
/*00000000043c*/ v_addc_u32      v8, vcc, v8, v11, s[12:13]
/*000000000444*/ v_mul_lo_u32    v11, v9, v8
/*00000000044c*/ v_mul_lo_u32    v10, v10, v5
/*000000000454*/ v_add_u32       v10, vcc, v11, v10
/*000000000458*/ v_mul_hi_u32    v11, v9, v5
/*000000000460*/ v_add_u32       v10, vcc, v10, v11
/*000000000464*/ v_mul_lo_u32    v9, v9, v5
/*00000000046c*/ v_mul_hi_u32    v11, v5, v9
/*000000000474*/ v_mul_lo_u32    v13, v8, v9
/*00000000047c*/ v_add_u32       v11, vcc, v11, v13
/*000000000480*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000488*/ v_mul_lo_u32    v14, v5, v10
/*000000000490*/ v_add_u32       v11, vcc, v11, v14
/*000000000494*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*00000000049c*/ v_mul_hi_u32    v9, v8, v9
/*0000000004a4*/ v_add_u32       v9, vcc, v11, v9
/*0000000004a8*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004b0*/ v_mul_hi_u32    v13, v5, v10
/*0000000004b8*/ v_add_u32       v9, vcc, v9, v13
/*0000000004bc*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004c4*/ v_mul_lo_u32    v13, v8, v10
/*0000000004cc*/ v_add_u32       v9, vcc, v9, v13
/*0000000004d0*/ v_mul_hi_u32    v8, v8, v10
/*0000000004d8*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000004dc*/ v_add_u32       v5, s[14:15], v5, v9
/*0000000004e4*/ v_addc_u32      v8, vcc, v12, v8, s[12:13]
/*0000000004ec*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*0000000004f4*/ v_mul_hi_u32    v5, s2, v5
/*0000000004fc*/ v_mul_lo_u32    v9, s2, v8
/*000000000504*/ v_add_u32       v5, vcc, v5, v9
/*000000000508*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*000000000510*/ v_mul_hi_u32    v8, s2, v8
/*000000000518*/ v_add_u32       v5, vcc, v5, v8
/*00000000051c*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000524*/ v_add_u32       v8, vcc, 0, v8
/*000000000528*/ v_mul_lo_u32    v8, v16, v8
/*000000000530*/ v_mul_lo_u32    v9, v17, v5
/*000000000538*/ v_add_u32       v8, vcc, v8, v9
/*00000000053c*/ v_mul_hi_u32    v9, v16, v5
/*000000000544*/ v_add_u32       v8, vcc, v8, v9
/*000000000548*/ v_mul_lo_u32    v9, v16, v5
/*000000000550*/ v_sub_u32       v9, s[12:13], s2, v9
/*000000000558*/ v_subb_u32      v10, vcc, 0, v8, s[12:13]
/*000000000560*/ v_cmp_ge_u32    s[14:15], v9, v16
/*000000000568*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000570*/ v_cmp_eq_i32    vcc, v10, v17
/*000000000574*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*00000000057c*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*000000000584*/ v_cndmask_b32   v10, v10, v11, vcc
/*000000000588*/ v_cmp_lg_u32    vcc, 0, v10
/*00000000058c*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000590*/ v_sub_u32       v8, vcc, 0, v8
/*000000000594*/ s_cbranch_execz .L1520_46
/*000000000598*/ v_sub_u32       v9, s[16:17], v9, v16
/*0000000005a0*/ v_subb_u32      v8, vcc, v8, v17, s[12:13]
/*0000000005a8*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*0000000005b0*/ v_cmp_ge_u32    s[12:13], v9, v16
/*0000000005b8*/ v_cmp_ge_u32    s[16:17], v8, v17
/*0000000005c0*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005c4*/ v_cndmask_b32   v6, 0, -1, s[16:17]
/*0000000005cc*/ v_cndmask_b32   v7, 0, -1, s[12:13]
/*0000000005d4*/ v_add_u32       v5, s[12:13], v5, 1
/*0000000005dc*/ v_cndmask_b32   v6, v6, v7, vcc
/*0000000005e0*/ v_cmp_lg_u32    vcc, 0, v6
/*0000000005e4*/ v_add_u32       v6, s[12:13], v5, 1
/*0000000005ec*/ v_cndmask_b32   v5, v5, v6, vcc
.L1520_46:
/*0000000005f0*/ s_mov_b64       exec, s[14:15]
/*0000000005f4*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*0000000005f8*/ v_cndmask_b32   v3, -1, v5, vcc
.L1532_46:
/*0000000005fc*/ s_andn2_b64     exec, s[6:7], exec
/*000000000600*/ v_mov_b32       v3, s2
/*000000000604*/ s_mov_b64       exec, s[6:7]
/*000000000608*/ s_lshl_b32      s2, s8, 1
/*00000000060c*/ v_add_u32       v2, vcc, s2, v2
/*000000000610*/ s_waitcnt       lgkmcnt(0)
/*000000000614*/ v_add_u32       v6, vcc, s0, v2
/*000000000618*/ v_mov_b32       v5, s11
/*00000000061c*/ v_addc_u32      v1, vcc, v5, v1, s[4:5]
/*000000000624*/ flat_store_dword v[0:1], v3
/*00000000062c*/ v_mov_b32       v7, 0
/*000000000630*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000638*/ v_add_u32       v0, vcc, s10, v0
/*00000000063c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000640*/ v_add_u32       v15, vcc, v2, s0
/*000000000648*/ v_mov_b32       v2, s1
/*00000000064c*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*000000000650*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000654*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000658*/ v_cvt_f32_u32   v6, v15
/*00000000065c*/ s_cbranch_execz .L2304_46
/*000000000660*/ v_cvt_f32_u32   v7, v16
/*000000000664*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*00000000066c*/ v_rcp_f32       v6, v6
/*000000000670*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000678*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000680*/ v_trunc_f32     v7, v7
/*000000000684*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*00000000068c*/ v_cvt_u32_f32   v6, v6
/*000000000690*/ v_cvt_u32_f32   v7, v7
/*000000000694*/ v_sub_u32       v8, vcc, 0, v15
/*000000000698*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*00000000069c*/ v_mul_lo_u32    v10, v8, v7
/*0000000006a4*/ v_mul_lo_u32    v11, v9, v6
/*0000000006ac*/ v_add_u32       v10, vcc, v10, v11
/*0000000006b0*/ v_mul_hi_u32    v11, v8, v6
/*0000000006b8*/ v_add_u32       v10, vcc, v10, v11
/*0000000006bc*/ v_mul_lo_u32    v11, v8, v6
/*0000000006c4*/ v_mul_hi_u32    v12, v6, v11
/*0000000006cc*/ v_mul_lo_u32    v13, v7, v11
/*0000000006d4*/ v_add_u32       v12, vcc, v12, v13
/*0000000006d8*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006e0*/ v_mul_lo_u32    v14, v6, v10
/*0000000006e8*/ v_add_u32       v12, vcc, v12, v14
/*0000000006ec*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*0000000006f4*/ v_mul_hi_u32    v11, v7, v11
/*0000000006fc*/ v_add_u32       v11, vcc, v12, v11
/*000000000700*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000708*/ v_mul_hi_u32    v13, v6, v10
/*000000000710*/ v_add_u32       v11, vcc, v11, v13
/*000000000714*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*00000000071c*/ v_mul_lo_u32    v13, v7, v10
/*000000000724*/ v_add_u32       v11, vcc, v11, v13
/*000000000728*/ v_mul_hi_u32    v10, v7, v10
/*000000000730*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000734*/ v_add_u32       v6, s[4:5], v6, v11
/*00000000073c*/ v_add_u32       v11, vcc, v7, v10
/*000000000740*/ v_addc_u32      v7, vcc, v7, v10, s[4:5]
/*000000000748*/ v_mul_lo_u32    v10, v8, v7
/*000000000750*/ v_mul_lo_u32    v9, v9, v6
/*000000000758*/ v_add_u32       v9, vcc, v10, v9
/*00000000075c*/ v_mul_hi_u32    v10, v8, v6
/*000000000764*/ v_add_u32       v9, vcc, v9, v10
/*000000000768*/ v_mul_lo_u32    v8, v8, v6
/*000000000770*/ v_mul_hi_u32    v10, v6, v8
/*000000000778*/ v_mul_lo_u32    v12, v7, v8
/*000000000780*/ v_add_u32       v10, vcc, v10, v12
/*000000000784*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000078c*/ v_mul_lo_u32    v13, v6, v9
/*000000000794*/ v_add_u32       v10, vcc, v10, v13
/*000000000798*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007a0*/ v_mul_hi_u32    v8, v7, v8
/*0000000007a8*/ v_add_u32       v8, vcc, v10, v8
/*0000000007ac*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007b4*/ v_mul_hi_u32    v12, v6, v9
/*0000000007bc*/ v_add_u32       v8, vcc, v8, v12
/*0000000007c0*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007c8*/ v_mul_lo_u32    v12, v7, v9
/*0000000007d0*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d4*/ v_mul_hi_u32    v7, v7, v9
/*0000000007dc*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007e0*/ v_add_u32       v6, s[6:7], v6, v8
/*0000000007e8*/ v_addc_u32      v7, vcc, v11, v7, s[4:5]
/*0000000007f0*/ v_addc_u32      v7, vcc, v7, 0, s[6:7]
/*0000000007f8*/ v_mul_hi_u32    v6, s0, v6
/*000000000800*/ v_mul_lo_u32    v8, s0, v7
/*000000000808*/ v_add_u32       v6, vcc, v6, v8
/*00000000080c*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000814*/ v_mul_hi_u32    v7, s0, v7
/*00000000081c*/ v_add_u32       v6, vcc, v6, v7
/*000000000820*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000828*/ v_add_u32       v7, vcc, 0, v7
/*00000000082c*/ v_mul_lo_u32    v7, v15, v7
/*000000000834*/ v_mul_lo_u32    v8, v16, v6
/*00000000083c*/ v_add_u32       v7, vcc, v7, v8
/*000000000840*/ v_mul_hi_u32    v8, v15, v6
/*000000000848*/ v_add_u32       v7, vcc, v7, v8
/*00000000084c*/ v_mul_lo_u32    v8, v15, v6
/*000000000854*/ v_sub_u32       v8, s[4:5], s0, v8
/*00000000085c*/ v_subb_u32      v9, vcc, 0, v7, s[4:5]
/*000000000864*/ v_cmp_ge_u32    s[6:7], v8, v15
/*00000000086c*/ v_cmp_ge_u32    s[8:9], v9, v16
/*000000000874*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000878*/ v_cndmask_b32   v9, 0, -1, s[8:9]
/*000000000880*/ v_cndmask_b32   v10, 0, -1, s[6:7]
/*000000000888*/ v_cndmask_b32   v9, v9, v10, vcc
/*00000000088c*/ v_cmp_lg_u32    vcc, 0, v9
/*000000000890*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000894*/ v_sub_u32       v7, vcc, 0, v7
/*000000000898*/ s_cbranch_execz .L2292_46
/*00000000089c*/ v_sub_u32       v8, s[8:9], v8, v15
/*0000000008a4*/ v_subb_u32      v7, vcc, v7, v16, s[4:5]
/*0000000008ac*/ v_subb_u32      v7, vcc, v7, 0, s[8:9]
/*0000000008b4*/ v_cmp_ge_u32    s[4:5], v8, v15
/*0000000008bc*/ v_cmp_ge_u32    s[8:9], v7, v16
/*0000000008c4*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008c8*/ v_cndmask_b32   v4, 0, -1, s[8:9]
/*0000000008d0*/ v_cndmask_b32   v5, 0, -1, s[4:5]
/*0000000008d8*/ v_add_u32       v6, s[4:5], v6, 1
/*0000000008e0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008e4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000008e8*/ v_add_u32       v4, s[4:5], v6, 1
/*0000000008f0*/ v_cndmask_b32   v6, v6, v4, vcc
.L2292_46:
/*0000000008f4*/ s_mov_b64       exec, s[6:7]
/*0000000008f8*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*0000000008fc*/ v_cndmask_b32   v2, -1, v6, vcc
.L2304_46:
/*000000000900*/ s_andn2_b64     exec, s[2:3], exec
/*000000000904*/ v_mov_b32       v2, s0
/*000000000908*/ s_mov_b64       exec, s[2:3]
/*00000000090c*/ flat_store_dword v[0:1], v2
/*000000000914*/ s_endpgm
.kernel div_get_local_id_get_global_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 24
        .vgprsnum 21
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c5
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 3
/*000000000014*/ v_add_u32       v3, vcc, s6, v0
/*000000000018*/ s_lshl_b32      s6, s8, 1
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ v_add_u32       v4, vcc, s0, v3
/*000000000024*/ v_add_u32       v19, vcc, v3, s0
/*00000000002c*/ v_mov_b32       v3, s1
/*000000000030*/ v_addc_u32      v20, vcc, 0, v3, vcc
/*000000000034*/ v_mov_b32       v5, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[4:5]
/*000000000040*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000048*/ v_add_u32       v9, vcc, s6, v2
/*00000000004c*/ v_add_u32       v3, s[4:5], s10, v3
/*000000000054*/ v_cmp_lg_i64    vcc, 1, v[19:20]
/*000000000058*/ s_and_saveexec_b64 s[8:9], vcc
/*00000000005c*/ v_cvt_f32_u32   v10, v19
/*000000000060*/ s_cbranch_execz .L772_47
/*000000000064*/ v_cvt_f32_u32   v11, v20
/*000000000068*/ v_madmk_f32     v10, v11, 0x4f800000 /* 4.2949673e+9f */, v10
/*000000000070*/ v_rcp_f32       v10, v10
/*000000000074*/ v_mul_f32       v10, 0x5f7ffffc /* 1.844674e+19f */, v10
/*00000000007c*/ v_mul_f32       v11, 0x2f800000 /* 2.32830644e-10f */, v10
/*000000000084*/ v_trunc_f32     v11, v11
/*000000000088*/ v_madmk_f32     v10, v11, 0xcf800000 /* -4.2949673e+9f */, v10
/*000000000090*/ v_cvt_u32_f32   v10, v10
/*000000000094*/ v_cvt_u32_f32   v11, v11
/*000000000098*/ v_sub_u32       v12, vcc, 0, v19
/*00000000009c*/ v_subb_u32      v13, vcc, 0, v20, vcc
/*0000000000a0*/ v_mul_lo_u32    v14, v12, v11
/*0000000000a8*/ v_mul_lo_u32    v15, v13, v10
/*0000000000b0*/ v_add_u32       v14, vcc, v14, v15
/*0000000000b4*/ v_mul_hi_u32    v15, v12, v10
/*0000000000bc*/ v_add_u32       v14, vcc, v14, v15
/*0000000000c0*/ v_mul_lo_u32    v15, v12, v10
/*0000000000c8*/ v_mul_hi_u32    v16, v10, v15
/*0000000000d0*/ v_mul_lo_u32    v17, v11, v15
/*0000000000d8*/ v_add_u32       v16, vcc, v16, v17
/*0000000000dc*/ v_cndmask_b32   v17, 0, 1, vcc
/*0000000000e4*/ v_mul_lo_u32    v18, v10, v14
/*0000000000ec*/ v_add_u32       v16, vcc, v16, v18
/*0000000000f0*/ v_addc_u32      v16, vcc, v17, 0, vcc
/*0000000000f8*/ v_mul_hi_u32    v15, v11, v15
/*000000000100*/ v_add_u32       v15, vcc, v16, v15
/*000000000104*/ v_cndmask_b32   v16, 0, 1, vcc
/*00000000010c*/ v_mul_hi_u32    v17, v10, v14
/*000000000114*/ v_add_u32       v15, vcc, v15, v17
/*000000000118*/ v_addc_u32      v16, vcc, v16, 0, vcc
/*000000000120*/ v_mul_lo_u32    v17, v11, v14
/*000000000128*/ v_add_u32       v15, vcc, v15, v17
/*00000000012c*/ v_mul_hi_u32    v14, v11, v14
/*000000000134*/ v_addc_u32      v14, vcc, v16, v14, vcc
/*000000000138*/ v_add_u32       v10, s[12:13], v10, v15
/*000000000140*/ v_add_u32       v15, vcc, v11, v14
/*000000000144*/ v_addc_u32      v11, vcc, v11, v14, s[12:13]
/*00000000014c*/ v_mul_lo_u32    v14, v12, v11
/*000000000154*/ v_mul_lo_u32    v13, v13, v10
/*00000000015c*/ v_add_u32       v13, vcc, v14, v13
/*000000000160*/ v_mul_hi_u32    v14, v12, v10
/*000000000168*/ v_add_u32       v13, vcc, v13, v14
/*00000000016c*/ v_mul_lo_u32    v12, v12, v10
/*000000000174*/ v_mul_hi_u32    v14, v10, v12
/*00000000017c*/ v_mul_lo_u32    v16, v11, v12
/*000000000184*/ v_add_u32       v14, vcc, v14, v16
/*000000000188*/ v_cndmask_b32   v16, 0, 1, vcc
/*000000000190*/ v_mul_lo_u32    v17, v10, v13
/*000000000198*/ v_add_u32       v14, vcc, v14, v17
/*00000000019c*/ v_addc_u32      v14, vcc, v16, 0, vcc
/*0000000001a4*/ v_mul_hi_u32    v12, v11, v12
/*0000000001ac*/ v_add_u32       v12, vcc, v14, v12
/*0000000001b0*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000001b8*/ v_mul_hi_u32    v16, v10, v13
/*0000000001c0*/ v_add_u32       v12, vcc, v12, v16
/*0000000001c4*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*0000000001cc*/ v_mul_lo_u32    v16, v11, v13
/*0000000001d4*/ v_add_u32       v12, vcc, v12, v16
/*0000000001d8*/ v_mul_hi_u32    v11, v11, v13
/*0000000001e0*/ v_addc_u32      v11, vcc, v14, v11, vcc
/*0000000001e4*/ v_add_u32       v10, s[14:15], v10, v12
/*0000000001ec*/ v_addc_u32      v11, vcc, v15, v11, s[12:13]
/*0000000001f4*/ v_addc_u32      v11, vcc, v11, 0, s[14:15]
/*0000000001fc*/ v_mul_hi_u32    v10, v0, v10
/*000000000204*/ v_mul_lo_u32    v12, v0, v11
/*00000000020c*/ v_add_u32       v10, vcc, v10, v12
/*000000000210*/ v_addc_u32      v10, vcc, 0, 0, vcc
/*000000000218*/ v_mul_hi_u32    v11, v0, v11
/*000000000220*/ v_add_u32       v10, vcc, v10, v11
/*000000000224*/ v_addc_u32      v11, vcc, 0, 0, vcc
/*00000000022c*/ v_add_u32       v11, vcc, 0, v11
/*000000000230*/ v_mul_lo_u32    v11, v19, v11
/*000000000238*/ v_mul_lo_u32    v12, v20, v10
/*000000000240*/ v_add_u32       v11, vcc, v11, v12
/*000000000244*/ v_mul_hi_u32    v12, v19, v10
/*00000000024c*/ v_add_u32       v11, vcc, v11, v12
/*000000000250*/ v_mul_lo_u32    v12, v19, v10
/*000000000258*/ v_sub_u32       v0, s[12:13], v0, v12
/*000000000260*/ v_subb_u32      v12, vcc, 0, v11, s[12:13]
/*000000000268*/ v_cmp_ge_u32    s[14:15], v0, v19
/*000000000270*/ v_cmp_ge_u32    s[16:17], v12, v20
/*000000000278*/ v_cmp_eq_i32    vcc, v12, v20
/*00000000027c*/ v_cndmask_b32   v12, 0, -1, s[16:17]
/*000000000284*/ v_cndmask_b32   v13, 0, -1, s[14:15]
/*00000000028c*/ v_cndmask_b32   v12, v12, v13, vcc
/*000000000290*/ v_cmp_lg_u32    vcc, 0, v12
/*000000000294*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000298*/ v_sub_u32       v11, vcc, 0, v11
/*00000000029c*/ s_cbranch_execz .L760_47
/*0000000002a0*/ v_sub_u32       v0, s[16:17], v0, v19
/*0000000002a8*/ v_subb_u32      v11, vcc, v11, v20, s[12:13]
/*0000000002b0*/ v_subb_u32      v11, vcc, v11, 0, s[16:17]
/*0000000002b8*/ v_cmp_ge_u32    s[12:13], v0, v19
/*0000000002c0*/ v_cmp_ge_u32    s[16:17], v11, v20
/*0000000002c8*/ v_cmp_eq_i32    vcc, v11, v20
/*0000000002cc*/ v_cndmask_b32   v0, 0, -1, s[16:17]
/*0000000002d4*/ v_cndmask_b32   v7, 0, -1, s[12:13]
/*0000000002dc*/ v_add_u32       v8, s[12:13], v10, 1
/*0000000002e4*/ v_cndmask_b32   v0, v0, v7, vcc
/*0000000002e8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002ec*/ v_add_u32       v0, s[12:13], v8, 1
/*0000000002f4*/ v_cndmask_b32   v10, v8, v0, vcc
.L760_47:
/*0000000002f8*/ s_mov_b64       exec, s[14:15]
/*0000000002fc*/ v_cmp_lg_i64    vcc, 0, v[19:20]
/*000000000300*/ v_cndmask_b32   v0, -1, v10, vcc
.L772_47:
/*000000000304*/ s_mov_b64       exec, s[8:9]
/*000000000308*/ s_lshl_b32      s6, s7, 2
/*00000000030c*/ v_add_u32       v7, vcc, s6, v1
/*000000000310*/ v_add_u32       v5, vcc, s2, v7
/*000000000314*/ v_mov_b32       v6, 0
/*000000000318*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*000000000320*/ v_mov_b32       v8, s11
/*000000000324*/ v_addc_u32      v4, vcc, v8, v4, s[4:5]
/*00000000032c*/ flat_store_dword v[3:4], v0
/*000000000334*/ v_add_u32       v4, s[4:5], s10, v5
/*00000000033c*/ v_add_u32       v18, vcc, v7, s2
/*000000000344*/ v_mov_b32       v3, s3
/*000000000348*/ v_addc_u32      v19, vcc, 0, v3, vcc
/*00000000034c*/ v_cmp_lg_i64    vcc, 1, v[18:19]
/*000000000350*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000354*/ v_cvt_f32_u32   v8, v18
/*000000000358*/ s_cbranch_execz .L1532_47
/*00000000035c*/ v_cvt_f32_u32   v10, v19
/*000000000360*/ v_madmk_f32     v8, v10, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000368*/ v_rcp_f32       v8, v8
/*00000000036c*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*000000000374*/ v_mul_f32       v10, 0x2f800000 /* 2.32830644e-10f */, v8
/*00000000037c*/ v_trunc_f32     v10, v10
/*000000000380*/ v_madmk_f32     v8, v10, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000388*/ v_cvt_u32_f32   v8, v8
/*00000000038c*/ v_cvt_u32_f32   v10, v10
/*000000000390*/ v_sub_u32       v11, vcc, 0, v18
/*000000000394*/ v_subb_u32      v12, vcc, 0, v19, vcc
/*000000000398*/ v_mul_lo_u32    v13, v11, v10
/*0000000003a0*/ v_mul_lo_u32    v14, v12, v8
/*0000000003a8*/ v_add_u32       v13, vcc, v13, v14
/*0000000003ac*/ v_mul_hi_u32    v14, v11, v8
/*0000000003b4*/ v_add_u32       v13, vcc, v13, v14
/*0000000003b8*/ v_mul_lo_u32    v14, v11, v8
/*0000000003c0*/ v_mul_hi_u32    v15, v8, v14
/*0000000003c8*/ v_mul_lo_u32    v16, v10, v14
/*0000000003d0*/ v_add_u32       v15, vcc, v15, v16
/*0000000003d4*/ v_cndmask_b32   v16, 0, 1, vcc
/*0000000003dc*/ v_mul_lo_u32    v17, v8, v13
/*0000000003e4*/ v_add_u32       v15, vcc, v15, v17
/*0000000003e8*/ v_addc_u32      v15, vcc, v16, 0, vcc
/*0000000003f0*/ v_mul_hi_u32    v14, v10, v14
/*0000000003f8*/ v_add_u32       v14, vcc, v15, v14
/*0000000003fc*/ v_cndmask_b32   v15, 0, 1, vcc
/*000000000404*/ v_mul_hi_u32    v16, v8, v13
/*00000000040c*/ v_add_u32       v14, vcc, v14, v16
/*000000000410*/ v_addc_u32      v15, vcc, v15, 0, vcc
/*000000000418*/ v_mul_lo_u32    v16, v10, v13
/*000000000420*/ v_add_u32       v14, vcc, v14, v16
/*000000000424*/ v_mul_hi_u32    v13, v10, v13
/*00000000042c*/ v_addc_u32      v13, vcc, v15, v13, vcc
/*000000000430*/ v_add_u32       v8, s[6:7], v8, v14
/*000000000438*/ v_add_u32       v14, vcc, v10, v13
/*00000000043c*/ v_addc_u32      v10, vcc, v10, v13, s[6:7]
/*000000000444*/ v_mul_lo_u32    v13, v11, v10
/*00000000044c*/ v_mul_lo_u32    v12, v12, v8
/*000000000454*/ v_add_u32       v12, vcc, v13, v12
/*000000000458*/ v_mul_hi_u32    v13, v11, v8
/*000000000460*/ v_add_u32       v12, vcc, v12, v13
/*000000000464*/ v_mul_lo_u32    v11, v11, v8
/*00000000046c*/ v_mul_hi_u32    v13, v8, v11
/*000000000474*/ v_mul_lo_u32    v15, v10, v11
/*00000000047c*/ v_add_u32       v13, vcc, v13, v15
/*000000000480*/ v_cndmask_b32   v15, 0, 1, vcc
/*000000000488*/ v_mul_lo_u32    v16, v8, v12
/*000000000490*/ v_add_u32       v13, vcc, v13, v16
/*000000000494*/ v_addc_u32      v13, vcc, v15, 0, vcc
/*00000000049c*/ v_mul_hi_u32    v11, v10, v11
/*0000000004a4*/ v_add_u32       v11, vcc, v13, v11
/*0000000004a8*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000004b0*/ v_mul_hi_u32    v15, v8, v12
/*0000000004b8*/ v_add_u32       v11, vcc, v11, v15
/*0000000004bc*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*0000000004c4*/ v_mul_lo_u32    v15, v10, v12
/*0000000004cc*/ v_add_u32       v11, vcc, v11, v15
/*0000000004d0*/ v_mul_hi_u32    v10, v10, v12
/*0000000004d8*/ v_addc_u32      v10, vcc, v13, v10, vcc
/*0000000004dc*/ v_add_u32       v8, s[8:9], v8, v11
/*0000000004e4*/ v_addc_u32      v10, vcc, v14, v10, s[6:7]
/*0000000004ec*/ v_addc_u32      v10, vcc, v10, 0, s[8:9]
/*0000000004f4*/ v_mul_hi_u32    v8, v1, v8
/*0000000004fc*/ v_mul_lo_u32    v11, v1, v10
/*000000000504*/ v_add_u32       v8, vcc, v8, v11
/*000000000508*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000510*/ v_mul_hi_u32    v10, v1, v10
/*000000000518*/ v_add_u32       v8, vcc, v8, v10
/*00000000051c*/ v_addc_u32      v10, vcc, 0, 0, vcc
/*000000000524*/ v_add_u32       v10, vcc, 0, v10
/*000000000528*/ v_mul_lo_u32    v10, v18, v10
/*000000000530*/ v_mul_lo_u32    v11, v19, v8
/*000000000538*/ v_add_u32       v10, vcc, v10, v11
/*00000000053c*/ v_mul_hi_u32    v11, v18, v8
/*000000000544*/ v_add_u32       v10, vcc, v10, v11
/*000000000548*/ v_mul_lo_u32    v11, v18, v8
/*000000000550*/ v_sub_u32       v1, s[6:7], v1, v11
/*000000000558*/ v_subb_u32      v11, vcc, 0, v10, s[6:7]
/*000000000560*/ v_cmp_ge_u32    s[8:9], v1, v18
/*000000000568*/ v_cmp_ge_u32    s[12:13], v11, v19
/*000000000570*/ v_cmp_eq_i32    vcc, v11, v19
/*000000000574*/ v_cndmask_b32   v11, 0, -1, s[12:13]
/*00000000057c*/ v_cndmask_b32   v12, 0, -1, s[8:9]
/*000000000584*/ v_cndmask_b32   v11, v11, v12, vcc
/*000000000588*/ v_cmp_lg_u32    vcc, 0, v11
/*00000000058c*/ s_and_saveexec_b64 s[8:9], vcc
/*000000000590*/ v_sub_u32       v10, vcc, 0, v10
/*000000000594*/ s_cbranch_execz .L1520_47
/*000000000598*/ v_sub_u32       v1, s[12:13], v1, v18
/*0000000005a0*/ v_subb_u32      v10, vcc, v10, v19, s[6:7]
/*0000000005a8*/ v_subb_u32      v10, vcc, v10, 0, s[12:13]
/*0000000005b0*/ v_cmp_ge_u32    s[6:7], v1, v18
/*0000000005b8*/ v_cmp_ge_u32    s[12:13], v10, v19
/*0000000005c0*/ v_cmp_eq_i32    vcc, v10, v19
/*0000000005c4*/ v_cndmask_b32   v0, 0, -1, s[12:13]
/*0000000005cc*/ v_cndmask_b32   v1, 0, -1, s[6:7]
/*0000000005d4*/ v_add_u32       v7, s[6:7], v8, 1
/*0000000005dc*/ v_cndmask_b32   v0, v0, v1, vcc
/*0000000005e0*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000005e4*/ v_add_u32       v0, s[6:7], v7, 1
/*0000000005ec*/ v_cndmask_b32   v8, v7, v0, vcc
.L1520_47:
/*0000000005f0*/ s_mov_b64       exec, s[8:9]
/*0000000005f4*/ v_cmp_lg_i64    vcc, 0, v[18:19]
/*0000000005f8*/ v_cndmask_b32   v7, -1, v8, vcc
.L1532_47:
/*0000000005fc*/ s_andn2_b64     exec, s[2:3], exec
/*000000000600*/ v_mov_b32       v7, v1
/*000000000604*/ s_mov_b64       exec, s[2:3]
/*000000000608*/ s_waitcnt       lgkmcnt(0)
/*00000000060c*/ v_add_u32       v0, vcc, s0, v9
/*000000000610*/ v_mov_b32       v1, 0
/*000000000614*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000061c*/ v_mov_b32       v8, s11
/*000000000620*/ v_addc_u32      v5, vcc, v8, v6, s[4:5]
/*000000000628*/ flat_store_dword v[4:5], v7
/*000000000630*/ v_add_u32       v0, vcc, s10, v0
/*000000000634*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000638*/ v_add_u32       v16, vcc, v9, s0
/*000000000640*/ v_mov_b32       v3, s1
/*000000000644*/ v_addc_u32      v17, vcc, 0, v3, vcc
/*000000000648*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*00000000064c*/ s_and_b64       exec, s[2:3], vcc
/*000000000650*/ v_cvt_f32_u32   v7, v16
/*000000000654*/ s_cbranch_execz .L2296_47
/*000000000658*/ v_cvt_f32_u32   v8, v17
/*00000000065c*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000664*/ v_rcp_f32       v7, v7
/*000000000668*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*000000000670*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000678*/ v_trunc_f32     v8, v8
/*00000000067c*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*000000000684*/ v_cvt_u32_f32   v7, v7
/*000000000688*/ v_cvt_u32_f32   v8, v8
/*00000000068c*/ v_sub_u32       v9, vcc, 0, v16
/*000000000690*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*000000000694*/ v_mul_lo_u32    v11, v9, v8
/*00000000069c*/ v_mul_lo_u32    v12, v10, v7
/*0000000006a4*/ v_add_u32       v11, vcc, v11, v12
/*0000000006a8*/ v_mul_hi_u32    v12, v9, v7
/*0000000006b0*/ v_add_u32       v11, vcc, v11, v12
/*0000000006b4*/ v_mul_lo_u32    v12, v9, v7
/*0000000006bc*/ v_mul_hi_u32    v13, v7, v12
/*0000000006c4*/ v_mul_lo_u32    v14, v8, v12
/*0000000006cc*/ v_add_u32       v13, vcc, v13, v14
/*0000000006d0*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000006d8*/ v_mul_lo_u32    v15, v7, v11
/*0000000006e0*/ v_add_u32       v13, vcc, v13, v15
/*0000000006e4*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*0000000006ec*/ v_mul_hi_u32    v12, v8, v12
/*0000000006f4*/ v_add_u32       v12, vcc, v13, v12
/*0000000006f8*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000700*/ v_mul_hi_u32    v14, v7, v11
/*000000000708*/ v_add_u32       v12, vcc, v12, v14
/*00000000070c*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000714*/ v_mul_lo_u32    v14, v8, v11
/*00000000071c*/ v_add_u32       v12, vcc, v12, v14
/*000000000720*/ v_mul_hi_u32    v11, v8, v11
/*000000000728*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*00000000072c*/ v_add_u32       v7, s[0:1], v7, v12
/*000000000734*/ v_add_u32       v12, vcc, v8, v11
/*000000000738*/ v_addc_u32      v8, vcc, v8, v11, s[0:1]
/*000000000740*/ v_mul_lo_u32    v11, v9, v8
/*000000000748*/ v_mul_lo_u32    v10, v10, v7
/*000000000750*/ v_add_u32       v10, vcc, v11, v10
/*000000000754*/ v_mul_hi_u32    v11, v9, v7
/*00000000075c*/ v_add_u32       v10, vcc, v10, v11
/*000000000760*/ v_mul_lo_u32    v9, v9, v7
/*000000000768*/ v_mul_hi_u32    v11, v7, v9
/*000000000770*/ v_mul_lo_u32    v13, v8, v9
/*000000000778*/ v_add_u32       v11, vcc, v11, v13
/*00000000077c*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000784*/ v_mul_lo_u32    v14, v7, v10
/*00000000078c*/ v_add_u32       v11, vcc, v11, v14
/*000000000790*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*000000000798*/ v_mul_hi_u32    v9, v8, v9
/*0000000007a0*/ v_add_u32       v9, vcc, v11, v9
/*0000000007a4*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000007ac*/ v_mul_hi_u32    v13, v7, v10
/*0000000007b4*/ v_add_u32       v9, vcc, v9, v13
/*0000000007b8*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000007c0*/ v_mul_lo_u32    v13, v8, v10
/*0000000007c8*/ v_add_u32       v9, vcc, v9, v13
/*0000000007cc*/ v_mul_hi_u32    v8, v8, v10
/*0000000007d4*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000007d8*/ v_add_u32       v7, s[4:5], v7, v9
/*0000000007e0*/ v_addc_u32      v8, vcc, v12, v8, s[0:1]
/*0000000007e8*/ v_addc_u32      v8, vcc, v8, 0, s[4:5]
/*0000000007f0*/ v_mul_hi_u32    v7, v2, v7
/*0000000007f8*/ v_mul_lo_u32    v9, v2, v8
/*000000000800*/ v_add_u32       v7, vcc, v7, v9
/*000000000804*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*00000000080c*/ v_mul_hi_u32    v8, v2, v8
/*000000000814*/ v_add_u32       v7, vcc, v7, v8
/*000000000818*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000820*/ v_add_u32       v8, vcc, 0, v8
/*000000000824*/ v_mul_lo_u32    v8, v16, v8
/*00000000082c*/ v_mul_lo_u32    v9, v17, v7
/*000000000834*/ v_add_u32       v8, vcc, v8, v9
/*000000000838*/ v_mul_hi_u32    v9, v16, v7
/*000000000840*/ v_add_u32       v8, vcc, v8, v9
/*000000000844*/ v_mul_lo_u32    v9, v16, v7
/*00000000084c*/ v_sub_u32       v2, s[0:1], v2, v9
/*000000000854*/ v_subb_u32      v9, vcc, 0, v8, s[0:1]
/*00000000085c*/ v_cmp_ge_u32    s[4:5], v2, v16
/*000000000864*/ v_cmp_ge_u32    s[6:7], v9, v17
/*00000000086c*/ v_cmp_eq_i32    vcc, v9, v17
/*000000000870*/ v_cndmask_b32   v9, 0, -1, s[6:7]
/*000000000878*/ v_cndmask_b32   v10, 0, -1, s[4:5]
/*000000000880*/ v_cndmask_b32   v9, v9, v10, vcc
/*000000000884*/ v_cmp_lg_u32    vcc, 0, v9
/*000000000888*/ s_and_saveexec_b64 s[4:5], vcc
/*00000000088c*/ v_sub_u32       v8, vcc, 0, v8
/*000000000890*/ s_cbranch_execz .L2284_47
/*000000000894*/ v_sub_u32       v2, s[6:7], v2, v16
/*00000000089c*/ v_subb_u32      v8, vcc, v8, v17, s[0:1]
/*0000000008a4*/ v_subb_u32      v8, vcc, v8, 0, s[6:7]
/*0000000008ac*/ v_cmp_ge_u32    s[0:1], v2, v16
/*0000000008b4*/ v_cmp_ge_u32    s[6:7], v8, v17
/*0000000008bc*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000008c0*/ v_cndmask_b32   v2, 0, -1, s[6:7]
/*0000000008c8*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000008d0*/ v_add_u32       v6, s[0:1], v7, 1
/*0000000008d8*/ v_cndmask_b32   v2, v2, v5, vcc
/*0000000008dc*/ v_cmp_lg_u32    vcc, 0, v2
/*0000000008e0*/ v_add_u32       v2, s[0:1], v6, 1
/*0000000008e8*/ v_cndmask_b32   v7, v6, v2, vcc
.L2284_47:
/*0000000008ec*/ s_mov_b64       exec, s[4:5]
/*0000000008f0*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*0000000008f4*/ v_cndmask_b32   v2, -1, v7, vcc
.L2296_47:
/*0000000008f8*/ s_mov_b64       exec, s[2:3]
/*0000000008fc*/ flat_store_dword v[0:1], v2
/*000000000904*/ s_endpgm
.kernel div_get_group_id_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 25
        .vgprsnum 19
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s9, s6, 1
/*000000000014*/ v_add_u32       v0, vcc, s9, v0
/*000000000018*/ s_lshl_b32      s9, s8, 1
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ v_add_u32       v3, vcc, s0, v0
/*000000000024*/ v_add_u32       v17, vcc, v0, s0
/*00000000002c*/ v_mov_b32       v4, s1
/*000000000030*/ v_addc_u32      v18, vcc, 0, v4, vcc
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000048*/ v_add_u32       v6, vcc, s9, v2
/*00000000004c*/ v_add_u32       v3, s[4:5], s10, v3
/*000000000054*/ v_cmp_lg_i64    vcc, 1, v[17:18]
/*000000000058*/ s_and_saveexec_b64 s[12:13], vcc
/*00000000005c*/ v_cvt_f32_u32   v8, v17
/*000000000060*/ s_cbranch_execz .L772_48
/*000000000064*/ v_cvt_f32_u32   v9, v18
/*000000000068*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000070*/ v_rcp_f32       v8, v8
/*000000000074*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*00000000007c*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000084*/ v_trunc_f32     v9, v9
/*000000000088*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000090*/ v_cvt_u32_f32   v8, v8
/*000000000094*/ v_cvt_u32_f32   v9, v9
/*000000000098*/ v_sub_u32       v10, vcc, 0, v17
/*00000000009c*/ v_subb_u32      v11, vcc, 0, v18, vcc
/*0000000000a0*/ v_mul_lo_u32    v12, v10, v9
/*0000000000a8*/ v_mul_lo_u32    v13, v11, v8
/*0000000000b0*/ v_add_u32       v12, vcc, v12, v13
/*0000000000b4*/ v_mul_hi_u32    v13, v10, v8
/*0000000000bc*/ v_add_u32       v12, vcc, v12, v13
/*0000000000c0*/ v_mul_lo_u32    v13, v10, v8
/*0000000000c8*/ v_mul_hi_u32    v14, v8, v13
/*0000000000d0*/ v_mul_lo_u32    v15, v9, v13
/*0000000000d8*/ v_add_u32       v14, vcc, v14, v15
/*0000000000dc*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000e4*/ v_mul_lo_u32    v16, v8, v12
/*0000000000ec*/ v_add_u32       v14, vcc, v14, v16
/*0000000000f0*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000f8*/ v_mul_hi_u32    v13, v9, v13
/*000000000100*/ v_add_u32       v13, vcc, v14, v13
/*000000000104*/ v_cndmask_b32   v14, 0, 1, vcc
/*00000000010c*/ v_mul_hi_u32    v15, v8, v12
/*000000000114*/ v_add_u32       v13, vcc, v13, v15
/*000000000118*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*000000000120*/ v_mul_lo_u32    v15, v9, v12
/*000000000128*/ v_add_u32       v13, vcc, v13, v15
/*00000000012c*/ v_mul_hi_u32    v12, v9, v12
/*000000000134*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000138*/ v_add_u32       v8, s[14:15], v8, v13
/*000000000140*/ v_add_u32       v13, vcc, v9, v12
/*000000000144*/ v_addc_u32      v9, vcc, v9, v12, s[14:15]
/*00000000014c*/ v_mul_lo_u32    v12, v10, v9
/*000000000154*/ v_mul_lo_u32    v11, v11, v8
/*00000000015c*/ v_add_u32       v11, vcc, v12, v11
/*000000000160*/ v_mul_hi_u32    v12, v10, v8
/*000000000168*/ v_add_u32       v11, vcc, v11, v12
/*00000000016c*/ v_mul_lo_u32    v10, v10, v8
/*000000000174*/ v_mul_hi_u32    v12, v8, v10
/*00000000017c*/ v_mul_lo_u32    v14, v9, v10
/*000000000184*/ v_add_u32       v12, vcc, v12, v14
/*000000000188*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000190*/ v_mul_lo_u32    v15, v8, v11
/*000000000198*/ v_add_u32       v12, vcc, v12, v15
/*00000000019c*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*0000000001a4*/ v_mul_hi_u32    v10, v9, v10
/*0000000001ac*/ v_add_u32       v10, vcc, v12, v10
/*0000000001b0*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001b8*/ v_mul_hi_u32    v14, v8, v11
/*0000000001c0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001c4*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001cc*/ v_mul_lo_u32    v14, v9, v11
/*0000000001d4*/ v_add_u32       v10, vcc, v10, v14
/*0000000001d8*/ v_mul_hi_u32    v9, v9, v11
/*0000000001e0*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001e4*/ v_add_u32       v8, s[16:17], v8, v10
/*0000000001ec*/ v_addc_u32      v9, vcc, v13, v9, s[14:15]
/*0000000001f4*/ v_addc_u32      v9, vcc, v9, 0, s[16:17]
/*0000000001fc*/ v_mul_hi_u32    v8, s6, v8
/*000000000204*/ v_mul_lo_u32    v10, s6, v9
/*00000000020c*/ v_add_u32       v8, vcc, v8, v10
/*000000000210*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000218*/ v_mul_hi_u32    v9, s6, v9
/*000000000220*/ v_add_u32       v8, vcc, v8, v9
/*000000000224*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*00000000022c*/ v_add_u32       v9, vcc, 0, v9
/*000000000230*/ v_mul_lo_u32    v9, v17, v9
/*000000000238*/ v_mul_lo_u32    v10, v18, v8
/*000000000240*/ v_add_u32       v9, vcc, v9, v10
/*000000000244*/ v_mul_hi_u32    v10, v17, v8
/*00000000024c*/ v_add_u32       v9, vcc, v9, v10
/*000000000250*/ v_mul_lo_u32    v10, v17, v8
/*000000000258*/ v_sub_u32       v10, s[14:15], s6, v10
/*000000000260*/ v_subb_u32      v11, vcc, 0, v9, s[14:15]
/*000000000268*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000270*/ v_cmp_ge_u32    s[18:19], v11, v18
/*000000000278*/ v_cmp_eq_i32    vcc, v11, v18
/*00000000027c*/ v_cndmask_b32   v11, 0, -1, s[18:19]
/*000000000284*/ v_cndmask_b32   v12, 0, -1, s[16:17]
/*00000000028c*/ v_cndmask_b32   v11, v11, v12, vcc
/*000000000290*/ v_cmp_lg_u32    vcc, 0, v11
/*000000000294*/ s_and_saveexec_b64 s[16:17], vcc
/*000000000298*/ v_sub_u32       v9, vcc, 0, v9
/*00000000029c*/ s_cbranch_execz .L760_48
/*0000000002a0*/ v_sub_u32       v10, s[18:19], v10, v17
/*0000000002a8*/ v_subb_u32      v9, vcc, v9, v18, s[14:15]
/*0000000002b0*/ v_subb_u32      v9, vcc, v9, 0, s[18:19]
/*0000000002b8*/ v_cmp_ge_u32    s[14:15], v10, v17
/*0000000002c0*/ v_cmp_ge_u32    s[18:19], v9, v18
/*0000000002c8*/ v_cmp_eq_i32    vcc, v9, v18
/*0000000002cc*/ v_cndmask_b32   v0, 0, -1, s[18:19]
/*0000000002d4*/ v_cndmask_b32   v5, 0, -1, s[14:15]
/*0000000002dc*/ v_add_u32       v8, s[14:15], v8, 1
/*0000000002e4*/ v_cndmask_b32   v0, v0, v5, vcc
/*0000000002e8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002ec*/ v_add_u32       v0, s[14:15], v8, 1
/*0000000002f4*/ v_cndmask_b32   v8, v8, v0, vcc
.L760_48:
/*0000000002f8*/ s_mov_b64       exec, s[16:17]
/*0000000002fc*/ v_cmp_lg_i64    vcc, 0, v[17:18]
/*000000000300*/ v_cndmask_b32   v5, -1, v8, vcc
.L772_48:
/*000000000304*/ s_andn2_b64     exec, s[12:13], exec
/*000000000308*/ v_mov_b32       v5, s6
/*00000000030c*/ s_mov_b64       exec, s[12:13]
/*000000000310*/ s_lshl_b32      s6, s7, 4
/*000000000314*/ v_add_u32       v8, vcc, s6, v1
/*000000000318*/ v_add_u32       v0, vcc, s2, v8
/*00000000031c*/ v_mov_b32       v1, 0
/*000000000320*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000328*/ v_mov_b32       v2, s11
/*00000000032c*/ v_addc_u32      v4, vcc, v2, v4, s[4:5]
/*000000000334*/ flat_store_dword v[3:4], v5
/*00000000033c*/ v_add_u32       v0, s[4:5], s10, v0
/*000000000344*/ v_add_u32       v16, vcc, v8, s2
/*00000000034c*/ v_mov_b32       v2, s3
/*000000000350*/ v_addc_u32      v17, vcc, 0, v2, vcc
/*000000000354*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000358*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000035c*/ v_cvt_f32_u32   v7, v16
/*000000000360*/ s_cbranch_execz .L1540_48
/*000000000364*/ v_cvt_f32_u32   v8, v17
/*000000000368*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000370*/ v_rcp_f32       v7, v7
/*000000000374*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*00000000037c*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000384*/ v_trunc_f32     v8, v8
/*000000000388*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*000000000390*/ v_cvt_u32_f32   v7, v7
/*000000000394*/ v_cvt_u32_f32   v8, v8
/*000000000398*/ v_sub_u32       v9, vcc, 0, v16
/*00000000039c*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*0000000003a0*/ v_mul_lo_u32    v11, v9, v8
/*0000000003a8*/ v_mul_lo_u32    v12, v10, v7
/*0000000003b0*/ v_add_u32       v11, vcc, v11, v12
/*0000000003b4*/ v_mul_hi_u32    v12, v9, v7
/*0000000003bc*/ v_add_u32       v11, vcc, v11, v12
/*0000000003c0*/ v_mul_lo_u32    v12, v9, v7
/*0000000003c8*/ v_mul_hi_u32    v13, v7, v12
/*0000000003d0*/ v_mul_lo_u32    v14, v8, v12
/*0000000003d8*/ v_add_u32       v13, vcc, v13, v14
/*0000000003dc*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000003e4*/ v_mul_lo_u32    v15, v7, v11
/*0000000003ec*/ v_add_u32       v13, vcc, v13, v15
/*0000000003f0*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*0000000003f8*/ v_mul_hi_u32    v12, v8, v12
/*000000000400*/ v_add_u32       v12, vcc, v13, v12
/*000000000404*/ v_cndmask_b32   v13, 0, 1, vcc
/*00000000040c*/ v_mul_hi_u32    v14, v7, v11
/*000000000414*/ v_add_u32       v12, vcc, v12, v14
/*000000000418*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000420*/ v_mul_lo_u32    v14, v8, v11
/*000000000428*/ v_add_u32       v12, vcc, v12, v14
/*00000000042c*/ v_mul_hi_u32    v11, v8, v11
/*000000000434*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000438*/ v_add_u32       v7, s[12:13], v7, v12
/*000000000440*/ v_add_u32       v12, vcc, v8, v11
/*000000000444*/ v_addc_u32      v8, vcc, v8, v11, s[12:13]
/*00000000044c*/ v_mul_lo_u32    v11, v9, v8
/*000000000454*/ v_mul_lo_u32    v10, v10, v7
/*00000000045c*/ v_add_u32       v10, vcc, v11, v10
/*000000000460*/ v_mul_hi_u32    v11, v9, v7
/*000000000468*/ v_add_u32       v10, vcc, v10, v11
/*00000000046c*/ v_mul_lo_u32    v9, v9, v7
/*000000000474*/ v_mul_hi_u32    v11, v7, v9
/*00000000047c*/ v_mul_lo_u32    v13, v8, v9
/*000000000484*/ v_add_u32       v11, vcc, v11, v13
/*000000000488*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000490*/ v_mul_lo_u32    v14, v7, v10
/*000000000498*/ v_add_u32       v11, vcc, v11, v14
/*00000000049c*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000004a4*/ v_mul_hi_u32    v9, v8, v9
/*0000000004ac*/ v_add_u32       v9, vcc, v11, v9
/*0000000004b0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004b8*/ v_mul_hi_u32    v13, v7, v10
/*0000000004c0*/ v_add_u32       v9, vcc, v9, v13
/*0000000004c4*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004cc*/ v_mul_lo_u32    v13, v8, v10
/*0000000004d4*/ v_add_u32       v9, vcc, v9, v13
/*0000000004d8*/ v_mul_hi_u32    v8, v8, v10
/*0000000004e0*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000004e4*/ v_add_u32       v7, s[14:15], v7, v9
/*0000000004ec*/ v_addc_u32      v8, vcc, v12, v8, s[12:13]
/*0000000004f4*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*0000000004fc*/ v_mul_hi_u32    v7, s7, v7
/*000000000504*/ v_mul_lo_u32    v9, s7, v8
/*00000000050c*/ v_add_u32       v7, vcc, v7, v9
/*000000000510*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000518*/ v_mul_hi_u32    v8, s7, v8
/*000000000520*/ v_add_u32       v7, vcc, v7, v8
/*000000000524*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*00000000052c*/ v_add_u32       v8, vcc, 0, v8
/*000000000530*/ v_mul_lo_u32    v8, v16, v8
/*000000000538*/ v_mul_lo_u32    v9, v17, v7
/*000000000540*/ v_add_u32       v8, vcc, v8, v9
/*000000000544*/ v_mul_hi_u32    v9, v16, v7
/*00000000054c*/ v_add_u32       v8, vcc, v8, v9
/*000000000550*/ v_mul_lo_u32    v9, v16, v7
/*000000000558*/ v_sub_u32       v9, s[12:13], s7, v9
/*000000000560*/ v_subb_u32      v10, vcc, 0, v8, s[12:13]
/*000000000568*/ v_cmp_ge_u32    s[14:15], v9, v16
/*000000000570*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000578*/ v_cmp_eq_i32    vcc, v10, v17
/*00000000057c*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*000000000584*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*00000000058c*/ v_cndmask_b32   v10, v10, v11, vcc
/*000000000590*/ v_cmp_lg_u32    vcc, 0, v10
/*000000000594*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000598*/ v_sub_u32       v8, vcc, 0, v8
/*00000000059c*/ s_cbranch_execz .L1528_48
/*0000000005a0*/ v_sub_u32       v9, s[16:17], v9, v16
/*0000000005a8*/ v_subb_u32      v8, vcc, v8, v17, s[12:13]
/*0000000005b0*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*0000000005b8*/ v_cmp_ge_u32    s[12:13], v9, v16
/*0000000005c0*/ v_cmp_ge_u32    s[16:17], v8, v17
/*0000000005c8*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005cc*/ v_cndmask_b32   v4, 0, -1, s[16:17]
/*0000000005d4*/ v_cndmask_b32   v5, 0, -1, s[12:13]
/*0000000005dc*/ v_add_u32       v7, s[12:13], v7, 1
/*0000000005e4*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005e8*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005ec*/ v_add_u32       v4, s[12:13], v7, 1
/*0000000005f4*/ v_cndmask_b32   v7, v7, v4, vcc
.L1528_48:
/*0000000005f8*/ s_mov_b64       exec, s[14:15]
/*0000000005fc*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*000000000600*/ v_cndmask_b32   v4, -1, v7, vcc
.L1540_48:
/*000000000604*/ s_andn2_b64     exec, s[2:3], exec
/*000000000608*/ v_mov_b32       v4, s7
/*00000000060c*/ s_mov_b64       exec, s[2:3]
/*000000000610*/ s_waitcnt       lgkmcnt(0)
/*000000000614*/ v_add_u32       v2, vcc, s0, v6
/*000000000618*/ v_mov_b32       v3, 0
/*00000000061c*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000624*/ v_mov_b32       v5, s11
/*000000000628*/ v_addc_u32      v1, vcc, v5, v1, s[4:5]
/*000000000630*/ flat_store_dword v[0:1], v4
/*000000000638*/ v_add_u32       v0, vcc, s10, v2
/*00000000063c*/ v_addc_u32      v1, vcc, v5, v3, vcc
/*000000000640*/ v_add_u32       v15, vcc, v6, s0
/*000000000648*/ v_mov_b32       v2, s1
/*00000000064c*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*000000000650*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000654*/ s_and_b64       exec, s[2:3], vcc
/*000000000658*/ v_cvt_f32_u32   v6, v15
/*00000000065c*/ s_cbranch_execz .L2304_48
/*000000000660*/ v_cvt_f32_u32   v7, v16
/*000000000664*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*00000000066c*/ v_rcp_f32       v6, v6
/*000000000670*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000678*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000680*/ v_trunc_f32     v7, v7
/*000000000684*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*00000000068c*/ v_cvt_u32_f32   v6, v6
/*000000000690*/ v_cvt_u32_f32   v7, v7
/*000000000694*/ v_sub_u32       v8, vcc, 0, v15
/*000000000698*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*00000000069c*/ v_mul_lo_u32    v10, v8, v7
/*0000000006a4*/ v_mul_lo_u32    v11, v9, v6
/*0000000006ac*/ v_add_u32       v10, vcc, v10, v11
/*0000000006b0*/ v_mul_hi_u32    v11, v8, v6
/*0000000006b8*/ v_add_u32       v10, vcc, v10, v11
/*0000000006bc*/ v_mul_lo_u32    v11, v8, v6
/*0000000006c4*/ v_mul_hi_u32    v12, v6, v11
/*0000000006cc*/ v_mul_lo_u32    v13, v7, v11
/*0000000006d4*/ v_add_u32       v12, vcc, v12, v13
/*0000000006d8*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006e0*/ v_mul_lo_u32    v14, v6, v10
/*0000000006e8*/ v_add_u32       v12, vcc, v12, v14
/*0000000006ec*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*0000000006f4*/ v_mul_hi_u32    v11, v7, v11
/*0000000006fc*/ v_add_u32       v11, vcc, v12, v11
/*000000000700*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000708*/ v_mul_hi_u32    v13, v6, v10
/*000000000710*/ v_add_u32       v11, vcc, v11, v13
/*000000000714*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*00000000071c*/ v_mul_lo_u32    v13, v7, v10
/*000000000724*/ v_add_u32       v11, vcc, v11, v13
/*000000000728*/ v_mul_hi_u32    v10, v7, v10
/*000000000730*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000734*/ v_add_u32       v6, s[0:1], v6, v11
/*00000000073c*/ v_add_u32       v11, vcc, v7, v10
/*000000000740*/ v_addc_u32      v7, vcc, v7, v10, s[0:1]
/*000000000748*/ v_mul_lo_u32    v10, v8, v7
/*000000000750*/ v_mul_lo_u32    v9, v9, v6
/*000000000758*/ v_add_u32       v9, vcc, v10, v9
/*00000000075c*/ v_mul_hi_u32    v10, v8, v6
/*000000000764*/ v_add_u32       v9, vcc, v9, v10
/*000000000768*/ v_mul_lo_u32    v8, v8, v6
/*000000000770*/ v_mul_hi_u32    v10, v6, v8
/*000000000778*/ v_mul_lo_u32    v12, v7, v8
/*000000000780*/ v_add_u32       v10, vcc, v10, v12
/*000000000784*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000078c*/ v_mul_lo_u32    v13, v6, v9
/*000000000794*/ v_add_u32       v10, vcc, v10, v13
/*000000000798*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007a0*/ v_mul_hi_u32    v8, v7, v8
/*0000000007a8*/ v_add_u32       v8, vcc, v10, v8
/*0000000007ac*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007b4*/ v_mul_hi_u32    v12, v6, v9
/*0000000007bc*/ v_add_u32       v8, vcc, v8, v12
/*0000000007c0*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007c8*/ v_mul_lo_u32    v12, v7, v9
/*0000000007d0*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d4*/ v_mul_hi_u32    v7, v7, v9
/*0000000007dc*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007e0*/ v_add_u32       v6, s[4:5], v6, v8
/*0000000007e8*/ v_addc_u32      v7, vcc, v11, v7, s[0:1]
/*0000000007f0*/ v_addc_u32      v7, vcc, v7, 0, s[4:5]
/*0000000007f8*/ v_mul_hi_u32    v6, s8, v6
/*000000000800*/ v_mul_lo_u32    v8, s8, v7
/*000000000808*/ v_add_u32       v6, vcc, v6, v8
/*00000000080c*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000814*/ v_mul_hi_u32    v7, s8, v7
/*00000000081c*/ v_add_u32       v6, vcc, v6, v7
/*000000000820*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000828*/ v_add_u32       v7, vcc, 0, v7
/*00000000082c*/ v_mul_lo_u32    v7, v15, v7
/*000000000834*/ v_mul_lo_u32    v8, v16, v6
/*00000000083c*/ v_add_u32       v7, vcc, v7, v8
/*000000000840*/ v_mul_hi_u32    v8, v15, v6
/*000000000848*/ v_add_u32       v7, vcc, v7, v8
/*00000000084c*/ v_mul_lo_u32    v8, v15, v6
/*000000000854*/ v_sub_u32       v8, s[0:1], s8, v8
/*00000000085c*/ v_subb_u32      v9, vcc, 0, v7, s[0:1]
/*000000000864*/ v_cmp_ge_u32    s[4:5], v8, v15
/*00000000086c*/ v_cmp_ge_u32    s[6:7], v9, v16
/*000000000874*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000878*/ v_cndmask_b32   v9, 0, -1, s[6:7]
/*000000000880*/ v_cndmask_b32   v10, 0, -1, s[4:5]
/*000000000888*/ v_cndmask_b32   v9, v9, v10, vcc
/*00000000088c*/ v_cmp_lg_u32    vcc, 0, v9
/*000000000890*/ s_and_saveexec_b64 s[4:5], vcc
/*000000000894*/ v_sub_u32       v7, vcc, 0, v7
/*000000000898*/ s_cbranch_execz .L2292_48
/*00000000089c*/ v_sub_u32       v8, s[6:7], v8, v15
/*0000000008a4*/ v_subb_u32      v7, vcc, v7, v16, s[0:1]
/*0000000008ac*/ v_subb_u32      v7, vcc, v7, 0, s[6:7]
/*0000000008b4*/ v_cmp_ge_u32    s[0:1], v8, v15
/*0000000008bc*/ v_cmp_ge_u32    s[6:7], v7, v16
/*0000000008c4*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008c8*/ v_cndmask_b32   v4, 0, -1, s[6:7]
/*0000000008d0*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000008d8*/ v_add_u32       v6, s[0:1], v6, 1
/*0000000008e0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008e4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000008e8*/ v_add_u32       v4, s[0:1], v6, 1
/*0000000008f0*/ v_cndmask_b32   v6, v6, v4, vcc
.L2292_48:
/*0000000008f4*/ s_mov_b64       exec, s[4:5]
/*0000000008f8*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*0000000008fc*/ v_cndmask_b32   v2, -1, v6, vcc
.L2304_48:
/*000000000900*/ s_andn2_b64     exec, s[2:3], exec
/*000000000904*/ v_mov_b32       v2, s8
/*000000000908*/ s_mov_b64       exec, s[2:3]
/*00000000090c*/ flat_store_dword v[0:1], v2
/*000000000914*/ s_endpgm
.kernel div_get_local_size_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 18
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_lshl_b32      s6, s6, 1
/*000000000014*/ v_add_u32       v0, vcc, s6, v0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ v_add_u32       v3, vcc, s0, v0
/*000000000020*/ v_add_u32       v5, vcc, v0, s0
/*000000000028*/ v_mov_b32       v4, s1
/*00000000002c*/ v_addc_u32      v6, vcc, 0, v4, vcc
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000003c*/ v_add_u32       v3, s[0:1], s10, v3
/*000000000044*/ v_cmp_lg_i64    vcc, 1, v[5:6]
/*000000000048*/ s_and_saveexec_b64 s[12:13], vcc
/*00000000004c*/ v_cvt_f32_u32   v8, v5
/*000000000050*/ s_cbranch_execz .L756_49
/*000000000054*/ v_cvt_f32_u32   v9, v6
/*000000000058*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000060*/ v_rcp_f32       v8, v8
/*000000000064*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*00000000006c*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000074*/ v_trunc_f32     v9, v9
/*000000000078*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000080*/ v_cvt_u32_f32   v8, v8
/*000000000084*/ v_cvt_u32_f32   v9, v9
/*000000000088*/ v_sub_u32       v10, vcc, 0, v5
/*00000000008c*/ v_subb_u32      v11, vcc, 0, v6, vcc
/*000000000090*/ v_mul_lo_u32    v12, v10, v9
/*000000000098*/ v_mul_lo_u32    v13, v11, v8
/*0000000000a0*/ v_add_u32       v12, vcc, v12, v13
/*0000000000a4*/ v_mul_hi_u32    v13, v10, v8
/*0000000000ac*/ v_add_u32       v12, vcc, v12, v13
/*0000000000b0*/ v_mul_lo_u32    v13, v10, v8
/*0000000000b8*/ v_mul_hi_u32    v14, v8, v13
/*0000000000c0*/ v_mul_lo_u32    v15, v9, v13
/*0000000000c8*/ v_add_u32       v14, vcc, v14, v15
/*0000000000cc*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000d4*/ v_mul_lo_u32    v16, v8, v12
/*0000000000dc*/ v_add_u32       v14, vcc, v14, v16
/*0000000000e0*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000e8*/ v_mul_hi_u32    v13, v9, v13
/*0000000000f0*/ v_add_u32       v13, vcc, v14, v13
/*0000000000f4*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000000fc*/ v_mul_hi_u32    v15, v8, v12
/*000000000104*/ v_add_u32       v13, vcc, v13, v15
/*000000000108*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*000000000110*/ v_mul_lo_u32    v15, v9, v12
/*000000000118*/ v_add_u32       v13, vcc, v13, v15
/*00000000011c*/ v_mul_hi_u32    v12, v9, v12
/*000000000124*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000128*/ v_add_u32       v8, s[14:15], v8, v13
/*000000000130*/ v_add_u32       v13, vcc, v9, v12
/*000000000134*/ v_addc_u32      v9, vcc, v9, v12, s[14:15]
/*00000000013c*/ v_mul_lo_u32    v12, v10, v9
/*000000000144*/ v_mul_lo_u32    v11, v11, v8
/*00000000014c*/ v_add_u32       v11, vcc, v12, v11
/*000000000150*/ v_mul_hi_u32    v12, v10, v8
/*000000000158*/ v_add_u32       v11, vcc, v11, v12
/*00000000015c*/ v_mul_lo_u32    v10, v10, v8
/*000000000164*/ v_mul_hi_u32    v12, v8, v10
/*00000000016c*/ v_mul_lo_u32    v14, v9, v10
/*000000000174*/ v_add_u32       v12, vcc, v12, v14
/*000000000178*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000180*/ v_mul_lo_u32    v15, v8, v11
/*000000000188*/ v_add_u32       v12, vcc, v12, v15
/*00000000018c*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*000000000194*/ v_mul_hi_u32    v10, v9, v10
/*00000000019c*/ v_add_u32       v10, vcc, v12, v10
/*0000000001a0*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001a8*/ v_mul_hi_u32    v14, v8, v11
/*0000000001b0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001b4*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001bc*/ v_mul_lo_u32    v14, v9, v11
/*0000000001c4*/ v_add_u32       v10, vcc, v10, v14
/*0000000001c8*/ v_mul_hi_u32    v9, v9, v11
/*0000000001d0*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001d4*/ v_add_u32       v8, s[16:17], v8, v10
/*0000000001dc*/ v_addc_u32      v9, vcc, v13, v9, s[14:15]
/*0000000001e4*/ v_addc_u32      v9, vcc, v9, 0, s[16:17]
/*0000000001ec*/ v_mul_hi_u32    v8, 2, v8
/*0000000001f4*/ v_mul_lo_u32    v10, 2, v9
/*0000000001fc*/ v_add_u32       v8, vcc, v8, v10
/*000000000200*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000208*/ v_mul_hi_u32    v9, 2, v9
/*000000000210*/ v_add_u32       v8, vcc, v8, v9
/*000000000214*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*00000000021c*/ v_add_u32       v9, vcc, 0, v9
/*000000000220*/ v_mul_lo_u32    v9, v5, v9
/*000000000228*/ v_mul_lo_u32    v10, v6, v8
/*000000000230*/ v_add_u32       v9, vcc, v9, v10
/*000000000234*/ v_mul_hi_u32    v10, v5, v8
/*00000000023c*/ v_add_u32       v9, vcc, v9, v10
/*000000000240*/ v_mul_lo_u32    v10, v5, v8
/*000000000248*/ v_sub_u32       v10, s[14:15], 2, v10
/*000000000250*/ v_subb_u32      v11, vcc, 0, v9, s[14:15]
/*000000000258*/ v_cmp_ge_u32    s[16:17], v10, v5
/*000000000260*/ v_cmp_ge_u32    s[18:19], v11, v6
/*000000000268*/ v_cmp_eq_i32    vcc, v11, v6
/*00000000026c*/ v_cndmask_b32   v11, 0, -1, s[18:19]
/*000000000274*/ v_cndmask_b32   v12, 0, -1, s[16:17]
/*00000000027c*/ v_cndmask_b32   v11, v11, v12, vcc
/*000000000280*/ v_cmp_lg_u32    vcc, 0, v11
/*000000000284*/ s_and_saveexec_b64 s[16:17], vcc
/*000000000288*/ v_sub_u32       v9, vcc, 0, v9
/*00000000028c*/ s_cbranch_execz .L744_49
/*000000000290*/ v_sub_u32       v10, s[18:19], v10, v5
/*000000000298*/ v_subb_u32      v9, vcc, v9, v6, s[14:15]
/*0000000002a0*/ v_subb_u32      v9, vcc, v9, 0, s[18:19]
/*0000000002a8*/ v_cmp_ge_u32    s[14:15], v10, v5
/*0000000002b0*/ v_cmp_ge_u32    s[18:19], v9, v6
/*0000000002b8*/ v_cmp_eq_i32    vcc, v9, v6
/*0000000002bc*/ v_cndmask_b32   v0, 0, -1, s[18:19]
/*0000000002c4*/ v_cndmask_b32   v7, 0, -1, s[14:15]
/*0000000002cc*/ v_add_u32       v8, s[14:15], v8, 1
/*0000000002d4*/ v_cndmask_b32   v0, v0, v7, vcc
/*0000000002d8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002dc*/ v_add_u32       v0, s[14:15], v8, 1
/*0000000002e4*/ v_cndmask_b32   v8, v8, v0, vcc
.L744_49:
/*0000000002e8*/ s_mov_b64       exec, s[16:17]
/*0000000002ec*/ v_cmp_lg_i64    vcc, 0, v[5:6]
/*0000000002f0*/ v_cndmask_b32   v5, -1, v8, vcc
.L756_49:
/*0000000002f4*/ s_andn2_b64     exec, s[12:13], exec
/*0000000002f8*/ v_mov_b32       v5, 2
/*0000000002fc*/ s_mov_b64       exec, s[12:13]
/*000000000300*/ s_lshl_b32      s6, s7, 1
/*000000000304*/ v_add_u32       v6, vcc, s6, v1
/*000000000308*/ v_add_u32       v7, vcc, s2, v6
/*00000000030c*/ v_mov_b32       v0, s11
/*000000000310*/ v_addc_u32      v4, vcc, v0, v4, s[0:1]
/*000000000318*/ flat_store_dword v[3:4], v5
/*000000000320*/ v_mov_b32       v8, 0
/*000000000324*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000032c*/ v_add_u32       v0, s[0:1], s10, v0
/*000000000334*/ v_add_u32       v16, vcc, v6, s2
/*00000000033c*/ v_mov_b32       v3, s3
/*000000000340*/ v_addc_u32      v17, vcc, 0, v3, vcc
/*000000000344*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000348*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000034c*/ v_cvt_f32_u32   v7, v16
/*000000000350*/ s_cbranch_execz .L1524_49
/*000000000354*/ v_cvt_f32_u32   v8, v17
/*000000000358*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000360*/ v_rcp_f32       v7, v7
/*000000000364*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*00000000036c*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000374*/ v_trunc_f32     v8, v8
/*000000000378*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*000000000380*/ v_cvt_u32_f32   v7, v7
/*000000000384*/ v_cvt_u32_f32   v8, v8
/*000000000388*/ v_sub_u32       v9, vcc, 0, v16
/*00000000038c*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*000000000390*/ v_mul_lo_u32    v11, v9, v8
/*000000000398*/ v_mul_lo_u32    v12, v10, v7
/*0000000003a0*/ v_add_u32       v11, vcc, v11, v12
/*0000000003a4*/ v_mul_hi_u32    v12, v9, v7
/*0000000003ac*/ v_add_u32       v11, vcc, v11, v12
/*0000000003b0*/ v_mul_lo_u32    v12, v9, v7
/*0000000003b8*/ v_mul_hi_u32    v13, v7, v12
/*0000000003c0*/ v_mul_lo_u32    v14, v8, v12
/*0000000003c8*/ v_add_u32       v13, vcc, v13, v14
/*0000000003cc*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000003d4*/ v_mul_lo_u32    v15, v7, v11
/*0000000003dc*/ v_add_u32       v13, vcc, v13, v15
/*0000000003e0*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*0000000003e8*/ v_mul_hi_u32    v12, v8, v12
/*0000000003f0*/ v_add_u32       v12, vcc, v13, v12
/*0000000003f4*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000003fc*/ v_mul_hi_u32    v14, v7, v11
/*000000000404*/ v_add_u32       v12, vcc, v12, v14
/*000000000408*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000410*/ v_mul_lo_u32    v14, v8, v11
/*000000000418*/ v_add_u32       v12, vcc, v12, v14
/*00000000041c*/ v_mul_hi_u32    v11, v8, v11
/*000000000424*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000428*/ v_add_u32       v7, s[6:7], v7, v12
/*000000000430*/ v_add_u32       v12, vcc, v8, v11
/*000000000434*/ v_addc_u32      v8, vcc, v8, v11, s[6:7]
/*00000000043c*/ v_mul_lo_u32    v11, v9, v8
/*000000000444*/ v_mul_lo_u32    v10, v10, v7
/*00000000044c*/ v_add_u32       v10, vcc, v11, v10
/*000000000450*/ v_mul_hi_u32    v11, v9, v7
/*000000000458*/ v_add_u32       v10, vcc, v10, v11
/*00000000045c*/ v_mul_lo_u32    v9, v9, v7
/*000000000464*/ v_mul_hi_u32    v11, v7, v9
/*00000000046c*/ v_mul_lo_u32    v13, v8, v9
/*000000000474*/ v_add_u32       v11, vcc, v11, v13
/*000000000478*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000480*/ v_mul_lo_u32    v14, v7, v10
/*000000000488*/ v_add_u32       v11, vcc, v11, v14
/*00000000048c*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*000000000494*/ v_mul_hi_u32    v9, v8, v9
/*00000000049c*/ v_add_u32       v9, vcc, v11, v9
/*0000000004a0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004a8*/ v_mul_hi_u32    v13, v7, v10
/*0000000004b0*/ v_add_u32       v9, vcc, v9, v13
/*0000000004b4*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004bc*/ v_mul_lo_u32    v13, v8, v10
/*0000000004c4*/ v_add_u32       v9, vcc, v9, v13
/*0000000004c8*/ v_mul_hi_u32    v8, v8, v10
/*0000000004d0*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000004d4*/ v_add_u32       v7, s[12:13], v7, v9
/*0000000004dc*/ v_addc_u32      v8, vcc, v12, v8, s[6:7]
/*0000000004e4*/ v_addc_u32      v8, vcc, v8, 0, s[12:13]
/*0000000004ec*/ v_mul_hi_u32    v7, 2, v7
/*0000000004f4*/ v_mul_lo_u32    v9, 2, v8
/*0000000004fc*/ v_add_u32       v7, vcc, v7, v9
/*000000000500*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000508*/ v_mul_hi_u32    v8, 2, v8
/*000000000510*/ v_add_u32       v7, vcc, v7, v8
/*000000000514*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*00000000051c*/ v_add_u32       v8, vcc, 0, v8
/*000000000520*/ v_mul_lo_u32    v8, v16, v8
/*000000000528*/ v_mul_lo_u32    v9, v17, v7
/*000000000530*/ v_add_u32       v8, vcc, v8, v9
/*000000000534*/ v_mul_hi_u32    v9, v16, v7
/*00000000053c*/ v_add_u32       v8, vcc, v8, v9
/*000000000540*/ v_mul_lo_u32    v9, v16, v7
/*000000000548*/ v_sub_u32       v9, s[6:7], 2, v9
/*000000000550*/ v_subb_u32      v10, vcc, 0, v8, s[6:7]
/*000000000558*/ v_cmp_ge_u32    s[12:13], v9, v16
/*000000000560*/ v_cmp_ge_u32    s[14:15], v10, v17
/*000000000568*/ v_cmp_eq_i32    vcc, v10, v17
/*00000000056c*/ v_cndmask_b32   v10, 0, -1, s[14:15]
/*000000000574*/ v_cndmask_b32   v11, 0, -1, s[12:13]
/*00000000057c*/ v_cndmask_b32   v10, v10, v11, vcc
/*000000000580*/ v_cmp_lg_u32    vcc, 0, v10
/*000000000584*/ s_and_saveexec_b64 s[12:13], vcc
/*000000000588*/ v_sub_u32       v8, vcc, 0, v8
/*00000000058c*/ s_cbranch_execz .L1512_49
/*000000000590*/ v_sub_u32       v9, s[14:15], v9, v16
/*000000000598*/ v_subb_u32      v8, vcc, v8, v17, s[6:7]
/*0000000005a0*/ v_subb_u32      v8, vcc, v8, 0, s[14:15]
/*0000000005a8*/ v_cmp_ge_u32    s[6:7], v9, v16
/*0000000005b0*/ v_cmp_ge_u32    s[14:15], v8, v17
/*0000000005b8*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005bc*/ v_cndmask_b32   v5, 0, -1, s[14:15]
/*0000000005c4*/ v_cndmask_b32   v6, 0, -1, s[6:7]
/*0000000005cc*/ v_add_u32       v7, s[6:7], v7, 1
/*0000000005d4*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000005d8*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000005dc*/ v_add_u32       v5, s[6:7], v7, 1
/*0000000005e4*/ v_cndmask_b32   v7, v7, v5, vcc
.L1512_49:
/*0000000005e8*/ s_mov_b64       exec, s[12:13]
/*0000000005ec*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*0000000005f0*/ v_cndmask_b32   v3, -1, v7, vcc
.L1524_49:
/*0000000005f4*/ s_andn2_b64     exec, s[2:3], exec
/*0000000005f8*/ v_mov_b32       v3, 2
/*0000000005fc*/ s_mov_b64       exec, s[2:3]
/*000000000600*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000608*/ s_lshl_b32      s4, s8, 2
/*00000000060c*/ v_add_u32       v2, vcc, s4, v2
/*000000000610*/ s_waitcnt       lgkmcnt(0)
/*000000000614*/ v_add_u32       v6, vcc, s2, v2
/*000000000618*/ v_mov_b32       v5, s11
/*00000000061c*/ v_addc_u32      v1, vcc, v5, v1, s[0:1]
/*000000000624*/ flat_store_dword v[0:1], v3
/*00000000062c*/ v_mov_b32       v7, 0
/*000000000630*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000638*/ v_add_u32       v0, vcc, s10, v0
/*00000000063c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000640*/ v_add_u32       v15, vcc, v2, s2
/*000000000648*/ v_mov_b32       v2, s3
/*00000000064c*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*000000000650*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000654*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000658*/ v_cvt_f32_u32   v6, v15
/*00000000065c*/ s_cbranch_execz .L2304_49
/*000000000660*/ v_cvt_f32_u32   v7, v16
/*000000000664*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*00000000066c*/ v_rcp_f32       v6, v6
/*000000000670*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000678*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000680*/ v_trunc_f32     v7, v7
/*000000000684*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*00000000068c*/ v_cvt_u32_f32   v6, v6
/*000000000690*/ v_cvt_u32_f32   v7, v7
/*000000000694*/ v_sub_u32       v8, vcc, 0, v15
/*000000000698*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*00000000069c*/ v_mul_lo_u32    v10, v8, v7
/*0000000006a4*/ v_mul_lo_u32    v11, v9, v6
/*0000000006ac*/ v_add_u32       v10, vcc, v10, v11
/*0000000006b0*/ v_mul_hi_u32    v11, v8, v6
/*0000000006b8*/ v_add_u32       v10, vcc, v10, v11
/*0000000006bc*/ v_mul_lo_u32    v11, v8, v6
/*0000000006c4*/ v_mul_hi_u32    v12, v6, v11
/*0000000006cc*/ v_mul_lo_u32    v13, v7, v11
/*0000000006d4*/ v_add_u32       v12, vcc, v12, v13
/*0000000006d8*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006e0*/ v_mul_lo_u32    v14, v6, v10
/*0000000006e8*/ v_add_u32       v12, vcc, v12, v14
/*0000000006ec*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*0000000006f4*/ v_mul_hi_u32    v11, v7, v11
/*0000000006fc*/ v_add_u32       v11, vcc, v12, v11
/*000000000700*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000708*/ v_mul_hi_u32    v13, v6, v10
/*000000000710*/ v_add_u32       v11, vcc, v11, v13
/*000000000714*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*00000000071c*/ v_mul_lo_u32    v13, v7, v10
/*000000000724*/ v_add_u32       v11, vcc, v11, v13
/*000000000728*/ v_mul_hi_u32    v10, v7, v10
/*000000000730*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000734*/ v_add_u32       v6, s[2:3], v6, v11
/*00000000073c*/ v_add_u32       v11, vcc, v7, v10
/*000000000740*/ v_addc_u32      v7, vcc, v7, v10, s[2:3]
/*000000000748*/ v_mul_lo_u32    v10, v8, v7
/*000000000750*/ v_mul_lo_u32    v9, v9, v6
/*000000000758*/ v_add_u32       v9, vcc, v10, v9
/*00000000075c*/ v_mul_hi_u32    v10, v8, v6
/*000000000764*/ v_add_u32       v9, vcc, v9, v10
/*000000000768*/ v_mul_lo_u32    v8, v8, v6
/*000000000770*/ v_mul_hi_u32    v10, v6, v8
/*000000000778*/ v_mul_lo_u32    v12, v7, v8
/*000000000780*/ v_add_u32       v10, vcc, v10, v12
/*000000000784*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000078c*/ v_mul_lo_u32    v13, v6, v9
/*000000000794*/ v_add_u32       v10, vcc, v10, v13
/*000000000798*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007a0*/ v_mul_hi_u32    v8, v7, v8
/*0000000007a8*/ v_add_u32       v8, vcc, v10, v8
/*0000000007ac*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007b4*/ v_mul_hi_u32    v12, v6, v9
/*0000000007bc*/ v_add_u32       v8, vcc, v8, v12
/*0000000007c0*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007c8*/ v_mul_lo_u32    v12, v7, v9
/*0000000007d0*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d4*/ v_mul_hi_u32    v7, v7, v9
/*0000000007dc*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007e0*/ v_add_u32       v6, s[4:5], v6, v8
/*0000000007e8*/ v_addc_u32      v7, vcc, v11, v7, s[2:3]
/*0000000007f0*/ v_addc_u32      v7, vcc, v7, 0, s[4:5]
/*0000000007f8*/ v_mul_hi_u32    v6, 4, v6
/*000000000800*/ v_mul_lo_u32    v8, 4, v7
/*000000000808*/ v_add_u32       v6, vcc, v6, v8
/*00000000080c*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000814*/ v_mul_hi_u32    v7, 4, v7
/*00000000081c*/ v_add_u32       v6, vcc, v6, v7
/*000000000820*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000828*/ v_add_u32       v7, vcc, 0, v7
/*00000000082c*/ v_mul_lo_u32    v7, v15, v7
/*000000000834*/ v_mul_lo_u32    v8, v16, v6
/*00000000083c*/ v_add_u32       v7, vcc, v7, v8
/*000000000840*/ v_mul_hi_u32    v8, v15, v6
/*000000000848*/ v_add_u32       v7, vcc, v7, v8
/*00000000084c*/ v_mul_lo_u32    v8, v15, v6
/*000000000854*/ v_sub_u32       v8, s[2:3], 4, v8
/*00000000085c*/ v_subb_u32      v9, vcc, 0, v7, s[2:3]
/*000000000864*/ v_cmp_ge_u32    s[4:5], v8, v15
/*00000000086c*/ v_cmp_ge_u32    s[6:7], v9, v16
/*000000000874*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000878*/ v_cndmask_b32   v9, 0, -1, s[6:7]
/*000000000880*/ v_cndmask_b32   v10, 0, -1, s[4:5]
/*000000000888*/ v_cndmask_b32   v9, v9, v10, vcc
/*00000000088c*/ v_cmp_lg_u32    vcc, 0, v9
/*000000000890*/ s_and_saveexec_b64 s[4:5], vcc
/*000000000894*/ v_sub_u32       v7, vcc, 0, v7
/*000000000898*/ s_cbranch_execz .L2292_49
/*00000000089c*/ v_sub_u32       v8, s[6:7], v8, v15
/*0000000008a4*/ v_subb_u32      v7, vcc, v7, v16, s[2:3]
/*0000000008ac*/ v_subb_u32      v7, vcc, v7, 0, s[6:7]
/*0000000008b4*/ v_cmp_ge_u32    s[2:3], v8, v15
/*0000000008bc*/ v_cmp_ge_u32    s[6:7], v7, v16
/*0000000008c4*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008c8*/ v_cndmask_b32   v4, 0, -1, s[6:7]
/*0000000008d0*/ v_cndmask_b32   v5, 0, -1, s[2:3]
/*0000000008d8*/ v_add_u32       v6, s[2:3], v6, 1
/*0000000008e0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008e4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000008e8*/ v_add_u32       v4, s[2:3], v6, 1
/*0000000008f0*/ v_cndmask_b32   v6, v6, v4, vcc
.L2292_49:
/*0000000008f4*/ s_mov_b64       exec, s[4:5]
/*0000000008f8*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*0000000008fc*/ v_cndmask_b32   v2, -1, v6, vcc
.L2304_49:
/*000000000900*/ s_andn2_b64     exec, s[0:1], exec
/*000000000904*/ v_mov_b32       v2, 4
/*000000000908*/ s_mov_b64       exec, s[0:1]
/*00000000090c*/ flat_store_dword v[0:1], v2
/*000000000914*/ s_endpgm
.kernel div_get_global_id_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 20
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0084
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_lshl_b32      s6, s6, 1
/*00000000000c*/ v_add_u32       v0, vcc, s6, v0
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ v_add_u32       v18, vcc, v0, s0
/*00000000001c*/ v_mov_b32       v3, s1
/*000000000020*/ v_addc_u32      v19, vcc, 0, v3, vcc
/*000000000024*/ v_add_u32       v17, vcc, s0, v0
/*000000000028*/ v_cmp_lg_i64    vcc, 1, v[18:19]
/*00000000002c*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000030*/ v_cvt_f32_u32   v8, v18
/*000000000034*/ s_cbranch_execz .L728_50
/*000000000038*/ v_cvt_f32_u32   v9, v19
/*00000000003c*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000044*/ v_rcp_f32       v8, v8
/*000000000048*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*000000000050*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000058*/ v_trunc_f32     v9, v9
/*00000000005c*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000064*/ v_cvt_u32_f32   v8, v8
/*000000000068*/ v_cvt_u32_f32   v9, v9
/*00000000006c*/ v_sub_u32       v10, vcc, 0, v18
/*000000000070*/ v_subb_u32      v11, vcc, 0, v19, vcc
/*000000000074*/ v_mul_lo_u32    v12, v10, v9
/*00000000007c*/ v_mul_lo_u32    v13, v11, v8
/*000000000084*/ v_add_u32       v12, vcc, v12, v13
/*000000000088*/ v_mul_hi_u32    v13, v10, v8
/*000000000090*/ v_add_u32       v12, vcc, v12, v13
/*000000000094*/ v_mul_lo_u32    v13, v10, v8
/*00000000009c*/ v_mul_hi_u32    v14, v8, v13
/*0000000000a4*/ v_mul_lo_u32    v15, v9, v13
/*0000000000ac*/ v_add_u32       v14, vcc, v14, v15
/*0000000000b0*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000b8*/ v_mul_lo_u32    v16, v8, v12
/*0000000000c0*/ v_add_u32       v14, vcc, v14, v16
/*0000000000c4*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000cc*/ v_mul_hi_u32    v13, v9, v13
/*0000000000d4*/ v_add_u32       v13, vcc, v14, v13
/*0000000000d8*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000000e0*/ v_mul_hi_u32    v15, v8, v12
/*0000000000e8*/ v_add_u32       v13, vcc, v13, v15
/*0000000000ec*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*0000000000f4*/ v_mul_lo_u32    v15, v9, v12
/*0000000000fc*/ v_add_u32       v13, vcc, v13, v15
/*000000000100*/ v_mul_hi_u32    v12, v9, v12
/*000000000108*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*00000000010c*/ v_add_u32       v8, s[10:11], v8, v13
/*000000000114*/ v_add_u32       v13, vcc, v9, v12
/*000000000118*/ v_addc_u32      v9, vcc, v9, v12, s[10:11]
/*000000000120*/ v_mul_lo_u32    v12, v10, v9
/*000000000128*/ v_mul_lo_u32    v11, v11, v8
/*000000000130*/ v_add_u32       v11, vcc, v12, v11
/*000000000134*/ v_mul_hi_u32    v12, v10, v8
/*00000000013c*/ v_add_u32       v11, vcc, v11, v12
/*000000000140*/ v_mul_lo_u32    v10, v10, v8
/*000000000148*/ v_mul_hi_u32    v12, v8, v10
/*000000000150*/ v_mul_lo_u32    v14, v9, v10
/*000000000158*/ v_add_u32       v12, vcc, v12, v14
/*00000000015c*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000164*/ v_mul_lo_u32    v15, v8, v11
/*00000000016c*/ v_add_u32       v12, vcc, v12, v15
/*000000000170*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*000000000178*/ v_mul_hi_u32    v10, v9, v10
/*000000000180*/ v_add_u32       v10, vcc, v12, v10
/*000000000184*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000018c*/ v_mul_hi_u32    v14, v8, v11
/*000000000194*/ v_add_u32       v10, vcc, v10, v14
/*000000000198*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001a0*/ v_mul_lo_u32    v14, v9, v11
/*0000000001a8*/ v_add_u32       v10, vcc, v10, v14
/*0000000001ac*/ v_mul_hi_u32    v9, v9, v11
/*0000000001b4*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001b8*/ v_add_u32       v8, s[12:13], v8, v10
/*0000000001c0*/ v_addc_u32      v9, vcc, v13, v9, s[10:11]
/*0000000001c8*/ v_addc_u32      v9, vcc, v9, 0, s[12:13]
/*0000000001d0*/ v_mul_hi_u32    v8, v17, v8
/*0000000001d8*/ v_mul_lo_u32    v10, v17, v9
/*0000000001e0*/ v_add_u32       v8, vcc, v8, v10
/*0000000001e4*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*0000000001ec*/ v_mul_hi_u32    v9, v17, v9
/*0000000001f4*/ v_add_u32       v8, vcc, v8, v9
/*0000000001f8*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*000000000200*/ v_add_u32       v9, vcc, 0, v9
/*000000000204*/ v_mul_lo_u32    v9, v18, v9
/*00000000020c*/ v_mul_lo_u32    v10, v19, v8
/*000000000214*/ v_add_u32       v9, vcc, v9, v10
/*000000000218*/ v_mul_hi_u32    v10, v18, v8
/*000000000220*/ v_add_u32       v9, vcc, v9, v10
/*000000000224*/ v_mul_lo_u32    v10, v18, v8
/*00000000022c*/ v_sub_u32       v7, s[10:11], v17, v10
/*000000000234*/ v_subb_u32      v10, vcc, 0, v9, s[10:11]
/*00000000023c*/ v_cmp_ge_u32    s[12:13], v7, v18
/*000000000244*/ v_cmp_ge_u32    s[14:15], v10, v19
/*00000000024c*/ v_cmp_eq_i32    vcc, v10, v19
/*000000000250*/ v_cndmask_b32   v10, 0, -1, s[14:15]
/*000000000258*/ v_cndmask_b32   v11, 0, -1, s[12:13]
/*000000000260*/ v_cndmask_b32   v10, v10, v11, vcc
/*000000000264*/ v_cmp_lg_u32    vcc, 0, v10
/*000000000268*/ s_and_saveexec_b64 s[12:13], vcc
/*00000000026c*/ v_sub_u32       v9, vcc, 0, v9
/*000000000270*/ s_cbranch_execz .L716_50
/*000000000274*/ v_sub_u32       v7, s[14:15], v7, v18
/*00000000027c*/ v_subb_u32      v9, vcc, v9, v19, s[10:11]
/*000000000284*/ v_subb_u32      v9, vcc, v9, 0, s[14:15]
/*00000000028c*/ v_cmp_ge_u32    s[10:11], v7, v18
/*000000000294*/ v_cmp_ge_u32    s[14:15], v9, v19
/*00000000029c*/ v_cmp_eq_i32    vcc, v9, v19
/*0000000002a0*/ v_cndmask_b32   v5, 0, -1, s[14:15]
/*0000000002a8*/ v_cndmask_b32   v6, 0, -1, s[10:11]
/*0000000002b0*/ v_add_u32       v7, s[10:11], v8, 1
/*0000000002b8*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000002bc*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000002c0*/ v_add_u32       v5, s[10:11], v7, 1
/*0000000002c8*/ v_cndmask_b32   v8, v7, v5, vcc
.L716_50:
/*0000000002cc*/ s_mov_b64       exec, s[12:13]
/*0000000002d0*/ v_cmp_lg_i64    vcc, 0, v[18:19]
/*0000000002d4*/ v_cndmask_b32   v17, -1, v8, vcc
.L728_50:
/*0000000002d8*/ s_mov_b64       exec, s[0:1]
/*0000000002dc*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*0000000002e4*/ s_lshl_b32      s6, s7, 1
/*0000000002e8*/ v_add_u32       v1, vcc, s6, v1
/*0000000002ec*/ v_add_u32       v15, vcc, v1, s2
/*0000000002f4*/ v_mov_b32       v5, s3
/*0000000002f8*/ v_addc_u32      v16, vcc, 0, v5, vcc
/*0000000002fc*/ v_add_u32       v6, vcc, s2, v1
/*000000000300*/ v_mov_b32       v1, 0
/*000000000304*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000030c*/ s_waitcnt       lgkmcnt(0)
/*000000000310*/ v_add_u32       v0, vcc, s0, v0
/*000000000314*/ v_mov_b32       v7, s1
/*000000000318*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000031c*/ flat_store_dword v[0:1], v17
/*000000000324*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000328*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000032c*/ v_cvt_f32_u32   v3, v15
/*000000000330*/ s_cbranch_execz .L1492_50
/*000000000334*/ v_cvt_f32_u32   v7, v16
/*000000000338*/ v_madmk_f32     v3, v7, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000340*/ v_rcp_f32       v3, v3
/*000000000344*/ v_mul_f32       v3, 0x5f7ffffc /* 1.844674e+19f */, v3
/*00000000034c*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v3
/*000000000354*/ v_trunc_f32     v7, v7
/*000000000358*/ v_madmk_f32     v3, v7, 0xcf800000 /* -4.2949673e+9f */, v3
/*000000000360*/ v_cvt_u32_f32   v3, v3
/*000000000364*/ v_cvt_u32_f32   v7, v7
/*000000000368*/ v_sub_u32       v8, vcc, 0, v15
/*00000000036c*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*000000000370*/ v_mul_lo_u32    v10, v8, v7
/*000000000378*/ v_mul_lo_u32    v11, v9, v3
/*000000000380*/ v_add_u32       v10, vcc, v10, v11
/*000000000384*/ v_mul_hi_u32    v11, v8, v3
/*00000000038c*/ v_add_u32       v10, vcc, v10, v11
/*000000000390*/ v_mul_lo_u32    v11, v8, v3
/*000000000398*/ v_mul_hi_u32    v12, v3, v11
/*0000000003a0*/ v_mul_lo_u32    v13, v7, v11
/*0000000003a8*/ v_add_u32       v12, vcc, v12, v13
/*0000000003ac*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000003b4*/ v_mul_lo_u32    v14, v3, v10
/*0000000003bc*/ v_add_u32       v12, vcc, v12, v14
/*0000000003c0*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*0000000003c8*/ v_mul_hi_u32    v11, v7, v11
/*0000000003d0*/ v_add_u32       v11, vcc, v12, v11
/*0000000003d4*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000003dc*/ v_mul_hi_u32    v13, v3, v10
/*0000000003e4*/ v_add_u32       v11, vcc, v11, v13
/*0000000003e8*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000003f0*/ v_mul_lo_u32    v13, v7, v10
/*0000000003f8*/ v_add_u32       v11, vcc, v11, v13
/*0000000003fc*/ v_mul_hi_u32    v10, v7, v10
/*000000000404*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000408*/ v_add_u32       v3, s[6:7], v3, v11
/*000000000410*/ v_add_u32       v11, vcc, v7, v10
/*000000000414*/ v_addc_u32      v7, vcc, v7, v10, s[6:7]
/*00000000041c*/ v_mul_lo_u32    v10, v8, v7
/*000000000424*/ v_mul_lo_u32    v9, v9, v3
/*00000000042c*/ v_add_u32       v9, vcc, v10, v9
/*000000000430*/ v_mul_hi_u32    v10, v8, v3
/*000000000438*/ v_add_u32       v9, vcc, v9, v10
/*00000000043c*/ v_mul_lo_u32    v8, v8, v3
/*000000000444*/ v_mul_hi_u32    v10, v3, v8
/*00000000044c*/ v_mul_lo_u32    v12, v7, v8
/*000000000454*/ v_add_u32       v10, vcc, v10, v12
/*000000000458*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000460*/ v_mul_lo_u32    v13, v3, v9
/*000000000468*/ v_add_u32       v10, vcc, v10, v13
/*00000000046c*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*000000000474*/ v_mul_hi_u32    v8, v7, v8
/*00000000047c*/ v_add_u32       v8, vcc, v10, v8
/*000000000480*/ v_cndmask_b32   v10, 0, 1, vcc
/*000000000488*/ v_mul_hi_u32    v12, v3, v9
/*000000000490*/ v_add_u32       v8, vcc, v8, v12
/*000000000494*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*00000000049c*/ v_mul_lo_u32    v12, v7, v9
/*0000000004a4*/ v_add_u32       v8, vcc, v8, v12
/*0000000004a8*/ v_mul_hi_u32    v7, v7, v9
/*0000000004b0*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000004b4*/ v_add_u32       v3, s[10:11], v3, v8
/*0000000004bc*/ v_addc_u32      v7, vcc, v11, v7, s[6:7]
/*0000000004c4*/ v_addc_u32      v7, vcc, v7, 0, s[10:11]
/*0000000004cc*/ v_mul_hi_u32    v3, v6, v3
/*0000000004d4*/ v_mul_lo_u32    v8, v6, v7
/*0000000004dc*/ v_add_u32       v3, vcc, v3, v8
/*0000000004e0*/ v_addc_u32      v3, vcc, 0, 0, vcc
/*0000000004e8*/ v_mul_hi_u32    v7, v6, v7
/*0000000004f0*/ v_add_u32       v3, vcc, v3, v7
/*0000000004f4*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*0000000004fc*/ v_add_u32       v7, vcc, 0, v7
/*000000000500*/ v_mul_lo_u32    v7, v15, v7
/*000000000508*/ v_mul_lo_u32    v8, v16, v3
/*000000000510*/ v_add_u32       v7, vcc, v7, v8
/*000000000514*/ v_mul_hi_u32    v8, v15, v3
/*00000000051c*/ v_add_u32       v7, vcc, v7, v8
/*000000000520*/ v_mul_lo_u32    v8, v15, v3
/*000000000528*/ v_sub_u32       v8, s[6:7], v6, v8
/*000000000530*/ v_subb_u32      v9, vcc, 0, v7, s[6:7]
/*000000000538*/ v_cmp_ge_u32    s[10:11], v8, v15
/*000000000540*/ v_cmp_ge_u32    s[12:13], v9, v16
/*000000000548*/ v_cmp_eq_i32    vcc, v9, v16
/*00000000054c*/ v_cndmask_b32   v9, 0, -1, s[12:13]
/*000000000554*/ v_cndmask_b32   v10, 0, -1, s[10:11]
/*00000000055c*/ v_cndmask_b32   v9, v9, v10, vcc
/*000000000560*/ v_cmp_lg_u32    vcc, 0, v9
/*000000000564*/ s_and_saveexec_b64 s[10:11], vcc
/*000000000568*/ v_sub_u32       v7, vcc, 0, v7
/*00000000056c*/ s_cbranch_execz .L1480_50
/*000000000570*/ v_sub_u32       v8, s[12:13], v8, v15
/*000000000578*/ v_subb_u32      v7, vcc, v7, v16, s[6:7]
/*000000000580*/ v_subb_u32      v7, vcc, v7, 0, s[12:13]
/*000000000588*/ v_cmp_ge_u32    s[6:7], v8, v15
/*000000000590*/ v_cmp_ge_u32    s[12:13], v7, v16
/*000000000598*/ v_cmp_eq_i32    vcc, v7, v16
/*00000000059c*/ v_cndmask_b32   v4, 0, -1, s[12:13]
/*0000000005a4*/ v_cndmask_b32   v5, 0, -1, s[6:7]
/*0000000005ac*/ v_add_u32       v3, s[6:7], v3, 1
/*0000000005b4*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005b8*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005bc*/ v_add_u32       v4, s[6:7], v3, 1
/*0000000005c4*/ v_cndmask_b32   v3, v3, v4, vcc
.L1480_50:
/*0000000005c8*/ s_mov_b64       exec, s[10:11]
/*0000000005cc*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*0000000005d0*/ v_cndmask_b32   v3, -1, v3, vcc
.L1492_50:
/*0000000005d4*/ s_andn2_b64     exec, s[2:3], exec
/*0000000005d8*/ v_mov_b32       v3, v6
/*0000000005dc*/ s_mov_b64       exec, s[2:3]
/*0000000005e0*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*0000000005e8*/ s_lshl_b32      s4, s8, 2
/*0000000005ec*/ v_add_u32       v2, vcc, s4, v2
/*0000000005f0*/ v_mov_b32       v7, 0
/*0000000005f4*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*0000000005fc*/ v_add_u32       v0, vcc, s0, v0
/*000000000600*/ v_mov_b32       v4, s1
/*000000000604*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*000000000608*/ flat_store_dword v[0:1], v3
/*000000000610*/ s_waitcnt       lgkmcnt(0)
/*000000000614*/ v_add_u32       v14, vcc, v2, s2
/*00000000061c*/ v_mov_b32       v0, s3
/*000000000620*/ v_addc_u32      v15, vcc, 0, v0, vcc
/*000000000624*/ v_add_u32       v0, vcc, s2, v2
/*000000000628*/ v_cmp_lg_i64    vcc, 1, v[14:15]
/*00000000062c*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000630*/ v_cvt_f32_u32   v5, v14
/*000000000634*/ s_cbranch_execz .L2264_50
/*000000000638*/ v_cvt_f32_u32   v6, v15
/*00000000063c*/ v_madmk_f32     v5, v6, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000644*/ v_rcp_f32       v5, v5
/*000000000648*/ v_mul_f32       v5, 0x5f7ffffc /* 1.844674e+19f */, v5
/*000000000650*/ v_mul_f32       v6, 0x2f800000 /* 2.32830644e-10f */, v5
/*000000000658*/ v_trunc_f32     v6, v6
/*00000000065c*/ v_madmk_f32     v5, v6, 0xcf800000 /* -4.2949673e+9f */, v5
/*000000000664*/ v_cvt_u32_f32   v5, v5
/*000000000668*/ v_cvt_u32_f32   v6, v6
/*00000000066c*/ v_sub_u32       v7, vcc, 0, v14
/*000000000670*/ v_subb_u32      v8, vcc, 0, v15, vcc
/*000000000674*/ v_mul_lo_u32    v9, v7, v6
/*00000000067c*/ v_mul_lo_u32    v10, v8, v5
/*000000000684*/ v_add_u32       v9, vcc, v9, v10
/*000000000688*/ v_mul_hi_u32    v10, v7, v5
/*000000000690*/ v_add_u32       v9, vcc, v9, v10
/*000000000694*/ v_mul_lo_u32    v10, v7, v5
/*00000000069c*/ v_mul_hi_u32    v11, v5, v10
/*0000000006a4*/ v_mul_lo_u32    v12, v6, v10
/*0000000006ac*/ v_add_u32       v11, vcc, v11, v12
/*0000000006b0*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000006b8*/ v_mul_lo_u32    v13, v5, v9
/*0000000006c0*/ v_add_u32       v11, vcc, v11, v13
/*0000000006c4*/ v_addc_u32      v11, vcc, v12, 0, vcc
/*0000000006cc*/ v_mul_hi_u32    v10, v6, v10
/*0000000006d4*/ v_add_u32       v10, vcc, v11, v10
/*0000000006d8*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000006e0*/ v_mul_hi_u32    v12, v5, v9
/*0000000006e8*/ v_add_u32       v10, vcc, v10, v12
/*0000000006ec*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000006f4*/ v_mul_lo_u32    v12, v6, v9
/*0000000006fc*/ v_add_u32       v10, vcc, v10, v12
/*000000000700*/ v_mul_hi_u32    v9, v6, v9
/*000000000708*/ v_addc_u32      v9, vcc, v11, v9, vcc
/*00000000070c*/ v_add_u32       v5, s[4:5], v5, v10
/*000000000714*/ v_add_u32       v10, vcc, v6, v9
/*000000000718*/ v_addc_u32      v6, vcc, v6, v9, s[4:5]
/*000000000720*/ v_mul_lo_u32    v9, v7, v6
/*000000000728*/ v_mul_lo_u32    v8, v8, v5
/*000000000730*/ v_add_u32       v8, vcc, v9, v8
/*000000000734*/ v_mul_hi_u32    v9, v7, v5
/*00000000073c*/ v_add_u32       v8, vcc, v8, v9
/*000000000740*/ v_mul_lo_u32    v7, v7, v5
/*000000000748*/ v_mul_hi_u32    v9, v5, v7
/*000000000750*/ v_mul_lo_u32    v11, v6, v7
/*000000000758*/ v_add_u32       v9, vcc, v9, v11
/*00000000075c*/ v_cndmask_b32   v11, 0, 1, vcc
/*000000000764*/ v_mul_lo_u32    v12, v5, v8
/*00000000076c*/ v_add_u32       v9, vcc, v9, v12
/*000000000770*/ v_addc_u32      v9, vcc, v11, 0, vcc
/*000000000778*/ v_mul_hi_u32    v7, v6, v7
/*000000000780*/ v_add_u32       v7, vcc, v9, v7
/*000000000784*/ v_cndmask_b32   v9, 0, 1, vcc
/*00000000078c*/ v_mul_hi_u32    v11, v5, v8
/*000000000794*/ v_add_u32       v7, vcc, v7, v11
/*000000000798*/ v_addc_u32      v9, vcc, v9, 0, vcc
/*0000000007a0*/ v_mul_lo_u32    v11, v6, v8
/*0000000007a8*/ v_add_u32       v7, vcc, v7, v11
/*0000000007ac*/ v_mul_hi_u32    v6, v6, v8
/*0000000007b4*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*0000000007b8*/ v_add_u32       v5, s[6:7], v5, v7
/*0000000007c0*/ v_addc_u32      v6, vcc, v10, v6, s[4:5]
/*0000000007c8*/ v_addc_u32      v6, vcc, v6, 0, s[6:7]
/*0000000007d0*/ v_mul_hi_u32    v5, v0, v5
/*0000000007d8*/ v_mul_lo_u32    v7, v0, v6
/*0000000007e0*/ v_add_u32       v5, vcc, v5, v7
/*0000000007e4*/ v_addc_u32      v5, vcc, 0, 0, vcc
/*0000000007ec*/ v_mul_hi_u32    v6, v0, v6
/*0000000007f4*/ v_add_u32       v5, vcc, v5, v6
/*0000000007f8*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000800*/ v_add_u32       v6, vcc, 0, v6
/*000000000804*/ v_mul_lo_u32    v6, v14, v6
/*00000000080c*/ v_mul_lo_u32    v7, v15, v5
/*000000000814*/ v_add_u32       v6, vcc, v6, v7
/*000000000818*/ v_mul_hi_u32    v7, v14, v5
/*000000000820*/ v_add_u32       v6, vcc, v6, v7
/*000000000824*/ v_mul_lo_u32    v7, v14, v5
/*00000000082c*/ v_sub_u32       v7, s[4:5], v0, v7
/*000000000834*/ v_subb_u32      v8, vcc, 0, v6, s[4:5]
/*00000000083c*/ v_cmp_ge_u32    s[6:7], v7, v14
/*000000000844*/ v_cmp_ge_u32    s[8:9], v8, v15
/*00000000084c*/ v_cmp_eq_i32    vcc, v8, v15
/*000000000850*/ v_cndmask_b32   v8, 0, -1, s[8:9]
/*000000000858*/ v_cndmask_b32   v9, 0, -1, s[6:7]
/*000000000860*/ v_cndmask_b32   v8, v8, v9, vcc
/*000000000864*/ v_cmp_lg_u32    vcc, 0, v8
/*000000000868*/ s_and_saveexec_b64 s[6:7], vcc
/*00000000086c*/ v_sub_u32       v6, vcc, 0, v6
/*000000000870*/ s_cbranch_execz .L2252_50
/*000000000874*/ v_sub_u32       v7, s[8:9], v7, v14
/*00000000087c*/ v_subb_u32      v6, vcc, v6, v15, s[4:5]
/*000000000884*/ v_subb_u32      v6, vcc, v6, 0, s[8:9]
/*00000000088c*/ v_cmp_ge_u32    s[4:5], v7, v14
/*000000000894*/ v_cmp_ge_u32    s[8:9], v6, v15
/*00000000089c*/ v_cmp_eq_i32    vcc, v6, v15
/*0000000008a0*/ v_cndmask_b32   v3, 0, -1, s[8:9]
/*0000000008a8*/ v_cndmask_b32   v4, 0, -1, s[4:5]
/*0000000008b0*/ v_add_u32       v5, s[4:5], v5, 1
/*0000000008b8*/ v_cndmask_b32   v3, v3, v4, vcc
/*0000000008bc*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000008c0*/ v_add_u32       v3, s[4:5], v5, 1
/*0000000008c8*/ v_cndmask_b32   v5, v5, v3, vcc
.L2252_50:
/*0000000008cc*/ s_mov_b64       exec, s[6:7]
/*0000000008d0*/ v_cmp_lg_i64    vcc, 0, v[14:15]
/*0000000008d4*/ v_cndmask_b32   v3, -1, v5, vcc
.L2264_50:
/*0000000008d8*/ s_andn2_b64     exec, s[2:3], exec
/*0000000008dc*/ v_mov_b32       v3, v0
/*0000000008e0*/ s_mov_b64       exec, s[2:3]
/*0000000008e4*/ v_mov_b32       v1, 0
/*0000000008e8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000008f0*/ v_add_u32       v0, vcc, s0, v0
/*0000000008f4*/ v_mov_b32       v2, s1
/*0000000008f8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000008fc*/ flat_store_dword v[0:1], v3
/*000000000904*/ s_endpgm
.kernel div_get_global_size_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 28
        .vgprsnum 19
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000010*/ s_lshl_b32      s8, s8, 4
/*000000000014*/ v_add_u32       v0, vcc, s8, v0
/*000000000018*/ s_lshl_b32      s8, s10, 1
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ v_add_u32       v3, vcc, s0, v0
/*000000000024*/ v_add_u32       v17, vcc, v0, s0
/*00000000002c*/ v_mov_b32       v4, s1
/*000000000030*/ v_addc_u32      v18, vcc, 0, v4, vcc
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ s_load_dwordx2  s[0:1], s[6:7], 0x10
/*000000000048*/ v_add_u32       v6, vcc, s8, v2
/*00000000004c*/ v_add_u32       v3, s[6:7], s12, v3
/*000000000054*/ s_load_dwordx2  s[10:11], s[4:5], 0xc
/*00000000005c*/ v_cmp_lg_i64    vcc, 1, v[17:18]
/*000000000060*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000064*/ v_cvt_f32_u32   v8, v17
/*000000000068*/ s_cbranch_execz .L784_51
/*00000000006c*/ v_cvt_f32_u32   v9, v18
/*000000000070*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000078*/ v_rcp_f32       v8, v8
/*00000000007c*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*000000000084*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*00000000008c*/ v_trunc_f32     v9, v9
/*000000000090*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000098*/ v_cvt_u32_f32   v8, v8
/*00000000009c*/ v_cvt_u32_f32   v9, v9
/*0000000000a0*/ v_sub_u32       v10, vcc, 0, v17
/*0000000000a4*/ v_subb_u32      v11, vcc, 0, v18, vcc
/*0000000000a8*/ v_mul_lo_u32    v12, v10, v9
/*0000000000b0*/ v_mul_lo_u32    v13, v11, v8
/*0000000000b8*/ v_add_u32       v12, vcc, v12, v13
/*0000000000bc*/ v_mul_hi_u32    v13, v10, v8
/*0000000000c4*/ v_add_u32       v12, vcc, v12, v13
/*0000000000c8*/ v_mul_lo_u32    v13, v10, v8
/*0000000000d0*/ v_mul_hi_u32    v14, v8, v13
/*0000000000d8*/ v_mul_lo_u32    v15, v9, v13
/*0000000000e0*/ v_add_u32       v14, vcc, v14, v15
/*0000000000e4*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000ec*/ v_mul_lo_u32    v16, v8, v12
/*0000000000f4*/ v_add_u32       v14, vcc, v14, v16
/*0000000000f8*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*000000000100*/ v_mul_hi_u32    v13, v9, v13
/*000000000108*/ v_add_u32       v13, vcc, v14, v13
/*00000000010c*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000114*/ v_mul_hi_u32    v15, v8, v12
/*00000000011c*/ v_add_u32       v13, vcc, v13, v15
/*000000000120*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*000000000128*/ v_mul_lo_u32    v15, v9, v12
/*000000000130*/ v_add_u32       v13, vcc, v13, v15
/*000000000134*/ v_mul_hi_u32    v12, v9, v12
/*00000000013c*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000140*/ v_add_u32       v8, s[16:17], v8, v13
/*000000000148*/ v_add_u32       v13, vcc, v9, v12
/*00000000014c*/ v_addc_u32      v9, vcc, v9, v12, s[16:17]
/*000000000154*/ v_mul_lo_u32    v12, v10, v9
/*00000000015c*/ v_mul_lo_u32    v11, v11, v8
/*000000000164*/ v_add_u32       v11, vcc, v12, v11
/*000000000168*/ v_mul_hi_u32    v12, v10, v8
/*000000000170*/ v_add_u32       v11, vcc, v11, v12
/*000000000174*/ v_mul_lo_u32    v10, v10, v8
/*00000000017c*/ v_mul_hi_u32    v12, v8, v10
/*000000000184*/ v_mul_lo_u32    v14, v9, v10
/*00000000018c*/ v_add_u32       v12, vcc, v12, v14
/*000000000190*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000198*/ v_mul_lo_u32    v15, v8, v11
/*0000000001a0*/ v_add_u32       v12, vcc, v12, v15
/*0000000001a4*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*0000000001ac*/ v_mul_hi_u32    v10, v9, v10
/*0000000001b4*/ v_add_u32       v10, vcc, v12, v10
/*0000000001b8*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001c0*/ v_mul_hi_u32    v14, v8, v11
/*0000000001c8*/ v_add_u32       v10, vcc, v10, v14
/*0000000001cc*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001d4*/ v_mul_lo_u32    v14, v9, v11
/*0000000001dc*/ v_add_u32       v10, vcc, v10, v14
/*0000000001e0*/ v_mul_hi_u32    v9, v9, v11
/*0000000001e8*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001ec*/ v_add_u32       v8, s[18:19], v8, v10
/*0000000001f4*/ v_addc_u32      v9, vcc, v13, v9, s[16:17]
/*0000000001fc*/ v_addc_u32      v9, vcc, v9, 0, s[18:19]
/*000000000204*/ s_waitcnt       lgkmcnt(0)
/*000000000208*/ v_mul_hi_u32    v8, s10, v8
/*000000000210*/ v_mul_lo_u32    v10, s10, v9
/*000000000218*/ v_add_u32       v8, vcc, v8, v10
/*00000000021c*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000224*/ v_mul_hi_u32    v9, s10, v9
/*00000000022c*/ v_add_u32       v8, vcc, v8, v9
/*000000000230*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*000000000238*/ v_add_u32       v9, vcc, 0, v9
/*00000000023c*/ v_mul_lo_u32    v9, v17, v9
/*000000000244*/ v_mul_lo_u32    v10, v18, v8
/*00000000024c*/ v_add_u32       v9, vcc, v9, v10
/*000000000250*/ v_mul_hi_u32    v10, v17, v8
/*000000000258*/ v_add_u32       v9, vcc, v9, v10
/*00000000025c*/ v_mul_lo_u32    v10, v17, v8
/*000000000264*/ v_sub_u32       v10, s[16:17], s10, v10
/*00000000026c*/ v_subb_u32      v11, vcc, 0, v9, s[16:17]
/*000000000274*/ v_cmp_ge_u32    s[18:19], v10, v17
/*00000000027c*/ v_cmp_ge_u32    s[20:21], v11, v18
/*000000000284*/ v_cmp_eq_i32    vcc, v11, v18
/*000000000288*/ v_cndmask_b32   v11, 0, -1, s[20:21]
/*000000000290*/ v_cndmask_b32   v12, 0, -1, s[18:19]
/*000000000298*/ v_cndmask_b32   v11, v11, v12, vcc
/*00000000029c*/ v_cmp_lg_u32    vcc, 0, v11
/*0000000002a0*/ s_and_saveexec_b64 s[18:19], vcc
/*0000000002a4*/ v_sub_u32       v9, vcc, 0, v9
/*0000000002a8*/ s_cbranch_execz .L772_51
/*0000000002ac*/ v_sub_u32       v10, s[20:21], v10, v17
/*0000000002b4*/ v_subb_u32      v9, vcc, v9, v18, s[16:17]
/*0000000002bc*/ v_subb_u32      v9, vcc, v9, 0, s[20:21]
/*0000000002c4*/ v_cmp_ge_u32    s[16:17], v10, v17
/*0000000002cc*/ v_cmp_ge_u32    s[20:21], v9, v18
/*0000000002d4*/ v_cmp_eq_i32    vcc, v9, v18
/*0000000002d8*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*0000000002e0*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*0000000002e8*/ v_add_u32       v8, s[16:17], v8, 1
/*0000000002f0*/ v_cndmask_b32   v0, v0, v5, vcc
/*0000000002f4*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002f8*/ v_add_u32       v0, s[16:17], v8, 1
/*000000000300*/ v_cndmask_b32   v8, v8, v0, vcc
.L772_51:
/*000000000304*/ s_mov_b64       exec, s[18:19]
/*000000000308*/ v_cmp_lg_i64    vcc, 0, v[17:18]
/*00000000030c*/ v_cndmask_b32   v5, -1, v8, vcc
.L784_51:
/*000000000310*/ s_andn2_b64     exec, s[14:15], exec
/*000000000314*/ s_waitcnt       lgkmcnt(0)
/*000000000318*/ v_mov_b32       v5, s10
/*00000000031c*/ s_mov_b64       exec, s[14:15]
/*000000000320*/ s_lshl_b32      s8, s9, 1
/*000000000324*/ v_add_u32       v8, vcc, s8, v1
/*000000000328*/ v_add_u32       v0, vcc, s2, v8
/*00000000032c*/ v_mov_b32       v1, 0
/*000000000330*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000338*/ v_mov_b32       v2, s13
/*00000000033c*/ v_addc_u32      v4, vcc, v2, v4, s[6:7]
/*000000000344*/ flat_store_dword v[3:4], v5
/*00000000034c*/ v_add_u32       v0, s[6:7], s12, v0
/*000000000354*/ v_add_u32       v16, vcc, v8, s2
/*00000000035c*/ v_mov_b32       v2, s3
/*000000000360*/ v_addc_u32      v17, vcc, 0, v2, vcc
/*000000000364*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000368*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000036c*/ v_cvt_f32_u32   v7, v16
/*000000000370*/ s_cbranch_execz .L1556_51
/*000000000374*/ v_cvt_f32_u32   v8, v17
/*000000000378*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000380*/ v_rcp_f32       v7, v7
/*000000000384*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*00000000038c*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000394*/ v_trunc_f32     v8, v8
/*000000000398*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*0000000003a0*/ v_cvt_u32_f32   v7, v7
/*0000000003a4*/ v_cvt_u32_f32   v8, v8
/*0000000003a8*/ v_sub_u32       v9, vcc, 0, v16
/*0000000003ac*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*0000000003b0*/ v_mul_lo_u32    v11, v9, v8
/*0000000003b8*/ v_mul_lo_u32    v12, v10, v7
/*0000000003c0*/ v_add_u32       v11, vcc, v11, v12
/*0000000003c4*/ v_mul_hi_u32    v12, v9, v7
/*0000000003cc*/ v_add_u32       v11, vcc, v11, v12
/*0000000003d0*/ v_mul_lo_u32    v12, v9, v7
/*0000000003d8*/ v_mul_hi_u32    v13, v7, v12
/*0000000003e0*/ v_mul_lo_u32    v14, v8, v12
/*0000000003e8*/ v_add_u32       v13, vcc, v13, v14
/*0000000003ec*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000003f4*/ v_mul_lo_u32    v15, v7, v11
/*0000000003fc*/ v_add_u32       v13, vcc, v13, v15
/*000000000400*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*000000000408*/ v_mul_hi_u32    v12, v8, v12
/*000000000410*/ v_add_u32       v12, vcc, v13, v12
/*000000000414*/ v_cndmask_b32   v13, 0, 1, vcc
/*00000000041c*/ v_mul_hi_u32    v14, v7, v11
/*000000000424*/ v_add_u32       v12, vcc, v12, v14
/*000000000428*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000430*/ v_mul_lo_u32    v14, v8, v11
/*000000000438*/ v_add_u32       v12, vcc, v12, v14
/*00000000043c*/ v_mul_hi_u32    v11, v8, v11
/*000000000444*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000448*/ v_add_u32       v7, s[8:9], v7, v12
/*000000000450*/ v_add_u32       v12, vcc, v8, v11
/*000000000454*/ v_addc_u32      v8, vcc, v8, v11, s[8:9]
/*00000000045c*/ v_mul_lo_u32    v11, v9, v8
/*000000000464*/ v_mul_lo_u32    v10, v10, v7
/*00000000046c*/ v_add_u32       v10, vcc, v11, v10
/*000000000470*/ v_mul_hi_u32    v11, v9, v7
/*000000000478*/ v_add_u32       v10, vcc, v10, v11
/*00000000047c*/ v_mul_lo_u32    v9, v9, v7
/*000000000484*/ v_mul_hi_u32    v11, v7, v9
/*00000000048c*/ v_mul_lo_u32    v13, v8, v9
/*000000000494*/ v_add_u32       v11, vcc, v11, v13
/*000000000498*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000004a0*/ v_mul_lo_u32    v14, v7, v10
/*0000000004a8*/ v_add_u32       v11, vcc, v11, v14
/*0000000004ac*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000004b4*/ v_mul_hi_u32    v9, v8, v9
/*0000000004bc*/ v_add_u32       v9, vcc, v11, v9
/*0000000004c0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004c8*/ v_mul_hi_u32    v13, v7, v10
/*0000000004d0*/ v_add_u32       v9, vcc, v9, v13
/*0000000004d4*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004dc*/ v_mul_lo_u32    v13, v8, v10
/*0000000004e4*/ v_add_u32       v9, vcc, v9, v13
/*0000000004e8*/ v_mul_hi_u32    v8, v8, v10
/*0000000004f0*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000004f4*/ v_add_u32       v7, s[14:15], v7, v9
/*0000000004fc*/ v_addc_u32      v8, vcc, v12, v8, s[8:9]
/*000000000504*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*00000000050c*/ v_mul_hi_u32    v7, s11, v7
/*000000000514*/ v_mul_lo_u32    v9, s11, v8
/*00000000051c*/ v_add_u32       v7, vcc, v7, v9
/*000000000520*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000528*/ v_mul_hi_u32    v8, s11, v8
/*000000000530*/ v_add_u32       v7, vcc, v7, v8
/*000000000534*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*00000000053c*/ v_add_u32       v8, vcc, 0, v8
/*000000000540*/ v_mul_lo_u32    v8, v16, v8
/*000000000548*/ v_mul_lo_u32    v9, v17, v7
/*000000000550*/ v_add_u32       v8, vcc, v8, v9
/*000000000554*/ v_mul_hi_u32    v9, v16, v7
/*00000000055c*/ v_add_u32       v8, vcc, v8, v9
/*000000000560*/ v_mul_lo_u32    v9, v16, v7
/*000000000568*/ v_sub_u32       v9, s[8:9], s11, v9
/*000000000570*/ v_subb_u32      v10, vcc, 0, v8, s[8:9]
/*000000000578*/ v_cmp_ge_u32    s[14:15], v9, v16
/*000000000580*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000588*/ v_cmp_eq_i32    vcc, v10, v17
/*00000000058c*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*000000000594*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*00000000059c*/ v_cndmask_b32   v10, v10, v11, vcc
/*0000000005a0*/ v_cmp_lg_u32    vcc, 0, v10
/*0000000005a4*/ s_and_saveexec_b64 s[14:15], vcc
/*0000000005a8*/ v_sub_u32       v8, vcc, 0, v8
/*0000000005ac*/ s_cbranch_execz .L1544_51
/*0000000005b0*/ v_sub_u32       v9, s[16:17], v9, v16
/*0000000005b8*/ v_subb_u32      v8, vcc, v8, v17, s[8:9]
/*0000000005c0*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*0000000005c8*/ v_cmp_ge_u32    s[8:9], v9, v16
/*0000000005d0*/ v_cmp_ge_u32    s[16:17], v8, v17
/*0000000005d8*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005dc*/ v_cndmask_b32   v4, 0, -1, s[16:17]
/*0000000005e4*/ v_cndmask_b32   v5, 0, -1, s[8:9]
/*0000000005ec*/ v_add_u32       v7, s[8:9], v7, 1
/*0000000005f4*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000005f8*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000005fc*/ v_add_u32       v4, s[8:9], v7, 1
/*000000000604*/ v_cndmask_b32   v7, v7, v4, vcc
.L1544_51:
/*000000000608*/ s_mov_b64       exec, s[14:15]
/*00000000060c*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*000000000610*/ v_cndmask_b32   v4, -1, v7, vcc
.L1556_51:
/*000000000614*/ s_andn2_b64     exec, s[2:3], exec
/*000000000618*/ v_mov_b32       v4, s11
/*00000000061c*/ s_mov_b64       exec, s[2:3]
/*000000000620*/ v_add_u32       v2, vcc, s0, v6
/*000000000624*/ v_mov_b32       v3, 0
/*000000000628*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000630*/ v_mov_b32       v5, s13
/*000000000634*/ v_addc_u32      v1, vcc, v5, v1, s[6:7]
/*00000000063c*/ flat_store_dword v[0:1], v4
/*000000000644*/ v_add_u32       v0, vcc, s12, v2
/*000000000648*/ v_addc_u32      v1, vcc, v5, v3, vcc
/*00000000064c*/ v_add_u32       v15, vcc, v6, s0
/*000000000654*/ v_mov_b32       v2, s1
/*000000000658*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*00000000065c*/ s_load_dword    s0, s[4:5], 0x14
/*000000000664*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000668*/ s_and_b64       exec, s[2:3], vcc
/*00000000066c*/ v_cvt_f32_u32   v6, v15
/*000000000670*/ s_cbranch_execz .L2328_51
/*000000000674*/ v_cvt_f32_u32   v7, v16
/*000000000678*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*000000000680*/ v_rcp_f32       v6, v6
/*000000000684*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*00000000068c*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000694*/ v_trunc_f32     v7, v7
/*000000000698*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*0000000006a0*/ v_cvt_u32_f32   v6, v6
/*0000000006a4*/ v_cvt_u32_f32   v7, v7
/*0000000006a8*/ v_sub_u32       v8, vcc, 0, v15
/*0000000006ac*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*0000000006b0*/ v_mul_lo_u32    v10, v8, v7
/*0000000006b8*/ v_mul_lo_u32    v11, v9, v6
/*0000000006c0*/ v_add_u32       v10, vcc, v10, v11
/*0000000006c4*/ v_mul_hi_u32    v11, v8, v6
/*0000000006cc*/ v_add_u32       v10, vcc, v10, v11
/*0000000006d0*/ v_mul_lo_u32    v11, v8, v6
/*0000000006d8*/ v_mul_hi_u32    v12, v6, v11
/*0000000006e0*/ v_mul_lo_u32    v13, v7, v11
/*0000000006e8*/ v_add_u32       v12, vcc, v12, v13
/*0000000006ec*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006f4*/ v_mul_lo_u32    v14, v6, v10
/*0000000006fc*/ v_add_u32       v12, vcc, v12, v14
/*000000000700*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*000000000708*/ v_mul_hi_u32    v11, v7, v11
/*000000000710*/ v_add_u32       v11, vcc, v12, v11
/*000000000714*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000071c*/ v_mul_hi_u32    v13, v6, v10
/*000000000724*/ v_add_u32       v11, vcc, v11, v13
/*000000000728*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*000000000730*/ v_mul_lo_u32    v13, v7, v10
/*000000000738*/ v_add_u32       v11, vcc, v11, v13
/*00000000073c*/ v_mul_hi_u32    v10, v7, v10
/*000000000744*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000748*/ v_add_u32       v6, s[4:5], v6, v11
/*000000000750*/ v_add_u32       v11, vcc, v7, v10
/*000000000754*/ v_addc_u32      v7, vcc, v7, v10, s[4:5]
/*00000000075c*/ v_mul_lo_u32    v10, v8, v7
/*000000000764*/ v_mul_lo_u32    v9, v9, v6
/*00000000076c*/ v_add_u32       v9, vcc, v10, v9
/*000000000770*/ v_mul_hi_u32    v10, v8, v6
/*000000000778*/ v_add_u32       v9, vcc, v9, v10
/*00000000077c*/ v_mul_lo_u32    v8, v8, v6
/*000000000784*/ v_mul_hi_u32    v10, v6, v8
/*00000000078c*/ v_mul_lo_u32    v12, v7, v8
/*000000000794*/ v_add_u32       v10, vcc, v10, v12
/*000000000798*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000007a0*/ v_mul_lo_u32    v13, v6, v9
/*0000000007a8*/ v_add_u32       v10, vcc, v10, v13
/*0000000007ac*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007b4*/ v_mul_hi_u32    v8, v7, v8
/*0000000007bc*/ v_add_u32       v8, vcc, v10, v8
/*0000000007c0*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007c8*/ v_mul_hi_u32    v12, v6, v9
/*0000000007d0*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d4*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007dc*/ v_mul_lo_u32    v12, v7, v9
/*0000000007e4*/ v_add_u32       v8, vcc, v8, v12
/*0000000007e8*/ v_mul_hi_u32    v7, v7, v9
/*0000000007f0*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007f4*/ v_add_u32       v6, s[6:7], v6, v8
/*0000000007fc*/ v_addc_u32      v7, vcc, v11, v7, s[4:5]
/*000000000804*/ v_addc_u32      v7, vcc, v7, 0, s[6:7]
/*00000000080c*/ s_waitcnt       lgkmcnt(0)
/*000000000810*/ v_mul_hi_u32    v6, s0, v6
/*000000000818*/ v_mul_lo_u32    v8, s0, v7
/*000000000820*/ v_add_u32       v6, vcc, v6, v8
/*000000000824*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*00000000082c*/ v_mul_hi_u32    v7, s0, v7
/*000000000834*/ v_add_u32       v6, vcc, v6, v7
/*000000000838*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000840*/ v_add_u32       v7, vcc, 0, v7
/*000000000844*/ v_mul_lo_u32    v7, v15, v7
/*00000000084c*/ v_mul_lo_u32    v8, v16, v6
/*000000000854*/ v_add_u32       v7, vcc, v7, v8
/*000000000858*/ v_mul_hi_u32    v8, v15, v6
/*000000000860*/ v_add_u32       v7, vcc, v7, v8
/*000000000864*/ v_mul_lo_u32    v8, v15, v6
/*00000000086c*/ v_sub_u32       v8, s[4:5], s0, v8
/*000000000874*/ v_subb_u32      v9, vcc, 0, v7, s[4:5]
/*00000000087c*/ v_cmp_ge_u32    s[6:7], v8, v15
/*000000000884*/ v_cmp_ge_u32    s[8:9], v9, v16
/*00000000088c*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000890*/ v_cndmask_b32   v9, 0, -1, s[8:9]
/*000000000898*/ v_cndmask_b32   v10, 0, -1, s[6:7]
/*0000000008a0*/ v_cndmask_b32   v9, v9, v10, vcc
/*0000000008a4*/ v_cmp_lg_u32    vcc, 0, v9
/*0000000008a8*/ s_and_saveexec_b64 s[6:7], vcc
/*0000000008ac*/ v_sub_u32       v7, vcc, 0, v7
/*0000000008b0*/ s_cbranch_execz .L2316_51
/*0000000008b4*/ v_sub_u32       v8, s[8:9], v8, v15
/*0000000008bc*/ v_subb_u32      v7, vcc, v7, v16, s[4:5]
/*0000000008c4*/ v_subb_u32      v7, vcc, v7, 0, s[8:9]
/*0000000008cc*/ v_cmp_ge_u32    s[4:5], v8, v15
/*0000000008d4*/ v_cmp_ge_u32    s[8:9], v7, v16
/*0000000008dc*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008e0*/ v_cndmask_b32   v4, 0, -1, s[8:9]
/*0000000008e8*/ v_cndmask_b32   v5, 0, -1, s[4:5]
/*0000000008f0*/ v_add_u32       v6, s[4:5], v6, 1
/*0000000008f8*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008fc*/ v_cmp_lg_u32    vcc, 0, v4
/*000000000900*/ v_add_u32       v4, s[4:5], v6, 1
/*000000000908*/ v_cndmask_b32   v6, v6, v4, vcc
.L2316_51:
/*00000000090c*/ s_mov_b64       exec, s[6:7]
/*000000000910*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*000000000914*/ v_cndmask_b32   v2, -1, v6, vcc
.L2328_51:
/*000000000918*/ s_andn2_b64     exec, s[2:3], exec
/*00000000091c*/ s_waitcnt       lgkmcnt(0)
/*000000000920*/ v_mov_b32       v2, s0
/*000000000924*/ s_mov_b64       exec, s[2:3]
/*000000000928*/ flat_store_dword v[0:1], v2
/*000000000930*/ s_endpgm
.kernel div_get_num_groups_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
        .vgprsnum 19
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_lshl_b32      s3, s10, 2
/*000000000044*/ v_add_u32       v6, vcc, s3, v2
/*000000000048*/ v_add_u32       v2, vcc, s12, v0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000058*/ v_add_u32       v2, s[10:11], s6, v2
/*000000000060*/ v_add_u32       v17, vcc, v0, s12
/*000000000068*/ v_mov_b32       v4, s13
/*00000000006c*/ v_addc_u32      v18, vcc, 0, v4, vcc
/*000000000070*/ v_cmp_lg_i64    vcc, 1, v[17:18]
/*000000000074*/ s_and_saveexec_b64 s[12:13], vcc
/*000000000078*/ v_cvt_f32_u32   v8, v17
/*00000000007c*/ s_cbranch_execz .L800_52
/*000000000080*/ v_cvt_f32_u32   v9, v18
/*000000000084*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*00000000008c*/ v_rcp_f32       v8, v8
/*000000000090*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*000000000098*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*0000000000a0*/ v_trunc_f32     v9, v9
/*0000000000a4*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*0000000000ac*/ v_cvt_u32_f32   v8, v8
/*0000000000b0*/ v_cvt_u32_f32   v9, v9
/*0000000000b4*/ v_sub_u32       v10, vcc, 0, v17
/*0000000000b8*/ v_subb_u32      v11, vcc, 0, v18, vcc
/*0000000000bc*/ v_mul_lo_u32    v12, v10, v9
/*0000000000c4*/ v_mul_lo_u32    v13, v11, v8
/*0000000000cc*/ v_add_u32       v12, vcc, v12, v13
/*0000000000d0*/ v_mul_hi_u32    v13, v10, v8
/*0000000000d8*/ v_add_u32       v12, vcc, v12, v13
/*0000000000dc*/ v_mul_lo_u32    v13, v10, v8
/*0000000000e4*/ v_mul_hi_u32    v14, v8, v13
/*0000000000ec*/ v_mul_lo_u32    v15, v9, v13
/*0000000000f4*/ v_add_u32       v14, vcc, v14, v15
/*0000000000f8*/ v_cndmask_b32   v15, 0, 1, vcc
/*000000000100*/ v_mul_lo_u32    v16, v8, v12
/*000000000108*/ v_add_u32       v14, vcc, v14, v16
/*00000000010c*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*000000000114*/ v_mul_hi_u32    v13, v9, v13
/*00000000011c*/ v_add_u32       v13, vcc, v14, v13
/*000000000120*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000128*/ v_mul_hi_u32    v15, v8, v12
/*000000000130*/ v_add_u32       v13, vcc, v13, v15
/*000000000134*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*00000000013c*/ v_mul_lo_u32    v15, v9, v12
/*000000000144*/ v_add_u32       v13, vcc, v13, v15
/*000000000148*/ v_mul_hi_u32    v12, v9, v12
/*000000000150*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000154*/ v_add_u32       v8, s[16:17], v8, v13
/*00000000015c*/ v_add_u32       v13, vcc, v9, v12
/*000000000160*/ v_addc_u32      v9, vcc, v9, v12, s[16:17]
/*000000000168*/ v_mul_lo_u32    v12, v10, v9
/*000000000170*/ v_mul_lo_u32    v11, v11, v8
/*000000000178*/ v_add_u32       v11, vcc, v12, v11
/*00000000017c*/ v_mul_hi_u32    v12, v10, v8
/*000000000184*/ v_add_u32       v11, vcc, v11, v12
/*000000000188*/ v_mul_lo_u32    v10, v10, v8
/*000000000190*/ v_mul_hi_u32    v12, v8, v10
/*000000000198*/ v_mul_lo_u32    v14, v9, v10
/*0000000001a0*/ v_add_u32       v12, vcc, v12, v14
/*0000000001a4*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000001ac*/ v_mul_lo_u32    v15, v8, v11
/*0000000001b4*/ v_add_u32       v12, vcc, v12, v15
/*0000000001b8*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*0000000001c0*/ v_mul_hi_u32    v10, v9, v10
/*0000000001c8*/ v_add_u32       v10, vcc, v12, v10
/*0000000001cc*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001d4*/ v_mul_hi_u32    v14, v8, v11
/*0000000001dc*/ v_add_u32       v10, vcc, v10, v14
/*0000000001e0*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001e8*/ v_mul_lo_u32    v14, v9, v11
/*0000000001f0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001f4*/ v_mul_hi_u32    v9, v9, v11
/*0000000001fc*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*000000000200*/ v_add_u32       v8, s[18:19], v8, v10
/*000000000208*/ v_addc_u32      v9, vcc, v13, v9, s[16:17]
/*000000000210*/ v_addc_u32      v9, vcc, v9, 0, s[18:19]
/*000000000218*/ v_mul_hi_u32    v8, s0, v8
/*000000000220*/ v_mul_lo_u32    v10, s0, v9
/*000000000228*/ v_add_u32       v8, vcc, v8, v10
/*00000000022c*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000234*/ v_mul_hi_u32    v9, s0, v9
/*00000000023c*/ v_add_u32       v8, vcc, v8, v9
/*000000000240*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*000000000248*/ v_add_u32       v9, vcc, 0, v9
/*00000000024c*/ v_mul_lo_u32    v9, v17, v9
/*000000000254*/ v_mul_lo_u32    v10, v18, v8
/*00000000025c*/ v_add_u32       v9, vcc, v9, v10
/*000000000260*/ v_mul_hi_u32    v10, v17, v8
/*000000000268*/ v_add_u32       v9, vcc, v9, v10
/*00000000026c*/ v_mul_lo_u32    v10, v17, v8
/*000000000274*/ v_sub_u32       v10, s[16:17], s0, v10
/*00000000027c*/ v_subb_u32      v11, vcc, 0, v9, s[16:17]
/*000000000284*/ v_cmp_ge_u32    s[18:19], v10, v17
/*00000000028c*/ v_cmp_ge_u32    s[20:21], v11, v18
/*000000000294*/ v_cmp_eq_i32    vcc, v11, v18
/*000000000298*/ v_cndmask_b32   v11, 0, -1, s[20:21]
/*0000000002a0*/ v_cndmask_b32   v12, 0, -1, s[18:19]
/*0000000002a8*/ v_cndmask_b32   v11, v11, v12, vcc
/*0000000002ac*/ v_cmp_lg_u32    vcc, 0, v11
/*0000000002b0*/ s_and_saveexec_b64 s[18:19], vcc
/*0000000002b4*/ v_sub_u32       v9, vcc, 0, v9
/*0000000002b8*/ s_cbranch_execz .L788_52
/*0000000002bc*/ v_sub_u32       v10, s[20:21], v10, v17
/*0000000002c4*/ v_subb_u32      v9, vcc, v9, v18, s[16:17]
/*0000000002cc*/ v_subb_u32      v9, vcc, v9, 0, s[20:21]
/*0000000002d4*/ v_cmp_ge_u32    s[16:17], v10, v17
/*0000000002dc*/ v_cmp_ge_u32    s[20:21], v9, v18
/*0000000002e4*/ v_cmp_eq_i32    vcc, v9, v18
/*0000000002e8*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*0000000002f0*/ v_cndmask_b32   v7, 0, -1, s[16:17]
/*0000000002f8*/ v_add_u32       v8, s[16:17], v8, 1
/*000000000300*/ v_cndmask_b32   v0, v0, v7, vcc
/*000000000304*/ v_cmp_lg_u32    vcc, 0, v0
/*000000000308*/ v_add_u32       v0, s[16:17], v8, 1
/*000000000310*/ v_cndmask_b32   v8, v8, v0, vcc
.L788_52:
/*000000000314*/ s_mov_b64       exec, s[18:19]
/*000000000318*/ v_cmp_lg_i64    vcc, 0, v[17:18]
/*00000000031c*/ v_cndmask_b32   v4, -1, v8, vcc
.L800_52:
/*000000000320*/ s_andn2_b64     exec, s[12:13], exec
/*000000000324*/ v_mov_b32       v4, s0
/*000000000328*/ s_mov_b64       exec, s[12:13]
/*00000000032c*/ s_lshl_b32      s0, s9, 1
/*000000000330*/ v_add_u32       v5, vcc, s0, v1
/*000000000334*/ v_add_u32       v0, vcc, s14, v5
/*000000000338*/ v_mov_b32       v1, 0
/*00000000033c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000344*/ v_mov_b32       v7, s7
/*000000000348*/ v_addc_u32      v3, vcc, v7, v3, s[10:11]
/*000000000350*/ flat_store_dword v[2:3], v4
/*000000000358*/ v_add_u32       v0, s[8:9], s6, v0
/*000000000360*/ v_add_u32       v16, vcc, v5, s14
/*000000000368*/ v_mov_b32       v2, s15
/*00000000036c*/ v_addc_u32      v17, vcc, 0, v2, vcc
/*000000000370*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000374*/ s_and_saveexec_b64 s[10:11], vcc
/*000000000378*/ v_cvt_f32_u32   v7, v16
/*00000000037c*/ s_cbranch_execz .L1568_52
/*000000000380*/ v_cvt_f32_u32   v8, v17
/*000000000384*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*00000000038c*/ v_rcp_f32       v7, v7
/*000000000390*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*000000000398*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*0000000003a0*/ v_trunc_f32     v8, v8
/*0000000003a4*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*0000000003ac*/ v_cvt_u32_f32   v7, v7
/*0000000003b0*/ v_cvt_u32_f32   v8, v8
/*0000000003b4*/ v_sub_u32       v9, vcc, 0, v16
/*0000000003b8*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*0000000003bc*/ v_mul_lo_u32    v11, v9, v8
/*0000000003c4*/ v_mul_lo_u32    v12, v10, v7
/*0000000003cc*/ v_add_u32       v11, vcc, v11, v12
/*0000000003d0*/ v_mul_hi_u32    v12, v9, v7
/*0000000003d8*/ v_add_u32       v11, vcc, v11, v12
/*0000000003dc*/ v_mul_lo_u32    v12, v9, v7
/*0000000003e4*/ v_mul_hi_u32    v13, v7, v12
/*0000000003ec*/ v_mul_lo_u32    v14, v8, v12
/*0000000003f4*/ v_add_u32       v13, vcc, v13, v14
/*0000000003f8*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000400*/ v_mul_lo_u32    v15, v7, v11
/*000000000408*/ v_add_u32       v13, vcc, v13, v15
/*00000000040c*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*000000000414*/ v_mul_hi_u32    v12, v8, v12
/*00000000041c*/ v_add_u32       v12, vcc, v13, v12
/*000000000420*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000428*/ v_mul_hi_u32    v14, v7, v11
/*000000000430*/ v_add_u32       v12, vcc, v12, v14
/*000000000434*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*00000000043c*/ v_mul_lo_u32    v14, v8, v11
/*000000000444*/ v_add_u32       v12, vcc, v12, v14
/*000000000448*/ v_mul_hi_u32    v11, v8, v11
/*000000000450*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000454*/ v_add_u32       v7, s[12:13], v7, v12
/*00000000045c*/ v_add_u32       v12, vcc, v8, v11
/*000000000460*/ v_addc_u32      v8, vcc, v8, v11, s[12:13]
/*000000000468*/ v_mul_lo_u32    v11, v9, v8
/*000000000470*/ v_mul_lo_u32    v10, v10, v7
/*000000000478*/ v_add_u32       v10, vcc, v11, v10
/*00000000047c*/ v_mul_hi_u32    v11, v9, v7
/*000000000484*/ v_add_u32       v10, vcc, v10, v11
/*000000000488*/ v_mul_lo_u32    v9, v9, v7
/*000000000490*/ v_mul_hi_u32    v11, v7, v9
/*000000000498*/ v_mul_lo_u32    v13, v8, v9
/*0000000004a0*/ v_add_u32       v11, vcc, v11, v13
/*0000000004a4*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000004ac*/ v_mul_lo_u32    v14, v7, v10
/*0000000004b4*/ v_add_u32       v11, vcc, v11, v14
/*0000000004b8*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000004c0*/ v_mul_hi_u32    v9, v8, v9
/*0000000004c8*/ v_add_u32       v9, vcc, v11, v9
/*0000000004cc*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004d4*/ v_mul_hi_u32    v13, v7, v10
/*0000000004dc*/ v_add_u32       v9, vcc, v9, v13
/*0000000004e0*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004e8*/ v_mul_lo_u32    v13, v8, v10
/*0000000004f0*/ v_add_u32       v9, vcc, v9, v13
/*0000000004f4*/ v_mul_hi_u32    v8, v8, v10
/*0000000004fc*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*000000000500*/ v_add_u32       v7, s[14:15], v7, v9
/*000000000508*/ v_addc_u32      v8, vcc, v12, v8, s[12:13]
/*000000000510*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*000000000518*/ v_mul_hi_u32    v7, s1, v7
/*000000000520*/ v_mul_lo_u32    v9, s1, v8
/*000000000528*/ v_add_u32       v7, vcc, v7, v9
/*00000000052c*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000534*/ v_mul_hi_u32    v8, s1, v8
/*00000000053c*/ v_add_u32       v7, vcc, v7, v8
/*000000000540*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000548*/ v_add_u32       v8, vcc, 0, v8
/*00000000054c*/ v_mul_lo_u32    v8, v16, v8
/*000000000554*/ v_mul_lo_u32    v9, v17, v7
/*00000000055c*/ v_add_u32       v8, vcc, v8, v9
/*000000000560*/ v_mul_hi_u32    v9, v16, v7
/*000000000568*/ v_add_u32       v8, vcc, v8, v9
/*00000000056c*/ v_mul_lo_u32    v9, v16, v7
/*000000000574*/ v_sub_u32       v9, s[12:13], s1, v9
/*00000000057c*/ v_subb_u32      v10, vcc, 0, v8, s[12:13]
/*000000000584*/ v_cmp_ge_u32    s[14:15], v9, v16
/*00000000058c*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000594*/ v_cmp_eq_i32    vcc, v10, v17
/*000000000598*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*0000000005a0*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*0000000005a8*/ v_cndmask_b32   v10, v10, v11, vcc
/*0000000005ac*/ v_cmp_lg_u32    vcc, 0, v10
/*0000000005b0*/ s_and_saveexec_b64 s[14:15], vcc
/*0000000005b4*/ v_sub_u32       v8, vcc, 0, v8
/*0000000005b8*/ s_cbranch_execz .L1556_52
/*0000000005bc*/ v_sub_u32       v9, s[16:17], v9, v16
/*0000000005c4*/ v_subb_u32      v8, vcc, v8, v17, s[12:13]
/*0000000005cc*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*0000000005d4*/ v_cmp_ge_u32    s[12:13], v9, v16
/*0000000005dc*/ v_cmp_ge_u32    s[16:17], v8, v17
/*0000000005e4*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005e8*/ v_cndmask_b32   v4, 0, -1, s[16:17]
/*0000000005f0*/ v_cndmask_b32   v5, 0, -1, s[12:13]
/*0000000005f8*/ v_add_u32       v7, s[12:13], v7, 1
/*000000000600*/ v_cndmask_b32   v4, v4, v5, vcc
/*000000000604*/ v_cmp_lg_u32    vcc, 0, v4
/*000000000608*/ v_add_u32       v4, s[12:13], v7, 1
/*000000000610*/ v_cndmask_b32   v7, v7, v4, vcc
.L1556_52:
/*000000000614*/ s_mov_b64       exec, s[14:15]
/*000000000618*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*00000000061c*/ v_cndmask_b32   v4, -1, v7, vcc
.L1568_52:
/*000000000620*/ s_andn2_b64     exec, s[10:11], exec
/*000000000624*/ v_mov_b32       v4, s1
/*000000000628*/ s_mov_b64       exec, s[10:11]
/*00000000062c*/ v_add_u32       v2, vcc, s4, v6
/*000000000630*/ v_mov_b32       v3, 0
/*000000000634*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*00000000063c*/ v_mov_b32       v5, s7
/*000000000640*/ v_addc_u32      v1, vcc, v5, v1, s[8:9]
/*000000000648*/ flat_store_dword v[0:1], v4
/*000000000650*/ v_add_u32       v0, vcc, s6, v2
/*000000000654*/ v_addc_u32      v1, vcc, v5, v3, vcc
/*000000000658*/ v_add_u32       v15, vcc, v6, s4
/*000000000660*/ v_mov_b32       v2, s5
/*000000000664*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*000000000668*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*00000000066c*/ s_and_b64       exec, s[10:11], vcc
/*000000000670*/ v_cvt_f32_u32   v6, v15
/*000000000674*/ s_cbranch_execz .L2328_52
/*000000000678*/ v_cvt_f32_u32   v7, v16
/*00000000067c*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*000000000684*/ v_rcp_f32       v6, v6
/*000000000688*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000690*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000698*/ v_trunc_f32     v7, v7
/*00000000069c*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*0000000006a4*/ v_cvt_u32_f32   v6, v6
/*0000000006a8*/ v_cvt_u32_f32   v7, v7
/*0000000006ac*/ v_sub_u32       v8, vcc, 0, v15
/*0000000006b0*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*0000000006b4*/ v_mul_lo_u32    v10, v8, v7
/*0000000006bc*/ v_mul_lo_u32    v11, v9, v6
/*0000000006c4*/ v_add_u32       v10, vcc, v10, v11
/*0000000006c8*/ v_mul_hi_u32    v11, v8, v6
/*0000000006d0*/ v_add_u32       v10, vcc, v10, v11
/*0000000006d4*/ v_mul_lo_u32    v11, v8, v6
/*0000000006dc*/ v_mul_hi_u32    v12, v6, v11
/*0000000006e4*/ v_mul_lo_u32    v13, v7, v11
/*0000000006ec*/ v_add_u32       v12, vcc, v12, v13
/*0000000006f0*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006f8*/ v_mul_lo_u32    v14, v6, v10
/*000000000700*/ v_add_u32       v12, vcc, v12, v14
/*000000000704*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*00000000070c*/ v_mul_hi_u32    v11, v7, v11
/*000000000714*/ v_add_u32       v11, vcc, v12, v11
/*000000000718*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000720*/ v_mul_hi_u32    v13, v6, v10
/*000000000728*/ v_add_u32       v11, vcc, v11, v13
/*00000000072c*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*000000000734*/ v_mul_lo_u32    v13, v7, v10
/*00000000073c*/ v_add_u32       v11, vcc, v11, v13
/*000000000740*/ v_mul_hi_u32    v10, v7, v10
/*000000000748*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*00000000074c*/ v_add_u32       v6, s[0:1], v6, v11
/*000000000754*/ v_add_u32       v11, vcc, v7, v10
/*000000000758*/ v_addc_u32      v7, vcc, v7, v10, s[0:1]
/*000000000760*/ v_mul_lo_u32    v10, v8, v7
/*000000000768*/ v_mul_lo_u32    v9, v9, v6
/*000000000770*/ v_add_u32       v9, vcc, v10, v9
/*000000000774*/ v_mul_hi_u32    v10, v8, v6
/*00000000077c*/ v_add_u32       v9, vcc, v9, v10
/*000000000780*/ v_mul_lo_u32    v8, v8, v6
/*000000000788*/ v_mul_hi_u32    v10, v6, v8
/*000000000790*/ v_mul_lo_u32    v12, v7, v8
/*000000000798*/ v_add_u32       v10, vcc, v10, v12
/*00000000079c*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000007a4*/ v_mul_lo_u32    v13, v6, v9
/*0000000007ac*/ v_add_u32       v10, vcc, v10, v13
/*0000000007b0*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007b8*/ v_mul_hi_u32    v8, v7, v8
/*0000000007c0*/ v_add_u32       v8, vcc, v10, v8
/*0000000007c4*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007cc*/ v_mul_hi_u32    v12, v6, v9
/*0000000007d4*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d8*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007e0*/ v_mul_lo_u32    v12, v7, v9
/*0000000007e8*/ v_add_u32       v8, vcc, v8, v12
/*0000000007ec*/ v_mul_hi_u32    v7, v7, v9
/*0000000007f4*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007f8*/ v_add_u32       v6, s[4:5], v6, v8
/*000000000800*/ v_addc_u32      v7, vcc, v11, v7, s[0:1]
/*000000000808*/ v_addc_u32      v7, vcc, v7, 0, s[4:5]
/*000000000810*/ v_mul_hi_u32    v6, s2, v6
/*000000000818*/ v_mul_lo_u32    v8, s2, v7
/*000000000820*/ v_add_u32       v6, vcc, v6, v8
/*000000000824*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*00000000082c*/ v_mul_hi_u32    v7, s2, v7
/*000000000834*/ v_add_u32       v6, vcc, v6, v7
/*000000000838*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000840*/ v_add_u32       v7, vcc, 0, v7
/*000000000844*/ v_mul_lo_u32    v7, v15, v7
/*00000000084c*/ v_mul_lo_u32    v8, v16, v6
/*000000000854*/ v_add_u32       v7, vcc, v7, v8
/*000000000858*/ v_mul_hi_u32    v8, v15, v6
/*000000000860*/ v_add_u32       v7, vcc, v7, v8
/*000000000864*/ v_mul_lo_u32    v8, v15, v6
/*00000000086c*/ v_sub_u32       v8, s[0:1], s2, v8
/*000000000874*/ v_subb_u32      v9, vcc, 0, v7, s[0:1]
/*00000000087c*/ v_cmp_ge_u32    s[4:5], v8, v15
/*000000000884*/ v_cmp_ge_u32    s[6:7], v9, v16
/*00000000088c*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000890*/ v_cndmask_b32   v9, 0, -1, s[6:7]
/*000000000898*/ v_cndmask_b32   v10, 0, -1, s[4:5]
/*0000000008a0*/ v_cndmask_b32   v9, v9, v10, vcc
/*0000000008a4*/ v_cmp_lg_u32    vcc, 0, v9
/*0000000008a8*/ s_and_saveexec_b64 s[4:5], vcc
/*0000000008ac*/ v_sub_u32       v7, vcc, 0, v7
/*0000000008b0*/ s_cbranch_execz .L2316_52
/*0000000008b4*/ v_sub_u32       v8, s[6:7], v8, v15
/*0000000008bc*/ v_subb_u32      v7, vcc, v7, v16, s[0:1]
/*0000000008c4*/ v_subb_u32      v7, vcc, v7, 0, s[6:7]
/*0000000008cc*/ v_cmp_ge_u32    s[0:1], v8, v15
/*0000000008d4*/ v_cmp_ge_u32    s[6:7], v7, v16
/*0000000008dc*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008e0*/ v_cndmask_b32   v4, 0, -1, s[6:7]
/*0000000008e8*/ v_cndmask_b32   v5, 0, -1, s[0:1]
/*0000000008f0*/ v_add_u32       v6, s[0:1], v6, 1
/*0000000008f8*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008fc*/ v_cmp_lg_u32    vcc, 0, v4
/*000000000900*/ v_add_u32       v4, s[0:1], v6, 1
/*000000000908*/ v_cndmask_b32   v6, v6, v4, vcc
.L2316_52:
/*00000000090c*/ s_mov_b64       exec, s[4:5]
/*000000000910*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*000000000914*/ v_cndmask_b32   v2, -1, v6, vcc
.L2328_52:
/*000000000918*/ s_andn2_b64     exec, s[10:11], exec
/*00000000091c*/ v_mov_b32       v2, s2
/*000000000920*/ s_mov_b64       exec, s[10:11]
/*000000000924*/ flat_store_dword v[0:1], v2
/*00000000092c*/ s_endpgm
.kernel div_get_work_dim_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
        .vgprsnum 18
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dword    s4, s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000018*/ s_lshl_b32      s5, s8, 1
/*00000000001c*/ v_add_u32       v0, vcc, s5, v0
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ v_add_u32       v3, vcc, s0, v0
/*000000000028*/ v_add_u32       v5, vcc, v0, s0
/*000000000030*/ v_mov_b32       v4, s1
/*000000000034*/ v_addc_u32      v6, vcc, 0, v4, vcc
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ s_bfe_u32       s0, s4, 0x20010
/*00000000004c*/ v_add_u32       v3, s[4:5], s12, v3
/*000000000054*/ v_cmp_lg_i64    vcc, 1, v[5:6]
/*000000000058*/ s_and_saveexec_b64 s[14:15], vcc
/*00000000005c*/ v_cvt_f32_u32   v8, v5
/*000000000060*/ s_cbranch_execz .L772_53
/*000000000064*/ v_cvt_f32_u32   v9, v6
/*000000000068*/ v_madmk_f32     v8, v9, 0x4f800000 /* 4.2949673e+9f */, v8
/*000000000070*/ v_rcp_f32       v8, v8
/*000000000074*/ v_mul_f32       v8, 0x5f7ffffc /* 1.844674e+19f */, v8
/*00000000007c*/ v_mul_f32       v9, 0x2f800000 /* 2.32830644e-10f */, v8
/*000000000084*/ v_trunc_f32     v9, v9
/*000000000088*/ v_madmk_f32     v8, v9, 0xcf800000 /* -4.2949673e+9f */, v8
/*000000000090*/ v_cvt_u32_f32   v8, v8
/*000000000094*/ v_cvt_u32_f32   v9, v9
/*000000000098*/ v_sub_u32       v10, vcc, 0, v5
/*00000000009c*/ v_subb_u32      v11, vcc, 0, v6, vcc
/*0000000000a0*/ v_mul_lo_u32    v12, v10, v9
/*0000000000a8*/ v_mul_lo_u32    v13, v11, v8
/*0000000000b0*/ v_add_u32       v12, vcc, v12, v13
/*0000000000b4*/ v_mul_hi_u32    v13, v10, v8
/*0000000000bc*/ v_add_u32       v12, vcc, v12, v13
/*0000000000c0*/ v_mul_lo_u32    v13, v10, v8
/*0000000000c8*/ v_mul_hi_u32    v14, v8, v13
/*0000000000d0*/ v_mul_lo_u32    v15, v9, v13
/*0000000000d8*/ v_add_u32       v14, vcc, v14, v15
/*0000000000dc*/ v_cndmask_b32   v15, 0, 1, vcc
/*0000000000e4*/ v_mul_lo_u32    v16, v8, v12
/*0000000000ec*/ v_add_u32       v14, vcc, v14, v16
/*0000000000f0*/ v_addc_u32      v14, vcc, v15, 0, vcc
/*0000000000f8*/ v_mul_hi_u32    v13, v9, v13
/*000000000100*/ v_add_u32       v13, vcc, v14, v13
/*000000000104*/ v_cndmask_b32   v14, 0, 1, vcc
/*00000000010c*/ v_mul_hi_u32    v15, v8, v12
/*000000000114*/ v_add_u32       v13, vcc, v13, v15
/*000000000118*/ v_addc_u32      v14, vcc, v14, 0, vcc
/*000000000120*/ v_mul_lo_u32    v15, v9, v12
/*000000000128*/ v_add_u32       v13, vcc, v13, v15
/*00000000012c*/ v_mul_hi_u32    v12, v9, v12
/*000000000134*/ v_addc_u32      v12, vcc, v14, v12, vcc
/*000000000138*/ v_add_u32       v8, s[16:17], v8, v13
/*000000000140*/ v_add_u32       v13, vcc, v9, v12
/*000000000144*/ v_addc_u32      v9, vcc, v9, v12, s[16:17]
/*00000000014c*/ v_mul_lo_u32    v12, v10, v9
/*000000000154*/ v_mul_lo_u32    v11, v11, v8
/*00000000015c*/ v_add_u32       v11, vcc, v12, v11
/*000000000160*/ v_mul_hi_u32    v12, v10, v8
/*000000000168*/ v_add_u32       v11, vcc, v11, v12
/*00000000016c*/ v_mul_lo_u32    v10, v10, v8
/*000000000174*/ v_mul_hi_u32    v12, v8, v10
/*00000000017c*/ v_mul_lo_u32    v14, v9, v10
/*000000000184*/ v_add_u32       v12, vcc, v12, v14
/*000000000188*/ v_cndmask_b32   v14, 0, 1, vcc
/*000000000190*/ v_mul_lo_u32    v15, v8, v11
/*000000000198*/ v_add_u32       v12, vcc, v12, v15
/*00000000019c*/ v_addc_u32      v12, vcc, v14, 0, vcc
/*0000000001a4*/ v_mul_hi_u32    v10, v9, v10
/*0000000001ac*/ v_add_u32       v10, vcc, v12, v10
/*0000000001b0*/ v_cndmask_b32   v12, 0, 1, vcc
/*0000000001b8*/ v_mul_hi_u32    v14, v8, v11
/*0000000001c0*/ v_add_u32       v10, vcc, v10, v14
/*0000000001c4*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*0000000001cc*/ v_mul_lo_u32    v14, v9, v11
/*0000000001d4*/ v_add_u32       v10, vcc, v10, v14
/*0000000001d8*/ v_mul_hi_u32    v9, v9, v11
/*0000000001e0*/ v_addc_u32      v9, vcc, v12, v9, vcc
/*0000000001e4*/ v_add_u32       v8, s[18:19], v8, v10
/*0000000001ec*/ v_addc_u32      v9, vcc, v13, v9, s[16:17]
/*0000000001f4*/ v_addc_u32      v9, vcc, v9, 0, s[18:19]
/*0000000001fc*/ v_mul_hi_u32    v8, s0, v8
/*000000000204*/ v_mul_lo_u32    v10, s0, v9
/*00000000020c*/ v_add_u32       v8, vcc, v8, v10
/*000000000210*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*000000000218*/ v_mul_hi_u32    v9, s0, v9
/*000000000220*/ v_add_u32       v8, vcc, v8, v9
/*000000000224*/ v_addc_u32      v9, vcc, 0, 0, vcc
/*00000000022c*/ v_add_u32       v9, vcc, 0, v9
/*000000000230*/ v_mul_lo_u32    v9, v5, v9
/*000000000238*/ v_mul_lo_u32    v10, v6, v8
/*000000000240*/ v_add_u32       v9, vcc, v9, v10
/*000000000244*/ v_mul_hi_u32    v10, v5, v8
/*00000000024c*/ v_add_u32       v9, vcc, v9, v10
/*000000000250*/ v_mul_lo_u32    v10, v5, v8
/*000000000258*/ v_sub_u32       v10, s[16:17], s0, v10
/*000000000260*/ v_subb_u32      v11, vcc, 0, v9, s[16:17]
/*000000000268*/ v_cmp_ge_u32    s[18:19], v10, v5
/*000000000270*/ v_cmp_ge_u32    s[20:21], v11, v6
/*000000000278*/ v_cmp_eq_i32    vcc, v11, v6
/*00000000027c*/ v_cndmask_b32   v11, 0, -1, s[20:21]
/*000000000284*/ v_cndmask_b32   v12, 0, -1, s[18:19]
/*00000000028c*/ v_cndmask_b32   v11, v11, v12, vcc
/*000000000290*/ v_cmp_lg_u32    vcc, 0, v11
/*000000000294*/ s_and_saveexec_b64 s[18:19], vcc
/*000000000298*/ v_sub_u32       v9, vcc, 0, v9
/*00000000029c*/ s_cbranch_execz .L760_53
/*0000000002a0*/ v_sub_u32       v10, s[20:21], v10, v5
/*0000000002a8*/ v_subb_u32      v9, vcc, v9, v6, s[16:17]
/*0000000002b0*/ v_subb_u32      v9, vcc, v9, 0, s[20:21]
/*0000000002b8*/ v_cmp_ge_u32    s[16:17], v10, v5
/*0000000002c0*/ v_cmp_ge_u32    s[20:21], v9, v6
/*0000000002c8*/ v_cmp_eq_i32    vcc, v9, v6
/*0000000002cc*/ v_cndmask_b32   v0, 0, -1, s[20:21]
/*0000000002d4*/ v_cndmask_b32   v7, 0, -1, s[16:17]
/*0000000002dc*/ v_add_u32       v8, s[16:17], v8, 1
/*0000000002e4*/ v_cndmask_b32   v0, v0, v7, vcc
/*0000000002e8*/ v_cmp_lg_u32    vcc, 0, v0
/*0000000002ec*/ v_add_u32       v0, s[16:17], v8, 1
/*0000000002f4*/ v_cndmask_b32   v8, v8, v0, vcc
.L760_53:
/*0000000002f8*/ s_mov_b64       exec, s[18:19]
/*0000000002fc*/ v_cmp_lg_i64    vcc, 0, v[5:6]
/*000000000300*/ v_cndmask_b32   v5, -1, v8, vcc
.L772_53:
/*000000000304*/ s_andn2_b64     exec, s[14:15], exec
/*000000000308*/ v_mov_b32       v5, s0
/*00000000030c*/ s_mov_b64       exec, s[14:15]
/*000000000310*/ s_lshl_b32      s1, s9, 1
/*000000000314*/ v_add_u32       v6, vcc, s1, v1
/*000000000318*/ v_add_u32       v7, vcc, s2, v6
/*00000000031c*/ v_mov_b32       v0, s13
/*000000000320*/ v_addc_u32      v4, vcc, v0, v4, s[4:5]
/*000000000328*/ flat_store_dword v[3:4], v5
/*000000000330*/ v_mov_b32       v8, 0
/*000000000334*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000033c*/ v_add_u32       v0, s[4:5], s12, v0
/*000000000344*/ v_add_u32       v16, vcc, v6, s2
/*00000000034c*/ v_mov_b32       v3, s3
/*000000000350*/ v_addc_u32      v17, vcc, 0, v3, vcc
/*000000000354*/ v_cmp_lg_i64    vcc, 1, v[16:17]
/*000000000358*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000035c*/ v_cvt_f32_u32   v7, v16
/*000000000360*/ s_cbranch_execz .L1540_53
/*000000000364*/ v_cvt_f32_u32   v8, v17
/*000000000368*/ v_madmk_f32     v7, v8, 0x4f800000 /* 4.2949673e+9f */, v7
/*000000000370*/ v_rcp_f32       v7, v7
/*000000000374*/ v_mul_f32       v7, 0x5f7ffffc /* 1.844674e+19f */, v7
/*00000000037c*/ v_mul_f32       v8, 0x2f800000 /* 2.32830644e-10f */, v7
/*000000000384*/ v_trunc_f32     v8, v8
/*000000000388*/ v_madmk_f32     v7, v8, 0xcf800000 /* -4.2949673e+9f */, v7
/*000000000390*/ v_cvt_u32_f32   v7, v7
/*000000000394*/ v_cvt_u32_f32   v8, v8
/*000000000398*/ v_sub_u32       v9, vcc, 0, v16
/*00000000039c*/ v_subb_u32      v10, vcc, 0, v17, vcc
/*0000000003a0*/ v_mul_lo_u32    v11, v9, v8
/*0000000003a8*/ v_mul_lo_u32    v12, v10, v7
/*0000000003b0*/ v_add_u32       v11, vcc, v11, v12
/*0000000003b4*/ v_mul_hi_u32    v12, v9, v7
/*0000000003bc*/ v_add_u32       v11, vcc, v11, v12
/*0000000003c0*/ v_mul_lo_u32    v12, v9, v7
/*0000000003c8*/ v_mul_hi_u32    v13, v7, v12
/*0000000003d0*/ v_mul_lo_u32    v14, v8, v12
/*0000000003d8*/ v_add_u32       v13, vcc, v13, v14
/*0000000003dc*/ v_cndmask_b32   v14, 0, 1, vcc
/*0000000003e4*/ v_mul_lo_u32    v15, v7, v11
/*0000000003ec*/ v_add_u32       v13, vcc, v13, v15
/*0000000003f0*/ v_addc_u32      v13, vcc, v14, 0, vcc
/*0000000003f8*/ v_mul_hi_u32    v12, v8, v12
/*000000000400*/ v_add_u32       v12, vcc, v13, v12
/*000000000404*/ v_cndmask_b32   v13, 0, 1, vcc
/*00000000040c*/ v_mul_hi_u32    v14, v7, v11
/*000000000414*/ v_add_u32       v12, vcc, v12, v14
/*000000000418*/ v_addc_u32      v13, vcc, v13, 0, vcc
/*000000000420*/ v_mul_lo_u32    v14, v8, v11
/*000000000428*/ v_add_u32       v12, vcc, v12, v14
/*00000000042c*/ v_mul_hi_u32    v11, v8, v11
/*000000000434*/ v_addc_u32      v11, vcc, v13, v11, vcc
/*000000000438*/ v_add_u32       v7, s[8:9], v7, v12
/*000000000440*/ v_add_u32       v12, vcc, v8, v11
/*000000000444*/ v_addc_u32      v8, vcc, v8, v11, s[8:9]
/*00000000044c*/ v_mul_lo_u32    v11, v9, v8
/*000000000454*/ v_mul_lo_u32    v10, v10, v7
/*00000000045c*/ v_add_u32       v10, vcc, v11, v10
/*000000000460*/ v_mul_hi_u32    v11, v9, v7
/*000000000468*/ v_add_u32       v10, vcc, v10, v11
/*00000000046c*/ v_mul_lo_u32    v9, v9, v7
/*000000000474*/ v_mul_hi_u32    v11, v7, v9
/*00000000047c*/ v_mul_lo_u32    v13, v8, v9
/*000000000484*/ v_add_u32       v11, vcc, v11, v13
/*000000000488*/ v_cndmask_b32   v13, 0, 1, vcc
/*000000000490*/ v_mul_lo_u32    v14, v7, v10
/*000000000498*/ v_add_u32       v11, vcc, v11, v14
/*00000000049c*/ v_addc_u32      v11, vcc, v13, 0, vcc
/*0000000004a4*/ v_mul_hi_u32    v9, v8, v9
/*0000000004ac*/ v_add_u32       v9, vcc, v11, v9
/*0000000004b0*/ v_cndmask_b32   v11, 0, 1, vcc
/*0000000004b8*/ v_mul_hi_u32    v13, v7, v10
/*0000000004c0*/ v_add_u32       v9, vcc, v9, v13
/*0000000004c4*/ v_addc_u32      v11, vcc, v11, 0, vcc
/*0000000004cc*/ v_mul_lo_u32    v13, v8, v10
/*0000000004d4*/ v_add_u32       v9, vcc, v9, v13
/*0000000004d8*/ v_mul_hi_u32    v8, v8, v10
/*0000000004e0*/ v_addc_u32      v8, vcc, v11, v8, vcc
/*0000000004e4*/ v_add_u32       v7, s[14:15], v7, v9
/*0000000004ec*/ v_addc_u32      v8, vcc, v12, v8, s[8:9]
/*0000000004f4*/ v_addc_u32      v8, vcc, v8, 0, s[14:15]
/*0000000004fc*/ v_mul_hi_u32    v7, s0, v7
/*000000000504*/ v_mul_lo_u32    v9, s0, v8
/*00000000050c*/ v_add_u32       v7, vcc, v7, v9
/*000000000510*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000518*/ v_mul_hi_u32    v8, s0, v8
/*000000000520*/ v_add_u32       v7, vcc, v7, v8
/*000000000524*/ v_addc_u32      v8, vcc, 0, 0, vcc
/*00000000052c*/ v_add_u32       v8, vcc, 0, v8
/*000000000530*/ v_mul_lo_u32    v8, v16, v8
/*000000000538*/ v_mul_lo_u32    v9, v17, v7
/*000000000540*/ v_add_u32       v8, vcc, v8, v9
/*000000000544*/ v_mul_hi_u32    v9, v16, v7
/*00000000054c*/ v_add_u32       v8, vcc, v8, v9
/*000000000550*/ v_mul_lo_u32    v9, v16, v7
/*000000000558*/ v_sub_u32       v9, s[8:9], s0, v9
/*000000000560*/ v_subb_u32      v10, vcc, 0, v8, s[8:9]
/*000000000568*/ v_cmp_ge_u32    s[14:15], v9, v16
/*000000000570*/ v_cmp_ge_u32    s[16:17], v10, v17
/*000000000578*/ v_cmp_eq_i32    vcc, v10, v17
/*00000000057c*/ v_cndmask_b32   v10, 0, -1, s[16:17]
/*000000000584*/ v_cndmask_b32   v11, 0, -1, s[14:15]
/*00000000058c*/ v_cndmask_b32   v10, v10, v11, vcc
/*000000000590*/ v_cmp_lg_u32    vcc, 0, v10
/*000000000594*/ s_and_saveexec_b64 s[14:15], vcc
/*000000000598*/ v_sub_u32       v8, vcc, 0, v8
/*00000000059c*/ s_cbranch_execz .L1528_53
/*0000000005a0*/ v_sub_u32       v9, s[16:17], v9, v16
/*0000000005a8*/ v_subb_u32      v8, vcc, v8, v17, s[8:9]
/*0000000005b0*/ v_subb_u32      v8, vcc, v8, 0, s[16:17]
/*0000000005b8*/ v_cmp_ge_u32    s[8:9], v9, v16
/*0000000005c0*/ v_cmp_ge_u32    s[16:17], v8, v17
/*0000000005c8*/ v_cmp_eq_i32    vcc, v8, v17
/*0000000005cc*/ v_cndmask_b32   v5, 0, -1, s[16:17]
/*0000000005d4*/ v_cndmask_b32   v6, 0, -1, s[8:9]
/*0000000005dc*/ v_add_u32       v7, s[8:9], v7, 1
/*0000000005e4*/ v_cndmask_b32   v5, v5, v6, vcc
/*0000000005e8*/ v_cmp_lg_u32    vcc, 0, v5
/*0000000005ec*/ v_add_u32       v5, s[8:9], v7, 1
/*0000000005f4*/ v_cndmask_b32   v7, v7, v5, vcc
.L1528_53:
/*0000000005f8*/ s_mov_b64       exec, s[14:15]
/*0000000005fc*/ v_cmp_lg_i64    vcc, 0, v[16:17]
/*000000000600*/ v_cndmask_b32   v3, -1, v7, vcc
.L1540_53:
/*000000000604*/ s_andn2_b64     exec, s[2:3], exec
/*000000000608*/ v_mov_b32       v3, s0
/*00000000060c*/ s_mov_b64       exec, s[2:3]
/*000000000610*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000618*/ s_lshl_b32      s1, s10, 2
/*00000000061c*/ v_add_u32       v2, vcc, s1, v2
/*000000000620*/ s_waitcnt       lgkmcnt(0)
/*000000000624*/ v_add_u32       v6, vcc, s2, v2
/*000000000628*/ v_mov_b32       v5, s13
/*00000000062c*/ v_addc_u32      v1, vcc, v5, v1, s[4:5]
/*000000000634*/ flat_store_dword v[0:1], v3
/*00000000063c*/ v_mov_b32       v7, 0
/*000000000640*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000648*/ v_add_u32       v0, vcc, s12, v0
/*00000000064c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000650*/ v_add_u32       v15, vcc, v2, s2
/*000000000658*/ v_mov_b32       v2, s3
/*00000000065c*/ v_addc_u32      v16, vcc, 0, v2, vcc
/*000000000660*/ v_cmp_lg_i64    vcc, 1, v[15:16]
/*000000000664*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000668*/ v_cvt_f32_u32   v6, v15
/*00000000066c*/ s_cbranch_execz .L2320_53
/*000000000670*/ v_cvt_f32_u32   v7, v16
/*000000000674*/ v_madmk_f32     v6, v7, 0x4f800000 /* 4.2949673e+9f */, v6
/*00000000067c*/ v_rcp_f32       v6, v6
/*000000000680*/ v_mul_f32       v6, 0x5f7ffffc /* 1.844674e+19f */, v6
/*000000000688*/ v_mul_f32       v7, 0x2f800000 /* 2.32830644e-10f */, v6
/*000000000690*/ v_trunc_f32     v7, v7
/*000000000694*/ v_madmk_f32     v6, v7, 0xcf800000 /* -4.2949673e+9f */, v6
/*00000000069c*/ v_cvt_u32_f32   v6, v6
/*0000000006a0*/ v_cvt_u32_f32   v7, v7
/*0000000006a4*/ v_sub_u32       v8, vcc, 0, v15
/*0000000006a8*/ v_subb_u32      v9, vcc, 0, v16, vcc
/*0000000006ac*/ v_mul_lo_u32    v10, v8, v7
/*0000000006b4*/ v_mul_lo_u32    v11, v9, v6
/*0000000006bc*/ v_add_u32       v10, vcc, v10, v11
/*0000000006c0*/ v_mul_hi_u32    v11, v8, v6
/*0000000006c8*/ v_add_u32       v10, vcc, v10, v11
/*0000000006cc*/ v_mul_lo_u32    v11, v8, v6
/*0000000006d4*/ v_mul_hi_u32    v12, v6, v11
/*0000000006dc*/ v_mul_lo_u32    v13, v7, v11
/*0000000006e4*/ v_add_u32       v12, vcc, v12, v13
/*0000000006e8*/ v_cndmask_b32   v13, 0, 1, vcc
/*0000000006f0*/ v_mul_lo_u32    v14, v6, v10
/*0000000006f8*/ v_add_u32       v12, vcc, v12, v14
/*0000000006fc*/ v_addc_u32      v12, vcc, v13, 0, vcc
/*000000000704*/ v_mul_hi_u32    v11, v7, v11
/*00000000070c*/ v_add_u32       v11, vcc, v12, v11
/*000000000710*/ v_cndmask_b32   v12, 0, 1, vcc
/*000000000718*/ v_mul_hi_u32    v13, v6, v10
/*000000000720*/ v_add_u32       v11, vcc, v11, v13
/*000000000724*/ v_addc_u32      v12, vcc, v12, 0, vcc
/*00000000072c*/ v_mul_lo_u32    v13, v7, v10
/*000000000734*/ v_add_u32       v11, vcc, v11, v13
/*000000000738*/ v_mul_hi_u32    v10, v7, v10
/*000000000740*/ v_addc_u32      v10, vcc, v12, v10, vcc
/*000000000744*/ v_add_u32       v6, s[4:5], v6, v11
/*00000000074c*/ v_add_u32       v11, vcc, v7, v10
/*000000000750*/ v_addc_u32      v7, vcc, v7, v10, s[4:5]
/*000000000758*/ v_mul_lo_u32    v10, v8, v7
/*000000000760*/ v_mul_lo_u32    v9, v9, v6
/*000000000768*/ v_add_u32       v9, vcc, v10, v9
/*00000000076c*/ v_mul_hi_u32    v10, v8, v6
/*000000000774*/ v_add_u32       v9, vcc, v9, v10
/*000000000778*/ v_mul_lo_u32    v8, v8, v6
/*000000000780*/ v_mul_hi_u32    v10, v6, v8
/*000000000788*/ v_mul_lo_u32    v12, v7, v8
/*000000000790*/ v_add_u32       v10, vcc, v10, v12
/*000000000794*/ v_cndmask_b32   v12, 0, 1, vcc
/*00000000079c*/ v_mul_lo_u32    v13, v6, v9
/*0000000007a4*/ v_add_u32       v10, vcc, v10, v13
/*0000000007a8*/ v_addc_u32      v10, vcc, v12, 0, vcc
/*0000000007b0*/ v_mul_hi_u32    v8, v7, v8
/*0000000007b8*/ v_add_u32       v8, vcc, v10, v8
/*0000000007bc*/ v_cndmask_b32   v10, 0, 1, vcc
/*0000000007c4*/ v_mul_hi_u32    v12, v6, v9
/*0000000007cc*/ v_add_u32       v8, vcc, v8, v12
/*0000000007d0*/ v_addc_u32      v10, vcc, v10, 0, vcc
/*0000000007d8*/ v_mul_lo_u32    v12, v7, v9
/*0000000007e0*/ v_add_u32       v8, vcc, v8, v12
/*0000000007e4*/ v_mul_hi_u32    v7, v7, v9
/*0000000007ec*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*0000000007f0*/ v_add_u32       v6, s[6:7], v6, v8
/*0000000007f8*/ v_addc_u32      v7, vcc, v11, v7, s[4:5]
/*000000000800*/ v_addc_u32      v7, vcc, v7, 0, s[6:7]
/*000000000808*/ v_mul_hi_u32    v6, s0, v6
/*000000000810*/ v_mul_lo_u32    v8, s0, v7
/*000000000818*/ v_add_u32       v6, vcc, v6, v8
/*00000000081c*/ v_addc_u32      v6, vcc, 0, 0, vcc
/*000000000824*/ v_mul_hi_u32    v7, s0, v7
/*00000000082c*/ v_add_u32       v6, vcc, v6, v7
/*000000000830*/ v_addc_u32      v7, vcc, 0, 0, vcc
/*000000000838*/ v_add_u32       v7, vcc, 0, v7
/*00000000083c*/ v_mul_lo_u32    v7, v15, v7
/*000000000844*/ v_mul_lo_u32    v8, v16, v6
/*00000000084c*/ v_add_u32       v7, vcc, v7, v8
/*000000000850*/ v_mul_hi_u32    v8, v15, v6
/*000000000858*/ v_add_u32       v7, vcc, v7, v8
/*00000000085c*/ v_mul_lo_u32    v8, v15, v6
/*000000000864*/ v_sub_u32       v8, s[4:5], s0, v8
/*00000000086c*/ v_subb_u32      v9, vcc, 0, v7, s[4:5]
/*000000000874*/ v_cmp_ge_u32    s[6:7], v8, v15
/*00000000087c*/ v_cmp_ge_u32    s[8:9], v9, v16
/*000000000884*/ v_cmp_eq_i32    vcc, v9, v16
/*000000000888*/ v_cndmask_b32   v9, 0, -1, s[8:9]
/*000000000890*/ v_cndmask_b32   v10, 0, -1, s[6:7]
/*000000000898*/ v_cndmask_b32   v9, v9, v10, vcc
/*00000000089c*/ v_cmp_lg_u32    vcc, 0, v9
/*0000000008a0*/ s_and_saveexec_b64 s[6:7], vcc
/*0000000008a4*/ v_sub_u32       v7, vcc, 0, v7
/*0000000008a8*/ s_cbranch_execz .L2308_53
/*0000000008ac*/ v_sub_u32       v8, s[8:9], v8, v15
/*0000000008b4*/ v_subb_u32      v7, vcc, v7, v16, s[4:5]
/*0000000008bc*/ v_subb_u32      v7, vcc, v7, 0, s[8:9]
/*0000000008c4*/ v_cmp_ge_u32    s[4:5], v8, v15
/*0000000008cc*/ v_cmp_ge_u32    s[8:9], v7, v16
/*0000000008d4*/ v_cmp_eq_i32    vcc, v7, v16
/*0000000008d8*/ v_cndmask_b32   v4, 0, -1, s[8:9]
/*0000000008e0*/ v_cndmask_b32   v5, 0, -1, s[4:5]
/*0000000008e8*/ v_add_u32       v6, s[4:5], v6, 1
/*0000000008f0*/ v_cndmask_b32   v4, v4, v5, vcc
/*0000000008f4*/ v_cmp_lg_u32    vcc, 0, v4
/*0000000008f8*/ v_add_u32       v4, s[4:5], v6, 1
/*000000000900*/ v_cndmask_b32   v6, v6, v4, vcc
.L2308_53:
/*000000000904*/ s_mov_b64       exec, s[6:7]
/*000000000908*/ v_cmp_lg_i64    vcc, 0, v[15:16]
/*00000000090c*/ v_cndmask_b32   v2, -1, v6, vcc
.L2320_53:
/*000000000910*/ s_andn2_b64     exec, s[2:3], exec
/*000000000914*/ v_mov_b32       v2, s0
/*000000000918*/ s_mov_b64       exec, s[2:3]
/*00000000091c*/ flat_store_dword v[0:1], v2
/*000000000924*/ s_endpgm
.kernel div_x_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshl_b32      s5, s8, 4
/*000000000040*/ s_lshl_b32      s7, s9, 1
/*000000000044*/ s_lshl_b32      s8, s10, 1
/*000000000048*/ v_cvt_f32_u32   v3, s0
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v5, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000064*/ v_sub_u32       v6, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000078*/ v_mul_hi_u32    v3, v3, v5
/*000000000080*/ v_sub_u32       v4, vcc, v5, v3
/*000000000084*/ v_add_u32       v3, vcc, v5, v3
/*000000000088*/ v_cndmask_b32   v3, v3, v4, s[10:11]
/*000000000090*/ v_mul_hi_u32    v3, v3, s3
/*000000000098*/ v_mul_lo_u32    v4, v3, s0
/*0000000000a0*/ v_sub_u32       v5, vcc, s3, v4
/*0000000000a4*/ v_cmp_ge_u32    s[10:11], s3, v4
/*0000000000ac*/ v_cmp_ge_u32    s[16:17], v5, s0
/*0000000000b4*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000c8*/ s_cmp_lg_i32    s0, 0
/*0000000000cc*/ s_cselect_b64   vcc, exec, 0
/*0000000000d0*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000d4*/ s_add_u32       s0, s5, s4
/*0000000000d8*/ v_add_u32       v3, vcc, s0, v0
/*0000000000dc*/ v_mov_b32       v4, 0
/*0000000000e0*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e8*/ v_add_u32       v3, vcc, s12, v3
/*0000000000ec*/ v_mov_b32       v6, s13
/*0000000000f0*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f4*/ flat_store_dword v[3:4], v5
/*0000000000fc*/ v_cvt_f32_u32   v0, s1
/*000000000100*/ v_rcp_f32       v0, v0
/*000000000104*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*00000000010c*/ v_cvt_u32_f32   v0, v0
/*000000000110*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*000000000118*/ v_sub_u32       v5, vcc, 0, v3
/*00000000011c*/ v_cmp_lg_i32    s[4:5], 0, v4
/*000000000124*/ v_cndmask_b32   v3, v5, v3, s[4:5]
/*00000000012c*/ v_mul_hi_u32    v3, v3, v0
/*000000000134*/ v_sub_u32       v4, vcc, v0, v3
/*000000000138*/ v_add_u32       v0, vcc, v0, v3
/*00000000013c*/ v_cndmask_b32   v0, v0, v4, s[4:5]
/*000000000144*/ v_mul_hi_u32    v0, v0, s3
/*00000000014c*/ v_mul_lo_u32    v3, v0, s1
/*000000000154*/ v_sub_u32       v4, vcc, s3, v3
/*000000000158*/ v_cmp_ge_u32    s[4:5], s3, v3
/*000000000160*/ v_cmp_ge_u32    s[10:11], v4, s1
/*000000000168*/ s_and_b64       s[10:11], s[4:5], s[10:11]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000174*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*00000000017c*/ s_cmp_lg_i32    s1, 0
/*000000000180*/ s_cselect_b64   vcc, exec, 0
/*000000000184*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000188*/ s_add_u32       s0, s7, s14
/*00000000018c*/ v_add_u32       v0, vcc, s0, v1
/*000000000190*/ v_mov_b32       v1, 0
/*000000000194*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000019c*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a4*/ flat_store_dword v[0:1], v3
/*0000000001ac*/ v_cvt_f32_u32   v0, s2
/*0000000001b0*/ v_rcp_f32       v0, v0
/*0000000001b4*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001bc*/ v_cvt_u32_f32   v3, v0
/*0000000001c0*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001c8*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001cc*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d4*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001dc*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e4*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e8*/ v_add_u32       v0, vcc, v3, v0
/*0000000001ec*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f4*/ v_mul_hi_u32    v0, v0, s3
/*0000000001fc*/ v_mul_lo_u32    v1, v0, s2
/*000000000204*/ v_sub_u32       v3, vcc, s3, v1
/*000000000208*/ v_cmp_ge_u32    s[0:1], s3, v1
/*000000000210*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000218*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000224*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*00000000022c*/ s_cmp_lg_i32    s2, 0
/*000000000230*/ s_cselect_b64   vcc, exec, 0
/*000000000234*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000238*/ s_add_u32       s0, s8, s6
/*00000000023c*/ v_add_u32       v0, vcc, s0, v2
/*000000000240*/ v_mov_b32       v1, 0
/*000000000244*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000024c*/ v_add_u32       v0, vcc, s12, v0
/*000000000250*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000254*/ flat_store_dword v[0:1], v3
/*00000000025c*/ s_endpgm
.kernel div_get_global_offset_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 21
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0082
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshl_b32      s5, s9, 4
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ s_add_u32       s3, s3, s4
/*000000000044*/ v_add_u32       v7, vcc, s3, v0
/*000000000048*/ v_cvt_f32_u32   v3, s0
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v5, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000064*/ v_sub_u32       v6, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000078*/ v_mul_hi_u32    v3, v3, v5
/*000000000080*/ v_sub_u32       v4, vcc, v5, v3
/*000000000084*/ v_add_u32       v3, vcc, v5, v3
/*000000000088*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*000000000090*/ v_mul_hi_u32    v3, v3, s4
/*000000000098*/ v_mul_lo_u32    v4, v3, s0
/*0000000000a0*/ v_sub_u32       v5, vcc, s4, v4
/*0000000000a4*/ v_cmp_ge_u32    s[8:9], s4, v4
/*0000000000ac*/ v_cmp_ge_u32    s[10:11], v5, s0
/*0000000000b4*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000c8*/ s_cmp_lg_i32    s0, 0
/*0000000000cc*/ s_cselect_b64   vcc, exec, 0
/*0000000000d0*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000d4*/ v_mov_b32       v8, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000e0*/ v_add_u32       v3, vcc, s12, v3
/*0000000000e4*/ v_mov_b32       v6, s13
/*0000000000e8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v5
/*0000000000f4*/ v_cvt_f32_u32   v0, s1
/*0000000000f8*/ v_rcp_f32       v0, v0
/*0000000000fc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000104*/ v_cvt_u32_f32   v0, v0
/*000000000108*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*000000000110*/ v_sub_u32       v5, vcc, 0, v3
/*000000000114*/ v_cmp_lg_i32    s[8:9], 0, v4
/*00000000011c*/ v_cndmask_b32   v3, v5, v3, s[8:9]
/*000000000124*/ v_mul_hi_u32    v3, v3, v0
/*00000000012c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000130*/ v_add_u32       v0, vcc, v0, v3
/*000000000134*/ v_cndmask_b32   v0, v0, v4, s[8:9]
/*00000000013c*/ v_mul_hi_u32    v0, v0, s14
/*000000000144*/ v_mul_lo_u32    v3, v0, s1
/*00000000014c*/ v_sub_u32       v4, vcc, s14, v3
/*000000000150*/ v_cmp_ge_u32    s[8:9], s14, v3
/*000000000158*/ v_cmp_ge_u32    s[10:11], v4, s1
/*000000000160*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000164*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000174*/ s_cmp_lg_i32    s1, 0
/*000000000178*/ s_cselect_b64   vcc, exec, 0
/*00000000017c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000180*/ s_add_u32       s0, s5, s14
/*000000000184*/ v_add_u32       v0, vcc, s0, v1
/*000000000188*/ v_mov_b32       v1, 0
/*00000000018c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000194*/ v_add_u32       v0, vcc, s12, v0
/*000000000198*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000019c*/ flat_store_dword v[0:1], v3
/*0000000001a4*/ v_cvt_f32_u32   v0, s2
/*0000000001a8*/ v_rcp_f32       v0, v0
/*0000000001ac*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b4*/ v_cvt_u32_f32   v3, v0
/*0000000001b8*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001c0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001cc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001d4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001dc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001ec*/ v_mul_hi_u32    v0, v0, s6
/*0000000001f4*/ v_mul_lo_u32    v1, v0, s2
/*0000000001fc*/ v_sub_u32       v3, vcc, s6, v1
/*000000000200*/ v_cmp_ge_u32    s[0:1], s6, v1
/*000000000208*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000210*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000214*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000224*/ s_cmp_lg_i32    s2, 0
/*000000000228*/ s_cselect_b64   vcc, exec, 0
/*00000000022c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000230*/ s_add_u32       s0, s7, s6
/*000000000234*/ v_add_u32       v0, vcc, s0, v2
/*000000000238*/ v_mov_b32       v1, 0
/*00000000023c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000244*/ v_add_u32       v0, vcc, s12, v0
/*000000000248*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000024c*/ flat_store_dword v[0:1], v3
/*000000000254*/ s_endpgm
.kernel div_get_local_id_get_global_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_lshl_b32      s3, s8, 3
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshl_b32      s5, s9, 2
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ s_add_u32       s3, s3, s4
/*000000000044*/ v_add_u32       v5, vcc, s3, v0
/*000000000048*/ v_cvt_f32_u32   v3, s0
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v6, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s0, v6, 0
/*000000000064*/ v_sub_u32       v7, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v7, v3, s[8:9]
/*000000000078*/ v_mul_hi_u32    v3, v3, v6
/*000000000080*/ v_sub_u32       v4, vcc, v6, v3
/*000000000084*/ v_add_u32       v3, vcc, v6, v3
/*000000000088*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*000000000090*/ v_mul_hi_u32    v3, v3, v0
/*000000000098*/ v_mul_lo_u32    v4, v3, s0
/*0000000000a0*/ v_sub_u32       v6, vcc, v0, v4
/*0000000000a4*/ v_cmp_ge_u32    s[8:9], v0, v4
/*0000000000ac*/ v_cmp_ge_u32    s[10:11], v6, s0
/*0000000000b4*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000b8*/ v_addc_u32      v0, vcc, v3, 0, s[10:11]
/*0000000000c0*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*0000000000c8*/ s_cmp_lg_i32    s0, 0
/*0000000000cc*/ s_cselect_b64   vcc, exec, 0
/*0000000000d0*/ v_cndmask_b32   v0, -1, v0, vcc
/*0000000000d4*/ v_mov_b32       v6, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*0000000000e0*/ v_add_u32       v3, vcc, s12, v3
/*0000000000e4*/ v_mov_b32       v5, s13
/*0000000000e8*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v0
/*0000000000f4*/ v_cvt_f32_u32   v0, s1
/*0000000000f8*/ v_rcp_f32       v0, v0
/*0000000000fc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000104*/ v_cvt_u32_f32   v0, v0
/*000000000108*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*000000000110*/ v_sub_u32       v6, vcc, 0, v3
/*000000000114*/ v_cmp_lg_i32    s[8:9], 0, v4
/*00000000011c*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000124*/ v_mul_hi_u32    v3, v3, v0
/*00000000012c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000130*/ v_add_u32       v0, vcc, v0, v3
/*000000000134*/ v_cndmask_b32   v0, v0, v4, s[8:9]
/*00000000013c*/ v_mul_hi_u32    v0, v0, v1
/*000000000144*/ v_mul_lo_u32    v3, v0, s1
/*00000000014c*/ v_sub_u32       v4, vcc, v1, v3
/*000000000150*/ v_cmp_ge_u32    s[8:9], v1, v3
/*000000000158*/ v_cmp_ge_u32    s[10:11], v4, s1
/*000000000160*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000164*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000174*/ s_cmp_lg_i32    s1, 0
/*000000000178*/ s_cselect_b64   vcc, exec, 0
/*00000000017c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000180*/ s_add_u32       s0, s5, s14
/*000000000184*/ v_add_u32       v0, vcc, s0, v1
/*000000000188*/ v_mov_b32       v1, 0
/*00000000018c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000194*/ v_add_u32       v0, vcc, s12, v0
/*000000000198*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000019c*/ flat_store_dword v[0:1], v3
/*0000000001a4*/ v_cvt_f32_u32   v0, s2
/*0000000001a8*/ v_rcp_f32       v0, v0
/*0000000001ac*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b4*/ v_cvt_u32_f32   v3, v0
/*0000000001b8*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001c0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001cc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001d4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001dc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001ec*/ v_mul_hi_u32    v0, v0, v2
/*0000000001f4*/ v_mul_lo_u32    v1, v0, s2
/*0000000001fc*/ v_sub_u32       v3, vcc, v2, v1
/*000000000200*/ v_cmp_ge_u32    s[0:1], v2, v1
/*000000000208*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000210*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000214*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000224*/ s_cmp_lg_i32    s2, 0
/*000000000228*/ s_cselect_b64   vcc, exec, 0
/*00000000022c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000230*/ s_add_u32       s0, s7, s6
/*000000000234*/ v_add_u32       v0, vcc, s0, v2
/*000000000238*/ v_mov_b32       v1, 0
/*00000000023c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000244*/ v_add_u32       v0, vcc, s12, v0
/*000000000248*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000024c*/ flat_store_dword v[0:1], v3
/*000000000254*/ s_endpgm
.kernel div_get_group_id_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshl_b32      s5, s9, 4
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ s_add_u32       s3, s3, s4
/*000000000044*/ v_add_u32       v7, vcc, s3, v0
/*000000000048*/ v_cvt_f32_u32   v3, s0
/*00000000004c*/ v_rcp_f32       v3, v3
/*000000000050*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000058*/ v_cvt_u32_f32   v5, v3
/*00000000005c*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000064*/ v_sub_u32       v6, vcc, 0, v3
/*000000000068*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000070*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000078*/ v_mul_hi_u32    v3, v3, v5
/*000000000080*/ v_sub_u32       v4, vcc, v5, v3
/*000000000084*/ v_add_u32       v3, vcc, v5, v3
/*000000000088*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*000000000090*/ v_mul_hi_u32    v3, v3, s8
/*000000000098*/ v_mul_lo_u32    v4, v3, s0
/*0000000000a0*/ v_sub_u32       v5, vcc, s8, v4
/*0000000000a4*/ v_cmp_ge_u32    s[16:17], s8, v4
/*0000000000ac*/ v_cmp_ge_u32    s[18:19], v5, s0
/*0000000000b4*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000c8*/ s_cmp_lg_i32    s0, 0
/*0000000000cc*/ s_cselect_b64   vcc, exec, 0
/*0000000000d0*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000d4*/ v_mov_b32       v8, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000e0*/ v_add_u32       v3, vcc, s12, v3
/*0000000000e4*/ v_mov_b32       v6, s13
/*0000000000e8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v5
/*0000000000f4*/ v_cvt_f32_u32   v0, s1
/*0000000000f8*/ v_rcp_f32       v0, v0
/*0000000000fc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000104*/ v_cvt_u32_f32   v0, v0
/*000000000108*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*000000000110*/ v_sub_u32       v5, vcc, 0, v3
/*000000000114*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000011c*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000124*/ v_mul_hi_u32    v3, v3, v0
/*00000000012c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000130*/ v_add_u32       v0, vcc, v0, v3
/*000000000134*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*00000000013c*/ v_mul_hi_u32    v0, v0, s9
/*000000000144*/ v_mul_lo_u32    v3, v0, s1
/*00000000014c*/ v_sub_u32       v4, vcc, s9, v3
/*000000000150*/ v_cmp_ge_u32    s[8:9], s9, v3
/*000000000158*/ v_cmp_ge_u32    s[16:17], v4, s1
/*000000000160*/ s_and_b64       s[16:17], s[8:9], s[16:17]
/*000000000164*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*00000000016c*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000174*/ s_cmp_lg_i32    s1, 0
/*000000000178*/ s_cselect_b64   vcc, exec, 0
/*00000000017c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000180*/ s_add_u32       s0, s5, s14
/*000000000184*/ v_add_u32       v0, vcc, s0, v1
/*000000000188*/ v_mov_b32       v1, 0
/*00000000018c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000194*/ v_add_u32       v0, vcc, s12, v0
/*000000000198*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000019c*/ flat_store_dword v[0:1], v3
/*0000000001a4*/ v_cvt_f32_u32   v0, s2
/*0000000001a8*/ v_rcp_f32       v0, v0
/*0000000001ac*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001b4*/ v_cvt_u32_f32   v3, v0
/*0000000001b8*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001c0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001c4*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001cc*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001d4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001dc*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001e0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001e4*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001ec*/ v_mul_hi_u32    v0, v0, s10
/*0000000001f4*/ v_mul_lo_u32    v1, v0, s2
/*0000000001fc*/ v_sub_u32       v3, vcc, s10, v1
/*000000000200*/ v_cmp_ge_u32    s[0:1], s10, v1
/*000000000208*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000210*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000214*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*00000000021c*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000224*/ s_cmp_lg_i32    s2, 0
/*000000000228*/ s_cselect_b64   vcc, exec, 0
/*00000000022c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000230*/ s_add_u32       s0, s7, s6
/*000000000234*/ v_add_u32       v0, vcc, s0, v2
/*000000000238*/ v_mov_b32       v1, 0
/*00000000023c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000244*/ v_add_u32       v0, vcc, s12, v0
/*000000000248*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000024c*/ flat_store_dword v[0:1], v3
/*000000000254*/ s_endpgm
.kernel div_get_local_size_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 32
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0103
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ v_cvt_f32_u32   v3, s0
/*000000000018*/ v_rcp_f32       v3, v3
/*00000000001c*/ v_cvt_f32_u32   v4, s1
/*000000000020*/ v_rcp_f32       v4, v4
/*000000000024*/ v_cvt_f32_u32   v5, s2
/*000000000028*/ v_rcp_f32       v5, v5
/*00000000002c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000034*/ v_cvt_u32_f32   v3, v3
/*000000000038*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*000000000040*/ v_mad_u64_u32   v[6:7], vcc, s0, v3, 0
/*000000000048*/ v_cvt_u32_f32   v4, v4
/*00000000004c*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000054*/ v_mad_u64_u32   v[8:9], vcc, s1, v4, 0
/*00000000005c*/ v_cvt_u32_f32   v5, v5
/*000000000060*/ v_mad_u64_u32   v[10:11], vcc, s2, v5, 0
/*000000000068*/ v_sub_u32       v12, vcc, 0, v6
/*00000000006c*/ v_cmp_lg_i32    s[4:5], 0, v7
/*000000000074*/ v_cndmask_b32   v6, v12, v6, s[4:5]
/*00000000007c*/ v_sub_u32       v7, vcc, 0, v8
/*000000000080*/ v_cmp_lg_i32    s[12:13], 0, v9
/*000000000088*/ v_mul_hi_u32    v6, v6, v3
/*000000000090*/ v_cndmask_b32   v7, v7, v8, s[12:13]
/*000000000098*/ v_sub_u32       v8, vcc, 0, v10
/*00000000009c*/ v_cmp_lg_i32    s[14:15], 0, v11
/*0000000000a4*/ v_mul_hi_u32    v7, v7, v4
/*0000000000ac*/ v_cndmask_b32   v8, v8, v10, s[14:15]
/*0000000000b4*/ v_mul_hi_u32    v8, v8, v5
/*0000000000bc*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000c0*/ v_add_u32       v3, vcc, v3, v6
/*0000000000c4*/ v_cndmask_b32   v3, v3, v9, s[4:5]
/*0000000000cc*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000d0*/ v_add_u32       v4, vcc, v4, v7
/*0000000000d4*/ v_readfirstlane_b32 s3, v3
/*0000000000d8*/ v_cndmask_b32   v3, v4, v6, s[12:13]
/*0000000000e0*/ v_sub_u32       v4, vcc, v5, v8
/*0000000000e4*/ v_add_u32       v5, vcc, v5, v8
/*0000000000e8*/ v_readfirstlane_b32 s4, v3
/*0000000000ec*/ v_cndmask_b32   v3, v5, v4, s[14:15]
/*0000000000f4*/ v_readfirstlane_b32 s5, v3
/*0000000000f8*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000100*/ s_lshr_b32      s3, s3, 31
/*000000000104*/ s_load_dwordx2  s[16:17], s[6:7], 0x10
/*00000000010c*/ s_mul_i32       s11, s3, s0
/*000000000110*/ s_lshr_b32      s4, s4, 31
/*000000000114*/ s_waitcnt       lgkmcnt(0)
/*000000000118*/ s_sub_u32       s13, 2, s11
/*00000000011c*/ s_mul_i32       s15, s4, s1
/*000000000120*/ s_lshr_b32      s5, s5, 30
/*000000000124*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*00000000012c*/ s_lshl_b32      s8, s8, 1
/*000000000130*/ s_cmp_le_u32    s11, 2
/*000000000134*/ s_cselect_b64   s[18:19], exec, 0
/*000000000138*/ s_cmp_ge_u32    s13, s0
/*00000000013c*/ s_cselect_b64   s[20:21], exec, 0
/*000000000140*/ s_sub_u32       s11, 2, s15
/*000000000144*/ s_mul_i32       s13, s5, s2
/*000000000148*/ s_lshl_b32      s9, s9, 1
/*00000000014c*/ s_add_u32       s8, s8, s12
/*000000000150*/ s_cmp_le_u32    s15, 2
/*000000000154*/ s_cselect_b64   s[22:23], exec, 0
/*000000000158*/ s_cmp_ge_u32    s11, s1
/*00000000015c*/ s_cselect_b64   s[24:25], exec, 0
/*000000000160*/ s_sub_u32       s11, 4, s13
/*000000000164*/ s_lshl_b32      s10, s10, 2
/*000000000168*/ v_add_u32       v5, vcc, s8, v0
/*00000000016c*/ s_add_u32       s8, s9, s14
/*000000000170*/ s_and_b64       s[14:15], s[18:19], s[20:21]
/*000000000174*/ v_mov_b32       v3, s3
/*000000000178*/ s_cmp_le_u32    s13, 4
/*00000000017c*/ s_cselect_b64   s[12:13], exec, 0
/*000000000180*/ s_cmp_ge_u32    s11, s2
/*000000000184*/ s_cselect_b64   s[20:21], exec, 0
/*000000000188*/ v_add_u32       v8, vcc, s8, v1
/*00000000018c*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*000000000194*/ s_cmp_lg_i32    s0, 0
/*000000000198*/ s_cselect_b64   s[8:9], exec, 0
/*00000000019c*/ s_and_b64       s[14:15], s[22:23], s[24:25]
/*0000000001a0*/ v_mov_b32       v4, s4
/*0000000001a4*/ s_add_u32       s0, s10, s16
/*0000000001a8*/ v_mov_b32       v6, 0
/*0000000001ac*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*0000000001b4*/ v_addc_u32      v0, vcc, v3, -1, s[18:19]
/*0000000001bc*/ v_addc_u32      v3, vcc, v4, 0, s[14:15]
/*0000000001c4*/ s_cmp_lg_i32    s1, 0
/*0000000001c8*/ s_cselect_b64   s[10:11], exec, 0
/*0000000001cc*/ v_add_u32       v10, vcc, s0, v2
/*0000000001d0*/ s_and_b64       s[0:1], s[12:13], s[20:21]
/*0000000001d4*/ v_mov_b32       v4, s5
/*0000000001d8*/ s_waitcnt       lgkmcnt(0)
/*0000000001dc*/ v_add_u32       v5, vcc, s6, v5
/*0000000001e0*/ v_mov_b32       v7, s7
/*0000000001e4*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*0000000001e8*/ v_cndmask_b32   v0, -1, v0, s[8:9]
/*0000000001f0*/ v_mov_b32       v9, 0
/*0000000001f4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000001fc*/ v_addc_u32      v1, vcc, v3, -1, s[22:23]
/*000000000204*/ v_addc_u32      v3, vcc, v4, 0, s[0:1]
/*00000000020c*/ s_cmp_lg_i32    s2, 0
/*000000000210*/ s_cselect_b64   s[0:1], exec, 0
/*000000000214*/ v_add_u32       v12, vcc, s6, v8
/*000000000218*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*00000000021c*/ v_cndmask_b32   v1, -1, v1, s[10:11]
/*000000000224*/ v_mov_b32       v11, 0
/*000000000228*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000230*/ v_addc_u32      v2, vcc, v3, -1, s[12:13]
/*000000000238*/ v_add_u32       v3, vcc, s6, v9
/*00000000023c*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000240*/ v_cndmask_b32   v2, -1, v2, s[0:1]
/*000000000248*/ flat_store_dword v[5:6], v0
/*000000000250*/ flat_store_dword v[12:13], v1
/*000000000258*/ flat_store_dword v[3:4], v2
/*000000000260*/ s_endpgm
.kernel div_get_global_id_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c4
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_lshl_b32      s3, s8, 1
/*000000000014*/ s_lshl_b32      s4, s9, 1
/*000000000018*/ s_lshl_b32      s5, s10, 2
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ v_cvt_f32_u32   v3, s0
/*000000000024*/ v_rcp_f32       v3, v3
/*000000000028*/ v_cvt_f32_u32   v4, s1
/*00000000002c*/ v_rcp_f32       v4, v4
/*000000000030*/ v_cvt_f32_u32   v5, s2
/*000000000034*/ v_rcp_f32       v5, v5
/*000000000038*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000040*/ v_cvt_u32_f32   v3, v3
/*000000000044*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000004c*/ v_mad_u64_u32   v[6:7], vcc, s0, v3, 0
/*000000000054*/ v_cvt_u32_f32   v4, v4
/*000000000058*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000060*/ v_mad_u64_u32   v[8:9], vcc, s1, v4, 0
/*000000000068*/ v_cvt_u32_f32   v5, v5
/*00000000006c*/ v_mad_u64_u32   v[10:11], vcc, s2, v5, 0
/*000000000074*/ v_sub_u32       v12, vcc, 0, v6
/*000000000078*/ v_cmp_lg_i32    s[8:9], 0, v7
/*000000000080*/ v_cndmask_b32   v6, v12, v6, s[8:9]
/*000000000088*/ v_sub_u32       v7, vcc, 0, v8
/*00000000008c*/ v_cmp_lg_i32    s[10:11], 0, v9
/*000000000094*/ s_load_dwordx2  s[12:13], s[6:7], 0x0
/*00000000009c*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*0000000000a4*/ v_mul_hi_u32    v6, v6, v3
/*0000000000ac*/ v_cndmask_b32   v7, v7, v8, s[10:11]
/*0000000000b4*/ v_sub_u32       v8, vcc, 0, v10
/*0000000000b8*/ v_cmp_lg_i32    s[16:17], 0, v11
/*0000000000c0*/ s_load_dwordx2  s[18:19], s[6:7], 0x10
/*0000000000c8*/ v_mul_hi_u32    v7, v7, v4
/*0000000000d0*/ v_cndmask_b32   v8, v8, v10, s[16:17]
/*0000000000d8*/ v_mul_hi_u32    v8, v8, v5
/*0000000000e0*/ v_add_u32       v11, vcc, s3, v0
/*0000000000e4*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000e8*/ v_add_u32       v3, vcc, v3, v6
/*0000000000ec*/ s_waitcnt       lgkmcnt(0)
/*0000000000f0*/ v_add_u32       v6, vcc, s12, v11
/*0000000000f4*/ v_cndmask_b32   v3, v3, v9, s[8:9]
/*0000000000fc*/ s_add_u32       s3, s4, s14
/*000000000100*/ v_sub_u32       v9, vcc, v4, v7
/*000000000104*/ v_add_u32       v4, vcc, v4, v7
/*000000000108*/ v_mul_hi_u32    v3, v3, v6
/*000000000110*/ v_add_u32       v13, vcc, s3, v1
/*000000000114*/ v_cndmask_b32   v4, v4, v9, s[10:11]
/*00000000011c*/ s_add_u32       s3, s5, s18
/*000000000120*/ v_sub_u32       v7, vcc, v5, v8
/*000000000124*/ v_add_u32       v5, vcc, v5, v8
/*000000000128*/ v_mul_hi_u32    v4, v4, v13
/*000000000130*/ v_add_u32       v15, vcc, s3, v2
/*000000000134*/ v_cndmask_b32   v5, v5, v7, s[16:17]
/*00000000013c*/ v_mul_hi_u32    v5, v5, v15
/*000000000144*/ v_mul_lo_u32    v7, v3, s0
/*00000000014c*/ v_mul_lo_u32    v8, v4, s1
/*000000000154*/ v_mul_lo_u32    v9, v5, s2
/*00000000015c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000164*/ v_sub_u32       v10, vcc, v6, v7
/*000000000168*/ v_cmp_ge_u32    s[6:7], v6, v7
/*000000000170*/ v_cmp_ge_u32    s[8:9], v10, s0
/*000000000178*/ v_sub_u32       v6, vcc, v13, v8
/*00000000017c*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*000000000180*/ v_cmp_ge_u32    s[10:11], v13, v8
/*000000000188*/ v_cmp_ge_u32    s[12:13], v6, s1
/*000000000190*/ v_sub_u32       v6, vcc, v15, v9
/*000000000194*/ v_addc_u32      v3, vcc, v3, 0, s[8:9]
/*00000000019c*/ s_cmp_lg_i32    s0, 0
/*0000000001a0*/ s_cselect_b64   s[8:9], exec, 0
/*0000000001a4*/ s_and_b64       s[12:13], s[10:11], s[12:13]
/*0000000001a8*/ v_cmp_ge_u32    s[14:15], v15, v9
/*0000000001b0*/ v_cmp_ge_u32    s[16:17], v6, s2
/*0000000001b8*/ v_mov_b32       v12, 0
/*0000000001bc*/ v_lshlrev_b64   v[6:7], 2, v[11:12]
/*0000000001c4*/ v_addc_u32      v0, vcc, v3, -1, s[6:7]
/*0000000001cc*/ v_addc_u32      v3, vcc, v4, 0, s[12:13]
/*0000000001d4*/ s_cmp_lg_i32    s1, 0
/*0000000001d8*/ s_cselect_b64   s[0:1], exec, 0
/*0000000001dc*/ s_and_b64       s[6:7], s[14:15], s[16:17]
/*0000000001e0*/ s_waitcnt       lgkmcnt(0)
/*0000000001e4*/ v_add_u32       v11, vcc, s4, v6
/*0000000001e8*/ v_mov_b32       v6, s5
/*0000000001ec*/ v_addc_u32      v12, vcc, v6, v7, vcc
/*0000000001f0*/ v_cndmask_b32   v0, -1, v0, s[8:9]
/*0000000001f8*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*000000000200*/ v_mov_b32       v14, 0
/*000000000204*/ v_lshlrev_b64   v[8:9], 2, v[13:14]
/*00000000020c*/ v_addc_u32      v1, vcc, v5, 0, s[6:7]
/*000000000214*/ s_cmp_lg_i32    s2, 0
/*000000000218*/ s_cselect_b64   s[2:3], exec, 0
/*00000000021c*/ v_cndmask_b32   v3, -1, v3, s[0:1]
/*000000000224*/ v_add_u32       v4, vcc, s4, v8
/*000000000228*/ v_addc_u32      v5, vcc, v6, v9, vcc
/*00000000022c*/ v_addc_u32      v1, vcc, v1, -1, s[14:15]
/*000000000234*/ v_mov_b32       v16, 0
/*000000000238*/ v_lshlrev_b64   v[9:10], 2, v[15:16]
/*000000000240*/ v_cndmask_b32   v1, -1, v1, s[2:3]
/*000000000248*/ v_add_u32       v7, vcc, s4, v9
/*00000000024c*/ v_addc_u32      v8, vcc, v6, v10, vcc
/*000000000250*/ flat_store_dword v[11:12], v0
/*000000000258*/ flat_store_dword v[4:5], v3
/*000000000260*/ flat_store_dword v[7:8], v1
/*000000000268*/ s_endpgm
.kernel div_get_global_size_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 4
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_get_num_groups_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s3, s0, 1
/*000000000038*/ s_lshr_b32      s5, s1, 1
/*00000000003c*/ s_lshr_b32      s7, s2, 2
/*000000000040*/ s_lshl_b32      s8, s8, 1
/*000000000044*/ s_lshl_b32      s9, s9, 1
/*000000000048*/ s_lshl_b32      s10, s10, 2
/*00000000004c*/ s_add_u32       s4, s8, s4
/*000000000050*/ v_add_u32       v7, vcc, s4, v0
/*000000000054*/ v_cvt_f32_u32   v3, s0
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s3
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s0
/*0000000000ac*/ v_sub_u32       v5, vcc, s3, v4
/*0000000000b0*/ v_cmp_ge_u32    s[16:17], s3, v4
/*0000000000b8*/ v_cmp_ge_u32    s[18:19], v5, s0
/*0000000000c0*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ v_mov_b32       v8, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v6, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v5
/*000000000100*/ v_cvt_f32_u32   v0, s1
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*00000000011c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*000000000148*/ v_mul_hi_u32    v0, v0, s5
/*000000000150*/ v_mul_lo_u32    v3, v0, s1
/*000000000158*/ v_sub_u32       v4, vcc, s5, v3
/*00000000015c*/ v_cmp_ge_u32    s[4:5], s5, v3
/*000000000164*/ v_cmp_ge_u32    s[16:17], v4, s1
/*00000000016c*/ s_and_b64       s[16:17], s[4:5], s[16:17]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*000000000180*/ s_cmp_lg_i32    s1, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s9, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s2
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, s7
/*000000000200*/ v_mul_lo_u32    v1, v0, s2
/*000000000208*/ v_sub_u32       v3, vcc, s7, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], s7, v1
/*000000000214*/ v_cmp_ge_u32    s[4:5], v3, s2
/*00000000021c*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s2, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s10, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_work_dim_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000044*/ s_lshl_b32      s5, s8, 1
/*000000000048*/ s_lshl_b32      s7, s9, 1
/*00000000004c*/ s_lshl_b32      s8, s10, 2
/*000000000050*/ v_cvt_f32_u32   v3, s2
/*000000000054*/ v_rcp_f32       v3, v3
/*000000000058*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000060*/ v_cvt_u32_f32   v5, v3
/*000000000064*/ v_mad_u64_u32   v[3:4], vcc, s2, v5, 0
/*00000000006c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000070*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000078*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000080*/ v_mul_hi_u32    v3, v3, v5
/*000000000088*/ v_sub_u32       v4, vcc, v5, v3
/*00000000008c*/ v_add_u32       v3, vcc, v5, v3
/*000000000090*/ v_cndmask_b32   v3, v3, v4, s[10:11]
/*000000000098*/ v_mul_hi_u32    v3, v3, s0
/*0000000000a0*/ v_mul_lo_u32    v4, v3, s2
/*0000000000a8*/ v_sub_u32       v5, vcc, s0, v4
/*0000000000ac*/ v_cmp_ge_u32    s[10:11], s0, v4
/*0000000000b4*/ v_cmp_ge_u32    s[16:17], v5, s2
/*0000000000bc*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000c8*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000d0*/ s_cmp_lg_i32    s2, 0
/*0000000000d4*/ s_cselect_b64   vcc, exec, 0
/*0000000000d8*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000dc*/ s_add_u32       s2, s5, s4
/*0000000000e0*/ v_add_u32       v3, vcc, s2, v0
/*0000000000e4*/ v_mov_b32       v4, 0
/*0000000000e8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000f0*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f4*/ v_mov_b32       v6, s13
/*0000000000f8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000fc*/ flat_store_dword v[3:4], v5
/*000000000104*/ v_cvt_f32_u32   v0, s3
/*000000000108*/ v_rcp_f32       v0, v0
/*00000000010c*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000114*/ v_cvt_u32_f32   v0, v0
/*000000000118*/ v_mad_u64_u32   v[3:4], vcc, s3, v0, 0
/*000000000120*/ v_sub_u32       v5, vcc, 0, v3
/*000000000124*/ v_cmp_lg_i32    s[4:5], 0, v4
/*00000000012c*/ v_cndmask_b32   v3, v5, v3, s[4:5]
/*000000000134*/ v_mul_hi_u32    v3, v3, v0
/*00000000013c*/ v_sub_u32       v4, vcc, v0, v3
/*000000000140*/ v_add_u32       v0, vcc, v0, v3
/*000000000144*/ v_cndmask_b32   v0, v0, v4, s[4:5]
/*00000000014c*/ v_mul_hi_u32    v0, v0, s0
/*000000000154*/ v_mul_lo_u32    v3, v0, s3
/*00000000015c*/ v_sub_u32       v4, vcc, s0, v3
/*000000000160*/ v_cmp_ge_u32    s[4:5], s0, v3
/*000000000168*/ v_cmp_ge_u32    s[10:11], v4, s3
/*000000000170*/ s_and_b64       s[10:11], s[4:5], s[10:11]
/*000000000174*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*00000000017c*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*000000000184*/ s_cmp_lg_i32    s3, 0
/*000000000188*/ s_cselect_b64   vcc, exec, 0
/*00000000018c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000190*/ s_add_u32       s2, s7, s14
/*000000000194*/ v_add_u32       v0, vcc, s2, v1
/*000000000198*/ v_mov_b32       v1, 0
/*00000000019c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a4*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001ac*/ flat_store_dword v[0:1], v3
/*0000000001b4*/ v_cvt_f32_u32   v0, s1
/*0000000001b8*/ v_rcp_f32       v0, v0
/*0000000001bc*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c4*/ v_cvt_u32_f32   v3, v0
/*0000000001c8*/ v_mad_u64_u32   v[0:1], vcc, s1, v3, 0
/*0000000001d0*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d4*/ v_cmp_lg_i32    s[2:3], 0, v1
/*0000000001dc*/ v_cndmask_b32   v0, v4, v0, s[2:3]
/*0000000001e4*/ v_mul_hi_u32    v0, v0, v3
/*0000000001ec*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001f0*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f4*/ v_cndmask_b32   v0, v0, v1, s[2:3]
/*0000000001fc*/ v_mul_hi_u32    v0, v0, s0
/*000000000204*/ v_mul_lo_u32    v1, v0, s1
/*00000000020c*/ v_sub_u32       v3, vcc, s0, v1
/*000000000210*/ v_cmp_ge_u32    s[2:3], s0, v1
/*000000000218*/ v_cmp_ge_u32    s[4:5], v3, s1
/*000000000220*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*000000000224*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*00000000022c*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*000000000234*/ s_cmp_lg_i32    s1, 0
/*000000000238*/ s_cselect_b64   vcc, exec, 0
/*00000000023c*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000240*/ s_add_u32       s0, s8, s6
/*000000000244*/ v_add_u32       v0, vcc, s0, v2
/*000000000248*/ v_mov_b32       v1, 0
/*00000000024c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000254*/ v_add_u32       v0, vcc, s12, v0
/*000000000258*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000025c*/ flat_store_dword v[0:1], v3
/*000000000264*/ s_endpgm
.kernel div_x_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshr_b32      s0, s0, 4
/*000000000040*/ s_lshr_b32      s1, s1, 1
/*000000000044*/ s_lshr_b32      s2, s2, 1
/*000000000048*/ s_lshl_b32      s5, s8, 4
/*00000000004c*/ s_lshl_b32      s7, s9, 1
/*000000000050*/ s_lshl_b32      s8, s10, 1
/*000000000054*/ v_cvt_f32_u32   v3, s0
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[10:11], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[10:11]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s3
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s0
/*0000000000ac*/ v_sub_u32       v5, vcc, s3, v4
/*0000000000b0*/ v_cmp_ge_u32    s[10:11], s3, v4
/*0000000000b8*/ v_cmp_ge_u32    s[16:17], v5, s0
/*0000000000c0*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ s_add_u32       s0, s5, s4
/*0000000000e4*/ v_add_u32       v3, vcc, s0, v0
/*0000000000e8*/ v_mov_b32       v4, 0
/*0000000000ec*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000f4*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f8*/ v_mov_b32       v6, s13
/*0000000000fc*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000100*/ flat_store_dword v[3:4], v5
/*000000000108*/ v_cvt_f32_u32   v0, s1
/*00000000010c*/ v_rcp_f32       v0, v0
/*000000000110*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000118*/ v_cvt_u32_f32   v0, v0
/*00000000011c*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*000000000124*/ v_sub_u32       v5, vcc, 0, v3
/*000000000128*/ v_cmp_lg_i32    s[4:5], 0, v4
/*000000000130*/ v_cndmask_b32   v3, v5, v3, s[4:5]
/*000000000138*/ v_mul_hi_u32    v3, v3, v0
/*000000000140*/ v_sub_u32       v4, vcc, v0, v3
/*000000000144*/ v_add_u32       v0, vcc, v0, v3
/*000000000148*/ v_cndmask_b32   v0, v0, v4, s[4:5]
/*000000000150*/ v_mul_hi_u32    v0, v0, s3
/*000000000158*/ v_mul_lo_u32    v3, v0, s1
/*000000000160*/ v_sub_u32       v4, vcc, s3, v3
/*000000000164*/ v_cmp_ge_u32    s[4:5], s3, v3
/*00000000016c*/ v_cmp_ge_u32    s[10:11], v4, s1
/*000000000174*/ s_and_b64       s[10:11], s[4:5], s[10:11]
/*000000000178*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000180*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*000000000188*/ s_cmp_lg_i32    s1, 0
/*00000000018c*/ s_cselect_b64   vcc, exec, 0
/*000000000190*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000194*/ s_add_u32       s0, s7, s14
/*000000000198*/ v_add_u32       v0, vcc, s0, v1
/*00000000019c*/ v_mov_b32       v1, 0
/*0000000001a0*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a8*/ v_add_u32       v0, vcc, s12, v0
/*0000000001ac*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001b0*/ flat_store_dword v[0:1], v3
/*0000000001b8*/ v_cvt_f32_u32   v0, s2
/*0000000001bc*/ v_rcp_f32       v0, v0
/*0000000001c0*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c8*/ v_cvt_u32_f32   v3, v0
/*0000000001cc*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001d4*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d8*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001e0*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e8*/ v_mul_hi_u32    v0, v0, v3
/*0000000001f0*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001f4*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f8*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*000000000200*/ v_mul_hi_u32    v0, v0, s3
/*000000000208*/ v_mul_lo_u32    v1, v0, s2
/*000000000210*/ v_sub_u32       v3, vcc, s3, v1
/*000000000214*/ v_cmp_ge_u32    s[0:1], s3, v1
/*00000000021c*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000224*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000230*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000238*/ s_cmp_lg_i32    s2, 0
/*00000000023c*/ s_cselect_b64   vcc, exec, 0
/*000000000240*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000244*/ s_add_u32       s0, s8, s6
/*000000000248*/ v_add_u32       v0, vcc, s0, v2
/*00000000024c*/ v_mov_b32       v1, 0
/*000000000250*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000258*/ v_add_u32       v0, vcc, s12, v0
/*00000000025c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000260*/ flat_store_dword v[0:1], v3
/*000000000268*/ s_endpgm
.kernel div_get_global_offset_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 21
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0082
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 1
/*000000000038*/ s_lshr_b32      s1, s1, 4
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshl_b32      s3, s8, 1
/*000000000044*/ s_lshl_b32      s5, s9, 4
/*000000000048*/ s_lshl_b32      s7, s10, 1
/*00000000004c*/ s_add_u32       s3, s3, s4
/*000000000050*/ v_add_u32       v7, vcc, s3, v0
/*000000000054*/ v_cvt_f32_u32   v3, s0
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[8:9], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s4
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s0
/*0000000000ac*/ v_sub_u32       v5, vcc, s4, v4
/*0000000000b0*/ v_cmp_ge_u32    s[8:9], s4, v4
/*0000000000b8*/ v_cmp_ge_u32    s[10:11], v5, s0
/*0000000000c0*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ v_mov_b32       v8, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v6, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v5
/*000000000100*/ v_cvt_f32_u32   v0, s1
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*00000000011c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v5, v3, s[8:9]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[8:9]
/*000000000148*/ v_mul_hi_u32    v0, v0, s14
/*000000000150*/ v_mul_lo_u32    v3, v0, s1
/*000000000158*/ v_sub_u32       v4, vcc, s14, v3
/*00000000015c*/ v_cmp_ge_u32    s[8:9], s14, v3
/*000000000164*/ v_cmp_ge_u32    s[10:11], v4, s1
/*00000000016c*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000180*/ s_cmp_lg_i32    s1, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s5, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s2
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, s6
/*000000000200*/ v_mul_lo_u32    v1, v0, s2
/*000000000208*/ v_sub_u32       v3, vcc, s6, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], s6, v1
/*000000000214*/ v_cmp_ge_u32    s[4:5], v3, s2
/*00000000021c*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s2, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s7, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_local_id_get_num_groups
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 3
/*000000000038*/ s_lshr_b32      s1, s1, 2
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshl_b32      s3, s8, 3
/*000000000044*/ s_lshl_b32      s5, s9, 2
/*000000000048*/ s_lshl_b32      s7, s10, 1
/*00000000004c*/ s_add_u32       s3, s3, s4
/*000000000050*/ v_add_u32       v5, vcc, s3, v0
/*000000000054*/ v_cvt_f32_u32   v3, s0
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v6, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s0, v6, 0
/*000000000070*/ v_sub_u32       v7, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[8:9], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v7, v3, s[8:9]
/*000000000084*/ v_mul_hi_u32    v3, v3, v6
/*00000000008c*/ v_sub_u32       v4, vcc, v6, v3
/*000000000090*/ v_add_u32       v3, vcc, v6, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*00000000009c*/ v_mul_hi_u32    v3, v3, v0
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s0
/*0000000000ac*/ v_sub_u32       v6, vcc, v0, v4
/*0000000000b0*/ v_cmp_ge_u32    s[8:9], v0, v4
/*0000000000b8*/ v_cmp_ge_u32    s[10:11], v6, s0
/*0000000000c0*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000c4*/ v_addc_u32      v0, vcc, v3, 0, s[10:11]
/*0000000000cc*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v0, -1, v0, vcc
/*0000000000e0*/ v_mov_b32       v6, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v5, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v0
/*000000000100*/ v_cvt_f32_u32   v0, s1
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*00000000011c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[8:9]
/*000000000148*/ v_mul_hi_u32    v0, v0, v1
/*000000000150*/ v_mul_lo_u32    v3, v0, s1
/*000000000158*/ v_sub_u32       v4, vcc, v1, v3
/*00000000015c*/ v_cmp_ge_u32    s[8:9], v1, v3
/*000000000164*/ v_cmp_ge_u32    s[10:11], v4, s1
/*00000000016c*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000180*/ s_cmp_lg_i32    s1, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s5, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s2
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, v2
/*000000000200*/ v_mul_lo_u32    v1, v0, s2
/*000000000208*/ v_sub_u32       v3, vcc, v2, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], v2, v1
/*000000000214*/ v_cmp_ge_u32    s[4:5], v3, s2
/*00000000021c*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s2, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s7, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_group_id_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 1
/*000000000038*/ s_lshr_b32      s1, s1, 4
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshl_b32      s3, s8, 1
/*000000000044*/ s_lshl_b32      s5, s9, 4
/*000000000048*/ s_lshl_b32      s7, s10, 1
/*00000000004c*/ s_add_u32       s3, s3, s4
/*000000000050*/ v_add_u32       v7, vcc, s3, v0
/*000000000054*/ v_cvt_f32_u32   v3, s0
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s8
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s0
/*0000000000ac*/ v_sub_u32       v5, vcc, s8, v4
/*0000000000b0*/ v_cmp_ge_u32    s[16:17], s8, v4
/*0000000000b8*/ v_cmp_ge_u32    s[18:19], v5, s0
/*0000000000c0*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000d4*/ s_cmp_lg_i32    s0, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ v_mov_b32       v8, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v6, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v5
/*000000000100*/ v_cvt_f32_u32   v0, s1
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s1, v0, 0
/*00000000011c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*000000000148*/ v_mul_hi_u32    v0, v0, s9
/*000000000150*/ v_mul_lo_u32    v3, v0, s1
/*000000000158*/ v_sub_u32       v4, vcc, s9, v3
/*00000000015c*/ v_cmp_ge_u32    s[8:9], s9, v3
/*000000000164*/ v_cmp_ge_u32    s[16:17], v4, s1
/*00000000016c*/ s_and_b64       s[16:17], s[8:9], s[16:17]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000180*/ s_cmp_lg_i32    s1, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s5, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s2
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, s10
/*000000000200*/ v_mul_lo_u32    v1, v0, s2
/*000000000208*/ v_sub_u32       v3, vcc, s10, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], s10, v1
/*000000000214*/ v_cmp_ge_u32    s[4:5], v3, s2
/*00000000021c*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s2, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s7, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_local_size_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 32
        .vgprsnum 14
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0103
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshr_b32      s0, s0, 1
/*000000000018*/ s_lshr_b32      s1, s1, 1
/*00000000001c*/ v_cvt_f32_u32   v3, s0
/*000000000020*/ s_lshr_b32      s2, s2, 2
/*000000000024*/ v_rcp_f32       v3, v3
/*000000000028*/ v_cvt_f32_u32   v4, s1
/*00000000002c*/ v_rcp_f32       v4, v4
/*000000000030*/ v_cvt_f32_u32   v5, s2
/*000000000034*/ v_rcp_f32       v5, v5
/*000000000038*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000040*/ v_cvt_u32_f32   v3, v3
/*000000000044*/ v_mul_f32       v4, 0x4f800000 /* 4.2949673e+9f */, v4
/*00000000004c*/ v_mad_u64_u32   v[6:7], vcc, s0, v3, 0
/*000000000054*/ v_cvt_u32_f32   v4, v4
/*000000000058*/ v_mul_f32       v5, 0x4f800000 /* 4.2949673e+9f */, v5
/*000000000060*/ v_mad_u64_u32   v[8:9], vcc, s1, v4, 0
/*000000000068*/ v_cvt_u32_f32   v5, v5
/*00000000006c*/ v_mad_u64_u32   v[10:11], vcc, s2, v5, 0
/*000000000074*/ v_sub_u32       v12, vcc, 0, v6
/*000000000078*/ v_cmp_lg_i32    s[4:5], 0, v7
/*000000000080*/ v_cndmask_b32   v6, v12, v6, s[4:5]
/*000000000088*/ v_sub_u32       v7, vcc, 0, v8
/*00000000008c*/ v_cmp_lg_i32    s[12:13], 0, v9
/*000000000094*/ v_mul_hi_u32    v6, v6, v3
/*00000000009c*/ v_cndmask_b32   v7, v7, v8, s[12:13]
/*0000000000a4*/ v_sub_u32       v8, vcc, 0, v10
/*0000000000a8*/ v_cmp_lg_i32    s[14:15], 0, v11
/*0000000000b0*/ v_mul_hi_u32    v7, v7, v4
/*0000000000b8*/ v_cndmask_b32   v8, v8, v10, s[14:15]
/*0000000000c0*/ v_mul_hi_u32    v8, v8, v5
/*0000000000c8*/ v_sub_u32       v9, vcc, v3, v6
/*0000000000cc*/ v_add_u32       v3, vcc, v3, v6
/*0000000000d0*/ v_cndmask_b32   v3, v3, v9, s[4:5]
/*0000000000d8*/ v_sub_u32       v6, vcc, v4, v7
/*0000000000dc*/ v_add_u32       v4, vcc, v4, v7
/*0000000000e0*/ v_readfirstlane_b32 s3, v3
/*0000000000e4*/ v_cndmask_b32   v3, v4, v6, s[12:13]
/*0000000000ec*/ v_sub_u32       v4, vcc, v5, v8
/*0000000000f0*/ v_add_u32       v5, vcc, v5, v8
/*0000000000f4*/ v_readfirstlane_b32 s4, v3
/*0000000000f8*/ v_cndmask_b32   v3, v5, v4, s[14:15]
/*000000000100*/ v_readfirstlane_b32 s5, v3
/*000000000104*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*00000000010c*/ s_lshr_b32      s3, s3, 31
/*000000000110*/ s_load_dwordx2  s[16:17], s[6:7], 0x10
/*000000000118*/ s_mul_i32       s11, s3, s0
/*00000000011c*/ s_lshr_b32      s4, s4, 31
/*000000000120*/ s_waitcnt       lgkmcnt(0)
/*000000000124*/ s_sub_u32       s13, 2, s11
/*000000000128*/ s_mul_i32       s15, s4, s1
/*00000000012c*/ s_lshr_b32      s5, s5, 30
/*000000000130*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000138*/ s_lshl_b32      s8, s8, 1
/*00000000013c*/ s_cmp_le_u32    s11, 2
/*000000000140*/ s_cselect_b64   s[18:19], exec, 0
/*000000000144*/ s_cmp_ge_u32    s13, s0
/*000000000148*/ s_cselect_b64   s[20:21], exec, 0
/*00000000014c*/ s_sub_u32       s11, 2, s15
/*000000000150*/ s_mul_i32       s13, s5, s2
/*000000000154*/ s_lshl_b32      s9, s9, 1
/*000000000158*/ s_add_u32       s8, s8, s12
/*00000000015c*/ s_cmp_le_u32    s15, 2
/*000000000160*/ s_cselect_b64   s[22:23], exec, 0
/*000000000164*/ s_cmp_ge_u32    s11, s1
/*000000000168*/ s_cselect_b64   s[24:25], exec, 0
/*00000000016c*/ s_sub_u32       s11, 4, s13
/*000000000170*/ s_lshl_b32      s10, s10, 2
/*000000000174*/ v_add_u32       v5, vcc, s8, v0
/*000000000178*/ s_add_u32       s8, s9, s14
/*00000000017c*/ s_and_b64       s[14:15], s[18:19], s[20:21]
/*000000000180*/ v_mov_b32       v3, s3
/*000000000184*/ s_cmp_le_u32    s13, 4
/*000000000188*/ s_cselect_b64   s[12:13], exec, 0
/*00000000018c*/ s_cmp_ge_u32    s11, s2
/*000000000190*/ s_cselect_b64   s[20:21], exec, 0
/*000000000194*/ v_add_u32       v8, vcc, s8, v1
/*000000000198*/ v_addc_u32      v3, vcc, v3, 0, s[14:15]
/*0000000001a0*/ s_cmp_lg_i32    s0, 0
/*0000000001a4*/ s_cselect_b64   s[8:9], exec, 0
/*0000000001a8*/ s_and_b64       s[14:15], s[22:23], s[24:25]
/*0000000001ac*/ v_mov_b32       v4, s4
/*0000000001b0*/ s_add_u32       s0, s10, s16
/*0000000001b4*/ v_mov_b32       v6, 0
/*0000000001b8*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*0000000001c0*/ v_addc_u32      v0, vcc, v3, -1, s[18:19]
/*0000000001c8*/ v_addc_u32      v3, vcc, v4, 0, s[14:15]
/*0000000001d0*/ s_cmp_lg_i32    s1, 0
/*0000000001d4*/ s_cselect_b64   s[10:11], exec, 0
/*0000000001d8*/ v_add_u32       v10, vcc, s0, v2
/*0000000001dc*/ s_and_b64       s[0:1], s[12:13], s[20:21]
/*0000000001e0*/ v_mov_b32       v4, s5
/*0000000001e4*/ s_waitcnt       lgkmcnt(0)
/*0000000001e8*/ v_add_u32       v5, vcc, s6, v5
/*0000000001ec*/ v_mov_b32       v7, s7
/*0000000001f0*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*0000000001f4*/ v_cndmask_b32   v0, -1, v0, s[8:9]
/*0000000001fc*/ v_mov_b32       v9, 0
/*000000000200*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000208*/ v_addc_u32      v1, vcc, v3, -1, s[22:23]
/*000000000210*/ v_addc_u32      v3, vcc, v4, 0, s[0:1]
/*000000000218*/ s_cmp_lg_i32    s2, 0
/*00000000021c*/ s_cselect_b64   s[0:1], exec, 0
/*000000000220*/ v_add_u32       v12, vcc, s6, v8
/*000000000224*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000228*/ v_cndmask_b32   v1, -1, v1, s[10:11]
/*000000000230*/ v_mov_b32       v11, 0
/*000000000234*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*00000000023c*/ v_addc_u32      v2, vcc, v3, -1, s[12:13]
/*000000000244*/ v_add_u32       v3, vcc, s6, v9
/*000000000248*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*00000000024c*/ v_cndmask_b32   v2, -1, v2, s[0:1]
/*000000000254*/ flat_store_dword v[5:6], v0
/*00000000025c*/ flat_store_dword v[12:13], v1
/*000000000264*/ flat_store_dword v[3:4], v2
/*00000000026c*/ s_endpgm
.kernel div_get_global_id_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 12
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0082
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 1
/*000000000038*/ s_lshr_b32      s1, s1, 1
/*00000000003c*/ s_lshr_b32      s2, s2, 2
/*000000000040*/ s_lshl_b32      s3, s8, 1
/*000000000044*/ v_add_u32       v8, vcc, s3, v0
/*000000000048*/ s_lshl_b32      s3, s9, 1
/*00000000004c*/ s_lshl_b32      s5, s10, 2
/*000000000050*/ v_mov_b32       v9, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[8:9]
/*00000000005c*/ v_add_u32       v10, vcc, s12, v3
/*000000000060*/ v_mov_b32       v6, s13
/*000000000064*/ v_addc_u32      v11, vcc, v6, v4, vcc
/*000000000068*/ v_add_u32       v0, vcc, s4, v8
/*00000000006c*/ v_cvt_f32_u32   v3, s0
/*000000000070*/ v_rcp_f32       v3, v3
/*000000000074*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000007c*/ v_cvt_u32_f32   v8, v3
/*000000000080*/ v_mad_u64_u32   v[3:4], vcc, s0, v8, 0
/*000000000088*/ v_sub_u32       v9, vcc, 0, v3
/*00000000008c*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000094*/ v_cndmask_b32   v3, v9, v3, s[8:9]
/*00000000009c*/ v_mul_hi_u32    v3, v3, v8
/*0000000000a4*/ v_sub_u32       v4, vcc, v8, v3
/*0000000000a8*/ v_add_u32       v3, vcc, v8, v3
/*0000000000ac*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*0000000000b4*/ v_mul_hi_u32    v3, v3, v0
/*0000000000bc*/ v_mul_lo_u32    v4, v3, s0
/*0000000000c4*/ v_sub_u32       v8, vcc, v0, v4
/*0000000000c8*/ v_cmp_ge_u32    s[8:9], v0, v4
/*0000000000d0*/ v_cmp_ge_u32    s[10:11], v8, s0
/*0000000000d8*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000dc*/ v_addc_u32      v0, vcc, v3, 0, s[10:11]
/*0000000000e4*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*0000000000ec*/ s_cmp_lg_i32    s0, 0
/*0000000000f0*/ s_cselect_b64   vcc, exec, 0
/*0000000000f4*/ v_cndmask_b32   v0, -1, v0, vcc
/*0000000000f8*/ flat_store_dword v[10:11], v0
/*000000000100*/ s_add_u32       s0, s3, s14
/*000000000104*/ v_add_u32       v7, vcc, s0, v1
/*000000000108*/ v_cvt_f32_u32   v0, s1
/*00000000010c*/ v_rcp_f32       v0, v0
/*000000000110*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000118*/ v_cvt_u32_f32   v4, v0
/*00000000011c*/ v_mad_u64_u32   v[0:1], vcc, s1, v4, 0
/*000000000124*/ v_sub_u32       v5, vcc, 0, v0
/*000000000128*/ v_cmp_lg_i32    s[8:9], 0, v1
/*000000000130*/ v_cndmask_b32   v0, v5, v0, s[8:9]
/*000000000138*/ v_mul_hi_u32    v0, v0, v4
/*000000000140*/ v_sub_u32       v1, vcc, v4, v0
/*000000000144*/ v_add_u32       v0, vcc, v4, v0
/*000000000148*/ v_cndmask_b32   v0, v0, v1, s[8:9]
/*000000000150*/ v_mul_hi_u32    v0, v0, v7
/*000000000158*/ v_mul_lo_u32    v1, v0, s1
/*000000000160*/ v_sub_u32       v4, vcc, v7, v1
/*000000000164*/ v_cmp_ge_u32    s[8:9], v7, v1
/*00000000016c*/ v_cmp_ge_u32    s[10:11], v4, s1
/*000000000174*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000178*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000180*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000188*/ s_cmp_lg_i32    s1, 0
/*00000000018c*/ s_cselect_b64   vcc, exec, 0
/*000000000190*/ v_cndmask_b32   v4, -1, v0, vcc
/*000000000194*/ v_mov_b32       v8, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v4
/*0000000001b0*/ s_add_u32       s0, s5, s6
/*0000000001b4*/ v_add_u32       v7, vcc, s0, v2
/*0000000001b8*/ v_cvt_f32_u32   v0, s2
/*0000000001bc*/ v_rcp_f32       v0, v0
/*0000000001c0*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c8*/ v_cvt_u32_f32   v3, v0
/*0000000001cc*/ v_mad_u64_u32   v[0:1], vcc, s2, v3, 0
/*0000000001d4*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d8*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001e0*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e8*/ v_mul_hi_u32    v0, v0, v3
/*0000000001f0*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001f4*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f8*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*000000000200*/ v_mul_hi_u32    v0, v0, v7
/*000000000208*/ v_mul_lo_u32    v1, v0, s2
/*000000000210*/ v_sub_u32       v3, vcc, v7, v1
/*000000000214*/ v_cmp_ge_u32    s[0:1], v7, v1
/*00000000021c*/ v_cmp_ge_u32    s[4:5], v3, s2
/*000000000224*/ s_and_b64       s[4:5], s[0:1], s[4:5]
/*000000000228*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000230*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000238*/ s_cmp_lg_i32    s2, 0
/*00000000023c*/ s_cselect_b64   vcc, exec, 0
/*000000000240*/ v_cndmask_b32   v3, -1, v0, vcc
/*000000000244*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000024c*/ v_add_u32       v0, vcc, s12, v0
/*000000000250*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000254*/ flat_store_dword v[0:1], v3
/*00000000025c*/ s_endpgm
.kernel div_get_global_size_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 25
        .vgprsnum 9
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c2
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s3, s0, 4
/*000000000038*/ s_lshr_b32      s5, s1, 1
/*00000000003c*/ s_lshr_b32      s7, s2, 1
/*000000000040*/ s_lshl_b32      s8, s8, 4
/*000000000044*/ s_lshl_b32      s9, s9, 1
/*000000000048*/ s_lshl_b32      s10, s10, 1
/*00000000004c*/ s_add_u32       s4, s8, s4
/*000000000050*/ v_add_u32       v7, vcc, s4, v0
/*000000000054*/ v_cvt_f32_u32   v3, s3
/*000000000058*/ v_rcp_f32       v3, v3
/*00000000005c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000064*/ v_cvt_u32_f32   v5, v3
/*000000000068*/ v_mad_u64_u32   v[3:4], vcc, s3, v5, 0
/*000000000070*/ v_sub_u32       v6, vcc, 0, v3
/*000000000074*/ v_cmp_lg_i32    s[16:17], 0, v4
/*00000000007c*/ v_cndmask_b32   v3, v6, v3, s[16:17]
/*000000000084*/ v_mul_hi_u32    v3, v3, v5
/*00000000008c*/ v_sub_u32       v4, vcc, v5, v3
/*000000000090*/ v_add_u32       v3, vcc, v5, v3
/*000000000094*/ v_cndmask_b32   v3, v3, v4, s[16:17]
/*00000000009c*/ v_mul_hi_u32    v3, v3, s0
/*0000000000a4*/ v_mul_lo_u32    v4, v3, s3
/*0000000000ac*/ v_sub_u32       v5, vcc, s0, v4
/*0000000000b0*/ v_cmp_ge_u32    s[16:17], s0, v4
/*0000000000b8*/ v_cmp_ge_u32    s[18:19], v5, s3
/*0000000000c0*/ s_and_b64       s[18:19], s[16:17], s[18:19]
/*0000000000c4*/ v_addc_u32      v3, vcc, v3, 0, s[18:19]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, -1, s[16:17]
/*0000000000d4*/ s_cmp_lg_i32    s3, 0
/*0000000000d8*/ s_cselect_b64   vcc, exec, 0
/*0000000000dc*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e0*/ v_mov_b32       v8, 0
/*0000000000e4*/ v_lshlrev_b64   v[3:4], 2, v[7:8]
/*0000000000ec*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f0*/ v_mov_b32       v6, s13
/*0000000000f4*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000f8*/ flat_store_dword v[3:4], v5
/*000000000100*/ v_cvt_f32_u32   v0, s5
/*000000000104*/ v_rcp_f32       v0, v0
/*000000000108*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000110*/ v_cvt_u32_f32   v0, v0
/*000000000114*/ v_mad_u64_u32   v[3:4], vcc, s5, v0, 0
/*00000000011c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000120*/ v_cmp_lg_i32    s[16:17], 0, v4
/*000000000128*/ v_cndmask_b32   v3, v5, v3, s[16:17]
/*000000000130*/ v_mul_hi_u32    v3, v3, v0
/*000000000138*/ v_sub_u32       v4, vcc, v0, v3
/*00000000013c*/ v_add_u32       v0, vcc, v0, v3
/*000000000140*/ v_cndmask_b32   v0, v0, v4, s[16:17]
/*000000000148*/ v_mul_hi_u32    v0, v0, s1
/*000000000150*/ v_mul_lo_u32    v3, v0, s5
/*000000000158*/ v_sub_u32       v4, vcc, s1, v3
/*00000000015c*/ v_cmp_ge_u32    s[0:1], s1, v3
/*000000000164*/ v_cmp_ge_u32    s[16:17], v4, s5
/*00000000016c*/ s_and_b64       s[16:17], s[0:1], s[16:17]
/*000000000170*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000178*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000180*/ s_cmp_lg_i32    s5, 0
/*000000000184*/ s_cselect_b64   vcc, exec, 0
/*000000000188*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000018c*/ s_add_u32       s0, s9, s14
/*000000000190*/ v_add_u32       v0, vcc, s0, v1
/*000000000194*/ v_mov_b32       v1, 0
/*000000000198*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001a8*/ flat_store_dword v[0:1], v3
/*0000000001b0*/ v_cvt_f32_u32   v0, s7
/*0000000001b4*/ v_rcp_f32       v0, v0
/*0000000001b8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001c0*/ v_cvt_u32_f32   v3, v0
/*0000000001c4*/ v_mad_u64_u32   v[0:1], vcc, s7, v3, 0
/*0000000001cc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001d0*/ v_cmp_lg_i32    s[0:1], 0, v1
/*0000000001d8*/ v_cndmask_b32   v0, v4, v0, s[0:1]
/*0000000001e0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001e8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001ec*/ v_add_u32       v0, vcc, v3, v0
/*0000000001f0*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*0000000001f8*/ v_mul_hi_u32    v0, v0, s2
/*000000000200*/ v_mul_lo_u32    v1, v0, s7
/*000000000208*/ v_sub_u32       v3, vcc, s2, v1
/*00000000020c*/ v_cmp_ge_u32    s[0:1], s2, v1
/*000000000214*/ v_cmp_ge_u32    s[2:3], v3, s7
/*00000000021c*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*000000000220*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*000000000228*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*000000000230*/ s_cmp_lg_i32    s7, 0
/*000000000234*/ s_cselect_b64   vcc, exec, 0
/*000000000238*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000023c*/ s_add_u32       s0, s10, s6
/*000000000240*/ v_add_u32       v0, vcc, s0, v2
/*000000000244*/ v_mov_b32       v1, 0
/*000000000248*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000250*/ v_add_u32       v0, vcc, s12, v0
/*000000000254*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000258*/ flat_store_dword v[0:1], v3
/*000000000260*/ s_endpgm
.kernel div_get_num_groups_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_get_work_dim_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000044*/ s_lshr_b32      s2, s2, 1
/*000000000048*/ s_lshr_b32      s3, s3, 1
/*00000000004c*/ s_lshr_b32      s1, s1, 2
/*000000000050*/ s_lshl_b32      s5, s8, 1
/*000000000054*/ s_lshl_b32      s7, s9, 1
/*000000000058*/ s_lshl_b32      s8, s10, 2
/*00000000005c*/ v_cvt_f32_u32   v3, s2
/*000000000060*/ v_rcp_f32       v3, v3
/*000000000064*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000006c*/ v_cvt_u32_f32   v5, v3
/*000000000070*/ v_mad_u64_u32   v[3:4], vcc, s2, v5, 0
/*000000000078*/ v_sub_u32       v6, vcc, 0, v3
/*00000000007c*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000084*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*00000000008c*/ v_mul_hi_u32    v3, v3, v5
/*000000000094*/ v_sub_u32       v4, vcc, v5, v3
/*000000000098*/ v_add_u32       v3, vcc, v5, v3
/*00000000009c*/ v_cndmask_b32   v3, v3, v4, s[10:11]
/*0000000000a4*/ v_mul_hi_u32    v3, v3, s0
/*0000000000ac*/ v_mul_lo_u32    v4, v3, s2
/*0000000000b4*/ v_sub_u32       v5, vcc, s0, v4
/*0000000000b8*/ v_cmp_ge_u32    s[10:11], s0, v4
/*0000000000c0*/ v_cmp_ge_u32    s[16:17], v5, s2
/*0000000000c8*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000d4*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000dc*/ s_cmp_lg_i32    s2, 0
/*0000000000e0*/ s_cselect_b64   vcc, exec, 0
/*0000000000e4*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000e8*/ s_add_u32       s2, s5, s4
/*0000000000ec*/ v_add_u32       v3, vcc, s2, v0
/*0000000000f0*/ v_mov_b32       v4, 0
/*0000000000f4*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000fc*/ v_add_u32       v3, vcc, s12, v3
/*000000000100*/ v_mov_b32       v6, s13
/*000000000104*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000108*/ flat_store_dword v[3:4], v5
/*000000000110*/ v_cvt_f32_u32   v0, s3
/*000000000114*/ v_rcp_f32       v0, v0
/*000000000118*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*000000000120*/ v_cvt_u32_f32   v0, v0
/*000000000124*/ v_mad_u64_u32   v[3:4], vcc, s3, v0, 0
/*00000000012c*/ v_sub_u32       v5, vcc, 0, v3
/*000000000130*/ v_cmp_lg_i32    s[4:5], 0, v4
/*000000000138*/ v_cndmask_b32   v3, v5, v3, s[4:5]
/*000000000140*/ v_mul_hi_u32    v3, v3, v0
/*000000000148*/ v_sub_u32       v4, vcc, v0, v3
/*00000000014c*/ v_add_u32       v0, vcc, v0, v3
/*000000000150*/ v_cndmask_b32   v0, v0, v4, s[4:5]
/*000000000158*/ v_mul_hi_u32    v0, v0, s0
/*000000000160*/ v_mul_lo_u32    v3, v0, s3
/*000000000168*/ v_sub_u32       v4, vcc, s0, v3
/*00000000016c*/ v_cmp_ge_u32    s[4:5], s0, v3
/*000000000174*/ v_cmp_ge_u32    s[10:11], v4, s3
/*00000000017c*/ s_and_b64       s[10:11], s[4:5], s[10:11]
/*000000000180*/ v_addc_u32      v0, vcc, v0, 0, s[10:11]
/*000000000188*/ v_addc_u32      v0, vcc, v0, -1, s[4:5]
/*000000000190*/ s_cmp_lg_i32    s3, 0
/*000000000194*/ s_cselect_b64   vcc, exec, 0
/*000000000198*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000019c*/ s_add_u32       s2, s7, s14
/*0000000001a0*/ v_add_u32       v0, vcc, s2, v1
/*0000000001a4*/ v_mov_b32       v1, 0
/*0000000001a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001b0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000001b8*/ flat_store_dword v[0:1], v3
/*0000000001c0*/ v_cvt_f32_u32   v0, s1
/*0000000001c4*/ v_rcp_f32       v0, v0
/*0000000001c8*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*0000000001d0*/ v_cvt_u32_f32   v3, v0
/*0000000001d4*/ v_mad_u64_u32   v[0:1], vcc, s1, v3, 0
/*0000000001dc*/ v_sub_u32       v4, vcc, 0, v0
/*0000000001e0*/ v_cmp_lg_i32    s[2:3], 0, v1
/*0000000001e8*/ v_cndmask_b32   v0, v4, v0, s[2:3]
/*0000000001f0*/ v_mul_hi_u32    v0, v0, v3
/*0000000001f8*/ v_sub_u32       v1, vcc, v3, v0
/*0000000001fc*/ v_add_u32       v0, vcc, v3, v0
/*000000000200*/ v_cndmask_b32   v0, v0, v1, s[2:3]
/*000000000208*/ v_mul_hi_u32    v0, v0, s0
/*000000000210*/ v_mul_lo_u32    v1, v0, s1
/*000000000218*/ v_sub_u32       v3, vcc, s0, v1
/*00000000021c*/ v_cmp_ge_u32    s[2:3], s0, v1
/*000000000224*/ v_cmp_ge_u32    s[4:5], v3, s1
/*00000000022c*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*000000000230*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000238*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*000000000240*/ s_cmp_lg_i32    s1, 0
/*000000000244*/ s_cselect_b64   vcc, exec, 0
/*000000000248*/ v_cndmask_b32   v3, -1, v0, vcc
/*00000000024c*/ s_add_u32       s0, s8, s6
/*000000000250*/ v_add_u32       v0, vcc, s0, v2
/*000000000254*/ v_mov_b32       v1, 0
/*000000000258*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000260*/ v_add_u32       v0, vcc, s12, v0
/*000000000264*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000268*/ flat_store_dword v[0:1], v3
/*000000000270*/ s_endpgm
.kernel div_x_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dword    s1, s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx4  s[12:15], s[6:7], 0x8
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000034*/ s_lshl_b32      s3, s8, 4
/*000000000038*/ s_lshl_b32      s6, s9, 1
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ v_cvt_f32_u32   v3, s0
/*000000000044*/ v_rcp_f32       v3, v3
/*000000000048*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000050*/ v_cvt_u32_f32   v5, v3
/*000000000054*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*00000000005c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000060*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000068*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000070*/ v_mul_hi_u32    v3, v3, v5
/*000000000078*/ v_sub_u32       v4, vcc, v5, v3
/*00000000007c*/ v_add_u32       v3, vcc, v5, v3
/*000000000080*/ v_cndmask_b32   v3, v3, v4, s[8:9]
/*000000000088*/ v_mul_hi_u32    v3, v3, s1
/*000000000090*/ v_mul_lo_u32    v4, v3, s0
/*000000000098*/ v_sub_u32       v5, vcc, s1, v4
/*00000000009c*/ v_cmp_ge_u32    s[8:9], s1, v4
/*0000000000a4*/ v_cmp_ge_u32    s[10:11], v5, s0
/*0000000000ac*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000c0*/ s_cmp_lg_i32    s0, 0
/*0000000000c4*/ s_cselect_b64   vcc, exec, 0
/*0000000000c8*/ v_cndmask_b32   v5, -1, v3, vcc
/*0000000000cc*/ s_add_u32       s0, s3, s2
/*0000000000d0*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d4*/ v_mov_b32       v4, 0
/*0000000000d8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e0*/ v_add_u32       v3, vcc, s4, v3
/*0000000000e4*/ v_mov_b32       v6, s5
/*0000000000e8*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*0000000000ec*/ flat_store_dword v[3:4], v5
/*0000000000f4*/ s_add_u32       s0, s6, s12
/*0000000000f8*/ v_add_u32       v0, vcc, s0, v1
/*0000000000fc*/ v_mov_b32       v1, 0
/*000000000100*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000108*/ v_add_u32       v0, vcc, s4, v0
/*00000000010c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000110*/ flat_store_dword v[0:1], v5
/*000000000118*/ s_add_u32       s0, s7, s14
/*00000000011c*/ v_add_u32       v0, vcc, s0, v2
/*000000000120*/ v_mov_b32       v1, 0
/*000000000124*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000012c*/ v_add_u32       v0, vcc, s4, v0
/*000000000130*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000134*/ flat_store_dword v[0:1], v5
/*00000000013c*/ s_endpgm
.kernel div_get_global_offset_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x8
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s3, s9, 4
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ v_cvt_f32_u32   v3, s0
/*00000000003c*/ v_rcp_f32       v3, v3
/*000000000040*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000048*/ v_cvt_u32_f32   v5, v3
/*00000000004c*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000054*/ v_sub_u32       v6, vcc, 0, v3
/*000000000058*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000060*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000068*/ v_mul_hi_u32    v3, v3, v5
/*000000000070*/ v_sub_u32       v4, vcc, v5, v3
/*000000000074*/ v_add_u32       v3, vcc, v5, v3
/*000000000078*/ v_cndmask_b32   v5, v3, v4, s[8:9]
/*000000000080*/ v_mul_hi_u32    v3, v5, s2
/*000000000088*/ v_mul_lo_u32    v4, v3, s0
/*000000000090*/ v_sub_u32       v6, vcc, s2, v4
/*000000000094*/ v_cmp_ge_u32    s[8:9], s2, v4
/*00000000009c*/ v_cmp_ge_u32    s[10:11], v6, s0
/*0000000000a4*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000a8*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000b8*/ s_cmp_lg_i32    s0, 0
/*0000000000bc*/ s_cselect_b64   s[8:9], exec, 0
/*0000000000c0*/ v_cndmask_b32   v6, -1, v3, s[8:9]
/*0000000000c8*/ s_add_u32       s1, s1, s2
/*0000000000cc*/ v_add_u32       v3, vcc, s1, v0
/*0000000000d0*/ v_mov_b32       v4, 0
/*0000000000d4*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000dc*/ v_add_u32       v3, vcc, s4, v3
/*0000000000e0*/ v_mov_b32       v7, s5
/*0000000000e4*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000e8*/ flat_store_dword v[3:4], v6
/*0000000000f0*/ v_mul_hi_u32    v0, v5, s12
/*0000000000f8*/ v_mul_lo_u32    v3, v0, s0
/*000000000100*/ v_sub_u32       v4, vcc, s12, v3
/*000000000104*/ v_cmp_ge_u32    s[10:11], s12, v3
/*00000000010c*/ v_cmp_ge_u32    s[16:17], v4, s0
/*000000000114*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*000000000118*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000120*/ v_addc_u32      v0, vcc, v0, -1, s[10:11]
/*000000000128*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000130*/ s_add_u32       s1, s3, s12
/*000000000134*/ v_add_u32       v0, vcc, s1, v1
/*000000000138*/ v_mov_b32       v1, 0
/*00000000013c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000144*/ v_add_u32       v0, vcc, s4, v0
/*000000000148*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000014c*/ flat_store_dword v[0:1], v3
/*000000000154*/ v_mul_hi_u32    v0, v5, s14
/*00000000015c*/ v_mul_lo_u32    v1, v0, s0
/*000000000164*/ v_sub_u32       v3, vcc, s14, v1
/*000000000168*/ v_cmp_ge_u32    s[2:3], s14, v1
/*000000000170*/ v_cmp_ge_u32    s[0:1], v3, s0
/*000000000178*/ s_and_b64       s[0:1], s[2:3], s[0:1]
/*00000000017c*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*000000000184*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*00000000018c*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000194*/ s_add_u32       s0, s6, s14
/*000000000198*/ v_add_u32       v0, vcc, s0, v2
/*00000000019c*/ v_mov_b32       v1, 0
/*0000000001a0*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001a8*/ v_add_u32       v0, vcc, s4, v0
/*0000000001ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001b0*/ flat_store_dword v[0:1], v3
/*0000000001b8*/ s_endpgm
.kernel div_get_local_id_get_work_dim
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x8
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000034*/ s_lshl_b32      s1, s8, 3
/*000000000038*/ s_lshl_b32      s3, s9, 2
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ v_cvt_f32_u32   v3, s0
/*000000000044*/ v_rcp_f32       v3, v3
/*000000000048*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000050*/ v_cvt_u32_f32   v5, v3
/*000000000054*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*00000000005c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000060*/ v_cmp_lg_i32    s[8:9], 0, v4
/*000000000068*/ v_cndmask_b32   v3, v6, v3, s[8:9]
/*000000000070*/ v_mul_hi_u32    v3, v3, v5
/*000000000078*/ v_sub_u32       v4, vcc, v5, v3
/*00000000007c*/ v_add_u32       v3, vcc, v5, v3
/*000000000080*/ v_cndmask_b32   v5, v3, v4, s[8:9]
/*000000000088*/ v_mul_hi_u32    v3, v5, v0
/*000000000090*/ v_mul_lo_u32    v4, v3, s0
/*000000000098*/ v_sub_u32       v6, vcc, v0, v4
/*00000000009c*/ v_cmp_ge_u32    s[8:9], v0, v4
/*0000000000a4*/ v_cmp_ge_u32    s[10:11], v6, s0
/*0000000000ac*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, 0, s[10:11]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, -1, s[8:9]
/*0000000000c0*/ s_cmp_lg_i32    s0, 0
/*0000000000c4*/ s_cselect_b64   s[8:9], exec, 0
/*0000000000c8*/ v_cndmask_b32   v6, -1, v3, s[8:9]
/*0000000000d0*/ s_add_u32       s1, s1, s2
/*0000000000d4*/ v_add_u32       v3, vcc, s1, v0
/*0000000000d8*/ v_mov_b32       v4, 0
/*0000000000dc*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e4*/ v_add_u32       v3, vcc, s4, v3
/*0000000000e8*/ v_mov_b32       v7, s5
/*0000000000ec*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000f0*/ flat_store_dword v[3:4], v6
/*0000000000f8*/ v_mul_hi_u32    v0, v5, v1
/*000000000100*/ v_mul_lo_u32    v3, v0, s0
/*000000000108*/ v_sub_u32       v4, vcc, v1, v3
/*00000000010c*/ v_cmp_ge_u32    s[10:11], v1, v3
/*000000000114*/ v_cmp_ge_u32    s[14:15], v4, s0
/*00000000011c*/ s_and_b64       s[14:15], s[10:11], s[14:15]
/*000000000120*/ v_addc_u32      v0, vcc, v0, 0, s[14:15]
/*000000000128*/ v_addc_u32      v0, vcc, v0, -1, s[10:11]
/*000000000130*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*000000000138*/ s_add_u32       s1, s3, s12
/*00000000013c*/ v_add_u32       v0, vcc, s1, v1
/*000000000140*/ v_mov_b32       v1, 0
/*000000000144*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000014c*/ v_add_u32       v0, vcc, s4, v0
/*000000000150*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000154*/ flat_store_dword v[0:1], v3
/*00000000015c*/ v_mul_hi_u32    v0, v5, v2
/*000000000164*/ v_mul_lo_u32    v1, v0, s0
/*00000000016c*/ v_sub_u32       v3, vcc, v2, v1
/*000000000170*/ v_cmp_ge_u32    s[2:3], v2, v1
/*000000000178*/ v_cmp_ge_u32    s[0:1], v3, s0
/*000000000180*/ s_and_b64       s[0:1], s[2:3], s[0:1]
/*000000000184*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*00000000018c*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*000000000194*/ v_cndmask_b32   v3, -1, v0, s[8:9]
/*00000000019c*/ s_add_u32       s0, s7, s6
/*0000000001a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000001a4*/ v_mov_b32       v1, 0
/*0000000001a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000001b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001b8*/ flat_store_dword v[0:1], v3
/*0000000001c0*/ s_endpgm
.kernel div_get_group_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[12:13], s[6:7], 0x8
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000034*/ s_lshl_b32      s1, s8, 1
/*000000000038*/ s_lshl_b32      s3, s9, 4
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ v_cvt_f32_u32   v3, s0
/*000000000044*/ v_rcp_f32       v3, v3
/*000000000048*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000050*/ v_cvt_u32_f32   v5, v3
/*000000000054*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*00000000005c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000060*/ v_cmp_lg_i32    s[14:15], 0, v4
/*000000000068*/ v_cndmask_b32   v3, v6, v3, s[14:15]
/*000000000070*/ v_mul_hi_u32    v3, v3, v5
/*000000000078*/ v_sub_u32       v4, vcc, v5, v3
/*00000000007c*/ v_add_u32       v3, vcc, v5, v3
/*000000000080*/ v_cndmask_b32   v5, v3, v4, s[14:15]
/*000000000088*/ v_mul_hi_u32    v3, v5, s8
/*000000000090*/ v_mul_lo_u32    v4, v3, s0
/*000000000098*/ v_sub_u32       v6, vcc, s8, v4
/*00000000009c*/ v_cmp_ge_u32    s[14:15], s8, v4
/*0000000000a4*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000000ac*/ s_and_b64       s[16:17], s[14:15], s[16:17]
/*0000000000b0*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, -1, s[14:15]
/*0000000000c0*/ s_cmp_lg_i32    s0, 0
/*0000000000c4*/ s_cselect_b64   s[14:15], exec, 0
/*0000000000c8*/ v_cndmask_b32   v6, -1, v3, s[14:15]
/*0000000000d0*/ s_add_u32       s1, s1, s2
/*0000000000d4*/ v_add_u32       v3, vcc, s1, v0
/*0000000000d8*/ v_mov_b32       v4, 0
/*0000000000dc*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000e4*/ v_add_u32       v3, vcc, s4, v3
/*0000000000e8*/ v_mov_b32       v7, s5
/*0000000000ec*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*0000000000f0*/ flat_store_dword v[3:4], v6
/*0000000000f8*/ v_mul_hi_u32    v0, v5, s9
/*000000000100*/ v_mul_lo_u32    v3, v0, s0
/*000000000108*/ v_sub_u32       v4, vcc, s9, v3
/*00000000010c*/ v_cmp_ge_u32    s[8:9], s9, v3
/*000000000114*/ v_cmp_ge_u32    s[16:17], v4, s0
/*00000000011c*/ s_and_b64       s[16:17], s[8:9], s[16:17]
/*000000000120*/ v_addc_u32      v0, vcc, v0, 0, s[16:17]
/*000000000128*/ v_addc_u32      v0, vcc, v0, -1, s[8:9]
/*000000000130*/ v_cndmask_b32   v3, -1, v0, s[14:15]
/*000000000138*/ s_add_u32       s1, s3, s12
/*00000000013c*/ v_add_u32       v0, vcc, s1, v1
/*000000000140*/ v_mov_b32       v1, 0
/*000000000144*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000014c*/ v_add_u32       v0, vcc, s4, v0
/*000000000150*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000154*/ flat_store_dword v[0:1], v3
/*00000000015c*/ v_mul_hi_u32    v0, v5, s10
/*000000000164*/ v_mul_lo_u32    v1, v0, s0
/*00000000016c*/ v_sub_u32       v3, vcc, s10, v1
/*000000000170*/ v_cmp_ge_u32    s[2:3], s10, v1
/*000000000178*/ v_cmp_ge_u32    s[0:1], v3, s0
/*000000000180*/ s_and_b64       s[0:1], s[2:3], s[0:1]
/*000000000184*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*00000000018c*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*000000000194*/ v_cndmask_b32   v3, -1, v0, s[14:15]
/*00000000019c*/ s_add_u32       s0, s7, s6
/*0000000001a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000001a4*/ v_mov_b32       v1, 0
/*0000000001a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000001b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001b8*/ flat_store_dword v[0:1], v3
/*0000000001c0*/ s_endpgm
.kernel div_get_local_size_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 13
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c3
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000014*/ v_cvt_f32_u32   v3, s0
/*000000000018*/ v_rcp_f32       v3, v3
/*00000000001c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000024*/ v_cvt_u32_f32   v3, v3
/*000000000028*/ v_mad_u64_u32   v[4:5], vcc, s0, v3, 0
/*000000000030*/ v_sub_u32       v6, vcc, 0, v4
/*000000000034*/ v_cmp_lg_i32    s[2:3], 0, v5
/*00000000003c*/ v_cndmask_b32   v4, v6, v4, s[2:3]
/*000000000044*/ v_mul_hi_u32    v4, v4, v3
/*00000000004c*/ v_sub_u32       v5, vcc, v3, v4
/*000000000050*/ v_add_u32       v3, vcc, v3, v4
/*000000000054*/ v_cndmask_b32   v3, v3, v5, s[2:3]
/*00000000005c*/ v_readfirstlane_b32 s1, v3
/*000000000060*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000068*/ s_load_dwordx4  s[12:15], s[6:7], 0x8
/*000000000070*/ s_waitcnt       lgkmcnt(0)
/*000000000074*/ s_lshr_b32      s3, s1, 31
/*000000000078*/ s_mul_i32       s4, s3, s0
/*00000000007c*/ s_sub_u32       s5, 2, s4
/*000000000080*/ s_lshr_b32      s1, s1, 30
/*000000000084*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*00000000008c*/ s_lshl_b32      s8, s8, 1
/*000000000090*/ s_cmp_le_u32    s4, 2
/*000000000094*/ s_cselect_b64   s[16:17], exec, 0
/*000000000098*/ s_cmp_ge_u32    s5, s0
/*00000000009c*/ s_cselect_b64   s[4:5], exec, 0
/*0000000000a0*/ s_mul_i32       s11, s1, s0
/*0000000000a4*/ s_lshl_b32      s9, s9, 1
/*0000000000a8*/ s_add_u32       s2, s8, s2
/*0000000000ac*/ s_sub_u32       s8, 4, s11
/*0000000000b0*/ s_lshl_b32      s10, s10, 2
/*0000000000b4*/ v_add_u32       v4, vcc, s2, v0
/*0000000000b8*/ s_and_b64       vcc, s[16:17], s[4:5]
/*0000000000bc*/ v_mov_b32       v3, s3
/*0000000000c0*/ s_add_u32       s2, s9, s12
/*0000000000c4*/ s_cmp_le_u32    s11, 4
/*0000000000c8*/ s_cselect_b64   s[4:5], exec, 0
/*0000000000cc*/ s_cmp_ge_u32    s8, s0
/*0000000000d0*/ s_cselect_b64   s[8:9], exec, 0
/*0000000000d4*/ v_addc_u32      v3, vcc, v3, 0, vcc
/*0000000000dc*/ s_cmp_lg_i32    s0, 0
/*0000000000e0*/ s_cselect_b64   s[12:13], exec, 0
/*0000000000e4*/ v_add_u32       v7, vcc, s2, v1
/*0000000000e8*/ s_add_u32       s0, s10, s14
/*0000000000ec*/ v_mov_b32       v5, 0
/*0000000000f0*/ v_lshlrev_b64   v[4:5], 2, v[4:5]
/*0000000000f8*/ v_addc_u32      v0, vcc, v3, -1, s[16:17]
/*000000000100*/ v_add_u32       v9, vcc, s0, v2
/*000000000104*/ s_and_b64       s[2:3], s[4:5], s[8:9]
/*000000000108*/ v_mov_b32       v3, s1
/*00000000010c*/ s_waitcnt       lgkmcnt(0)
/*000000000110*/ v_add_u32       v4, vcc, s6, v4
/*000000000114*/ v_mov_b32       v6, s7
/*000000000118*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*00000000011c*/ v_cndmask_b32   v0, -1, v0, s[12:13]
/*000000000124*/ v_mov_b32       v8, 0
/*000000000128*/ v_lshlrev_b64   v[7:8], 2, v[7:8]
/*000000000130*/ v_addc_u32      v1, vcc, v3, 0, s[2:3]
/*000000000138*/ v_add_u32       v11, vcc, s6, v7
/*00000000013c*/ v_addc_u32      v12, vcc, v6, v8, vcc
/*000000000140*/ v_mov_b32       v10, 0
/*000000000144*/ v_lshlrev_b64   v[8:9], 2, v[9:10]
/*00000000014c*/ v_addc_u32      v1, vcc, v1, -1, s[4:5]
/*000000000154*/ v_add_u32       v2, vcc, s6, v8
/*000000000158*/ v_addc_u32      v3, vcc, v6, v9, vcc
/*00000000015c*/ v_cndmask_b32   v1, -1, v1, s[12:13]
/*000000000164*/ flat_store_dword v[4:5], v0
/*00000000016c*/ flat_store_dword v[11:12], v0
/*000000000174*/ flat_store_dword v[2:3], v1
/*00000000017c*/ s_endpgm
.kernel div_get_global_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 17
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0084
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000014*/ v_cvt_f32_u32   v3, s0
/*000000000018*/ v_rcp_f32       v3, v3
/*00000000001c*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000024*/ v_cvt_u32_f32   v3, v3
/*000000000028*/ v_mad_u64_u32   v[4:5], vcc, s0, v3, 0
/*000000000030*/ v_sub_u32       v6, vcc, 0, v4
/*000000000034*/ v_cmp_lg_i32    s[2:3], 0, v5
/*00000000003c*/ v_cndmask_b32   v4, v6, v4, s[2:3]
/*000000000044*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*00000000004c*/ v_mul_hi_u32    v4, v4, v3
/*000000000054*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*00000000005c*/ s_lshl_b32      s1, s8, 1
/*000000000060*/ v_add_u32       v11, vcc, s1, v0
/*000000000064*/ s_lshl_b32      s1, s9, 1
/*000000000068*/ v_sub_u32       v5, vcc, v3, v4
/*00000000006c*/ v_add_u32       v3, vcc, v3, v4
/*000000000070*/ s_waitcnt       lgkmcnt(0)
/*000000000074*/ s_lshl_b32      s5, s10, 2
/*000000000078*/ v_add_u32       v4, vcc, s12, v11
/*00000000007c*/ v_cndmask_b32   v3, v3, v5, s[2:3]
/*000000000084*/ s_add_u32       s1, s1, s14
/*000000000088*/ v_mul_hi_u32    v5, v3, v4
/*000000000090*/ v_add_u32       v13, vcc, s1, v1
/*000000000094*/ s_add_u32       s1, s5, s4
/*000000000098*/ v_mul_hi_u32    v6, v3, v13
/*0000000000a0*/ v_add_u32       v15, vcc, s1, v2
/*0000000000a4*/ v_mul_hi_u32    v3, v3, v15
/*0000000000ac*/ v_mul_lo_u32    v7, v5, s0
/*0000000000b4*/ v_mul_lo_u32    v8, v6, s0
/*0000000000bc*/ v_mul_lo_u32    v9, v3, s0
/*0000000000c4*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*0000000000cc*/ v_sub_u32       v10, vcc, v4, v7
/*0000000000d0*/ v_cmp_ge_u32    s[4:5], v4, v7
/*0000000000d8*/ v_cmp_ge_u32    s[6:7], v10, s0
/*0000000000e0*/ v_sub_u32       v4, vcc, v13, v8
/*0000000000e4*/ s_and_b64       s[6:7], s[4:5], s[6:7]
/*0000000000e8*/ v_cmp_ge_u32    s[8:9], v13, v8
/*0000000000f0*/ v_cmp_ge_u32    s[10:11], v4, s0
/*0000000000f8*/ v_sub_u32       v4, vcc, v15, v9
/*0000000000fc*/ v_addc_u32      v5, vcc, v5, 0, s[6:7]
/*000000000104*/ s_cmp_lg_i32    s0, 0
/*000000000108*/ s_cselect_b64   s[6:7], exec, 0
/*00000000010c*/ s_and_b64       s[10:11], s[8:9], s[10:11]
/*000000000110*/ v_cmp_ge_u32    s[12:13], v15, v9
/*000000000118*/ v_cmp_ge_u32    s[0:1], v4, s0
/*000000000120*/ v_mov_b32       v12, 0
/*000000000124*/ v_lshlrev_b64   v[7:8], 2, v[11:12]
/*00000000012c*/ v_addc_u32      v0, vcc, v5, -1, s[4:5]
/*000000000134*/ v_addc_u32      v4, vcc, v6, 0, s[10:11]
/*00000000013c*/ s_and_b64       s[0:1], s[12:13], s[0:1]
/*000000000140*/ s_waitcnt       lgkmcnt(0)
/*000000000144*/ v_add_u32       v11, vcc, s2, v7
/*000000000148*/ v_mov_b32       v6, s3
/*00000000014c*/ v_addc_u32      v12, vcc, v6, v8, vcc
/*000000000150*/ v_cndmask_b32   v0, -1, v0, s[6:7]
/*000000000158*/ v_addc_u32      v4, vcc, v4, -1, s[8:9]
/*000000000160*/ v_mov_b32       v14, 0
/*000000000164*/ v_lshlrev_b64   v[8:9], 2, v[13:14]
/*00000000016c*/ v_addc_u32      v1, vcc, v3, 0, s[0:1]
/*000000000174*/ v_cndmask_b32   v3, -1, v4, s[6:7]
/*00000000017c*/ v_add_u32       v4, vcc, s2, v8
/*000000000180*/ v_addc_u32      v5, vcc, v6, v9, vcc
/*000000000184*/ v_addc_u32      v1, vcc, v1, -1, s[12:13]
/*00000000018c*/ v_mov_b32       v16, 0
/*000000000190*/ v_lshlrev_b64   v[9:10], 2, v[15:16]
/*000000000198*/ v_cndmask_b32   v1, -1, v1, s[6:7]
/*0000000001a0*/ v_add_u32       v7, vcc, s2, v9
/*0000000001a4*/ v_addc_u32      v8, vcc, v6, v10, vcc
/*0000000001a8*/ flat_store_dword v[11:12], v0
/*0000000001b0*/ flat_store_dword v[4:5], v3
/*0000000001b8*/ flat_store_dword v[7:8], v1
/*0000000001c0*/ s_endpgm
.kernel div_get_global_size_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global,
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000044*/ s_lshl_b32      s5, s8, 4
/*000000000048*/ s_lshl_b32      s7, s9, 1
/*00000000004c*/ s_lshl_b32      s8, s10, 1
/*000000000050*/ v_cvt_f32_u32   v3, s0
/*000000000054*/ v_rcp_f32       v3, v3
/*000000000058*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*000000000060*/ v_cvt_u32_f32   v5, v3
/*000000000064*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*00000000006c*/ v_sub_u32       v6, vcc, 0, v3
/*000000000070*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000078*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*000000000080*/ v_mul_hi_u32    v3, v3, v5
/*000000000088*/ v_sub_u32       v4, vcc, v5, v3
/*00000000008c*/ v_add_u32       v3, vcc, v5, v3
/*000000000090*/ v_cndmask_b32   v5, v3, v4, s[10:11]
/*000000000098*/ v_mul_hi_u32    v3, v5, s2
/*0000000000a0*/ v_mul_lo_u32    v4, v3, s0
/*0000000000a8*/ v_sub_u32       v6, vcc, s2, v4
/*0000000000ac*/ v_cmp_ge_u32    s[10:11], s2, v4
/*0000000000b4*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000000bc*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000c0*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000c8*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000d0*/ s_cmp_lg_i32    s0, 0
/*0000000000d4*/ s_cselect_b64   s[10:11], exec, 0
/*0000000000d8*/ v_cndmask_b32   v6, -1, v3, s[10:11]
/*0000000000e0*/ s_add_u32       s2, s5, s4
/*0000000000e4*/ v_add_u32       v3, vcc, s2, v0
/*0000000000e8*/ v_mov_b32       v4, 0
/*0000000000ec*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000000f4*/ v_add_u32       v3, vcc, s12, v3
/*0000000000f8*/ v_mov_b32       v7, s13
/*0000000000fc*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000100*/ flat_store_dword v[3:4], v6
/*000000000108*/ v_mul_hi_u32    v0, v5, s3
/*000000000110*/ v_mul_lo_u32    v3, v0, s0
/*000000000118*/ v_sub_u32       v4, vcc, s3, v3
/*00000000011c*/ v_cmp_ge_u32    s[2:3], s3, v3
/*000000000124*/ v_cmp_ge_u32    s[4:5], v4, s0
/*00000000012c*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*000000000130*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000138*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*000000000140*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*000000000148*/ s_add_u32       s2, s7, s14
/*00000000014c*/ v_add_u32       v0, vcc, s2, v1
/*000000000150*/ v_mov_b32       v1, 0
/*000000000154*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000015c*/ v_add_u32       v0, vcc, s12, v0
/*000000000160*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000164*/ flat_store_dword v[0:1], v3
/*00000000016c*/ v_mul_hi_u32    v0, v5, s1
/*000000000174*/ v_mul_lo_u32    v1, v0, s0
/*00000000017c*/ v_sub_u32       v3, vcc, s1, v1
/*000000000180*/ v_cmp_ge_u32    s[2:3], s1, v1
/*000000000188*/ v_cmp_ge_u32    s[0:1], v3, s0
/*000000000190*/ s_and_b64       s[0:1], s[2:3], s[0:1]
/*000000000194*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*00000000019c*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*0000000001a4*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*0000000001ac*/ s_add_u32       s0, s8, s6
/*0000000001b0*/ v_add_u32       v0, vcc, s0, v2
/*0000000001b4*/ v_mov_b32       v1, 0
/*0000000001b8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001c0*/ v_add_u32       v0, vcc, s12, v0
/*0000000001c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001c8*/ flat_store_dword v[0:1], v3
/*0000000001d0*/ s_endpgm
.kernel div_get_num_groups_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac00c1
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[14:15], s[6:7], 0x8
/*000000000030*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000044*/ s_lshr_b32      s2, s2, 1
/*000000000048*/ s_lshr_b32      s3, s3, 1
/*00000000004c*/ s_lshr_b32      s1, s1, 2
/*000000000050*/ s_lshl_b32      s5, s8, 1
/*000000000054*/ s_lshl_b32      s7, s9, 1
/*000000000058*/ s_lshl_b32      s8, s10, 2
/*00000000005c*/ v_cvt_f32_u32   v3, s0
/*000000000060*/ v_rcp_f32       v3, v3
/*000000000064*/ v_mul_f32       v3, 0x4f800000 /* 4.2949673e+9f */, v3
/*00000000006c*/ v_cvt_u32_f32   v5, v3
/*000000000070*/ v_mad_u64_u32   v[3:4], vcc, s0, v5, 0
/*000000000078*/ v_sub_u32       v6, vcc, 0, v3
/*00000000007c*/ v_cmp_lg_i32    s[10:11], 0, v4
/*000000000084*/ v_cndmask_b32   v3, v6, v3, s[10:11]
/*00000000008c*/ v_mul_hi_u32    v3, v3, v5
/*000000000094*/ v_sub_u32       v4, vcc, v5, v3
/*000000000098*/ v_add_u32       v3, vcc, v5, v3
/*00000000009c*/ v_cndmask_b32   v5, v3, v4, s[10:11]
/*0000000000a4*/ v_mul_hi_u32    v3, v5, s2
/*0000000000ac*/ v_mul_lo_u32    v4, v3, s0
/*0000000000b4*/ v_sub_u32       v6, vcc, s2, v4
/*0000000000b8*/ v_cmp_ge_u32    s[10:11], s2, v4
/*0000000000c0*/ v_cmp_ge_u32    s[16:17], v6, s0
/*0000000000c8*/ s_and_b64       s[16:17], s[10:11], s[16:17]
/*0000000000cc*/ v_addc_u32      v3, vcc, v3, 0, s[16:17]
/*0000000000d4*/ v_addc_u32      v3, vcc, v3, -1, s[10:11]
/*0000000000dc*/ s_cmp_lg_i32    s0, 0
/*0000000000e0*/ s_cselect_b64   s[10:11], exec, 0
/*0000000000e4*/ v_cndmask_b32   v6, -1, v3, s[10:11]
/*0000000000ec*/ s_add_u32       s2, s5, s4
/*0000000000f0*/ v_add_u32       v3, vcc, s2, v0
/*0000000000f4*/ v_mov_b32       v4, 0
/*0000000000f8*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000100*/ v_add_u32       v3, vcc, s12, v3
/*000000000104*/ v_mov_b32       v7, s13
/*000000000108*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000010c*/ flat_store_dword v[3:4], v6
/*000000000114*/ v_mul_hi_u32    v0, v5, s3
/*00000000011c*/ v_mul_lo_u32    v3, v0, s0
/*000000000124*/ v_sub_u32       v4, vcc, s3, v3
/*000000000128*/ v_cmp_ge_u32    s[2:3], s3, v3
/*000000000130*/ v_cmp_ge_u32    s[4:5], v4, s0
/*000000000138*/ s_and_b64       s[4:5], s[2:3], s[4:5]
/*00000000013c*/ v_addc_u32      v0, vcc, v0, 0, s[4:5]
/*000000000144*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*00000000014c*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*000000000154*/ s_add_u32       s2, s7, s14
/*000000000158*/ v_add_u32       v0, vcc, s2, v1
/*00000000015c*/ v_mov_b32       v1, 0
/*000000000160*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000168*/ v_add_u32       v0, vcc, s12, v0
/*00000000016c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000170*/ flat_store_dword v[0:1], v3
/*000000000178*/ v_mul_hi_u32    v0, v5, s1
/*000000000180*/ v_mul_lo_u32    v1, v0, s0
/*000000000188*/ v_sub_u32       v3, vcc, s1, v1
/*00000000018c*/ v_cmp_ge_u32    s[2:3], s1, v1
/*000000000194*/ v_cmp_ge_u32    s[0:1], v3, s0
/*00000000019c*/ s_and_b64       s[0:1], s[2:3], s[0:1]
/*0000000001a0*/ v_addc_u32      v0, vcc, v0, 0, s[0:1]
/*0000000001a8*/ v_addc_u32      v0, vcc, v0, -1, s[2:3]
/*0000000001b0*/ v_cndmask_b32   v3, -1, v0, s[10:11]
/*0000000001b8*/ s_add_u32       s0, s8, s6
/*0000000001bc*/ v_add_u32       v0, vcc, s0, v2
/*0000000001c0*/ v_mov_b32       v1, 0
/*0000000001c4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001cc*/ v_add_u32       v0, vcc, s12, v0
/*0000000001d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000001d4*/ flat_store_dword v[0:1], v3
/*0000000001dc*/ s_endpgm
.kernel div_get_work_dim_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, 1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v6, vcc, s4, v7
/*000000000080*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000084*/ flat_store_dword v[10:11], v5
/*00000000008c*/ flat_store_dword v[1:2], v5
/*000000000094*/ flat_store_dword v[6:7], v5
/*00000000009c*/ s_endpgm
.kernel div_x_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_global_offset_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_local_id_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_group_id_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_local_size_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_global_id_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_global_size_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_num_groups_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_work_dim
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_x_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 6
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x0000098c
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s3, s6, 3
/*000000000020*/ s_lshl_b32      s6, s7, 3
/*000000000024*/ s_add_u32       s2, s6, s2
/*000000000028*/ v_add_u32       v3, vcc, s2, v1
/*00000000002c*/ v_cvt_f32_u32   v1, v3
/*000000000030*/ v_rcp_f32       v1, v1
/*000000000034*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*00000000003c*/ v_cvt_u32_f32   v4, v1
/*000000000040*/ v_mad_u64_u32   v[1:2], vcc, v3, v4, 0
/*000000000048*/ v_sub_u32       v5, vcc, 0, v1
/*00000000004c*/ v_cmp_lg_i32    s[6:7], 0, v2
/*000000000054*/ v_cndmask_b32   v1, v5, v1, s[6:7]
/*00000000005c*/ v_mul_hi_u32    v1, v1, v4
/*000000000064*/ v_sub_u32       v2, vcc, v4, v1
/*000000000068*/ v_add_u32       v1, vcc, v4, v1
/*00000000006c*/ v_cndmask_b32   v1, v1, v2, s[6:7]
/*000000000074*/ s_waitcnt       lgkmcnt(0)
/*000000000078*/ v_mul_hi_u32    v1, v1, s1
/*000000000080*/ v_mul_lo_u32    v2, v1, v3
/*000000000088*/ v_sub_u32       v4, vcc, s1, v2
/*00000000008c*/ v_cmp_ge_u32    s[6:7], s1, v2
/*000000000094*/ v_cmp_ge_u32    s[8:9], v4, v3
/*00000000009c*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*0000000000a0*/ v_addc_u32      v1, vcc, v1, 0, s[8:9]
/*0000000000a8*/ v_addc_u32      v1, vcc, v1, -1, s[6:7]
/*0000000000b0*/ v_cmp_lg_i32    vcc, 0, v3
/*0000000000b4*/ v_cndmask_b32   v2, -1, v1, vcc
/*0000000000b8*/ s_add_u32       s0, s3, s0
/*0000000000bc*/ v_add_u32       v0, vcc, s0, v0
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d0*/ v_mov_b32       v3, s5
/*0000000000d4*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000d8*/ flat_store_dword v[0:1], v2
/*0000000000e0*/ s_endpgm
.kernel div_get_global_offset_8_8
    .config
        .dims x
        .cws 8, 8, 1
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 3
/*000000000010*/ v_cvt_f32_u32   v1, s2
/*000000000014*/ v_rcp_f32       v1, v1
/*000000000018*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000020*/ v_cvt_u32_f32   v3, v1
/*000000000024*/ v_mad_u64_u32   v[1:2], vcc, s2, v3, 0
/*00000000002c*/ v_sub_u32       v4, vcc, 0, v1
/*000000000030*/ v_cmp_lg_i32    s[6:7], 0, v2
/*000000000038*/ v_cndmask_b32   v1, v4, v1, s[6:7]
/*000000000040*/ v_mul_hi_u32    v1, v1, v3
/*000000000048*/ v_sub_u32       v2, vcc, v3, v1
/*00000000004c*/ v_add_u32       v1, vcc, v3, v1
/*000000000050*/ v_cndmask_b32   v1, v1, v2, s[6:7]
/*000000000058*/ v_mul_hi_u32    v1, v1, s0
/*000000000060*/ v_mul_lo_u32    v2, v1, s2
/*000000000068*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000070*/ v_sub_u32       v3, vcc, s0, v2
/*000000000074*/ v_cmp_ge_u32    s[6:7], s0, v2
/*00000000007c*/ v_cmp_ge_u32    s[8:9], v3, s2
/*000000000084*/ s_add_u32       s0, s1, s0
/*000000000088*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*00000000008c*/ v_add_u32       v0, vcc, s0, v0
/*000000000090*/ v_addc_u32      v1, vcc, v1, 0, s[8:9]
/*000000000098*/ s_cmp_lg_i32    s2, 0
/*00000000009c*/ s_cselect_b64   s[0:1], exec, 0
/*0000000000a0*/ v_addc_u32      v2, vcc, v1, -1, s[6:7]
/*0000000000a8*/ v_mov_b32       v1, 0
/*0000000000ac*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b4*/ v_cndmask_b32   v2, -1, v2, s[0:1]
/*0000000000bc*/ s_waitcnt       lgkmcnt(0)
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_mov_b32       v3, s5
/*0000000000c8*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000cc*/ flat_store_dword v[0:1], v2
/*0000000000d4*/ s_endpgm
.kernel div_get_local_id_8_8
    .config
        .dims x, xy
        .cws 8, 8, 1
        .sgprsnum 13
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000088c
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ v_cvt_f32_u32   v1, v1
/*00000000000c*/ v_rcp_f32       v2, v1
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ v_cvt_f32_u32   v3, v0
/*000000000024*/ v_mul_f32       v2, v3, v2
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_trunc_f32     v2, v2
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_mad_f32       v3, -v2, v1, v3
/*00000000003c*/ v_cmp_ge_f32    vcc, abs(v3), abs(v1)
/*000000000044*/ v_cvt_u32_f32   v2, v2
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000054*/ v_addc_u32      v2, vcc, v2, 0, vcc
/*00000000005c*/ v_add_u32       v0, vcc, s2, v0
/*000000000060*/ v_mov_b32       v3, s3
/*000000000064*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000068*/ flat_store_dword v[0:1], v2
/*000000000070*/ s_endpgm
.kernel div_get_group_id_8_8
    .config
        .dims xy, x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x0000018c
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ v_cvt_f32_u32   v1, s7
/*00000000001c*/ v_rcp_f32       v1, v1
/*000000000020*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000028*/ v_cvt_u32_f32   v3, v1
/*00000000002c*/ v_mad_u64_u32   v[1:2], vcc, s7, v3, 0
/*000000000034*/ v_sub_u32       v4, vcc, 0, v1
/*000000000038*/ v_cmp_lg_i32    s[4:5], 0, v2
/*000000000040*/ v_cndmask_b32   v1, v4, v1, s[4:5]
/*000000000048*/ v_mul_hi_u32    v1, v1, v3
/*000000000050*/ v_sub_u32       v2, vcc, v3, v1
/*000000000054*/ v_add_u32       v1, vcc, v3, v1
/*000000000058*/ v_cndmask_b32   v1, v1, v2, s[4:5]
/*000000000060*/ v_mul_hi_u32    v1, v1, s6
/*000000000068*/ v_mul_lo_u32    v2, v1, s7
/*000000000070*/ v_sub_u32       v3, vcc, s6, v2
/*000000000074*/ v_cmp_ge_u32    s[4:5], s6, v2
/*00000000007c*/ v_cmp_ge_u32    s[8:9], v3, s7
/*000000000084*/ s_and_b64       s[8:9], s[4:5], s[8:9]
/*000000000088*/ v_addc_u32      v1, vcc, v1, 0, s[8:9]
/*000000000090*/ v_addc_u32      v1, vcc, v1, -1, s[4:5]
/*000000000098*/ s_cmp_lg_i32    s7, 0
/*00000000009c*/ s_cselect_b64   vcc, exec, 0
/*0000000000a0*/ v_cndmask_b32   v2, -1, v1, vcc
/*0000000000a4*/ s_add_u32       s0, s1, s0
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v0
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000bc*/ v_mov_b32       v3, s3
/*0000000000c0*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000c4*/ flat_store_dword v[0:1], v2
/*0000000000cc*/ s_endpgm
.kernel div_get_local_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 1
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel div_get_global_id_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 6
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x0000098c
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
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_lshl_b32      s3, s7, 3
/*00000000001c*/ s_add_u32       s2, s3, s2
/*000000000020*/ v_add_u32       v2, vcc, s2, v1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ v_add_u32       v3, vcc, s0, v0
/*00000000002c*/ v_cvt_f32_u32   v0, v2
/*000000000030*/ v_rcp_f32       v0, v0
/*000000000034*/ v_mul_f32       v0, 0x4f800000 /* 4.2949673e+9f */, v0
/*00000000003c*/ v_cvt_u32_f32   v4, v0
/*000000000040*/ v_mad_u64_u32   v[0:1], vcc, v2, v4, 0
/*000000000048*/ v_sub_u32       v5, vcc, 0, v0
/*00000000004c*/ v_cmp_lg_i32    s[0:1], 0, v1
/*000000000054*/ v_cndmask_b32   v0, v5, v0, s[0:1]
/*00000000005c*/ v_mul_hi_u32    v0, v0, v4
/*000000000064*/ v_sub_u32       v1, vcc, v4, v0
/*000000000068*/ v_add_u32       v0, vcc, v4, v0
/*00000000006c*/ v_cndmask_b32   v0, v0, v1, s[0:1]
/*000000000074*/ v_mul_hi_u32    v0, v0, v3
/*00000000007c*/ v_mul_lo_u32    v1, v0, v2
/*000000000084*/ v_sub_u32       v4, vcc, v3, v1
/*000000000088*/ v_cmp_ge_u32    s[0:1], v3, v1
/*000000000090*/ v_cmp_ge_u32    s[2:3], v4, v2
/*000000000098*/ s_and_b64       s[2:3], s[0:1], s[2:3]
/*00000000009c*/ v_addc_u32      v0, vcc, v0, 0, s[2:3]
/*0000000000a4*/ v_addc_u32      v0, vcc, v0, -1, s[0:1]
/*0000000000ac*/ v_cmp_lg_i32    vcc, 0, v2
/*0000000000b0*/ v_cndmask_b32   v2, -1, v0, vcc
/*0000000000b4*/ v_mov_b32       v4, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_mov_b32       v3, s5
/*0000000000c8*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000cc*/ flat_store_dword v[0:1], v2
/*0000000000d4*/ s_endpgm
.kernel div_get_global_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 17
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00000090
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_lshl_b32      s2, s8, 3
/*00000000000c*/ s_waitcnt       lgkmcnt(0)
/*000000000010*/ v_cvt_f32_u32   v1, s1
/*000000000014*/ v_rcp_f32       v1, v1
/*000000000018*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000020*/ v_cvt_u32_f32   v3, v1
/*000000000024*/ v_mad_u64_u32   v[1:2], vcc, s1, v3, 0
/*00000000002c*/ v_sub_u32       v4, vcc, 0, v1
/*000000000030*/ v_cmp_lg_i32    s[4:5], 0, v2
/*000000000038*/ v_cndmask_b32   v1, v4, v1, s[4:5]
/*000000000040*/ v_mul_hi_u32    v1, v1, v3
/*000000000048*/ v_sub_u32       v2, vcc, v3, v1
/*00000000004c*/ v_add_u32       v1, vcc, v3, v1
/*000000000050*/ v_cndmask_b32   v1, v1, v2, s[4:5]
/*000000000058*/ v_mul_hi_u32    v1, v1, s0
/*000000000060*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000068*/ v_mul_lo_u32    v2, v1, s1
/*000000000070*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000078*/ v_sub_u32       v3, vcc, s0, v2
/*00000000007c*/ v_cmp_ge_u32    s[8:9], s0, v2
/*000000000084*/ v_cmp_ge_u32    s[10:11], v3, s1
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_add_u32       s0, s2, s4
/*000000000094*/ s_and_b64       s[2:3], s[8:9], s[10:11]
/*000000000098*/ v_add_u32       v0, vcc, s0, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v1, 0, s[2:3]
/*0000000000a4*/ s_cmp_lg_i32    s1, 0
/*0000000000a8*/ s_cselect_b64   s[0:1], exec, 0
/*0000000000ac*/ v_addc_u32      v2, vcc, v1, -1, s[8:9]
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000c0*/ v_cndmask_b32   v2, -1, v2, s[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s6, v0
/*0000000000cc*/ v_mov_b32       v3, s7
/*0000000000d0*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000d4*/ flat_store_dword v[0:1], v2
/*0000000000dc*/ s_endpgm
.kernel div_get_num_groups_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00000090
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshr_b32      s0, s0, 3
/*000000000020*/ s_lshr_b32      s1, s1, 3
/*000000000024*/ s_lshl_b32      s3, s8, 3
/*000000000028*/ v_cvt_f32_u32   v1, s1
/*00000000002c*/ v_rcp_f32       v1, v1
/*000000000030*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000038*/ v_cvt_u32_f32   v3, v1
/*00000000003c*/ v_mad_u64_u32   v[1:2], vcc, s1, v3, 0
/*000000000044*/ v_sub_u32       v4, vcc, 0, v1
/*000000000048*/ v_cmp_lg_i32    s[6:7], 0, v2
/*000000000050*/ v_cndmask_b32   v1, v4, v1, s[6:7]
/*000000000058*/ v_mul_hi_u32    v1, v1, v3
/*000000000060*/ v_sub_u32       v2, vcc, v3, v1
/*000000000064*/ v_add_u32       v1, vcc, v3, v1
/*000000000068*/ v_cndmask_b32   v1, v1, v2, s[6:7]
/*000000000070*/ v_mul_hi_u32    v1, v1, s0
/*000000000078*/ v_mul_lo_u32    v2, v1, s1
/*000000000080*/ v_sub_u32       v3, vcc, s0, v2
/*000000000084*/ v_cmp_ge_u32    s[6:7], s0, v2
/*00000000008c*/ v_cmp_ge_u32    s[8:9], v3, s1
/*000000000094*/ s_and_b64       s[8:9], s[6:7], s[8:9]
/*000000000098*/ v_addc_u32      v1, vcc, v1, 0, s[8:9]
/*0000000000a0*/ v_addc_u32      v1, vcc, v1, -1, s[6:7]
/*0000000000a8*/ s_cmp_lg_i32    s1, 0
/*0000000000ac*/ s_cselect_b64   vcc, exec, 0
/*0000000000b0*/ v_cndmask_b32   v2, -1, v1, vcc
/*0000000000b4*/ s_add_u32       s0, s3, s2
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v0
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_mov_b32       v3, s5
/*0000000000d0*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000d4*/ flat_store_dword v[0:1], v2
/*0000000000dc*/ s_endpgm
.kernel div_get_work_dim_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 20
        .vgprsnum 6
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00000990
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "uint*", uint*, global,
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000024*/ s_lshl_b32      s1, s8, 3
/*000000000028*/ s_lshl_b32      s4, s9, 3
/*00000000002c*/ s_add_u32       s4, s4, s14
/*000000000030*/ v_add_u32       v3, vcc, s4, v1
/*000000000034*/ v_cvt_f32_u32   v1, v3
/*000000000038*/ v_rcp_f32       v1, v1
/*00000000003c*/ v_mul_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v1
/*000000000044*/ v_cvt_u32_f32   v4, v1
/*000000000048*/ v_mad_u64_u32   v[1:2], vcc, v3, v4, 0
/*000000000050*/ v_sub_u32       v5, vcc, 0, v1
/*000000000054*/ v_cmp_lg_i32    s[4:5], 0, v2
/*00000000005c*/ v_cndmask_b32   v1, v5, v1, s[4:5]
/*000000000064*/ v_mul_hi_u32    v1, v1, v4
/*00000000006c*/ v_sub_u32       v2, vcc, v4, v1
/*000000000070*/ v_add_u32       v1, vcc, v4, v1
/*000000000074*/ v_cndmask_b32   v1, v1, v2, s[4:5]
/*00000000007c*/ v_mul_hi_u32    v1, v1, s0
/*000000000084*/ v_mul_lo_u32    v2, v1, v3
/*00000000008c*/ v_sub_u32       v4, vcc, s0, v2
/*000000000090*/ v_cmp_ge_u32    s[4:5], s0, v2
/*000000000098*/ v_cmp_ge_u32    s[6:7], v4, v3
/*0000000000a0*/ s_and_b64       s[6:7], s[4:5], s[6:7]
/*0000000000a4*/ v_addc_u32      v1, vcc, v1, 0, s[6:7]
/*0000000000ac*/ v_addc_u32      v1, vcc, v1, -1, s[4:5]
/*0000000000b4*/ v_cmp_lg_i32    vcc, 0, v3
/*0000000000b8*/ v_cndmask_b32   v2, -1, v1, vcc
/*0000000000bc*/ s_add_u32       s0, s1, s12
/*0000000000c0*/ v_add_u32       v0, vcc, s0, v0
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000d4*/ v_mov_b32       v3, s3
/*0000000000d8*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000dc*/ flat_store_dword v[0:1], v2
/*0000000000e4*/ s_endpgm
