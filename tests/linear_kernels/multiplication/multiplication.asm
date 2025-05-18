.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel mul_x_x
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s0, s1, s1
/*00000000003c*/ v_add_u32       v0, vcc, s2, v0
/*000000000040*/ v_mov_b32       v2, s3
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ flat_store_dword v[0:1], v2
/*000000000054*/ s_endpgm
.kernel mul_get_global_offset_x
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
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s6, s7, 4
/*00000000002c*/ s_add_u32       s3, s3, s0
/*000000000030*/ s_lshl_b32      s7, s8, 1
/*000000000034*/ v_add_u32       v3, vcc, s3, v0
/*000000000038*/ s_add_u32       s3, s6, s2
/*00000000003c*/ v_add_u32       v6, vcc, s3, v1
/*000000000040*/ s_add_u32       s3, s7, s10
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_mul_i32       s0, s2, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_mul_i32       s0, s10, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel mul_get_local_id_x
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 3
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 2
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ v_mul_lo_u32    v5, v0, s1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ v_add_u32       v3, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v6, s11
/*000000000058*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v5
/*000000000064*/ v_mul_lo_u32    v3, v1, s1
/*00000000006c*/ s_add_u32       s0, s5, s2
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000088*/ flat_store_dword v[0:1], v3
/*000000000090*/ v_mul_lo_u32    v3, v2, s1
/*000000000098*/ s_add_u32       s0, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ flat_store_dword v[0:1], v3
/*0000000000bc*/ s_endpgm
.kernel mul_get_group_id_x
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
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s9, s7, 4
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s9, s2
/*00000000003c*/ v_add_u32       v6, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s2, s6, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_mul_i32       s0, s7, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_mul_i32       s0, s8, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel mul_get_local_size_x
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 2
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s6, s2
/*00000000003c*/ v_add_u32       v6, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ s_waitcnt       lgkmcnt(0)
/*000000000054*/ s_lshl_b32      s2, s1, 1
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ v_mov_b32       v7, 0
/*000000000070*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000078*/ v_add_u32       v1, vcc, s4, v6
/*00000000007c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000008c*/ s_lshl_b32      s0, s1, 2
/*000000000090*/ v_add_u32       v12, vcc, s4, v7
/*000000000094*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ flat_store_dword v[10:11], v5
/*0000000000a4*/ flat_store_dword v[1:2], v5
/*0000000000ac*/ flat_store_dword v[12:13], v7
/*0000000000b4*/ s_endpgm
.kernel mul_get_global_id_x
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_lshl_b32      s3, s6, 1
/*000000000020*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000028*/ v_add_u32       v5, vcc, s3, v0
/*00000000002c*/ s_lshl_b32      s3, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 2
/*000000000034*/ v_add_u32       v3, vcc, s0, v5
/*000000000038*/ s_add_u32       s0, s3, s2
/*00000000003c*/ s_waitcnt       lgkmcnt(0)
/*000000000040*/ v_mul_lo_u32    v3, v3, s1
/*000000000048*/ v_add_u32       v8, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s6, s10
/*000000000050*/ v_mul_lo_u32    v4, v8, s1
/*000000000058*/ v_add_u32       v10, vcc, s0, v2
/*00000000005c*/ v_mov_b32       v6, 0
/*000000000060*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*000000000068*/ v_mul_lo_u32    v0, v10, s1
/*000000000070*/ v_add_u32       v5, vcc, s4, v5
/*000000000074*/ v_mov_b32       v7, s5
/*000000000078*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ v_add_u32       v12, vcc, s4, v8
/*00000000008c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000090*/ v_mov_b32       v11, 0
/*000000000094*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*00000000009c*/ v_add_u32       v1, vcc, s4, v9
/*0000000000a0*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*0000000000a4*/ flat_store_dword v[5:6], v3
/*0000000000ac*/ flat_store_dword v[12:13], v4
/*0000000000b4*/ flat_store_dword v[1:2], v0
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_size_x
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
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[6:7], 0x38
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_load_dword    s4, s[4:5], 0x14
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ s_lshl_b32      s3, s10, 1
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s5, s2
/*00000000004c*/ v_add_u32       v6, vcc, s0, v1
/*000000000050*/ s_add_u32       s0, s3, s12
/*000000000054*/ s_waitcnt       lgkmcnt(0)
/*000000000058*/ s_mul_i32       s2, s14, s1
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ s_mul_i32       s0, s15, s1
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ v_add_u32       v1, vcc, s6, v6
/*000000000090*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000094*/ v_mov_b32       v7, s0
/*000000000098*/ s_mul_i32       s0, s4, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ v_add_u32       v12, vcc, s6, v8
/*0000000000ac*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b0*/ v_mov_b32       v8, s0
/*0000000000b4*/ flat_store_dword v[10:11], v5
/*0000000000bc*/ flat_store_dword v[1:2], v7
/*0000000000c4*/ flat_store_dword v[12:13], v8
/*0000000000cc*/ s_endpgm
.kernel mul_get_num_groups_x
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
/*00000000001c*/ s_load_dword    s1, s[6:7], 0x30
/*000000000024*/ s_load_dword    s3, s[4:5], 0x14
/*00000000002c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000034*/ s_lshl_b32      s6, s8, 1
/*000000000038*/ s_lshl_b32      s7, s9, 1
/*00000000003c*/ s_add_u32       s0, s6, s0
/*000000000040*/ s_lshl_b32      s6, s10, 2
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s7, s2
/*00000000004c*/ s_lshr_b32      s2, s12, 1
/*000000000050*/ v_add_u32       v6, vcc, s0, v1
/*000000000054*/ s_add_u32       s0, s6, s14
/*000000000058*/ s_lshr_b32      s6, s13, 1
/*00000000005c*/ s_waitcnt       lgkmcnt(0)
/*000000000060*/ s_mul_i32       s2, s2, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ s_lshr_b32      s0, s3, 2
/*000000000078*/ v_add_u32       v10, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v3, s5
/*000000000080*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ s_mul_i32       s2, s6, s1
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000098*/ v_add_u32       v1, vcc, s4, v6
/*00000000009c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a0*/ v_mov_b32       v7, s2
/*0000000000a4*/ s_mul_i32       s0, s0, s1
/*0000000000a8*/ v_mov_b32       v9, 0
/*0000000000ac*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b4*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b8*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000bc*/ v_mov_b32       v8, s0
/*0000000000c0*/ flat_store_dword v[10:11], v5
/*0000000000c8*/ flat_store_dword v[1:2], v7
/*0000000000d0*/ flat_store_dword v[12:13], v8
/*0000000000d8*/ s_endpgm
.kernel mul_get_work_dim_x
    .config
        .dims x
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dword    s2, s[6:7], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_add_u32       s0, s3, s0
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s0, s1, 0x20010
/*00000000003c*/ s_mul_i32       s0, s0, s2
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s4, v0
/*000000000050*/ v_mov_b32       v2, s5
/*000000000054*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000058*/ v_mov_b32       v2, s0
/*00000000005c*/ flat_store_dword v[0:1], v2
/*000000000064*/ s_endpgm
.kernel mul_x_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s3, s3, s0
/*000000000030*/ s_lshl_b32      s7, s8, 1
/*000000000034*/ v_add_u32       v3, vcc, s3, v0
/*000000000038*/ s_add_u32       s3, s6, s2
/*00000000003c*/ v_add_u32       v6, vcc, s3, v1
/*000000000040*/ s_add_u32       s3, s7, s10
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_mul_i32       s0, s2, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_mul_i32       s0, s10, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_offset_get_global_offset
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
/*000000000048*/ s_mul_i32       s0, s0, s0
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_mul_i32       s0, s2, s2
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_mul_i32       s0, s10, s10
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_id_get_global_offset
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ v_mul_lo_u32    v0, v0, s0
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v5, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000050*/ flat_store_dword v[3:4], v0
/*000000000058*/ v_mul_lo_u32    v3, v1, s2
/*000000000060*/ s_add_u32       s0, s3, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, v2, s4
/*00000000008c*/ s_add_u32       s0, s5, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel mul_get_group_id_get_global_offset
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
/*000000000028*/ s_lshl_b32      s9, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s1, v1
/*000000000038*/ s_add_u32       s1, s9, s10
/*00000000003c*/ s_mul_i32       s0, s6, s0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ s_mul_i32       s0, s7, s2
/*000000000064*/ v_mov_b32       v7, 0
/*000000000068*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ s_mul_i32       s0, s8, s10
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_size_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s1, v1
/*000000000038*/ s_add_u32       s1, s6, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ s_lshl_b32      s0, s0, 1
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_lshl_b32      s0, s2, 1
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_lshl_b32      s0, s10, 2
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_global_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v5, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v5
/*000000000030*/ s_add_u32       s1, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, v3, s0
/*00000000003c*/ v_add_u32       v8, vcc, s1, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, v8, s2
/*00000000004c*/ v_add_u32       v10, vcc, s0, v2
/*000000000050*/ v_mov_b32       v6, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000005c*/ v_mul_lo_u32    v0, v10, s10
/*000000000064*/ s_waitcnt       lgkmcnt(0)
/*000000000068*/ v_add_u32       v5, vcc, s4, v5
/*00000000006c*/ v_mov_b32       v7, s5
/*000000000070*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000094*/ v_add_u32       v1, vcc, s4, v9
/*000000000098*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*00000000009c*/ flat_store_dword v[5:6], v3
/*0000000000a4*/ flat_store_dword v[12:13], v4
/*0000000000ac*/ flat_store_dword v[1:2], v0
/*0000000000b4*/ s_endpgm
.kernel mul_get_global_size_get_global_offset
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
/*000000000034*/ s_add_u32       s1, s1, s0
/*000000000038*/ s_lshl_b32      s5, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ s_add_u32       s1, s4, s2
/*000000000044*/ v_add_u32       v6, vcc, s1, v1
/*000000000048*/ s_add_u32       s1, s5, s12
/*00000000004c*/ s_mul_i32       s0, s14, s0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s1, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_mul_i32       s0, s15, s2
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_mul_i32       s0, s3, s12
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_num_groups_get_global_offset
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
/*000000000034*/ s_add_u32       s3, s3, s0
/*000000000038*/ s_lshl_b32      s7, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ s_lshr_b32      s6, s12, 1
/*000000000048*/ v_add_u32       v6, vcc, s3, v1
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ s_lshr_b32      s7, s13, 1
/*000000000054*/ s_mul_i32       s0, s6, s0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s3, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s1, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ s_mul_i32       s0, s7, s2
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ s_mul_i32       s0, s1, s14
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_work_dim_get_global_offset
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
/*000000000030*/ s_add_u32       s3, s3, s0
/*000000000034*/ s_lshl_b32      s8, s10, 2
/*000000000038*/ v_add_u32       v3, vcc, s3, v0
/*00000000003c*/ s_add_u32       s3, s5, s2
/*000000000040*/ s_bfe_u32       s1, s1, 0x20010
/*000000000048*/ v_add_u32       v6, vcc, s3, v1
/*00000000004c*/ s_add_u32       s3, s8, s4
/*000000000050*/ s_mul_i32       s0, s1, s0
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s3, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s0
/*000000000074*/ s_mul_i32       s0, s1, s2
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_mul_i32       s0, s1, s4
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_x_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ v_mul_lo_u32    v5, v0, s1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ v_add_u32       v3, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v6, s11
/*000000000058*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v5
/*000000000064*/ v_mul_lo_u32    v3, v1, s1
/*00000000006c*/ s_add_u32       s0, s5, s2
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000088*/ flat_store_dword v[0:1], v3
/*000000000090*/ v_mul_lo_u32    v3, v2, s1
/*000000000098*/ s_add_u32       s0, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ flat_store_dword v[0:1], v3
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_offset_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ v_mul_lo_u32    v0, v0, s0
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v5, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000050*/ flat_store_dword v[3:4], v0
/*000000000058*/ v_mul_lo_u32    v3, v1, s2
/*000000000060*/ s_add_u32       s0, s3, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, v2, s4
/*00000000008c*/ s_add_u32       s0, s5, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_id_get_local_id
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
/*000000000058*/ v_mul_i32_i24   v0, v0, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_mul_i32_i24   v1, v1, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_mul_i32_i24   v2, v2, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel mul_get_group_id_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ v_mul_lo_u32    v0, v0, s6
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v5, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000050*/ flat_store_dword v[3:4], v0
/*000000000058*/ v_mul_lo_u32    v3, v1, s7
/*000000000060*/ s_add_u32       s0, s3, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, v2, s8
/*00000000008c*/ s_add_u32       s0, s5, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_size_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
/*000000000058*/ v_lshlrev_b32   v0, 1, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_lshlrev_b32   v1, 1, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_lshlrev_b32   v2, 2, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel mul_get_global_id_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v6, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v4, vcc, s0, v6
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v0, v0, v4
/*00000000003c*/ v_add_u32       v8, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v1, v1, v8
/*00000000004c*/ v_add_u32       v10, vcc, s0, v2
/*000000000050*/ v_mov_b32       v7, 0
/*000000000054*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000005c*/ v_mul_lo_u32    v2, v2, v10
/*000000000064*/ s_waitcnt       lgkmcnt(0)
/*000000000068*/ v_add_u32       v12, vcc, s4, v6
/*00000000006c*/ v_mov_b32       v6, s5
/*000000000070*/ v_addc_u32      v13, vcc, v6, v7, vcc
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v3, vcc, s4, v8
/*000000000084*/ v_addc_u32      v4, vcc, v6, v9, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000094*/ v_add_u32       v5, vcc, s4, v9
/*000000000098*/ v_addc_u32      v6, vcc, v6, v10, vcc
/*00000000009c*/ flat_store_dword v[12:13], v0
/*0000000000a4*/ flat_store_dword v[3:4], v1
/*0000000000ac*/ flat_store_dword v[5:6], v2
/*0000000000b4*/ s_endpgm
.kernel mul_get_global_size_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 6
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ v_mul_lo_u32    v0, v0, s0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s4, v3
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000060*/ flat_store_dword v[3:4], v0
/*000000000068*/ v_mul_lo_u32    v3, v1, s1
/*000000000070*/ s_add_u32       s0, s7, s14
/*000000000074*/ v_add_u32       v0, vcc, s0, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s4, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v3
/*000000000094*/ v_mul_lo_u32    v3, v2, s2
/*00000000009c*/ s_add_u32       s0, s8, s6
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel mul_get_num_groups_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 6
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ v_mul_lo_u32    v0, v0, s0
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v5, s5
/*000000000068*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000006c*/ flat_store_dword v[3:4], v0
/*000000000074*/ v_mul_lo_u32    v3, v1, s1
/*00000000007c*/ s_add_u32       s0, s7, s14
/*000000000080*/ v_add_u32       v0, vcc, s0, v1
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000098*/ flat_store_dword v[0:1], v3
/*0000000000a0*/ v_mul_lo_u32    v3, v2, s2
/*0000000000a8*/ s_add_u32       s0, s8, s6
/*0000000000ac*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000c4*/ flat_store_dword v[0:1], v3
/*0000000000cc*/ s_endpgm
.kernel mul_get_work_dim_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ v_mul_lo_u32    v5, v0, s0
/*000000000040*/ s_add_u32       s1, s1, s12
/*000000000044*/ v_add_u32       v3, vcc, s1, v0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s2, v3
/*000000000058*/ v_mov_b32       v6, s3
/*00000000005c*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000060*/ flat_store_dword v[3:4], v5
/*000000000068*/ v_mul_lo_u32    v3, v1, s0
/*000000000070*/ s_add_u32       s1, s5, s14
/*000000000074*/ v_add_u32       v0, vcc, s1, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s2, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v3
/*000000000094*/ v_mul_lo_u32    v3, v2, s0
/*00000000009c*/ s_add_u32       s0, s6, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel mul_x_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s9, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s9, s2
/*00000000003c*/ v_add_u32       v6, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s2, s6, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_mul_i32       s0, s7, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_mul_i32       s0, s8, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_offset_get_group_id
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
/*000000000028*/ s_lshl_b32      s9, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s1, v1
/*000000000038*/ s_add_u32       s1, s9, s10
/*00000000003c*/ s_mul_i32       s0, s6, s0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ s_mul_i32       s0, s7, s2
/*000000000064*/ v_mov_b32       v7, 0
/*000000000068*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ s_mul_i32       s0, s8, s10
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_id_get_group_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ v_mul_lo_u32    v0, s6, v0
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v5, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000050*/ flat_store_dword v[3:4], v0
/*000000000058*/ v_mul_lo_u32    v3, s7, v1
/*000000000060*/ s_add_u32       s0, s3, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, s8, v2
/*00000000008c*/ s_add_u32       s0, s5, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel mul_get_group_id_get_group_id
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
/*000000000048*/ s_mul_i32       s1, s6, s6
/*00000000004c*/ v_add_u32       v8, vcc, s0, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_mul_i32       s0, s7, s7
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_mul_i32       s0, s8, s8
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_size_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s6, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, s1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v7, s3
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000088*/ v_mov_b32       v8, s6
/*00000000008c*/ flat_store_dword v[10:11], v5
/*000000000094*/ flat_store_dword v[1:2], v7
/*00000000009c*/ flat_store_dword v[12:13], v8
/*0000000000a4*/ s_endpgm
.kernel mul_get_global_id_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v5, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v5
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, s6, v3
/*00000000003c*/ v_add_u32       v8, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, s7, v8
/*00000000004c*/ v_add_u32       v10, vcc, s0, v2
/*000000000050*/ v_mov_b32       v6, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000005c*/ v_mul_lo_u32    v0, s8, v10
/*000000000064*/ s_waitcnt       lgkmcnt(0)
/*000000000068*/ v_add_u32       v5, vcc, s4, v5
/*00000000006c*/ v_mov_b32       v7, s5
/*000000000070*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000094*/ v_add_u32       v1, vcc, s4, v9
/*000000000098*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*00000000009c*/ flat_store_dword v[5:6], v3
/*0000000000a4*/ flat_store_dword v[12:13], v4
/*0000000000ac*/ flat_store_dword v[1:2], v0
/*0000000000b4*/ s_endpgm
.kernel mul_get_global_size_get_group_id
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
/*00000000004c*/ s_mul_i32       s1, s8, s14
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ s_mul_i32       s0, s9, s15
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_mul_i32       s0, s10, s3
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_num_groups_get_group_id
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
/*000000000054*/ s_mul_i32       s2, s8, s2
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_mul_i32       s1, s9, s3
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ s_mul_i32       s0, s10, s0
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_work_dim_get_group_id
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
/*000000000050*/ s_mul_i32       s2, s8, s1
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s2
/*000000000074*/ s_mul_i32       s0, s9, s1
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_mul_i32       s0, s10, s1
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_x_get_local_size
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
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s6, s2
/*00000000003c*/ v_add_u32       v6, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ s_waitcnt       lgkmcnt(0)
/*000000000054*/ s_lshl_b32      s2, s1, 4
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ v_mov_b32       v7, 0
/*000000000070*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000078*/ s_lshl_b32      s0, s1, 1
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
.kernel mul_get_global_offset_get_local_size
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
/*000000000048*/ s_lshl_b32      s0, s0, 1
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_lshl_b32      s0, s2, 4
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_lshl_b32      s0, s10, 1
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_id_get_local_size
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
/*000000000058*/ v_lshlrev_b32   v0, 3, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_lshlrev_b32   v1, 2, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_lshlrev_b32   v2, 1, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel mul_get_group_id_get_local_size
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
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s6, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s0, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, s1
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v7, s3
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000088*/ v_mov_b32       v8, s6
/*00000000008c*/ flat_store_dword v[10:11], v5
/*000000000094*/ flat_store_dword v[1:2], v7
/*00000000009c*/ flat_store_dword v[12:13], v8
/*0000000000a4*/ s_endpgm
.kernel mul_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
/*000000000058*/ v_mov_b32       v5, 4
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v12, vcc, s4, v7
/*000000000080*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*000000000084*/ v_mov_b32       v7, 16
/*000000000088*/ flat_store_dword v[10:11], v5
/*000000000090*/ flat_store_dword v[1:2], v5
/*000000000098*/ flat_store_dword v[12:13], v7
/*0000000000a0*/ s_endpgm
.kernel mul_get_global_id_get_local_size
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
/*000000000024*/ v_add_u32       v5, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ s_add_u32       s2, s3, s2
/*000000000030*/ v_add_u32       v8, vcc, s2, v1
/*000000000034*/ s_add_u32       s1, s1, s10
/*000000000038*/ v_mov_b32       v6, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000044*/ v_add_u32       v0, vcc, s0, v5
/*000000000048*/ v_add_u32       v10, vcc, s1, v2
/*00000000004c*/ v_add_u32       v3, vcc, s4, v3
/*000000000050*/ v_mov_b32       v5, s5
/*000000000054*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000058*/ v_lshlrev_b32   v0, 1, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000068*/ v_add_u32       v6, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000070*/ v_lshlrev_b32   v1, 1, v8
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000080*/ v_add_u32       v10, vcc, s4, v8
/*000000000084*/ v_addc_u32      v11, vcc, v5, v9, vcc
/*000000000088*/ flat_store_dword v[3:4], v0
/*000000000090*/ flat_store_dword v[6:7], v1
/*000000000098*/ flat_store_dword v[10:11], v8
/*0000000000a0*/ s_endpgm
.kernel mul_get_global_size_get_local_size
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
/*000000000058*/ s_lshl_b32      s1, s14, 4
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_lshl_b32      s0, s15, 1
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_lshl_b32      s0, s3, 1
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_num_groups_get_local_size
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
/*000000000060*/ s_lshl_b32      s2, s2, 1
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_lshl_b32      s1, s3, 1
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_lshl_b32      s0, s0, 2
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_work_dim_get_local_size
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
/*00000000005c*/ s_lshl_b32      s2, s1, 1
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
/*000000000094*/ s_lshl_b32      s0, s1, 2
/*000000000098*/ v_add_u32       v12, vcc, s6, v7
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*0000000000a0*/ v_mov_b32       v7, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[12:13], v7
/*0000000000bc*/ s_endpgm
.kernel mul_x_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ v_mul_lo_u32    v0, v3, s1
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v5, s11
/*000000000058*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v0
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_mul_lo_u32    v3, v0, s1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000088*/ flat_store_dword v[0:1], v3
/*000000000090*/ s_add_u32       s0, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mul_lo_u32    v2, v0, s1
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b4*/ flat_store_dword v[0:1], v2
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_offset_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ v_mul_lo_u32    v0, v3, s0
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v5, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000050*/ flat_store_dword v[3:4], v0
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_mul_lo_u32    v3, v0, s2
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ s_add_u32       s0, s5, s4
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mul_lo_u32    v2, v0, s4
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v2
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_id_get_global_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v7, vcc, s0, v1
/*000000000038*/ v_mul_lo_u32    v0, v0, v3
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v6, s11
/*000000000054*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000058*/ flat_store_dword v[3:4], v0
/*000000000060*/ v_mul_lo_u32    v3, v1, v7
/*000000000068*/ v_mov_b32       v8, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v3
/*000000000084*/ s_add_u32       s0, s5, s4
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mul_lo_u32    v2, v2, v0
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v2
/*0000000000b0*/ s_endpgm
.kernel mul_get_group_id_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s0, v1
/*000000000038*/ v_mul_lo_u32    v4, s6, v0
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s10, v0
/*000000000050*/ v_mov_b32       v5, s11
/*000000000054*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000058*/ flat_store_dword v[0:1], v4
/*000000000060*/ v_mul_lo_u32    v4, s7, v6
/*000000000068*/ v_mov_b32       v7, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ flat_store_dword v[0:1], v4
/*000000000084*/ s_add_u32       s0, s5, s4
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mul_lo_u32    v2, s8, v0
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v2
/*0000000000b0*/ s_endpgm
.kernel mul_get_local_size_get_global_id
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
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ s_lshl_b32      s1, s8, 2
/*000000000030*/ v_add_u32       v6, vcc, s0, v0
/*000000000034*/ v_add_u32       v2, vcc, s1, v2
/*000000000038*/ v_add_u32       v8, vcc, s2, v1
/*00000000003c*/ v_mov_b32       v7, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[6:7]
/*000000000048*/ v_add_u32       v10, vcc, s10, v2
/*00000000004c*/ v_add_u32       v3, vcc, s4, v3
/*000000000050*/ v_mov_b32       v5, s5
/*000000000054*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000058*/ v_lshlrev_b32   v0, 1, v6
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000068*/ v_add_u32       v6, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000070*/ v_lshlrev_b32   v1, 1, v8
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000080*/ v_add_u32       v8, vcc, s4, v8
/*000000000084*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*000000000088*/ v_lshlrev_b32   v2, 2, v10
/*00000000008c*/ flat_store_dword v[3:4], v0
/*000000000094*/ flat_store_dword v[6:7], v1
/*00000000009c*/ flat_store_dword v[8:9], v2
/*0000000000a4*/ s_endpgm
.kernel mul_get_global_id_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v5, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v5
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, v3, v3
/*00000000003c*/ v_add_u32       v8, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, v8, v8
/*00000000004c*/ v_add_u32       v10, vcc, s0, v2
/*000000000050*/ v_mov_b32       v6, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000005c*/ v_mul_lo_u32    v0, v10, v10
/*000000000064*/ s_waitcnt       lgkmcnt(0)
/*000000000068*/ v_add_u32       v5, vcc, s4, v5
/*00000000006c*/ v_mov_b32       v7, s5
/*000000000070*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000094*/ v_add_u32       v1, vcc, s4, v9
/*000000000098*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*00000000009c*/ flat_store_dword v[5:6], v3
/*0000000000a4*/ flat_store_dword v[12:13], v4
/*0000000000ac*/ flat_store_dword v[1:2], v0
/*0000000000b4*/ s_endpgm
.kernel mul_get_global_size_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v6, vcc, s3, v1
/*000000000048*/ v_mul_lo_u32    v4, s0, v0
/*000000000050*/ v_mov_b32       v1, 0
/*000000000054*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000005c*/ v_add_u32       v0, vcc, s4, v0
/*000000000060*/ v_mov_b32       v5, s5
/*000000000064*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000068*/ flat_store_dword v[0:1], v4
/*000000000070*/ v_mul_lo_u32    v4, s1, v6
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000084*/ v_add_u32       v0, vcc, s4, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v4
/*000000000094*/ s_add_u32       s0, s8, s6
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mul_lo_u32    v2, s2, v0
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v2
/*0000000000c0*/ s_endpgm
.kernel mul_get_num_groups_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v6, vcc, s3, v1
/*000000000054*/ v_mul_lo_u32    v4, s0, v0
/*00000000005c*/ v_mov_b32       v1, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_mov_b32       v5, s5
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v4
/*00000000007c*/ v_mul_lo_u32    v4, s1, v6
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000098*/ flat_store_dword v[0:1], v4
/*0000000000a0*/ s_add_u32       s0, s8, s6
/*0000000000a4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a8*/ v_mul_lo_u32    v2, s2, v0
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000c4*/ flat_store_dword v[0:1], v2
/*0000000000cc*/ s_endpgm
.kernel mul_get_work_dim_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 6
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mul_lo_u32    v0, s0, v3
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s2, v3
/*000000000058*/ v_mov_b32       v5, s3
/*00000000005c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000060*/ flat_store_dword v[3:4], v0
/*000000000068*/ s_add_u32       s1, s5, s14
/*00000000006c*/ v_add_u32       v0, vcc, s1, v1
/*000000000070*/ v_mul_lo_u32    v3, s0, v0
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s2, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v3
/*000000000094*/ s_add_u32       s1, s6, s4
/*000000000098*/ v_add_u32       v0, vcc, s1, v2
/*00000000009c*/ v_mul_lo_u32    v2, s0, v0
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v2
/*0000000000c0*/ s_endpgm
.kernel mul_x_get_global_size
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
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[6:7], 0x38
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_load_dword    s4, s[4:5], 0x14
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ s_lshl_b32      s3, s10, 1
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s5, s2
/*00000000004c*/ v_add_u32       v6, vcc, s0, v1
/*000000000050*/ s_add_u32       s0, s3, s12
/*000000000054*/ s_waitcnt       lgkmcnt(0)
/*000000000058*/ s_mul_i32       s2, s14, s1
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ s_mul_i32       s0, s15, s1
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ v_add_u32       v1, vcc, s6, v6
/*000000000090*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000094*/ v_mov_b32       v7, s0
/*000000000098*/ s_mul_i32       s0, s4, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ v_add_u32       v12, vcc, s6, v8
/*0000000000ac*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b0*/ v_mov_b32       v8, s0
/*0000000000b4*/ flat_store_dword v[10:11], v5
/*0000000000bc*/ flat_store_dword v[1:2], v7
/*0000000000c4*/ flat_store_dword v[12:13], v8
/*0000000000cc*/ s_endpgm
.kernel mul_get_global_offset_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s8, 1
/*000000000028*/ s_load_dword    s3, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s9, 4
/*000000000034*/ s_add_u32       s1, s1, s0
/*000000000038*/ s_lshl_b32      s5, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ s_add_u32       s1, s4, s2
/*000000000044*/ v_add_u32       v6, vcc, s1, v1
/*000000000048*/ s_add_u32       s1, s5, s12
/*00000000004c*/ s_mul_i32       s0, s14, s0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s1, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_mul_i32       s0, s15, s2
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_mul_i32       s0, s3, s12
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_local_id_get_global_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 6
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
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 3
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 2
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ v_mul_lo_u32    v0, s0, v0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s4, v3
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000060*/ flat_store_dword v[3:4], v0
/*000000000068*/ v_mul_lo_u32    v3, s1, v1
/*000000000070*/ s_add_u32       s0, s7, s14
/*000000000074*/ v_add_u32       v0, vcc, s0, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s4, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v3
/*000000000094*/ v_mul_lo_u32    v3, s2, v2
/*00000000009c*/ s_add_u32       s0, s8, s6
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel mul_get_group_id_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s8, 1
/*000000000028*/ s_load_dword    s3, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s9, 4
/*000000000034*/ s_add_u32       s0, s1, s0
/*000000000038*/ s_lshl_b32      s1, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s4, s2
/*000000000044*/ v_add_u32       v6, vcc, s0, v1
/*000000000048*/ s_add_u32       s0, s1, s12
/*00000000004c*/ s_mul_i32       s1, s14, s8
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ s_mul_i32       s0, s15, s9
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_mul_i32       s0, s3, s10
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_local_size_get_global_size
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
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s8, 1
/*000000000028*/ s_load_dword    s3, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s1, s0
/*000000000038*/ s_lshl_b32      s1, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s4, s2
/*000000000044*/ v_add_u32       v6, vcc, s0, v1
/*000000000048*/ s_add_u32       s0, s1, s12
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ s_lshl_b32      s1, s14, 1
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_lshl_b32      s0, s15, 1
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_lshl_b32      s0, s3, 2
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_global_id_get_global_size
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
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000030*/ v_add_u32       v5, vcc, s3, v0
/*000000000034*/ s_lshl_b32      s3, s9, 1
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s0, v5
/*000000000040*/ s_add_u32       s0, s3, s2
/*000000000044*/ v_mul_lo_u32    v3, s12, v3
/*00000000004c*/ v_add_u32       v8, vcc, s0, v1
/*000000000050*/ s_add_u32       s0, s6, s14
/*000000000054*/ v_mul_lo_u32    v4, s13, v8
/*00000000005c*/ v_add_u32       v10, vcc, s0, v2
/*000000000060*/ v_mov_b32       v6, 0
/*000000000064*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000006c*/ s_waitcnt       lgkmcnt(0)
/*000000000070*/ v_mul_lo_u32    v0, s1, v10
/*000000000078*/ v_add_u32       v5, vcc, s4, v5
/*00000000007c*/ v_mov_b32       v7, s5
/*000000000080*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000084*/ v_mov_b32       v9, 0
/*000000000088*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000090*/ v_add_u32       v12, vcc, s4, v8
/*000000000094*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000098*/ v_mov_b32       v11, 0
/*00000000009c*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*0000000000a4*/ v_add_u32       v1, vcc, s4, v9
/*0000000000a8*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*0000000000ac*/ flat_store_dword v[5:6], v3
/*0000000000b4*/ flat_store_dword v[12:13], v4
/*0000000000bc*/ flat_store_dword v[1:2], v0
/*0000000000c4*/ s_endpgm
.kernel mul_get_global_size_get_global_size
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
/*000000000058*/ s_mul_i32       s1, s14, s14
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_mul_i32       s0, s15, s15
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_mul_i32       s0, s3, s3
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_num_groups_get_global_size
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
/*000000000054*/ s_mul_i32       s2, s12, s2
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_mul_i32       s2, s13, s3
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s2
/*00000000009c*/ s_mul_i32       s0, s1, s0
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_work_dim_get_global_size
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*00000000001c*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_load_dword    s4, s[4:5], 0x14
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ s_lshl_b32      s3, s10, 2
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s5, s2
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_bfe_u32       s1, s1, 0x20010
/*000000000058*/ v_add_u32       v6, vcc, s0, v1
/*00000000005c*/ s_add_u32       s0, s3, s12
/*000000000060*/ s_mul_i32       s2, s14, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ v_add_u32       v10, vcc, s6, v3
/*000000000078*/ v_mov_b32       v3, s7
/*00000000007c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ s_mul_i32       s0, s15, s1
/*000000000088*/ v_mov_b32       v7, 0
/*00000000008c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000094*/ v_add_u32       v1, vcc, s6, v6
/*000000000098*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000009c*/ v_mov_b32       v7, s0
/*0000000000a0*/ s_mul_i32       s0, s4, s1
/*0000000000a4*/ v_mov_b32       v9, 0
/*0000000000a8*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000b4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b8*/ v_mov_b32       v8, s0
/*0000000000bc*/ flat_store_dword v[10:11], v5
/*0000000000c4*/ flat_store_dword v[1:2], v7
/*0000000000cc*/ flat_store_dword v[12:13], v8
/*0000000000d4*/ s_endpgm
.kernel mul_x_get_num_groups
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
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[6:7], 0x38
/*000000000024*/ s_load_dword    s3, s[4:5], 0x14
/*00000000002c*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000034*/ s_lshl_b32      s6, s8, 4
/*000000000038*/ s_lshl_b32      s7, s9, 1
/*00000000003c*/ s_add_u32       s0, s6, s0
/*000000000040*/ s_lshl_b32      s6, s10, 1
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s7, s2
/*00000000004c*/ s_lshr_b32      s2, s12, 4
/*000000000050*/ v_add_u32       v6, vcc, s0, v1
/*000000000054*/ s_add_u32       s0, s6, s14
/*000000000058*/ s_lshr_b32      s6, s13, 1
/*00000000005c*/ s_waitcnt       lgkmcnt(0)
/*000000000060*/ s_mul_i32       s2, s2, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ s_lshr_b32      s0, s3, 1
/*000000000078*/ v_add_u32       v10, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v3, s5
/*000000000080*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ s_mul_i32       s2, s6, s1
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000098*/ v_add_u32       v1, vcc, s4, v6
/*00000000009c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a0*/ v_mov_b32       v7, s2
/*0000000000a4*/ s_mul_i32       s0, s0, s1
/*0000000000a8*/ v_mov_b32       v9, 0
/*0000000000ac*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b4*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b8*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000bc*/ v_mov_b32       v8, s0
/*0000000000c0*/ flat_store_dword v[10:11], v5
/*0000000000c8*/ flat_store_dword v[1:2], v7
/*0000000000d0*/ flat_store_dword v[12:13], v8
/*0000000000d8*/ s_endpgm
.kernel mul_get_global_offset_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x14
/*000000000024*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s6, s9, 4
/*000000000034*/ s_add_u32       s3, s3, s0
/*000000000038*/ s_lshl_b32      s7, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ s_lshr_b32      s6, s12, 1
/*000000000048*/ v_add_u32       v6, vcc, s3, v1
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ s_lshr_b32      s7, s13, 4
/*000000000054*/ s_mul_i32       s0, s6, s0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s3, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s1, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ s_mul_i32       s0, s7, s2
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ s_mul_i32       s0, s1, s14
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_local_id_get_num_groups
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 6
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
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 3
/*000000000030*/ s_lshr_b32      s1, s1, 2
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 3
/*00000000003c*/ s_lshl_b32      s7, s9, 2
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ v_mul_lo_u32    v0, s0, v0
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v5, s5
/*000000000068*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000006c*/ flat_store_dword v[3:4], v0
/*000000000074*/ v_mul_lo_u32    v3, s1, v1
/*00000000007c*/ s_add_u32       s0, s7, s14
/*000000000080*/ v_add_u32       v0, vcc, s0, v1
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000098*/ flat_store_dword v[0:1], v3
/*0000000000a0*/ v_mul_lo_u32    v3, s2, v2
/*0000000000a8*/ s_add_u32       s0, s8, s6
/*0000000000ac*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000c4*/ flat_store_dword v[0:1], v3
/*0000000000cc*/ s_endpgm
.kernel mul_get_group_id_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x14
/*000000000024*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s6, s9, 4
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s6, s2
/*000000000044*/ s_lshr_b32      s2, s12, 1
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s14
/*000000000050*/ s_lshr_b32      s3, s13, 4
/*000000000054*/ s_mul_i32       s2, s2, s8
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_mul_i32       s1, s3, s9
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ s_mul_i32       s0, s0, s10
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_local_size_get_num_groups
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
/*000000000060*/ s_lshl_b32      s2, s2, 1
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_lshl_b32      s1, s3, 1
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_lshl_b32      s0, s0, 2
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_global_id_get_num_groups
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s3, s[4:5], 0x14
/*000000000024*/ s_lshl_b32      s4, s8, 1
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000030*/ v_add_u32       v5, vcc, s4, v0
/*000000000034*/ s_lshl_b32      s4, s9, 1
/*000000000038*/ s_lshr_b32      s0, s0, 1
/*00000000003c*/ s_lshl_b32      s5, s10, 2
/*000000000040*/ v_add_u32       v3, vcc, s12, v5
/*000000000044*/ s_add_u32       s4, s4, s14
/*000000000048*/ s_lshr_b32      s1, s1, 1
/*00000000004c*/ v_mul_lo_u32    v3, s0, v3
/*000000000054*/ v_add_u32       v8, vcc, s4, v1
/*000000000058*/ s_add_u32       s0, s5, s2
/*00000000005c*/ s_waitcnt       lgkmcnt(0)
/*000000000060*/ s_lshr_b32      s2, s3, 2
/*000000000064*/ v_mul_lo_u32    v4, s1, v8
/*00000000006c*/ v_add_u32       v10, vcc, s0, v2
/*000000000070*/ v_mov_b32       v6, 0
/*000000000074*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000007c*/ v_mul_lo_u32    v0, s2, v10
/*000000000084*/ v_add_u32       v5, vcc, s6, v5
/*000000000088*/ v_mov_b32       v7, s7
/*00000000008c*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000090*/ v_mov_b32       v9, 0
/*000000000094*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000009c*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a0*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*0000000000a4*/ v_mov_b32       v11, 0
/*0000000000a8*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*0000000000b0*/ v_add_u32       v1, vcc, s6, v9
/*0000000000b4*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*0000000000b8*/ flat_store_dword v[5:6], v3
/*0000000000c0*/ flat_store_dword v[12:13], v4
/*0000000000c8*/ flat_store_dword v[1:2], v0
/*0000000000d0*/ s_endpgm
.kernel mul_get_global_size_get_num_groups
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
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x14
/*000000000024*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_lshl_b32      s6, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s6, s2
/*000000000044*/ s_lshr_b32      s2, s12, 4
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s14
/*000000000050*/ s_lshr_b32      s3, s13, 1
/*000000000054*/ s_mul_i32       s2, s2, s12
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_mul_i32       s2, s3, s13
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s2
/*00000000009c*/ s_mul_i32       s0, s0, s1
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_num_groups_get_num_groups
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
/*000000000060*/ s_mul_i32       s2, s2, s2
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_mul_i32       s1, s3, s3
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_mul_i32       s0, s0, s0
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel mul_get_work_dim_get_num_groups
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*00000000001c*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000024*/ s_load_dword    s3, s[4:5], 0x14
/*00000000002c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000034*/ s_lshl_b32      s6, s8, 1
/*000000000038*/ s_lshl_b32      s7, s9, 1
/*00000000003c*/ s_add_u32       s0, s6, s0
/*000000000040*/ s_lshl_b32      s6, s10, 2
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s7, s2
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_bfe_u32       s1, s1, 0x20010
/*000000000058*/ s_lshr_b32      s2, s12, 1
/*00000000005c*/ v_add_u32       v6, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s6, s14
/*000000000064*/ s_lshr_b32      s6, s13, 1
/*000000000068*/ s_mul_i32       s2, s2, s1
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000078*/ v_add_u32       v8, vcc, s0, v2
/*00000000007c*/ s_lshr_b32      s0, s3, 2
/*000000000080*/ v_add_u32       v10, vcc, s4, v3
/*000000000084*/ v_mov_b32       v3, s5
/*000000000088*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ s_mul_i32       s2, s6, s1
/*000000000094*/ v_mov_b32       v7, 0
/*000000000098*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*0000000000a0*/ v_add_u32       v1, vcc, s4, v6
/*0000000000a4*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a8*/ v_mov_b32       v7, s2
/*0000000000ac*/ s_mul_i32       s0, s0, s1
/*0000000000b0*/ v_mov_b32       v9, 0
/*0000000000b4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000bc*/ v_add_u32       v12, vcc, s4, v8
/*0000000000c0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000c4*/ v_mov_b32       v8, s0
/*0000000000c8*/ flat_store_dword v[10:11], v5
/*0000000000d0*/ flat_store_dword v[1:2], v7
/*0000000000d8*/ flat_store_dword v[12:13], v8
/*0000000000e0*/ s_endpgm
.kernel mul_x_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*00000000001c*/ s_load_dword    s3, s[6:7], 0x38
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s5, s8, 4
/*000000000034*/ s_lshl_b32      s8, s9, 1
/*000000000038*/ s_add_u32       s0, s5, s0
/*00000000003c*/ s_lshl_b32      s5, s10, 1
/*000000000040*/ v_add_u32       v3, vcc, s0, v0
/*000000000044*/ s_add_u32       s0, s8, s2
/*000000000048*/ s_bfe_u32       s1, s1, 0x20010
/*000000000050*/ v_add_u32       v6, vcc, s0, v1
/*000000000054*/ s_add_u32       s0, s5, s4
/*000000000058*/ s_mul_i32       s1, s1, s3
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s1
/*00000000007c*/ v_mov_b32       v7, 0
/*000000000080*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000088*/ v_add_u32       v1, vcc, s6, v6
/*00000000008c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000090*/ v_mov_b32       v9, 0
/*000000000094*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000009c*/ v_add_u32       v6, vcc, s6, v7
/*0000000000a0*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[6:7], v5
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_offset_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*00000000001c*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s9, 4
/*000000000030*/ s_add_u32       s3, s3, s0
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ v_add_u32       v3, vcc, s3, v0
/*00000000003c*/ s_add_u32       s3, s5, s2
/*000000000040*/ s_bfe_u32       s1, s1, 0x20010
/*000000000048*/ v_add_u32       v6, vcc, s3, v1
/*00000000004c*/ s_add_u32       s3, s8, s4
/*000000000050*/ s_mul_i32       s0, s1, s0
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s3, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s0
/*000000000074*/ s_mul_i32       s0, s1, s2
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_mul_i32       s0, s1, s4
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_local_id_get_work_dim
    .config
        .dims xyz
        .cws 8, 4, 2
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
        .arg x, "int", int
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 3
/*000000000030*/ s_lshl_b32      s5, s9, 2
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ v_mul_lo_u32    v5, s0, v0
/*000000000040*/ s_add_u32       s1, s1, s12
/*000000000044*/ v_add_u32       v3, vcc, s1, v0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s2, v3
/*000000000058*/ v_mov_b32       v6, s3
/*00000000005c*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000060*/ flat_store_dword v[3:4], v5
/*000000000068*/ v_mul_lo_u32    v3, s0, v1
/*000000000070*/ s_add_u32       s1, s5, s14
/*000000000074*/ v_add_u32       v0, vcc, s1, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s2, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000008c*/ flat_store_dword v[0:1], v3
/*000000000094*/ v_mul_lo_u32    v3, s0, v2
/*00000000009c*/ s_add_u32       s0, s6, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel mul_get_group_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*00000000001c*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s9, 4
/*000000000030*/ s_add_u32       s0, s3, s0
/*000000000034*/ s_lshl_b32      s3, s10, 1
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s5, s2
/*000000000040*/ s_bfe_u32       s1, s1, 0x20010
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s4
/*000000000050*/ s_mul_i32       s2, s1, s8
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s2
/*000000000074*/ s_mul_i32       s0, s1, s9
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_mul_i32       s0, s1, s10
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel mul_get_local_size_get_work_dim
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
/*00000000005c*/ s_lshl_b32      s2, s1, 1
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
/*000000000094*/ s_lshl_b32      s0, s1, 2
/*000000000098*/ v_add_u32       v12, vcc, s6, v7
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*0000000000a0*/ v_mov_b32       v7, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[12:13], v7
/*0000000000bc*/ s_endpgm
.kernel mul_get_global_id_get_work_dim
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
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_lshl_b32      s1, s8, 1
/*00000000001c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000024*/ v_add_u32       v5, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s9, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_bfe_u32       s0, s0, 0x20010
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s12, v5
/*000000000040*/ s_add_u32       s1, s1, s14
/*000000000044*/ v_mul_lo_u32    v3, s0, v3
/*00000000004c*/ v_add_u32       v8, vcc, s1, v1
/*000000000050*/ s_add_u32       s1, s3, s2
/*000000000054*/ v_mul_lo_u32    v4, v8, s0
/*00000000005c*/ v_add_u32       v10, vcc, s1, v2
/*000000000060*/ v_mov_b32       v6, 0
/*000000000064*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*00000000006c*/ v_mul_lo_u32    v0, v10, s0
/*000000000074*/ v_add_u32       v5, vcc, s4, v5
/*000000000078*/ v_mov_b32       v7, s5
/*00000000007c*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000094*/ v_mov_b32       v11, 0
/*000000000098*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*0000000000a0*/ v_add_u32       v1, vcc, s4, v9
/*0000000000a4*/ v_addc_u32      v2, vcc, v7, v10, vcc
/*0000000000a8*/ flat_store_dword v[5:6], v3
/*0000000000b0*/ flat_store_dword v[12:13], v4
/*0000000000b8*/ flat_store_dword v[1:2], v0
/*0000000000c0*/ s_endpgm
.kernel mul_get_global_size_get_work_dim
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*00000000001c*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_load_dword    s4, s[4:5], 0x14
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ s_lshl_b32      s3, s10, 1
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s5, s2
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_bfe_u32       s1, s1, 0x20010
/*000000000058*/ v_add_u32       v6, vcc, s0, v1
/*00000000005c*/ s_add_u32       s0, s3, s12
/*000000000060*/ s_mul_i32       s2, s1, s14
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ v_add_u32       v10, vcc, s6, v3
/*000000000078*/ v_mov_b32       v3, s7
/*00000000007c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ s_mul_i32       s0, s1, s15
/*000000000088*/ v_mov_b32       v7, 0
/*00000000008c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000094*/ v_add_u32       v1, vcc, s6, v6
/*000000000098*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000009c*/ v_mov_b32       v7, s0
/*0000000000a0*/ s_mul_i32       s0, s1, s4
/*0000000000a4*/ v_mov_b32       v9, 0
/*0000000000a8*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000b4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b8*/ v_mov_b32       v8, s0
/*0000000000bc*/ flat_store_dword v[10:11], v5
/*0000000000c4*/ flat_store_dword v[1:2], v7
/*0000000000cc*/ flat_store_dword v[12:13], v8
/*0000000000d4*/ s_endpgm
.kernel mul_get_num_groups_get_work_dim
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*00000000001c*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000024*/ s_load_dword    s3, s[4:5], 0x14
/*00000000002c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000034*/ s_lshl_b32      s6, s8, 1
/*000000000038*/ s_lshl_b32      s7, s9, 1
/*00000000003c*/ s_add_u32       s0, s6, s0
/*000000000040*/ s_lshl_b32      s6, s10, 2
/*000000000044*/ v_add_u32       v3, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s7, s2
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_bfe_u32       s1, s1, 0x20010
/*000000000058*/ s_lshr_b32      s2, s12, 1
/*00000000005c*/ v_add_u32       v6, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s6, s14
/*000000000064*/ s_lshr_b32      s6, s13, 1
/*000000000068*/ s_mul_i32       s2, s1, s2
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000078*/ v_add_u32       v8, vcc, s0, v2
/*00000000007c*/ s_lshr_b32      s0, s3, 2
/*000000000080*/ v_add_u32       v10, vcc, s4, v3
/*000000000084*/ v_mov_b32       v3, s5
/*000000000088*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ s_mul_i32       s2, s1, s6
/*000000000094*/ v_mov_b32       v7, 0
/*000000000098*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*0000000000a0*/ v_add_u32       v1, vcc, s4, v6
/*0000000000a4*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a8*/ v_mov_b32       v7, s2
/*0000000000ac*/ s_mul_i32       s0, s1, s0
/*0000000000b0*/ v_mov_b32       v9, 0
/*0000000000b4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000bc*/ v_add_u32       v12, vcc, s4, v8
/*0000000000c0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000c4*/ v_mov_b32       v8, s0
/*0000000000c8*/ flat_store_dword v[10:11], v5
/*0000000000d0*/ flat_store_dword v[1:2], v7
/*0000000000d8*/ flat_store_dword v[12:13], v8
/*0000000000e0*/ s_endpgm
.kernel mul_get_work_dim_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
/*00000000005c*/ s_mul_i32       s1, s1, s1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s1
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v9, 0
/*00000000008c*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*000000000094*/ v_add_u32       v6, vcc, s6, v7
/*000000000098*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*00000000009c*/ flat_store_dword v[10:11], v5
/*0000000000a4*/ flat_store_dword v[1:2], v5
/*0000000000ac*/ flat_store_dword v[6:7], v5
/*0000000000b4*/ s_endpgm
.kernel mul_x_64
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
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s0, s1, s1
/*00000000003c*/ v_add_u32       v0, vcc, s2, v0
/*000000000040*/ v_mov_b32       v2, s3
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ flat_store_dword v[0:1], v2
/*000000000054*/ s_endpgm
.kernel mul_get_global_offset_64
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
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ s_mul_i32       s0, s0, s0
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v2, s3
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_get_local_id_64
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v1, vcc, s0, v0
/*000000000020*/ v_mov_b32       v2, 0
/*000000000024*/ v_lshlrev_b64   v[1:2], 2, v[1:2]
/*00000000002c*/ v_add_u32       v1, vcc, s2, v1
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000038*/ v_mul_i32_i24   v0, v0, v0
/*00000000003c*/ flat_store_dword v[1:2], v0
/*000000000044*/ s_endpgm
.kernel mul_get_group_id_64
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
/*00000000002c*/ s_mul_i32       s0, s6, s6
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v2, s3
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_get_local_size_64
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
/*000000000038*/ v_mov_b32       v2, 0x1000
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_get_global_id_64
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 6
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mul_lo_u32    v2, v0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_add_u32       v0, vcc, s2, v0
/*00000000003c*/ v_mov_b32       v3, s3
/*000000000040*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000044*/ flat_store_dword v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel mul_get_global_size_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0xc
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s0, s1, s1
/*00000000003c*/ v_add_u32       v0, vcc, s2, v0
/*000000000040*/ v_mov_b32       v2, s3
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ flat_store_dword v[0:1], v2
/*000000000054*/ s_endpgm
.kernel mul_get_num_groups_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0xc
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s1, 6
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000003c*/ s_mul_i32       s0, s0, s0
/*000000000040*/ v_add_u32       v0, vcc, s2, v0
/*000000000044*/ v_mov_b32       v2, s3
/*000000000048*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
.kernel mul_get_work_dim
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s1, 0x20010
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ s_mul_i32       s0, s0, s0
/*000000000044*/ v_add_u32       v0, vcc, s2, v0
/*000000000048*/ v_mov_b32       v2, s3
/*00000000004c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000050*/ v_mov_b32       v2, s0
/*000000000054*/ flat_store_dword v[0:1], v2
/*00000000005c*/ s_endpgm
.kernel mul_x_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000014*/ s_lshl_b32      s3, s7, 3
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ s_lshl_b32      s6, s6, 3
/*000000000024*/ s_add_u32       s2, s3, s2
/*000000000028*/ v_add_u32       v1, vcc, s2, v1
/*00000000002c*/ s_add_u32       s0, s6, s0
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_mul_lo_u32    v2, v1, s1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s4, v0
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000058*/ flat_store_dword v[0:1], v2
/*000000000060*/ s_endpgm
.kernel mul_get_global_offset_8_8
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_mul_i32       s0, s2, s0
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ v_mov_b32       v2, s5
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_get_local_id_8_8
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
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ v_mul_i32_i24   v2, v1, v0
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ v_add_u32       v0, vcc, s0, v0
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v3, s3
/*000000000038*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel mul_get_group_id_8_8
    .config
        .dims xy, x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ s_mul_i32       s0, s7, s6
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v2, s3
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_get_local_size_8_8
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
/*000000000038*/ v_mov_b32       v2, 64
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel mul_get_global_id_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*00000000000c*/ s_lshl_b32      s1, s6, 3
/*000000000010*/ s_lshl_b32      s3, s7, 3
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ s_add_u32       s1, s3, s2
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ v_mul_lo_u32    v2, v1, v0
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_add_u32       v0, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
.kernel mul_get_global_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s8, 3
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_mul_i32       s0, s3, s2
/*00000000002c*/ v_mov_b32       v1, 0
/*000000000030*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000038*/ v_add_u32       v0, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v2, s5
/*000000000040*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel mul_get_num_groups_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s8, 3
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_lshr_b32      s0, s2, 3
/*00000000002c*/ s_lshr_b32      s1, s3, 3
/*000000000030*/ s_mul_i32       s0, s1, s0
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ v_add_u32       v0, vcc, s4, v0
/*000000000044*/ v_mov_b32       v2, s5
/*000000000048*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
.kernel mul_get_work_dim_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_lshl_b32      s3, s9, 3
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s6, s8, 3
/*000000000024*/ s_add_u32       s2, s3, s2
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s1, s1, 0x20010
/*000000000034*/ v_add_u32       v1, vcc, s2, v1
/*000000000038*/ s_add_u32       s0, s6, s0
/*00000000003c*/ v_mul_lo_u32    v2, v1, s1
/*000000000044*/ v_add_u32       v0, vcc, s0, v0
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000054*/ v_add_u32       v0, vcc, s4, v0
/*000000000058*/ v_mov_b32       v3, s5
/*00000000005c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000060*/ flat_store_dword v[0:1], v2
/*000000000068*/ s_endpgm
.kernel mul_long_x_x
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ s_mul_i32       s0, s1, s1
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel mul_long_get_global_offset_x
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 4
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ s_add_u32       s3, s3, s0
/*000000000038*/ v_add_u32       v0, vcc, s3, v0
/*00000000003c*/ s_add_u32       s3, s5, s2
/*000000000040*/ v_add_u32       v7, vcc, s3, v1
/*000000000044*/ v_mov_b32       v1, 0
/*000000000048*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000050*/ v_add_u32       v0, vcc, s10, v0
/*000000000054*/ v_mov_b32       v6, s11
/*000000000058*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000005c*/ s_mul_i32       s0, s0, s1
/*000000000060*/ v_mov_b32       v3, s0
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000070*/ v_mov_b32       v8, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000084*/ s_mul_i32       s0, s2, s1
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s6, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b0*/ s_mul_i32       s0, s4, s1
/*0000000000b4*/ v_mov_b32       v2, s0
/*0000000000b8*/ v_mov_b32       v3, 0
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c4*/ s_endpgm
.kernel mul_long_get_local_id_x
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 3
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 2
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s5, s2
/*000000000040*/ v_add_u32       v3, vcc, s0, v1
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_mov_b32       v6, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*00000000005c*/ v_add_u32       v5, vcc, s10, v5
/*000000000060*/ v_mov_b32       v9, s11
/*000000000064*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*000000000068*/ v_mul_lo_u32    v7, v0, s1
/*000000000070*/ v_mov_b32       v8, 0
/*000000000074*/ flat_store_dwordx2 v[5:6], v[7:8]
/*00000000007c*/ v_add_u32       v5, vcc, s10, v3
/*000000000080*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000084*/ v_mul_lo_u32    v3, v1, s1
/*00000000008c*/ v_mov_b32       v4, 0
/*000000000090*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000098*/ s_add_u32       s0, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b4*/ v_mul_lo_u32    v2, v2, s1
/*0000000000bc*/ v_mov_b32       v3, 0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_group_id_x
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 4
/*000000000030*/ s_lshl_b32      s9, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s5, s2
/*000000000040*/ v_add_u32       v0, vcc, s0, v1
/*000000000044*/ v_mov_b32       v1, 0
/*000000000048*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s10, v3
/*000000000060*/ v_mov_b32       v7, s11
/*000000000064*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000068*/ s_mul_i32       s0, s6, s1
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ v_mov_b32       v6, 0
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000084*/ s_mul_i32       s0, s7, s1
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ v_mov_b32       v4, 0
/*000000000090*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000098*/ s_add_u32       s0, s9, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ s_mul_i32       s0, s8, s1
/*0000000000b8*/ v_mov_b32       v2, s0
/*0000000000bc*/ v_mov_b32       v3, 0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_local_size_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 2
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000048*/ v_add_u32       v3, vcc, s10, v3
/*00000000004c*/ v_mov_b32       v7, s11
/*000000000050*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000054*/ s_lshl_b32      s0, s1, 1
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_mov_b32       v6, 0
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ s_add_u32       s0, s5, s2
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000084*/ flat_store_dwordx2 v[0:1], v[5:6]
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a8*/ s_lshl_b32      s0, s1, 2
/*0000000000ac*/ v_mov_b32       v2, s0
/*0000000000b0*/ v_mov_b32       v3, 0
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel mul_long_get_global_id_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ v_add_u32       v5, vcc, s3, v0
/*00000000002c*/ s_lshl_b32      s3, s7, 1
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s5, s8, 2
/*000000000038*/ v_mov_b32       v6, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 3, v[5:6]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v7, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000050*/ v_add_u32       v0, vcc, s0, v5
/*000000000054*/ v_mul_lo_u32    v5, v0, s1
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ s_add_u32       s0, s3, s2
/*000000000068*/ v_add_u32       v3, vcc, s0, v1
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 3, v[3:4]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ v_mul_lo_u32    v3, v3, s1
/*000000000088*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000090*/ s_add_u32       s0, s5, s4
/*000000000094*/ v_add_u32       v2, vcc, s0, v2
/*000000000098*/ v_mov_b32       v3, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*0000000000a4*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ac*/ v_mul_lo_u32    v2, v2, s1
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel mul_long_get_global_size_x
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dword    s3, s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s7, s8, 4
/*000000000038*/ s_lshl_b32      s8, s9, 1
/*00000000003c*/ s_lshl_b32      s9, s10, 1
/*000000000040*/ s_add_u32       s7, s7, s12
/*000000000044*/ v_add_u32       v3, vcc, s7, v0
/*000000000048*/ s_add_u32       s7, s8, s14
/*00000000004c*/ v_add_u32       v0, vcc, s7, v1
/*000000000050*/ v_mov_b32       v1, 0
/*000000000054*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000068*/ v_add_u32       v3, vcc, s4, v3
/*00000000006c*/ v_mov_b32       v7, s5
/*000000000070*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000074*/ s_mul_i32       s0, s0, s3
/*000000000078*/ v_mov_b32       v5, s0
/*00000000007c*/ v_mov_b32       v6, 0
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_mul_i32       s0, s1, s3
/*000000000094*/ v_mov_b32       v3, s0
/*000000000098*/ v_mov_b32       v4, 0
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ s_add_u32       s0, s9, s6
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c0*/ s_mul_i32       s0, s2, s3
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, 0
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel mul_long_get_num_groups_x
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dword    s3, s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 1
/*000000000038*/ s_lshr_b32      s1, s1, 1
/*00000000003c*/ s_lshr_b32      s2, s2, 2
/*000000000040*/ s_lshl_b32      s7, s8, 1
/*000000000044*/ s_lshl_b32      s8, s9, 1
/*000000000048*/ s_lshl_b32      s9, s10, 2
/*00000000004c*/ s_add_u32       s7, s7, s12
/*000000000050*/ v_add_u32       v3, vcc, s7, v0
/*000000000054*/ s_add_u32       s7, s8, s14
/*000000000058*/ v_add_u32       v0, vcc, s7, v1
/*00000000005c*/ v_mov_b32       v1, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000068*/ v_mov_b32       v4, 0
/*00000000006c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000074*/ v_add_u32       v3, vcc, s4, v3
/*000000000078*/ v_mov_b32       v7, s5
/*00000000007c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000080*/ s_mul_i32       s0, s0, s3
/*000000000084*/ v_mov_b32       v5, s0
/*000000000088*/ v_mov_b32       v6, 0
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ s_mul_i32       s0, s1, s3
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ v_mov_b32       v4, 0
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s9, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ s_mul_i32       s0, s2, s3
/*0000000000d0*/ v_mov_b32       v2, s0
/*0000000000d4*/ v_mov_b32       v3, 0
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel mul_long_get_work_dim_x
    .config
        .dims x
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 1
/*000000000020*/ s_load_dword    s5, s[6:7], 0x30
/*000000000028*/ s_add_u32       s0, s4, s0
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000003c*/ s_waitcnt       lgkmcnt(0)
/*000000000040*/ s_bfe_u32       s0, s1, 0x20010
/*000000000048*/ v_add_u32       v0, vcc, s2, v0
/*00000000004c*/ v_mov_b32       v2, s3
/*000000000050*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000054*/ s_mul_i32       s0, s0, s5
/*000000000058*/ v_mov_b32       v2, s0
/*00000000005c*/ v_mov_b32       v3, 0
/*000000000060*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000068*/ s_endpgm
.kernel mul_long_x_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x38
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_lshl_b32      s1, s6, 4
/*000000000024*/ s_lshl_b32      s6, s7, 1
/*000000000028*/ s_lshl_b32      s7, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_ashr_i32      s8, s0, 31
/*000000000034*/ v_mov_b32       v7, s0
/*000000000038*/ v_mul_hi_u32    v3, s12, v7
/*000000000040*/ s_mul_i32       s9, s13, s0
/*000000000044*/ s_mul_i32       s10, s12, s8
/*000000000048*/ s_add_u32       s9, s9, s10
/*00000000004c*/ v_add_u32       v6, vcc, s9, v3
/*000000000050*/ s_mul_i32       s9, s12, s0
/*000000000054*/ s_add_u32       s1, s1, s12
/*000000000058*/ v_add_u32       v3, vcc, s1, v0
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000068*/ v_add_u32       v3, vcc, s2, v3
/*00000000006c*/ v_mov_b32       v8, s3
/*000000000070*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000074*/ v_mov_b32       v5, s9
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ v_mul_hi_u32    v0, s14, v7
/*000000000088*/ s_mul_i32       s1, s15, s0
/*00000000008c*/ s_mul_i32       s3, s14, s8
/*000000000090*/ s_add_u32       s1, s1, s3
/*000000000094*/ v_add_u32       v4, vcc, s1, v0
/*000000000098*/ s_mul_i32       s1, s14, s0
/*00000000009c*/ s_add_u32       s3, s6, s14
/*0000000000a0*/ v_add_u32       v0, vcc, s3, v1
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b8*/ v_mov_b32       v3, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ v_mul_hi_u32    v0, s4, v7
/*0000000000cc*/ s_mul_i32       s1, s5, s0
/*0000000000d0*/ s_mul_i32       s3, s4, s8
/*0000000000d4*/ s_add_u32       s1, s1, s3
/*0000000000d8*/ v_add_u32       v3, vcc, s1, v0
/*0000000000dc*/ s_mul_i32       s0, s4, s0
/*0000000000e0*/ s_add_u32       s1, s7, s4
/*0000000000e4*/ v_add_u32       v0, vcc, s1, v2
/*0000000000e8*/ v_mov_b32       v1, 0
/*0000000000ec*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000f4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000f8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000fc*/ v_mov_b32       v2, s0
/*000000000100*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000108*/ s_endpgm
.kernel mul_long_get_global_offset_get_global_offset
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ s_lshl_b32      s7, s7, 4
/*000000000020*/ s_lshl_b32      s8, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ v_mul_hi_u32    v3, s0, s0
/*000000000030*/ s_mul_i32       s1, s0, s1
/*000000000034*/ v_add_u32       v6, vcc, s1, v3
/*000000000038*/ s_mul_i32       s1, s0, s0
/*00000000003c*/ s_add_u32       s0, s6, s0
/*000000000040*/ v_add_u32       v3, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v7, s11
/*000000000058*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_mul_hi_u32    v0, s2, s2
/*000000000070*/ s_mul_i32       s0, s2, s3
/*000000000074*/ v_add_u32       v4, vcc, s0, v0
/*000000000078*/ s_mul_i32       s0, s2, s2
/*00000000007c*/ s_add_u32       s1, s7, s2
/*000000000080*/ v_add_u32       v0, vcc, s1, v1
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s10, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ v_mov_b32       v3, s0
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ v_mul_hi_u32    v0, s4, s4
/*0000000000ac*/ s_mul_i32       s0, s4, s5
/*0000000000b0*/ v_add_u32       v3, vcc, s0, v0
/*0000000000b4*/ s_mul_i32       s0, s4, s4
/*0000000000b8*/ s_add_u32       s1, s8, s4
/*0000000000bc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s10, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ v_mov_b32       v2, s0
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel mul_long_get_local_id_get_global_offset
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 3
/*00000000001c*/ s_lshl_b32      s7, s7, 2
/*000000000020*/ s_lshl_b32      s8, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s6, s6, s0
/*00000000002c*/ v_add_u32       v3, vcc, s6, v0
/*000000000030*/ v_mul_hi_u32    v4, v0, s0
/*000000000038*/ v_mul_lo_u32    v5, v0, s1
/*000000000040*/ v_add_u32       v6, vcc, v5, v4
/*000000000044*/ v_mul_lo_u32    v5, v0, s0
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000058*/ v_add_u32       v3, vcc, s10, v3
/*00000000005c*/ v_mov_b32       v7, s11
/*000000000060*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ v_mul_hi_u32    v0, v1, s2
/*000000000074*/ v_mul_lo_u32    v3, v1, s3
/*00000000007c*/ v_add_u32       v4, vcc, v3, v0
/*000000000080*/ v_mul_lo_u32    v3, v1, s2
/*000000000088*/ s_add_u32       s0, s7, s2
/*00000000008c*/ v_add_u32       v0, vcc, s0, v1
/*000000000090*/ v_mov_b32       v1, 0
/*000000000094*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000009c*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mul_hi_u32    v0, v2, s4
/*0000000000b4*/ v_mul_lo_u32    v1, v2, s5
/*0000000000bc*/ v_add_u32       v4, vcc, v1, v0
/*0000000000c0*/ v_mul_lo_u32    v3, v2, s4
/*0000000000c8*/ s_add_u32       s0, s8, s4
/*0000000000cc*/ v_add_u32       v0, vcc, s0, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s10, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ec*/ s_endpgm
.kernel mul_long_get_group_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s9, s6, 1
/*00000000001c*/ s_lshl_b32      s12, s7, 4
/*000000000020*/ s_lshl_b32      s13, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s9, s9, s0
/*00000000002c*/ v_add_u32       v3, vcc, s9, v0
/*000000000030*/ v_mov_b32       v0, s6
/*000000000034*/ v_mul_hi_u32    v0, v0, s0
/*00000000003c*/ s_mul_i32       s1, s6, s1
/*000000000040*/ v_add_u32       v6, vcc, s1, v0
/*000000000044*/ s_mul_i32       s0, s6, s0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v7, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000060*/ v_mov_b32       v5, s0
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ v_mov_b32       v0, s7
/*000000000070*/ v_mul_hi_u32    v0, v0, s2
/*000000000078*/ s_mul_i32       s0, s7, s3
/*00000000007c*/ v_add_u32       v4, vcc, s0, v0
/*000000000080*/ s_mul_i32       s0, s7, s2
/*000000000084*/ s_add_u32       s1, s12, s2
/*000000000088*/ v_add_u32       v0, vcc, s1, v1
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mov_b32       v0, s8
/*0000000000b0*/ v_mul_hi_u32    v0, v0, s4
/*0000000000b8*/ s_mul_i32       s0, s8, s5
/*0000000000bc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000c0*/ s_mul_i32       s0, s8, s4
/*0000000000c4*/ s_add_u32       s1, s13, s4
/*0000000000c8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000cc*/ v_mov_b32       v1, 0
/*0000000000d0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000dc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000e0*/ v_mov_b32       v2, s0
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ec*/ s_endpgm
.kernel mul_long_get_local_size_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ s_lshl_b32      s7, s7, 1
/*000000000020*/ s_lshl_b32      s8, s8, 2
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s6, s6, s0
/*00000000002c*/ v_add_u32       v3, vcc, s6, v0
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000003c*/ v_add_u32       v3, vcc, s10, v3
/*000000000040*/ v_mov_b32       v7, s11
/*000000000044*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000048*/ s_lshl_b64      s[0:1], s[0:1], 1
/*00000000004c*/ v_mov_b32       v5, s0
/*000000000050*/ v_mov_b32       v6, s1
/*000000000054*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000005c*/ s_add_u32       s0, s7, s2
/*000000000060*/ v_add_u32       v0, vcc, s0, v1
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s10, v0
/*000000000074*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000078*/ s_lshl_b64      s[0:1], s[2:3], 1
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ v_mov_b32       v4, s1
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_add_u32       s0, s8, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a8*/ s_lshl_b64      s[0:1], s[4:5], 2
/*0000000000ac*/ v_mov_b32       v2, s0
/*0000000000b0*/ v_mov_b32       v3, s1
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel mul_long_get_global_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s4, s6, 1
/*00000000001c*/ v_add_u32       v5, vcc, s4, v0
/*000000000020*/ s_lshl_b32      s4, s7, 1
/*000000000024*/ s_lshl_b32      s5, s8, 2
/*000000000028*/ v_mov_b32       v6, 0
/*00000000002c*/ v_lshlrev_b64   v[3:4], 3, v[5:6]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_add_u32       v3, vcc, s0, v3
/*00000000003c*/ v_mov_b32       v7, s1
/*000000000040*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000044*/ v_add_u32       v0, vcc, s12, v5
/*000000000048*/ v_mul_hi_u32    v5, v0, s12
/*000000000050*/ v_mul_lo_u32    v6, v0, s13
/*000000000058*/ v_add_u32       v6, vcc, v6, v5
/*00000000005c*/ v_mul_lo_u32    v5, v0, s12
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ s_add_u32       s1, s4, s14
/*000000000070*/ v_add_u32       v0, vcc, s1, v1
/*000000000074*/ v_mul_hi_u32    v1, v0, s14
/*00000000007c*/ v_mul_lo_u32    v3, v0, s15
/*000000000084*/ v_add_u32       v4, vcc, v3, v1
/*000000000088*/ v_mul_lo_u32    v3, v0, s14
/*000000000090*/ v_mov_b32       v1, 0
/*000000000094*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000009c*/ v_add_u32       v0, vcc, s0, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_add_u32       s1, s5, s2
/*0000000000b0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000b4*/ v_mul_hi_u32    v1, v0, s2
/*0000000000bc*/ v_mul_lo_u32    v2, v0, s3
/*0000000000c4*/ v_add_u32       v3, vcc, v2, v1
/*0000000000c8*/ v_mul_lo_u32    v2, v0, s2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s0, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ec*/ s_endpgm
.kernel mul_long_get_global_size_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_lshl_b32      s8, s9, 1
/*000000000030*/ s_lshl_b32      s9, s10, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ v_mov_b32       v0, s12
/*000000000044*/ v_mul_hi_u32    v0, s0, v0
/*00000000004c*/ s_mul_i32       s3, s0, s13
/*000000000050*/ v_add_u32       v6, vcc, s3, v0
/*000000000054*/ s_mul_i32       s0, s0, s12
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v7, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000070*/ v_mov_b32       v5, s0
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_mov_b32       v0, s14
/*000000000080*/ v_mul_hi_u32    v0, s1, v0
/*000000000088*/ s_mul_i32       s0, s1, s15
/*00000000008c*/ v_add_u32       v4, vcc, s0, v0
/*000000000090*/ s_mul_i32       s0, s1, s14
/*000000000094*/ s_add_u32       s1, s8, s14
/*000000000098*/ v_add_u32       v0, vcc, s1, v1
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_mov_b32       v3, s0
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ v_mov_b32       v0, s6
/*0000000000c0*/ v_mul_hi_u32    v0, s2, v0
/*0000000000c8*/ s_mul_i32       s0, s2, s7
/*0000000000cc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d0*/ s_mul_i32       s0, s2, s6
/*0000000000d4*/ s_add_u32       s1, s9, s6
/*0000000000d8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel mul_long_get_num_groups_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s8, s9, 1
/*000000000040*/ s_lshl_b32      s9, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ v_mov_b32       v0, s12
/*000000000050*/ v_mul_hi_u32    v0, s0, v0
/*000000000058*/ s_mul_i32       s3, s0, s13
/*00000000005c*/ v_add_u32       v6, vcc, s3, v0
/*000000000060*/ s_mul_i32       s0, s0, s12
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v7, s5
/*000000000078*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_mov_b32       v0, s14
/*00000000008c*/ v_mul_hi_u32    v0, s1, v0
/*000000000094*/ s_mul_i32       s0, s1, s15
/*000000000098*/ v_add_u32       v4, vcc, s0, v0
/*00000000009c*/ s_mul_i32       s0, s1, s14
/*0000000000a0*/ s_add_u32       s1, s8, s14
/*0000000000a4*/ v_add_u32       v0, vcc, s1, v1
/*0000000000a8*/ v_mov_b32       v1, 0
/*0000000000ac*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000bc*/ v_mov_b32       v3, s0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ v_mov_b32       v0, s6
/*0000000000cc*/ v_mul_hi_u32    v0, s2, v0
/*0000000000d4*/ s_mul_i32       s0, s2, s7
/*0000000000d8*/ v_add_u32       v3, vcc, s0, v0
/*0000000000dc*/ s_mul_i32       s0, s2, s6
/*0000000000e0*/ s_add_u32       s1, s9, s6
/*0000000000e4*/ v_add_u32       v0, vcc, s1, v2
/*0000000000e8*/ v_mov_b32       v1, 0
/*0000000000ec*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000f4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000fc*/ v_mov_b32       v2, s0
/*000000000100*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000108*/ s_endpgm
.kernel mul_long_get_work_dim_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s6, s9, 1
/*000000000034*/ s_lshl_b32      s7, s10, 2
/*000000000038*/ v_mov_b32       v3, s12
/*00000000003c*/ v_mul_hi_u32    v3, s0, v3
/*000000000044*/ s_mul_i32       s8, s0, s13
/*000000000048*/ v_add_u32       v6, vcc, s8, v3
/*00000000004c*/ s_mul_i32       s8, s0, s12
/*000000000050*/ s_add_u32       s1, s1, s12
/*000000000054*/ v_add_u32       v3, vcc, s1, v0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s2, v3
/*000000000068*/ v_mov_b32       v7, s3
/*00000000006c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000070*/ v_mov_b32       v5, s8
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_mov_b32       v0, s14
/*000000000080*/ v_mul_hi_u32    v0, s0, v0
/*000000000088*/ s_mul_i32       s1, s0, s15
/*00000000008c*/ v_add_u32       v4, vcc, s1, v0
/*000000000090*/ s_mul_i32       s1, s0, s14
/*000000000094*/ s_add_u32       s3, s6, s14
/*000000000098*/ v_add_u32       v0, vcc, s3, v1
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_mov_b32       v3, s1
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ v_mov_b32       v0, s4
/*0000000000c0*/ v_mul_hi_u32    v0, s0, v0
/*0000000000c8*/ s_mul_i32       s1, s0, s5
/*0000000000cc*/ v_add_u32       v3, vcc, s1, v0
/*0000000000d0*/ s_mul_i32       s0, s0, s4
/*0000000000d4*/ s_add_u32       s1, s7, s4
/*0000000000d8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel mul_long_x_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_ashr_i32      s0, s1, 31
/*000000000040*/ v_mul_hi_u32    v4, v0, s1
/*000000000048*/ v_mul_lo_u32    v5, v0, s0
/*000000000050*/ v_add_u32       v6, vcc, v5, v4
/*000000000054*/ v_mul_lo_u32    v5, v0, s1
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000068*/ v_add_u32       v3, vcc, s10, v3
/*00000000006c*/ v_mov_b32       v7, s11
/*000000000070*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_mul_hi_u32    v0, v1, s1
/*000000000084*/ v_mul_lo_u32    v3, v1, s0
/*00000000008c*/ v_add_u32       v4, vcc, v3, v0
/*000000000090*/ v_mul_lo_u32    v3, v1, s1
/*000000000098*/ s_add_u32       s2, s5, s2
/*00000000009c*/ v_add_u32       v0, vcc, s2, v1
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ v_mul_hi_u32    v0, v2, s1
/*0000000000c4*/ v_mul_lo_u32    v1, v2, s0
/*0000000000cc*/ v_add_u32       v4, vcc, v1, v0
/*0000000000d0*/ v_mul_lo_u32    v3, v2, s1
/*0000000000d8*/ s_add_u32       s0, s6, s4
/*0000000000dc*/ v_add_u32       v0, vcc, s0, v2
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s10, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000fc*/ s_endpgm
.kernel mul_long_get_global_offset_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v9, vcc, s1, v1
/*000000000038*/ v_mul_hi_u32    v6, v0, s0
/*000000000040*/ v_mul_lo_u32    v5, v0, s0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v8, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_mul_hi_u32    v4, v1, s2
/*000000000070*/ v_mul_lo_u32    v3, v1, s2
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ v_mul_hi_u32    v4, v2, s4
/*00000000009c*/ v_mul_lo_u32    v3, v2, s4
/*0000000000a4*/ s_add_u32       s0, s5, s4
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_local_id_get_local_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v5, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v3, vcc, s0, v1
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000044*/ v_mov_b32       v6, 0
/*000000000048*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*000000000050*/ v_add_u32       v5, vcc, s10, v5
/*000000000054*/ v_mov_b32       v9, s11
/*000000000058*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*00000000005c*/ v_mul_hi_u32    v8, v0, v0
/*000000000064*/ v_mul_lo_u32    v7, v0, v0
/*00000000006c*/ flat_store_dwordx2 v[5:6], v[7:8]
/*000000000074*/ v_add_u32       v6, vcc, s10, v3
/*000000000078*/ v_addc_u32      v7, vcc, v9, v4, vcc
/*00000000007c*/ v_mul_hi_u32    v4, v1, v1
/*000000000084*/ v_mul_lo_u32    v3, v1, v1
/*00000000008c*/ flat_store_dwordx2 v[6:7], v[3:4]
/*000000000094*/ s_add_u32       s0, s5, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b0*/ v_mul_hi_u32    v3, v2, v2
/*0000000000b8*/ v_mul_lo_u32    v2, v2, v2
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_group_id_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v9, vcc, s0, v1
/*000000000038*/ v_mul_hi_u32    v6, v0, s6
/*000000000040*/ v_mul_lo_u32    v5, v0, s6
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v8, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_mul_hi_u32    v4, v1, s7
/*000000000070*/ v_mul_lo_u32    v3, v1, s7
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ v_mul_hi_u32    v4, v2, s8
/*00000000009c*/ v_mul_lo_u32    v3, v2, s8
/*0000000000a4*/ s_add_u32       s0, s5, s4
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_local_size_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 10
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_lshl_b32      s5, s8, 2
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v5, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v3, vcc, s0, v1
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000044*/ v_mov_b32       v6, 0
/*000000000048*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*000000000050*/ v_add_u32       v5, vcc, s10, v5
/*000000000054*/ v_mov_b32       v9, s11
/*000000000058*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*00000000005c*/ v_lshlrev_b32   v7, 1, v0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ flat_store_dwordx2 v[5:6], v[7:8]
/*00000000006c*/ v_add_u32       v5, vcc, s10, v3
/*000000000070*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000074*/ v_lshlrev_b32   v3, 1, v1
/*000000000078*/ v_mov_b32       v4, 0
/*00000000007c*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000084*/ s_add_u32       s0, s5, s4
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000a0*/ v_lshlrev_b32   v2, 2, v2
/*0000000000a4*/ v_mov_b32       v3, 0
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b0*/ s_endpgm
.kernel mul_long_get_global_id_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v5, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_mov_b32       v6, 0
/*000000000030*/ v_lshlrev_b64   v[3:4], 3, v[5:6]
/*000000000038*/ s_add_u32       s1, s1, s2
/*00000000003c*/ v_add_u32       v9, vcc, s1, v1
/*000000000040*/ v_add_u32       v3, vcc, s10, v3
/*000000000044*/ v_mov_b32       v8, s11
/*000000000048*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000004c*/ v_add_u32       v5, vcc, s0, v5
/*000000000050*/ v_mul_hi_u32    v6, v0, v5
/*000000000058*/ v_mul_lo_u32    v5, v0, v5
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_mul_hi_u32    v4, v1, v9
/*000000000070*/ v_mul_lo_u32    v3, v1, v9
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s3, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mul_hi_u32    v3, v2, v0
/*0000000000a4*/ v_mul_lo_u32    v2, v2, v0
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_global_size_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v9, vcc, s3, v1
/*000000000048*/ v_mul_hi_u32    v6, v0, s0
/*000000000050*/ v_mul_lo_u32    v5, v0, s0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v8, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_mul_hi_u32    v4, v1, s1
/*000000000080*/ v_mul_lo_u32    v3, v1, s1
/*000000000088*/ v_mov_b32       v10, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ v_mul_hi_u32    v4, v2, s2
/*0000000000ac*/ v_mul_lo_u32    v3, v2, s2
/*0000000000b4*/ s_add_u32       s0, s8, s6
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d8*/ s_endpgm
.kernel mul_long_get_num_groups_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v9, vcc, s3, v1
/*000000000054*/ v_mul_hi_u32    v6, v0, s0
/*00000000005c*/ v_mul_lo_u32    v5, v0, s0
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v8, s5
/*000000000078*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000007c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000084*/ v_mul_hi_u32    v4, v1, s1
/*00000000008c*/ v_mul_lo_u32    v3, v1, s1
/*000000000094*/ v_mov_b32       v10, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ v_mul_hi_u32    v4, v2, s2
/*0000000000b8*/ v_mul_lo_u32    v3, v2, s2
/*0000000000c0*/ s_add_u32       s0, s8, s6
/*0000000000c4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_work_dim_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mul_hi_u32    v6, v0, s0
/*000000000048*/ v_mul_lo_u32    v5, v0, s0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s2, v3
/*000000000060*/ v_mov_b32       v7, s3
/*000000000064*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000068*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000070*/ v_mul_hi_u32    v4, v1, s0
/*000000000078*/ v_mul_lo_u32    v3, v1, s0
/*000000000080*/ s_add_u32       s1, s5, s14
/*000000000084*/ v_add_u32       v0, vcc, s1, v1
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s2, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ v_mul_hi_u32    v4, v2, s0
/*0000000000ac*/ v_mul_lo_u32    v3, v2, s0
/*0000000000b4*/ s_add_u32       s0, s6, s4
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d8*/ s_endpgm
.kernel mul_long_x_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s9, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ s_ashr_i32      s0, s1, 31
/*000000000040*/ v_mov_b32       v0, s6
/*000000000044*/ v_mul_hi_u32    v0, v0, s1
/*00000000004c*/ s_mul_i32       s3, s6, s0
/*000000000050*/ v_add_u32       v6, vcc, s3, v0
/*000000000054*/ s_mul_i32       s3, s6, s1
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s10, v3
/*000000000068*/ v_mov_b32       v7, s11
/*00000000006c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000070*/ v_mov_b32       v5, s3
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_mov_b32       v0, s7
/*000000000080*/ v_mul_hi_u32    v0, v0, s1
/*000000000088*/ s_mul_i32       s3, s7, s0
/*00000000008c*/ v_add_u32       v4, vcc, s3, v0
/*000000000090*/ s_mul_i32       s3, s7, s1
/*000000000094*/ s_add_u32       s2, s5, s2
/*000000000098*/ v_add_u32       v0, vcc, s2, v1
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_mov_b32       v3, s3
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ v_mov_b32       v0, s8
/*0000000000c0*/ v_mul_hi_u32    v0, v0, s1
/*0000000000c8*/ s_mul_i32       s0, s8, s0
/*0000000000cc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d0*/ s_mul_i32       s0, s8, s1
/*0000000000d4*/ s_add_u32       s1, s9, s4
/*0000000000d8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel mul_long_get_global_offset_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v7, vcc, s1, v1
/*000000000038*/ v_mov_b32       v1, s6
/*00000000003c*/ v_mul_hi_u32    v4, v1, s0
/*000000000044*/ s_mul_i32       s0, s6, s0
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_add_u32       v0, vcc, s10, v0
/*000000000058*/ v_mov_b32       v6, s11
/*00000000005c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000060*/ v_mov_b32       v3, s0
/*000000000064*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000006c*/ v_mov_b32       v0, s7
/*000000000070*/ v_mul_hi_u32    v4, v0, s2
/*000000000078*/ s_mul_i32       s0, s7, s2
/*00000000007c*/ v_mov_b32       v8, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000088*/ v_add_u32       v0, vcc, s10, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000090*/ v_mov_b32       v3, s0
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ v_mov_b32       v0, s8
/*0000000000a0*/ v_mul_hi_u32    v3, v0, s4
/*0000000000a8*/ s_mul_i32       s0, s8, s4
/*0000000000ac*/ s_add_u32       s1, s5, s4
/*0000000000b0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000c8*/ v_mov_b32       v2, s0
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel mul_long_get_local_id_get_group_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v9, vcc, s0, v1
/*000000000038*/ v_mul_hi_u32    v6, s6, v0
/*000000000040*/ v_mul_lo_u32    v5, s6, v0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v8, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_mul_hi_u32    v4, s7, v1
/*000000000070*/ v_mul_lo_u32    v3, s7, v1
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ v_mul_hi_u32    v4, s8, v2
/*00000000009c*/ v_mul_lo_u32    v3, s8, v2
/*0000000000a4*/ s_add_u32       s0, s5, s4
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_group_id_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v0, vcc, s0, v1
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v7, s11
/*000000000058*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000005c*/ v_mul_hi_u32    v6, s6, s6
/*000000000064*/ s_mul_i32       s0, s6, s6
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000007c*/ v_mul_hi_u32    v4, s7, s7
/*000000000084*/ s_mul_i32       s0, s7, s7
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s5, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_mul_hi_u32    v3, s8, s8
/*0000000000b8*/ s_mul_i32       s0, s8, s8
/*0000000000bc*/ v_mov_b32       v2, s0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_local_size_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_lshl_b32      s5, s8, 2
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v0, vcc, s0, v1
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v7, s11
/*000000000058*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000005c*/ s_mov_b32       s0, s6
/*000000000060*/ s_movk_i32      s1, 0x0
/*000000000064*/ s_lshl_b64      s[0:1], s[0:1], 1
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ v_mov_b32       v6, s1
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ s_mov_b32       s0, s7
/*000000000084*/ s_movk_i32      s1, 0x0
/*000000000088*/ s_lshl_b64      s[0:1], s[0:1], 1
/*00000000008c*/ v_mov_b32       v3, s0
/*000000000090*/ v_mov_b32       v4, s1
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s0, s5, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b8*/ s_movk_i32      s9, 0x0
/*0000000000bc*/ s_lshl_b64      s[0:1], s[8:9], 2
/*0000000000c0*/ v_mov_b32       v2, s0
/*0000000000c4*/ v_mov_b32       v3, s1
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d0*/ s_endpgm
.kernel mul_long_get_global_id_get_group_id
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v7, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_mov_b32       v8, 0
/*000000000030*/ v_lshlrev_b64   v[3:4], 3, v[7:8]
/*000000000038*/ s_add_u32       s1, s1, s2
/*00000000003c*/ v_add_u32       v10, vcc, s1, v1
/*000000000040*/ v_add_u32       v8, vcc, s10, v3
/*000000000044*/ v_mov_b32       v6, s11
/*000000000048*/ v_addc_u32      v9, vcc, v6, v4, vcc
/*00000000004c*/ v_add_u32       v0, vcc, s0, v7
/*000000000050*/ v_mul_hi_u32    v4, s6, v0
/*000000000058*/ v_mul_lo_u32    v3, s6, v0
/*000000000060*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000068*/ v_mul_hi_u32    v4, s7, v10
/*000000000070*/ v_mul_lo_u32    v3, s7, v10
/*000000000078*/ v_mov_b32       v11, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s3, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mul_hi_u32    v3, s8, v0
/*0000000000a4*/ v_mul_lo_u32    v2, s8, v0
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_global_size_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s11, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v7, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, s8
/*00000000004c*/ v_mul_hi_u32    v4, v1, s0
/*000000000054*/ s_mul_i32       s0, s8, s0
/*000000000058*/ v_mov_b32       v1, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000064*/ v_add_u32       v0, vcc, s4, v0
/*000000000068*/ v_mov_b32       v6, s5
/*00000000006c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000070*/ v_mov_b32       v3, s0
/*000000000074*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000007c*/ v_mov_b32       v0, s9
/*000000000080*/ v_mul_hi_u32    v4, v0, s1
/*000000000088*/ s_mul_i32       s0, s9, s1
/*00000000008c*/ v_mov_b32       v8, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000098*/ v_add_u32       v0, vcc, s4, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mov_b32       v0, s10
/*0000000000b0*/ v_mul_hi_u32    v3, v0, s2
/*0000000000b8*/ s_mul_i32       s0, s10, s2
/*0000000000bc*/ s_add_u32       s1, s11, s6
/*0000000000c0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_num_groups_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s11, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, s8
/*000000000058*/ v_mul_hi_u32    v4, v1, s0
/*000000000060*/ s_mul_i32       s0, s8, s0
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ v_mov_b32       v0, s9
/*00000000008c*/ v_mul_hi_u32    v4, v0, s1
/*000000000094*/ s_mul_i32       s0, s9, s1
/*000000000098*/ v_mov_b32       v8, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mov_b32       v0, s10
/*0000000000bc*/ v_mul_hi_u32    v3, v0, s2
/*0000000000c4*/ s_mul_i32       s0, s10, s2
/*0000000000c8*/ s_add_u32       s1, s11, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel mul_long_get_work_dim_get_group_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mov_b32       v0, s8
/*000000000044*/ v_mul_hi_u32    v6, v0, s0
/*00000000004c*/ s_mul_i32       s1, s8, s0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s2, v3
/*000000000060*/ v_mov_b32       v7, s3
/*000000000064*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000068*/ v_mov_b32       v5, s1
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ v_mov_b32       v0, s9
/*000000000078*/ v_mul_hi_u32    v4, v0, s0
/*000000000080*/ s_mul_i32       s1, s9, s0
/*000000000084*/ s_add_u32       s3, s5, s14
/*000000000088*/ v_add_u32       v0, vcc, s3, v1
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s2, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s1
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mov_b32       v0, s10
/*0000000000b0*/ v_mul_hi_u32    v3, v0, s0
/*0000000000b8*/ s_mul_i32       s0, s10, s0
/*0000000000bc*/ s_add_u32       s1, s6, s4
/*0000000000c0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_x_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*000000000010*/ s_load_dword    s12, s[4:5], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s5, s7, 1
/*00000000002c*/ s_lshl_b32      s6, s8, 1
/*000000000030*/ s_add_u32       s0, s3, s0
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000044*/ v_add_u32       v3, vcc, s10, v3
/*000000000048*/ v_mov_b32       v7, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000050*/ s_ashr_i32      s13, s12, 31
/*000000000054*/ s_lshl_b64      s[8:9], s[12:13], 4
/*000000000058*/ v_mov_b32       v5, s8
/*00000000005c*/ v_mov_b32       v6, s9
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ s_add_u32       s2, s5, s2
/*00000000006c*/ v_add_u32       v0, vcc, s2, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000084*/ s_lshl_b64      s[0:1], s[12:13], 1
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ v_mov_b32       v4, s1
/*000000000090*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000098*/ s_add_u32       s0, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ s_endpgm
.kernel mul_long_get_global_offset_get_local_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ s_lshl_b32      s7, s7, 4
/*000000000020*/ s_lshl_b32      s8, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_add_u32       s6, s6, s0
/*00000000002c*/ v_add_u32       v0, vcc, s6, v0
/*000000000030*/ s_add_u32       s6, s7, s2
/*000000000034*/ v_add_u32       v7, vcc, s6, v1
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000044*/ v_add_u32       v0, vcc, s10, v0
/*000000000048*/ v_mov_b32       v6, s11
/*00000000004c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000050*/ s_lshl_b64      s[0:1], s[0:1], 1
/*000000000054*/ s_and_b32       s0, s0, -2
/*000000000058*/ s_and_b32       s1, s1, 1
/*00000000005c*/ v_mov_b32       v3, s0
/*000000000060*/ v_mov_b32       v4, s1
/*000000000064*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000006c*/ v_mov_b32       v8, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ s_lshl_b64      s[0:1], s[2:3], 4
/*000000000084*/ s_and_b32       s0, s0, -16
/*000000000088*/ s_and_b32       s1, s1, 15
/*00000000008c*/ v_mov_b32       v3, s0
/*000000000090*/ v_mov_b32       v4, s1
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s0, s8, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ s_lshl_b64      s[0:1], s[4:5], 1
/*0000000000bc*/ s_and_b32       s0, s0, -2
/*0000000000c0*/ s_and_b32       s1, s1, 1
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel mul_long_get_local_id_get_local_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v5, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v3, vcc, s0, v1
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000044*/ v_mov_b32       v6, 0
/*000000000048*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*000000000050*/ v_add_u32       v5, vcc, s10, v5
/*000000000054*/ v_mov_b32       v9, s11
/*000000000058*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*00000000005c*/ v_lshlrev_b32   v7, 3, v0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ flat_store_dwordx2 v[5:6], v[7:8]
/*00000000006c*/ v_add_u32       v5, vcc, s10, v3
/*000000000070*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000074*/ v_lshlrev_b32   v3, 2, v1
/*000000000078*/ v_mov_b32       v4, 0
/*00000000007c*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000084*/ s_add_u32       s0, s5, s4
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000a0*/ v_lshlrev_b32   v2, 1, v2
/*0000000000a4*/ v_mov_b32       v3, 0
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b0*/ s_endpgm
.kernel mul_long_get_group_id_get_local_size
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v0, vcc, s0, v1
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v7, s11
/*000000000058*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000005c*/ s_mov_b32       s0, s6
/*000000000060*/ s_movk_i32      s1, 0x0
/*000000000064*/ s_lshl_b64      s[0:1], s[0:1], 1
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ v_mov_b32       v6, s1
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ s_mov_b32       s0, s7
/*000000000084*/ s_movk_i32      s1, 0x0
/*000000000088*/ s_lshl_b64      s[0:1], s[0:1], 4
/*00000000008c*/ v_mov_b32       v3, s0
/*000000000090*/ v_mov_b32       v4, s1
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s0, s5, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b8*/ s_movk_i32      s9, 0x0
/*0000000000bc*/ s_lshl_b64      s[0:1], s[8:9], 1
/*0000000000c0*/ v_mov_b32       v2, s0
/*0000000000c4*/ v_mov_b32       v3, s1
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d0*/ s_endpgm
.kernel mul_long_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 15
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
        .arg data, "ulong*", ulong*, global, 
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
/*000000000034*/ v_add_u32       v7, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000048*/ v_add_u32       v9, vcc, s0, v2
/*00000000004c*/ v_add_u32       v11, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v12, vcc, v3, v4, vcc
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 4
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v13, vcc, s4, v8
/*000000000084*/ v_addc_u32      v14, vcc, v3, v9, vcc
/*000000000088*/ v_lshlrev_b64   v[8:9], 0, 16
/*000000000090*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[1:2], v[5:6]
/*0000000000a0*/ flat_store_dwordx2 v[13:14], v[8:9]
/*0000000000a8*/ s_endpgm
.kernel mul_long_get_global_id_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 18
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s3, s6, 1
/*000000000020*/ v_add_u32       v5, vcc, s3, v0
/*000000000024*/ s_lshl_b32      s3, s7, 1
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, v5, s0
/*000000000034*/ v_mov_b32       v4, s1
/*000000000038*/ v_addc_u32      v4, vcc, 0, v4, vcc
/*00000000003c*/ s_add_u32       s0, s3, s2
/*000000000040*/ v_add_u32       v7, vcc, s0, v1
/*000000000044*/ s_add_u32       s0, s6, s10
/*000000000048*/ v_mov_b32       v6, 0
/*00000000004c*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*000000000054*/ v_add_u32       v14, vcc, s0, v2
/*000000000058*/ v_add_u32       v16, vcc, s4, v5
/*00000000005c*/ v_mov_b32       v5, s5
/*000000000060*/ v_addc_u32      v17, vcc, v5, v6, vcc
/*000000000064*/ v_lshlrev_b64   v[3:4], 1, v[3:4]
/*00000000006c*/ v_mov_b32       v8, 0
/*000000000070*/ v_lshlrev_b64   v[9:10], 3, v[7:8]
/*000000000078*/ v_and_b32       v1, -2, v3
/*00000000007c*/ v_and_b32       v2, 1, v4
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v5, v10, vcc
/*000000000088*/ v_lshlrev_b64   v[7:8], 1, v[7:8]
/*000000000090*/ v_mov_b32       v15, 0
/*000000000094*/ v_lshlrev_b64   v[12:13], 3, v[14:15]
/*00000000009c*/ v_add_u32       v12, vcc, s4, v12
/*0000000000a0*/ v_addc_u32      v13, vcc, v5, v13, vcc
/*0000000000a4*/ v_lshlrev_b64   v[10:11], 2, v[14:15]
/*0000000000ac*/ flat_store_dwordx2 v[16:17], v[1:2]
/*0000000000b4*/ flat_store_dwordx2 v[3:4], v[7:8]
/*0000000000bc*/ flat_store_dwordx2 v[12:13], v[10:11]
/*0000000000c4*/ s_endpgm
.kernel mul_long_get_global_size_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v0, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v7, s5
/*000000000068*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000006c*/ s_mov_b32       s10, s0
/*000000000070*/ s_movk_i32      s11, 0x0
/*000000000074*/ s_lshl_b64      s[10:11], s[10:11], 4
/*000000000078*/ v_mov_b32       v5, s10
/*00000000007c*/ v_mov_b32       v6, s11
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_mov_b32       s0, s1
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_lshl_b64      s[0:1], s[0:1], 1
/*00000000009c*/ v_mov_b32       v3, s0
/*0000000000a0*/ v_mov_b32       v4, s1
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_add_u32       s0, s8, s6
/*0000000000b0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_lshl_b64      s[0:1], s[2:3], 1
/*0000000000d0*/ v_mov_b32       v2, s0
/*0000000000d4*/ v_mov_b32       v3, s1
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel mul_long_get_num_groups_get_local_size
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 1
/*000000000030*/ s_lshr_b32      s0, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v0, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, 0
/*000000000058*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v7, s5
/*000000000074*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000078*/ s_movk_i32      s17, 0x0
/*00000000007c*/ s_lshl_b64      s[10:11], s[16:17], 1
/*000000000080*/ v_mov_b32       v5, s10
/*000000000084*/ v_mov_b32       v6, s11
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ s_movk_i32      s1, 0x0
/*00000000009c*/ s_lshl_b64      s[0:1], s[0:1], 1
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ v_mov_b32       v4, s1
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s8, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ s_movk_i32      s3, 0x0
/*0000000000d0*/ s_lshl_b64      s[0:1], s[2:3], 2
/*0000000000d4*/ v_mov_b32       v2, s0
/*0000000000d8*/ v_mov_b32       v3, s1
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_work_dim_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s2, v3
/*000000000050*/ v_mov_b32       v7, s3
/*000000000054*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000058*/ s_movk_i32      s1, 0x0
/*00000000005c*/ s_lshl_b64      s[8:9], s[0:1], 1
/*000000000060*/ v_mov_b32       v5, s8
/*000000000064*/ v_mov_b32       v6, s9
/*000000000068*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000070*/ s_add_u32       s3, s5, s14
/*000000000074*/ v_add_u32       v0, vcc, s3, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s2, v0
/*000000000088*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[5:6]
/*000000000094*/ s_add_u32       s3, s6, s4
/*000000000098*/ v_add_u32       v0, vcc, s3, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ s_lshl_b64      s[0:1], s[0:1], 2
/*0000000000b4*/ v_mov_b32       v2, s0
/*0000000000b8*/ v_mov_b32       v3, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c4*/ s_endpgm
.kernel mul_long_x_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dword    s9, s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_lshl_b32      s6, s6, 4
/*000000000024*/ v_add_u32       v0, vcc, s6, v0
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ v_add_u32       v4, vcc, s6, v1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ v_add_u32       v5, vcc, s6, v2
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ v_add_u32       v1, vcc, v0, s0
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*00000000004c*/ s_ashr_i32      s1, s9, 31
/*000000000050*/ v_add_u32       v6, vcc, v4, s2
/*000000000058*/ v_mov_b32       v3, s3
/*00000000005c*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000060*/ v_mul_hi_u32    v3, v1, s9
/*000000000068*/ v_mul_lo_u32    v2, v2, s9
/*000000000070*/ v_add_u32       v2, vcc, v2, v3
/*000000000074*/ v_mul_lo_u32    v3, v1, s1
/*00000000007c*/ v_add_u32       v3, vcc, v3, v2
/*000000000080*/ v_mul_lo_u32    v2, v1, s9
/*000000000088*/ v_add_u32       v0, vcc, s0, v0
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_mov_b32       v8, s11
/*0000000000a0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ac*/ v_mul_hi_u32    v0, v6, s9
/*0000000000b4*/ v_mul_lo_u32    v1, v7, s9
/*0000000000bc*/ v_add_u32       v0, vcc, v1, v0
/*0000000000c0*/ v_mul_lo_u32    v1, v6, s1
/*0000000000c8*/ v_add_u32       v3, vcc, v1, v0
/*0000000000cc*/ v_mul_lo_u32    v2, v6, s9
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v4
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s10, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000ec*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f4*/ v_add_u32       v0, vcc, v5, s4
/*0000000000fc*/ v_mov_b32       v1, s5
/*000000000100*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*000000000104*/ v_mul_hi_u32    v2, v0, s9
/*00000000010c*/ v_mul_lo_u32    v1, v1, s9
/*000000000114*/ v_add_u32       v1, vcc, v1, v2
/*000000000118*/ v_mul_lo_u32    v2, v0, s1
/*000000000120*/ v_add_u32       v3, vcc, v2, v1
/*000000000124*/ v_mul_lo_u32    v2, v0, s9
/*00000000012c*/ v_add_u32       v0, vcc, s4, v5
/*000000000130*/ v_mov_b32       v1, 0
/*000000000134*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000013c*/ v_add_u32       v0, vcc, s10, v0
/*000000000140*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000144*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000014c*/ s_endpgm
.kernel mul_long_get_global_offset_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ v_add_u32       v0, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 4
/*000000000024*/ v_add_u32       v4, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v5, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v1, vcc, v0, s0
/*00000000003c*/ v_mov_b32       v2, s1
/*000000000040*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*000000000044*/ v_add_u32       v6, vcc, v4, s2
/*00000000004c*/ v_mov_b32       v3, s3
/*000000000050*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000054*/ v_mul_hi_u32    v3, v1, s0
/*00000000005c*/ v_mul_lo_u32    v2, v2, s0
/*000000000064*/ v_add_u32       v3, vcc, v2, v3
/*000000000068*/ v_mul_lo_u32    v2, v1, s0
/*000000000070*/ v_add_u32       v0, vcc, s0, v0
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_mov_b32       v8, s11
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000094*/ v_mul_hi_u32    v0, v6, s2
/*00000000009c*/ v_mul_lo_u32    v1, v7, s2
/*0000000000a4*/ v_add_u32       v3, vcc, v1, v0
/*0000000000a8*/ v_mul_lo_u32    v2, v6, s2
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v4
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d0*/ v_add_u32       v0, vcc, v5, s4
/*0000000000d8*/ v_mov_b32       v1, s5
/*0000000000dc*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000e0*/ v_mul_hi_u32    v2, v0, s4
/*0000000000e8*/ v_mul_lo_u32    v1, v1, s4
/*0000000000f0*/ v_add_u32       v3, vcc, v1, v2
/*0000000000f4*/ v_mul_lo_u32    v2, v0, s4
/*0000000000fc*/ v_add_u32       v0, vcc, s4, v5
/*000000000100*/ v_mov_b32       v1, 0
/*000000000104*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000010c*/ v_add_u32       v0, vcc, s10, v0
/*000000000110*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000114*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000011c*/ s_endpgm
.kernel mul_long_get_local_id_get_global_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
        .vgprsnum 13
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 3
/*00000000001c*/ v_add_u32       v3, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 2
/*000000000024*/ v_add_u32       v7, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v8, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v11, vcc, s0, v3
/*000000000038*/ v_add_u32       v3, vcc, v3, s0
/*000000000040*/ v_mov_b32       v5, s1
/*000000000044*/ v_addc_u32      v5, vcc, 0, v5, vcc
/*000000000048*/ v_add_u32       v9, vcc, v7, s2
/*000000000050*/ v_mov_b32       v6, s3
/*000000000054*/ v_addc_u32      v10, vcc, 0, v6, vcc
/*000000000058*/ v_mul_hi_u32    v6, v0, v3
/*000000000060*/ v_mul_lo_u32    v5, v0, v5
/*000000000068*/ v_add_u32       v6, vcc, v5, v6
/*00000000006c*/ v_mul_lo_u32    v5, v0, v3
/*000000000074*/ v_mov_b32       v12, 0
/*000000000078*/ v_lshlrev_b64   v[3:4], 3, v[11:12]
/*000000000080*/ v_add_u32       v3, vcc, s10, v3
/*000000000084*/ v_mov_b32       v11, s11
/*000000000088*/ v_addc_u32      v4, vcc, v11, v4, vcc
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_mul_hi_u32    v0, v1, v9
/*00000000009c*/ v_mul_lo_u32    v3, v1, v10
/*0000000000a4*/ v_add_u32       v4, vcc, v3, v0
/*0000000000a8*/ v_mul_lo_u32    v3, v1, v9
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v7
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v11, v1, vcc
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d0*/ v_add_u32       v0, vcc, v8, s4
/*0000000000d8*/ v_mov_b32       v1, s5
/*0000000000dc*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000e0*/ v_mul_hi_u32    v3, v2, v0
/*0000000000e8*/ v_mul_lo_u32    v1, v2, v1
/*0000000000f0*/ v_add_u32       v3, vcc, v1, v3
/*0000000000f4*/ v_mul_lo_u32    v2, v2, v0
/*0000000000fc*/ v_add_u32       v0, vcc, s4, v8
/*000000000100*/ v_mov_b32       v1, 0
/*000000000104*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000010c*/ v_add_u32       v0, vcc, s10, v0
/*000000000110*/ v_addc_u32      v1, vcc, v11, v1, vcc
/*000000000114*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000011c*/ s_endpgm
.kernel mul_long_get_group_id_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s9, s6, 1
/*00000000001c*/ v_add_u32       v0, vcc, s9, v0
/*000000000020*/ s_lshl_b32      s9, s7, 4
/*000000000024*/ v_add_u32       v4, vcc, s9, v1
/*000000000028*/ s_lshl_b32      s9, s8, 1
/*00000000002c*/ v_add_u32       v5, vcc, s9, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v8, vcc, s0, v0
/*000000000038*/ v_add_u32       v0, vcc, v0, s0
/*000000000040*/ v_mov_b32       v2, s1
/*000000000044*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*000000000048*/ v_add_u32       v6, vcc, v4, s2
/*000000000050*/ v_mov_b32       v3, s3
/*000000000054*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000058*/ v_mul_hi_u32    v3, s6, v0
/*000000000060*/ v_mul_lo_u32    v2, s6, v2
/*000000000068*/ v_add_u32       v3, vcc, v2, v3
/*00000000006c*/ v_mul_lo_u32    v2, s6, v0
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_mov_b32       v8, s11
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000094*/ v_mul_hi_u32    v0, s7, v6
/*00000000009c*/ v_mul_lo_u32    v1, s7, v7
/*0000000000a4*/ v_add_u32       v3, vcc, v1, v0
/*0000000000a8*/ v_mul_lo_u32    v2, s7, v6
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v4
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d0*/ v_add_u32       v0, vcc, v5, s4
/*0000000000d8*/ v_mov_b32       v1, s5
/*0000000000dc*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000e0*/ v_mul_hi_u32    v2, s8, v0
/*0000000000e8*/ v_mul_lo_u32    v1, s8, v1
/*0000000000f0*/ v_add_u32       v3, vcc, v1, v2
/*0000000000f4*/ v_mul_lo_u32    v2, s8, v0
/*0000000000fc*/ v_add_u32       v0, vcc, s4, v5
/*000000000100*/ v_mov_b32       v1, 0
/*000000000104*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000010c*/ v_add_u32       v0, vcc, s10, v0
/*000000000110*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000114*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000011c*/ s_endpgm
.kernel mul_long_get_local_size_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ v_add_u32       v0, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 1
/*000000000024*/ v_add_u32       v1, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ v_add_u32       v9, vcc, s0, v0
/*000000000034*/ v_add_u32       v4, vcc, v0, s0
/*00000000003c*/ v_mov_b32       v0, s1
/*000000000040*/ v_addc_u32      v5, vcc, 0, v0, vcc
/*000000000044*/ v_add_u32       v2, vcc, s6, v2
/*000000000048*/ v_add_u32       v12, vcc, s2, v1
/*00000000004c*/ v_add_u32       v7, vcc, v1, s2
/*000000000054*/ v_mov_b32       v0, s3
/*000000000058*/ v_addc_u32      v8, vcc, 0, v0, vcc
/*00000000005c*/ v_mov_b32       v10, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000068*/ v_add_u32       v16, vcc, s10, v2
/*00000000006c*/ v_add_u32       v10, vcc, v2, s10
/*000000000074*/ v_mov_b32       v2, s11
/*000000000078*/ v_addc_u32      v11, vcc, 0, v2, vcc
/*00000000007c*/ v_mov_b32       v13, 0
/*000000000080*/ v_lshlrev_b64   v[2:3], 3, v[12:13]
/*000000000088*/ v_add_u32       v18, vcc, s4, v0
/*00000000008c*/ v_mov_b32       v12, s5
/*000000000090*/ v_addc_u32      v19, vcc, v12, v1, vcc
/*000000000094*/ v_lshlrev_b64   v[0:1], 1, v[4:5]
/*00000000009c*/ v_add_u32       v13, vcc, s4, v2
/*0000000000a0*/ v_addc_u32      v14, vcc, v12, v3, vcc
/*0000000000a4*/ v_lshlrev_b64   v[2:3], 1, v[7:8]
/*0000000000ac*/ v_mov_b32       v17, 0
/*0000000000b0*/ v_lshlrev_b64   v[4:5], 3, v[16:17]
/*0000000000b8*/ v_add_u32       v6, vcc, s4, v4
/*0000000000bc*/ v_addc_u32      v7, vcc, v12, v5, vcc
/*0000000000c0*/ v_lshlrev_b64   v[4:5], 2, v[10:11]
/*0000000000c8*/ flat_store_dwordx2 v[18:19], v[0:1]
/*0000000000d0*/ flat_store_dwordx2 v[13:14], v[2:3]
/*0000000000d8*/ flat_store_dwordx2 v[6:7], v[4:5]
/*0000000000e0*/ s_endpgm
.kernel mul_long_get_global_id_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ v_add_u32       v7, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 1
/*000000000024*/ v_add_u32       v1, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v2, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v3, vcc, v7, s0
/*00000000003c*/ v_mov_b32       v4, s1
/*000000000040*/ v_addc_u32      v4, vcc, 0, v4, vcc
/*000000000044*/ v_add_u32       v5, vcc, s0, v7
/*000000000048*/ v_mul_hi_u32    v6, v5, v3
/*000000000050*/ v_mul_lo_u32    v4, v5, v4
/*000000000058*/ v_add_u32       v4, vcc, v4, v6
/*00000000005c*/ v_mul_lo_u32    v3, v5, v3
/*000000000064*/ v_mov_b32       v8, 0
/*000000000068*/ v_lshlrev_b64   v[5:6], 3, v[7:8]
/*000000000070*/ v_add_u32       v7, vcc, s10, v5
/*000000000074*/ v_mov_b32       v5, s11
/*000000000078*/ v_addc_u32      v8, vcc, v5, v6, vcc
/*00000000007c*/ flat_store_dwordx2 v[7:8], v[3:4]
/*000000000084*/ v_add_u32       v0, vcc, v1, s2
/*00000000008c*/ v_mov_b32       v3, s3
/*000000000090*/ v_addc_u32      v3, vcc, 0, v3, vcc
/*000000000094*/ v_add_u32       v6, vcc, s2, v1
/*000000000098*/ v_mul_hi_u32    v4, v6, v0
/*0000000000a0*/ v_mul_lo_u32    v3, v6, v3
/*0000000000a8*/ v_add_u32       v1, vcc, v3, v4
/*0000000000ac*/ v_mul_lo_u32    v0, v6, v0
/*0000000000b4*/ v_mov_b32       v7, 0
/*0000000000b8*/ v_lshlrev_b64   v[6:7], 3, v[6:7]
/*0000000000c0*/ v_add_u32       v6, vcc, s10, v6
/*0000000000c4*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*0000000000c8*/ flat_store_dwordx2 v[6:7], v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, v2, s4
/*0000000000d8*/ v_mov_b32       v1, s5
/*0000000000dc*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000e0*/ v_add_u32       v2, vcc, s4, v2
/*0000000000e4*/ v_mul_hi_u32    v3, v2, v0
/*0000000000ec*/ v_mul_lo_u32    v1, v2, v1
/*0000000000f4*/ v_add_u32       v1, vcc, v1, v3
/*0000000000f8*/ v_mul_lo_u32    v0, v2, v0
/*000000000100*/ v_mov_b32       v3, 0
/*000000000104*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*00000000010c*/ v_add_u32       v2, vcc, s10, v2
/*000000000110*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*000000000114*/ flat_store_dwordx2 v[2:3], v[0:1]
/*00000000011c*/ s_endpgm
.kernel mul_long_get_global_size_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ v_add_u32       v0, vcc, s3, v0
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ v_add_u32       v4, vcc, s3, v1
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ v_add_u32       v5, vcc, s3, v2
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_add_u32       v8, vcc, s12, v0
/*000000000048*/ v_add_u32       v0, vcc, v0, s12
/*000000000050*/ v_mov_b32       v2, s13
/*000000000054*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*000000000058*/ v_add_u32       v6, vcc, v4, s14
/*000000000060*/ v_mov_b32       v3, s15
/*000000000064*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000068*/ v_mul_hi_u32    v3, s0, v0
/*000000000070*/ v_mul_lo_u32    v2, s0, v2
/*000000000078*/ v_add_u32       v3, vcc, v2, v3
/*00000000007c*/ v_mul_lo_u32    v2, s0, v0
/*000000000084*/ v_mov_b32       v9, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_mov_b32       v8, s5
/*000000000098*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000a4*/ v_mul_hi_u32    v0, s1, v6
/*0000000000ac*/ v_mul_lo_u32    v1, s1, v7
/*0000000000b4*/ v_add_u32       v3, vcc, v1, v0
/*0000000000b8*/ v_mul_lo_u32    v2, s1, v6
/*0000000000c0*/ v_add_u32       v0, vcc, s14, v4
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ v_add_u32       v0, vcc, v5, s6
/*0000000000e8*/ v_mov_b32       v1, s7
/*0000000000ec*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000f0*/ v_mul_hi_u32    v2, s2, v0
/*0000000000f8*/ v_mul_lo_u32    v1, s2, v1
/*000000000100*/ v_add_u32       v3, vcc, v1, v2
/*000000000104*/ v_mul_lo_u32    v2, s2, v0
/*00000000010c*/ v_add_u32       v0, vcc, s6, v5
/*000000000110*/ v_mov_b32       v1, 0
/*000000000114*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000011c*/ v_add_u32       v0, vcc, s4, v0
/*000000000120*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000124*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000012c*/ s_endpgm
.kernel mul_long_get_num_groups_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 10
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_lshl_b32      s3, s9, 1
/*000000000044*/ v_add_u32       v4, vcc, s3, v1
/*000000000048*/ s_lshl_b32      s3, s10, 2
/*00000000004c*/ v_add_u32       v5, vcc, s3, v2
/*000000000050*/ v_add_u32       v8, vcc, s12, v0
/*000000000054*/ v_add_u32       v0, vcc, v0, s12
/*00000000005c*/ v_mov_b32       v2, s13
/*000000000060*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*000000000064*/ v_add_u32       v6, vcc, v4, s14
/*00000000006c*/ v_mov_b32       v3, s15
/*000000000070*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000074*/ v_mul_hi_u32    v3, s0, v0
/*00000000007c*/ v_mul_lo_u32    v2, s0, v2
/*000000000084*/ v_add_u32       v3, vcc, v2, v3
/*000000000088*/ v_mul_lo_u32    v2, s0, v0
/*000000000090*/ v_mov_b32       v9, 0
/*000000000094*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*00000000009c*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a0*/ v_mov_b32       v8, s5
/*0000000000a4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b0*/ v_mul_hi_u32    v0, s1, v6
/*0000000000b8*/ v_mul_lo_u32    v1, s1, v7
/*0000000000c0*/ v_add_u32       v3, vcc, v1, v0
/*0000000000c4*/ v_mul_lo_u32    v2, s1, v6
/*0000000000cc*/ v_add_u32       v0, vcc, s14, v4
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ec*/ v_add_u32       v0, vcc, v5, s6
/*0000000000f4*/ v_mov_b32       v1, s7
/*0000000000f8*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000fc*/ v_mul_hi_u32    v2, s2, v0
/*000000000104*/ v_mul_lo_u32    v1, s2, v1
/*00000000010c*/ v_add_u32       v3, vcc, v1, v2
/*000000000110*/ v_mul_lo_u32    v2, s2, v0
/*000000000118*/ v_add_u32       v0, vcc, s6, v5
/*00000000011c*/ v_mov_b32       v1, 0
/*000000000120*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000128*/ v_add_u32       v0, vcc, s4, v0
/*00000000012c*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000130*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000138*/ s_endpgm
.kernel mul_long_get_work_dim_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ v_add_u32       v0, vcc, s1, v0
/*000000000034*/ s_lshl_b32      s1, s9, 1
/*000000000038*/ v_add_u32       v4, vcc, s1, v1
/*00000000003c*/ s_lshl_b32      s1, s10, 2
/*000000000040*/ v_add_u32       v5, vcc, s1, v2
/*000000000044*/ v_add_u32       v1, vcc, v0, s12
/*00000000004c*/ v_mov_b32       v2, s13
/*000000000050*/ v_addc_u32      v2, vcc, 0, v2, vcc
/*000000000054*/ v_add_u32       v6, vcc, v4, s14
/*00000000005c*/ v_mov_b32       v3, s15
/*000000000060*/ v_addc_u32      v7, vcc, 0, v3, vcc
/*000000000064*/ v_mul_hi_u32    v3, s0, v1
/*00000000006c*/ v_mul_lo_u32    v2, s0, v2
/*000000000074*/ v_add_u32       v3, vcc, v2, v3
/*000000000078*/ v_mul_lo_u32    v2, s0, v1
/*000000000080*/ v_add_u32       v0, vcc, s12, v0
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s2, v0
/*000000000094*/ v_mov_b32       v8, s3
/*000000000098*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000a4*/ v_mul_hi_u32    v0, s0, v6
/*0000000000ac*/ v_mul_lo_u32    v1, s0, v7
/*0000000000b4*/ v_add_u32       v3, vcc, v1, v0
/*0000000000b8*/ v_mul_lo_u32    v2, s0, v6
/*0000000000c0*/ v_add_u32       v0, vcc, s14, v4
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ v_add_u32       v0, vcc, v5, s4
/*0000000000e8*/ v_mov_b32       v1, s5
/*0000000000ec*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000f0*/ v_mul_hi_u32    v2, s0, v0
/*0000000000f8*/ v_mul_lo_u32    v1, s0, v1
/*000000000100*/ v_add_u32       v3, vcc, v1, v2
/*000000000104*/ v_mul_lo_u32    v2, s0, v0
/*00000000010c*/ v_add_u32       v0, vcc, s4, v5
/*000000000110*/ v_mov_b32       v1, 0
/*000000000114*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000011c*/ v_add_u32       v0, vcc, s2, v0
/*000000000120*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000124*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000012c*/ s_endpgm
.kernel mul_long_x_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s7, s8, 4
/*000000000038*/ s_lshl_b32      s8, s9, 1
/*00000000003c*/ s_lshl_b32      s9, s10, 1
/*000000000040*/ s_add_u32       s7, s7, s12
/*000000000044*/ v_add_u32       v3, vcc, s7, v0
/*000000000048*/ s_ashr_i32      s7, s3, 31
/*00000000004c*/ v_mov_b32       v7, s3
/*000000000050*/ v_mul_hi_u32    v0, s0, v7
/*000000000058*/ s_mul_i32       s10, s0, s7
/*00000000005c*/ v_add_u32       v6, vcc, s10, v0
/*000000000060*/ s_mul_i32       s0, s0, s3
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v8, s5
/*000000000078*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_mul_hi_u32    v0, s1, v7
/*000000000090*/ s_mul_i32       s0, s1, s7
/*000000000094*/ v_add_u32       v4, vcc, s0, v0
/*000000000098*/ s_mul_i32       s0, s1, s3
/*00000000009c*/ s_add_u32       s1, s8, s14
/*0000000000a0*/ v_add_u32       v0, vcc, s1, v1
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b8*/ v_mov_b32       v3, s0
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ v_mul_hi_u32    v0, s2, v7
/*0000000000cc*/ s_mul_i32       s0, s2, s7
/*0000000000d0*/ v_add_u32       v3, vcc, s0, v0
/*0000000000d4*/ s_mul_i32       s0, s2, s3
/*0000000000d8*/ s_add_u32       s1, s9, s6
/*0000000000dc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000f4*/ v_mov_b32       v2, s0
/*0000000000f8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000100*/ s_endpgm
.kernel mul_long_get_global_offset_get_global_size
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 4
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v7, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, s12
/*00000000004c*/ v_mul_hi_u32    v4, s0, v1
/*000000000054*/ s_mul_i32       s0, s0, s12
/*000000000058*/ v_mov_b32       v1, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000064*/ v_add_u32       v0, vcc, s4, v0
/*000000000068*/ v_mov_b32       v6, s5
/*00000000006c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000070*/ v_mov_b32       v3, s0
/*000000000074*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000007c*/ v_mov_b32       v0, s14
/*000000000080*/ v_mul_hi_u32    v4, s1, v0
/*000000000088*/ s_mul_i32       s0, s1, s14
/*00000000008c*/ v_mov_b32       v8, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000098*/ v_add_u32       v0, vcc, s4, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mov_b32       v0, s6
/*0000000000b0*/ v_mul_hi_u32    v3, s2, v0
/*0000000000b8*/ s_mul_i32       s0, s2, s6
/*0000000000bc*/ s_add_u32       s1, s8, s6
/*0000000000c0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_local_id_get_global_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 3
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 2
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v9, vcc, s3, v1
/*000000000048*/ v_mul_hi_u32    v6, s0, v0
/*000000000050*/ v_mul_lo_u32    v5, s0, v0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v8, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_mul_hi_u32    v4, s1, v1
/*000000000080*/ v_mul_lo_u32    v3, s1, v1
/*000000000088*/ v_mov_b32       v10, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ v_mul_hi_u32    v4, s2, v2
/*0000000000ac*/ v_mul_lo_u32    v3, s2, v2
/*0000000000b4*/ s_add_u32       s0, s8, s6
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d8*/ s_endpgm
.kernel mul_long_get_group_id_get_global_size
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 4
/*000000000034*/ s_lshl_b32      s11, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v7, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, s8
/*00000000004c*/ v_mul_hi_u32    v4, s0, v1
/*000000000054*/ s_mul_i32       s0, s0, s8
/*000000000058*/ v_mov_b32       v1, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000064*/ v_add_u32       v0, vcc, s4, v0
/*000000000068*/ v_mov_b32       v6, s5
/*00000000006c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000070*/ v_mov_b32       v3, s0
/*000000000074*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000007c*/ v_mov_b32       v0, s9
/*000000000080*/ v_mul_hi_u32    v4, s1, v0
/*000000000088*/ s_mul_i32       s0, s1, s9
/*00000000008c*/ v_mov_b32       v8, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000098*/ v_add_u32       v0, vcc, s4, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ v_mov_b32       v0, s10
/*0000000000b0*/ v_mul_hi_u32    v3, s2, v0
/*0000000000b8*/ s_mul_i32       s0, s2, s10
/*0000000000bc*/ s_add_u32       s1, s11, s6
/*0000000000c0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_local_size_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 2
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v0, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v7, s5
/*000000000068*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000006c*/ s_mov_b32       s10, s0
/*000000000070*/ s_movk_i32      s11, 0x0
/*000000000074*/ s_lshl_b64      s[10:11], s[10:11], 1
/*000000000078*/ v_mov_b32       v5, s10
/*00000000007c*/ v_mov_b32       v6, s11
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_mov_b32       s0, s1
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_lshl_b64      s[0:1], s[0:1], 1
/*00000000009c*/ v_mov_b32       v3, s0
/*0000000000a0*/ v_mov_b32       v4, s1
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_add_u32       s0, s8, s6
/*0000000000b0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_lshl_b64      s[0:1], s[2:3], 2
/*0000000000d0*/ v_mov_b32       v2, s0
/*0000000000d4*/ v_mov_b32       v3, s1
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel mul_long_get_global_id_get_global_size
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ v_add_u32       v7, vcc, s3, v0
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshl_b32      s7, s10, 2
/*00000000003c*/ v_mov_b32       v8, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[7:8]
/*000000000048*/ s_add_u32       s3, s3, s14
/*00000000004c*/ v_add_u32       v10, vcc, s3, v1
/*000000000050*/ v_add_u32       v8, vcc, s4, v3
/*000000000054*/ v_mov_b32       v6, s5
/*000000000058*/ v_addc_u32      v9, vcc, v6, v4, vcc
/*00000000005c*/ v_add_u32       v0, vcc, s12, v7
/*000000000060*/ v_mul_hi_u32    v4, s0, v0
/*000000000068*/ v_mul_lo_u32    v3, s0, v0
/*000000000070*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000078*/ v_mul_hi_u32    v4, s1, v10
/*000000000080*/ v_mul_lo_u32    v3, s1, v10
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ s_add_u32       s0, s7, s6
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mul_hi_u32    v3, s2, v0
/*0000000000b4*/ v_mul_lo_u32    v2, s2, v0
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d8*/ s_endpgm
.kernel mul_long_get_global_size_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v3, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s7, s14
/*000000000044*/ v_add_u32       v0, vcc, s3, v1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v7, s5
/*000000000068*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000006c*/ v_mul_hi_u32    v6, s0, s0
/*000000000074*/ s_mul_i32       s0, s0, s0
/*000000000078*/ v_mov_b32       v5, s0
/*00000000007c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000084*/ v_add_u32       v0, vcc, s4, v0
/*000000000088*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000008c*/ v_mul_hi_u32    v4, s1, s1
/*000000000094*/ s_mul_i32       s0, s1, s1
/*000000000098*/ v_mov_b32       v3, s0
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ s_add_u32       s0, s8, s6
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c0*/ v_mul_hi_u32    v3, s2, s2
/*0000000000c8*/ s_mul_i32       s0, s2, s2
/*0000000000cc*/ v_mov_b32       v2, s0
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d8*/ s_endpgm
.kernel mul_long_get_num_groups_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s3, s0, 1
/*000000000030*/ s_lshr_b32      s7, s1, 1
/*000000000034*/ s_lshr_b32      s11, s2, 2
/*000000000038*/ s_lshl_b32      s8, s8, 1
/*00000000003c*/ s_lshl_b32      s9, s9, 1
/*000000000040*/ s_lshl_b32      s10, s10, 2
/*000000000044*/ s_add_u32       s8, s8, s12
/*000000000048*/ v_add_u32       v0, vcc, s8, v0
/*00000000004c*/ s_add_u32       s8, s9, s14
/*000000000050*/ v_add_u32       v7, vcc, s8, v1
/*000000000054*/ v_mov_b32       v1, s3
/*000000000058*/ v_mul_hi_u32    v4, s0, v1
/*000000000060*/ s_mul_i32       s0, s0, s3
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ v_mov_b32       v0, s7
/*00000000008c*/ v_mul_hi_u32    v4, s1, v0
/*000000000094*/ s_mul_i32       s0, s1, s7
/*000000000098*/ v_mov_b32       v8, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mov_b32       v0, s11
/*0000000000bc*/ v_mul_hi_u32    v3, s2, v0
/*0000000000c4*/ s_mul_i32       s0, s2, s11
/*0000000000c8*/ s_add_u32       s1, s10, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel mul_long_get_work_dim_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s0, s0, 0x20010
/*00000000003c*/ s_lshl_b32      s7, s8, 1
/*000000000040*/ s_lshl_b32      s8, s9, 1
/*000000000044*/ s_lshl_b32      s9, s10, 2
/*000000000048*/ s_add_u32       s7, s7, s12
/*00000000004c*/ v_add_u32       v3, vcc, s7, v0
/*000000000050*/ v_mov_b32       v7, s0
/*000000000054*/ v_mul_hi_u32    v6, s2, v7
/*00000000005c*/ s_mul_i32       s2, s2, s0
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v8, s5
/*000000000074*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000084*/ v_mul_hi_u32    v4, s3, v7
/*00000000008c*/ s_mul_i32       s2, s3, s0
/*000000000090*/ s_add_u32       s3, s8, s14
/*000000000094*/ v_add_u32       v0, vcc, s3, v1
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s2
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mul_hi_u32    v3, s1, v7
/*0000000000c0*/ s_mul_i32       s0, s1, s0
/*0000000000c4*/ s_add_u32       s1, s9, s6
/*0000000000c8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000cc*/ v_mov_b32       v1, 0
/*0000000000d0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000dc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000e0*/ v_mov_b32       v2, s0
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ec*/ s_endpgm
.kernel mul_long_x_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s3, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s0, s0, 4
/*000000000038*/ s_lshr_b32      s1, s1, 1
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshl_b32      s7, s8, 4
/*000000000044*/ s_lshl_b32      s8, s9, 1
/*000000000048*/ s_lshl_b32      s9, s10, 1
/*00000000004c*/ s_add_u32       s7, s7, s12
/*000000000050*/ v_add_u32       v3, vcc, s7, v0
/*000000000054*/ s_ashr_i32      s7, s3, 31
/*000000000058*/ v_mov_b32       v7, s3
/*00000000005c*/ v_mul_hi_u32    v0, s0, v7
/*000000000064*/ s_mul_i32       s10, s0, s7
/*000000000068*/ v_add_u32       v6, vcc, s10, v0
/*00000000006c*/ s_mul_i32       s0, s0, s3
/*000000000070*/ v_mov_b32       v4, 0
/*000000000074*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000007c*/ v_add_u32       v3, vcc, s4, v3
/*000000000080*/ v_mov_b32       v8, s5
/*000000000084*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000088*/ v_mov_b32       v5, s0
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_mul_hi_u32    v0, s1, v7
/*00000000009c*/ s_mul_i32       s0, s1, s7
/*0000000000a0*/ v_add_u32       v4, vcc, s0, v0
/*0000000000a4*/ s_mul_i32       s0, s1, s3
/*0000000000a8*/ s_add_u32       s1, s8, s14
/*0000000000ac*/ v_add_u32       v0, vcc, s1, v1
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c4*/ v_mov_b32       v3, s0
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d0*/ v_mul_hi_u32    v0, s2, v7
/*0000000000d8*/ s_mul_i32       s0, s2, s7
/*0000000000dc*/ v_add_u32       v3, vcc, s0, v0
/*0000000000e0*/ s_mul_i32       s0, s2, s3
/*0000000000e4*/ s_add_u32       s1, s9, s6
/*0000000000e8*/ v_add_u32       v0, vcc, s1, v2
/*0000000000ec*/ v_mov_b32       v1, 0
/*0000000000f0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000f8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000fc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000100*/ v_mov_b32       v2, s0
/*000000000104*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000010c*/ s_endpgm
.kernel mul_long_get_global_offset_get_num_groups
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 4
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 4
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, s12
/*000000000058*/ v_mul_hi_u32    v4, s0, v1
/*000000000060*/ s_mul_i32       s0, s0, s12
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ v_mov_b32       v0, s14
/*00000000008c*/ v_mul_hi_u32    v4, s1, v0
/*000000000094*/ s_mul_i32       s0, s1, s14
/*000000000098*/ v_mov_b32       v8, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mov_b32       v0, s6
/*0000000000bc*/ v_mul_hi_u32    v3, s2, v0
/*0000000000c4*/ s_mul_i32       s0, s2, s6
/*0000000000c8*/ s_add_u32       s1, s8, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel mul_long_get_local_id_get_num_groups
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 3
/*000000000030*/ s_lshr_b32      s1, s1, 2
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 3
/*00000000003c*/ s_lshl_b32      s7, s9, 2
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v9, vcc, s3, v1
/*000000000054*/ v_mul_hi_u32    v6, s0, v0
/*00000000005c*/ v_mul_lo_u32    v5, s0, v0
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v8, s5
/*000000000078*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000007c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000084*/ v_mul_hi_u32    v4, s1, v1
/*00000000008c*/ v_mul_lo_u32    v3, s1, v1
/*000000000094*/ v_mov_b32       v10, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ v_mul_hi_u32    v4, s2, v2
/*0000000000b8*/ v_mul_lo_u32    v3, s2, v2
/*0000000000c0*/ s_add_u32       s0, s8, s6
/*0000000000c4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_group_id_get_num_groups
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 4
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 4
/*000000000040*/ s_lshl_b32      s11, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, s8
/*000000000058*/ v_mul_hi_u32    v4, s0, v1
/*000000000060*/ s_mul_i32       s0, s0, s8
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ v_mov_b32       v0, s9
/*00000000008c*/ v_mul_hi_u32    v4, s1, v0
/*000000000094*/ s_mul_i32       s0, s1, s9
/*000000000098*/ v_mov_b32       v8, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mov_b32       v0, s10
/*0000000000bc*/ v_mul_hi_u32    v3, s2, v0
/*0000000000c4*/ s_mul_i32       s0, s2, s10
/*0000000000c8*/ s_add_u32       s1, s11, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel mul_long_get_local_size_get_num_groups
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 1
/*000000000030*/ s_lshr_b32      s0, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v0, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, 0
/*000000000058*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v7, s5
/*000000000074*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000078*/ s_movk_i32      s17, 0x0
/*00000000007c*/ s_lshl_b64      s[10:11], s[16:17], 1
/*000000000080*/ v_mov_b32       v5, s10
/*000000000084*/ v_mov_b32       v6, s11
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ s_movk_i32      s1, 0x0
/*00000000009c*/ s_lshl_b64      s[0:1], s[0:1], 1
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ v_mov_b32       v4, s1
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s8, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ s_movk_i32      s3, 0x0
/*0000000000d0*/ s_lshl_b64      s[0:1], s[2:3], 2
/*0000000000d4*/ v_mov_b32       v2, s0
/*0000000000d8*/ v_mov_b32       v3, s1
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_global_id_get_num_groups
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ v_add_u32       v7, vcc, s3, v0
/*000000000040*/ s_lshl_b32      s3, s9, 1
/*000000000044*/ s_lshl_b32      s7, s10, 2
/*000000000048*/ v_mov_b32       v8, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[7:8]
/*000000000054*/ s_add_u32       s3, s3, s14
/*000000000058*/ v_add_u32       v10, vcc, s3, v1
/*00000000005c*/ v_add_u32       v8, vcc, s4, v3
/*000000000060*/ v_mov_b32       v6, s5
/*000000000064*/ v_addc_u32      v9, vcc, v6, v4, vcc
/*000000000068*/ v_add_u32       v0, vcc, s12, v7
/*00000000006c*/ v_mul_hi_u32    v4, s0, v0
/*000000000074*/ v_mul_lo_u32    v3, s0, v0
/*00000000007c*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000084*/ v_mul_hi_u32    v4, s1, v10
/*00000000008c*/ v_mul_lo_u32    v3, s1, v10
/*000000000094*/ v_mov_b32       v11, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s7, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mul_hi_u32    v3, s2, v0
/*0000000000c0*/ v_mul_lo_u32    v2, s2, v0
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_global_size_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s3, s0, 4
/*000000000030*/ s_lshr_b32      s7, s1, 1
/*000000000034*/ s_lshr_b32      s11, s2, 1
/*000000000038*/ s_lshl_b32      s8, s8, 4
/*00000000003c*/ s_lshl_b32      s9, s9, 1
/*000000000040*/ s_lshl_b32      s10, s10, 1
/*000000000044*/ s_add_u32       s8, s8, s12
/*000000000048*/ v_add_u32       v0, vcc, s8, v0
/*00000000004c*/ s_add_u32       s8, s9, s14
/*000000000050*/ v_add_u32       v7, vcc, s8, v1
/*000000000054*/ v_mov_b32       v1, s0
/*000000000058*/ v_mul_hi_u32    v4, s3, v1
/*000000000060*/ s_mul_i32       s0, s3, s0
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s0
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ v_mov_b32       v0, s1
/*00000000008c*/ v_mul_hi_u32    v4, s7, v0
/*000000000094*/ s_mul_i32       s0, s7, s1
/*000000000098*/ v_mov_b32       v8, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ v_mov_b32       v0, s2
/*0000000000bc*/ v_mul_hi_u32    v3, s11, v0
/*0000000000c4*/ s_mul_i32       s0, s11, s2
/*0000000000c8*/ s_add_u32       s1, s10, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel mul_long_get_num_groups_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v0, vcc, s3, v1
/*000000000054*/ v_mov_b32       v1, 0
/*000000000058*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v7, s5
/*000000000074*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000078*/ v_mul_hi_u32    v6, s0, s0
/*000000000080*/ s_mul_i32       s0, s0, s0
/*000000000084*/ v_mov_b32       v5, s0
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ v_mul_hi_u32    v4, s1, s1
/*0000000000a0*/ s_mul_i32       s0, s1, s1
/*0000000000a4*/ v_mov_b32       v3, s0
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s8, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ v_mul_hi_u32    v3, s2, s2
/*0000000000d4*/ s_mul_i32       s0, s2, s2
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel mul_long_get_work_dim_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s0, s0, 0x20010
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshr_b32      s3, s3, 1
/*000000000044*/ s_lshr_b32      s1, s1, 2
/*000000000048*/ s_lshl_b32      s7, s8, 1
/*00000000004c*/ s_lshl_b32      s8, s9, 1
/*000000000050*/ s_lshl_b32      s9, s10, 2
/*000000000054*/ s_add_u32       s7, s7, s12
/*000000000058*/ v_add_u32       v3, vcc, s7, v0
/*00000000005c*/ v_mov_b32       v7, s0
/*000000000060*/ v_mul_hi_u32    v6, s2, v7
/*000000000068*/ s_mul_i32       s2, s2, s0
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000078*/ v_add_u32       v3, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v8, s5
/*000000000080*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_mul_hi_u32    v4, s3, v7
/*000000000098*/ s_mul_i32       s2, s3, s0
/*00000000009c*/ s_add_u32       s3, s8, s14
/*0000000000a0*/ v_add_u32       v0, vcc, s3, v1
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b8*/ v_mov_b32       v3, s2
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ v_mul_hi_u32    v3, s1, v7
/*0000000000cc*/ s_mul_i32       s0, s1, s0
/*0000000000d0*/ s_add_u32       s1, s9, s6
/*0000000000d4*/ v_add_u32       v0, vcc, s1, v2
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000ec*/ v_mov_b32       v2, s0
/*0000000000f0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f8*/ s_endpgm
.kernel mul_long_x_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x30
/*000000000018*/ s_load_dword    s1, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000034*/ s_lshl_b32      s5, s8, 4
/*000000000038*/ s_lshl_b32      s6, s9, 1
/*00000000003c*/ s_lshl_b32      s7, s10, 1
/*000000000040*/ s_add_u32       s5, s5, s12
/*000000000044*/ v_add_u32       v3, vcc, s5, v0
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s2, v3
/*000000000058*/ v_mov_b32       v7, s3
/*00000000005c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000060*/ s_mul_i32       s0, s0, s1
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_mov_b32       v6, 0
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ s_add_u32       s0, s6, s14
/*000000000078*/ v_add_u32       v0, vcc, s0, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ flat_store_dwordx2 v[0:1], v[5:6]
/*000000000098*/ s_add_u32       s0, s7, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[5:6]
/*0000000000bc*/ s_endpgm
.kernel mul_long_get_global_offset_get_work_dim
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 4
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v0, vcc, s1, v0
/*000000000040*/ s_add_u32       s1, s5, s14
/*000000000044*/ v_add_u32       v7, vcc, s1, v1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_add_u32       v0, vcc, s2, v0
/*000000000058*/ v_mov_b32       v6, s3
/*00000000005c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000060*/ s_mul_i32       s1, s0, s12
/*000000000064*/ v_mov_b32       v3, s1
/*000000000068*/ v_mov_b32       v4, 0
/*00000000006c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000074*/ v_mov_b32       v8, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000088*/ s_mul_i32       s1, s0, s14
/*00000000008c*/ v_mov_b32       v3, s1
/*000000000090*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000098*/ s_add_u32       s1, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s1, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ s_mul_i32       s0, s0, s4
/*0000000000b8*/ v_mov_b32       v2, s0
/*0000000000bc*/ v_mov_b32       v3, 0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel mul_long_get_local_id_get_work_dim
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 21
        .vgprsnum 10
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 3
/*000000000030*/ s_lshl_b32      s5, s9, 2
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v5, vcc, s1, v0
/*000000000040*/ s_add_u32       s1, s5, s14
/*000000000044*/ v_add_u32       v3, vcc, s1, v1
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_mov_b32       v6, 0
/*000000000058*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*000000000060*/ v_add_u32       v5, vcc, s2, v5
/*000000000064*/ v_mov_b32       v9, s3
/*000000000068*/ v_addc_u32      v6, vcc, v9, v6, vcc
/*00000000006c*/ v_mul_lo_u32    v7, s0, v0
/*000000000074*/ v_mov_b32       v8, 0
/*000000000078*/ flat_store_dwordx2 v[5:6], v[7:8]
/*000000000080*/ v_add_u32       v5, vcc, s2, v3
/*000000000084*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000088*/ v_mul_lo_u32    v3, s0, v1
/*000000000090*/ v_mov_b32       v4, 0
/*000000000094*/ flat_store_dwordx2 v[5:6], v[3:4]
/*00000000009c*/ s_add_u32       s1, s6, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b8*/ v_mul_lo_u32    v2, s0, v2
/*0000000000c0*/ v_mov_b32       v3, 0
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000cc*/ s_endpgm
.kernel mul_long_get_group_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 4
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ s_add_u32       s1, s5, s14
/*000000000044*/ v_add_u32       v0, vcc, s1, v1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s2, v3
/*000000000064*/ v_mov_b32       v7, s3
/*000000000068*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000006c*/ s_mul_i32       s1, s0, s8
/*000000000070*/ v_mov_b32       v5, s1
/*000000000074*/ v_mov_b32       v6, 0
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000088*/ s_mul_i32       s1, s0, s9
/*00000000008c*/ v_mov_b32       v3, s1
/*000000000090*/ v_mov_b32       v4, 0
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s1, s6, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b8*/ s_mul_i32       s0, s0, s10
/*0000000000bc*/ v_mov_b32       v2, s0
/*0000000000c0*/ v_mov_b32       v3, 0
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000cc*/ s_endpgm
.kernel mul_long_get_local_size_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s2, v3
/*000000000050*/ v_mov_b32       v7, s3
/*000000000054*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000058*/ s_lshl_b32      s1, s0, 1
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_mov_b32       v6, 0
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ s_add_u32       s1, s5, s14
/*000000000070*/ v_add_u32       v0, vcc, s1, v1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000088*/ flat_store_dwordx2 v[0:1], v[5:6]
/*000000000090*/ s_add_u32       s1, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s1, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ac*/ s_lshl_b32      s0, s0, 2
/*0000000000b0*/ v_mov_b32       v2, s0
/*0000000000b4*/ v_mov_b32       v3, 0
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c0*/ s_endpgm
.kernel mul_long_get_global_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ v_add_u32       v5, vcc, s1, v0
/*000000000034*/ s_lshl_b32      s1, s9, 1
/*000000000038*/ s_lshl_b32      s5, s10, 2
/*00000000003c*/ v_mov_b32       v6, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[5:6]
/*000000000048*/ v_add_u32       v3, vcc, s2, v3
/*00000000004c*/ v_mov_b32       v7, s3
/*000000000050*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000054*/ v_add_u32       v0, vcc, s12, v5
/*000000000058*/ v_mul_lo_u32    v5, s0, v0
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ s_add_u32       s1, s1, s14
/*00000000006c*/ v_add_u32       v3, vcc, s1, v1
/*000000000070*/ v_mov_b32       v4, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[3:4]
/*00000000007c*/ v_add_u32       v0, vcc, s2, v0
/*000000000080*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000084*/ v_mul_lo_u32    v3, v3, s0
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s1, s5, s4
/*000000000098*/ v_add_u32       v2, vcc, s1, v2
/*00000000009c*/ v_mov_b32       v3, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*0000000000a8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_mul_lo_u32    v2, v2, s0
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c0*/ s_endpgm
.kernel mul_long_get_global_size_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s0, s0, 0x20010
/*00000000003c*/ s_lshl_b32      s7, s8, 4
/*000000000040*/ s_lshl_b32      s8, s9, 1
/*000000000044*/ s_lshl_b32      s9, s10, 1
/*000000000048*/ s_add_u32       s7, s7, s12
/*00000000004c*/ v_add_u32       v3, vcc, s7, v0
/*000000000050*/ s_add_u32       s7, s8, s14
/*000000000054*/ v_add_u32       v0, vcc, s7, v1
/*000000000058*/ v_mov_b32       v1, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v7, s5
/*000000000078*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000007c*/ s_mul_i32       s2, s0, s2
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ v_mov_b32       v6, 0
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ s_mul_i32       s2, s0, s3
/*00000000009c*/ v_mov_b32       v3, s2
/*0000000000a0*/ v_mov_b32       v4, 0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_add_u32       s2, s9, s6
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c8*/ s_mul_i32       s0, s0, s1
/*0000000000cc*/ v_mov_b32       v2, s0
/*0000000000d0*/ v_mov_b32       v3, 0
/*0000000000d4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000dc*/ s_endpgm
.kernel mul_long_get_num_groups_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s0, s0, 0x20010
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshr_b32      s3, s3, 1
/*000000000044*/ s_lshr_b32      s1, s1, 2
/*000000000048*/ s_lshl_b32      s7, s8, 1
/*00000000004c*/ s_lshl_b32      s8, s9, 1
/*000000000050*/ s_lshl_b32      s9, s10, 2
/*000000000054*/ s_add_u32       s7, s7, s12
/*000000000058*/ v_add_u32       v3, vcc, s7, v0
/*00000000005c*/ s_add_u32       s7, s8, s14
/*000000000060*/ v_add_u32       v0, vcc, s7, v1
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_mov_b32       v4, 0
/*000000000074*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000007c*/ v_add_u32       v3, vcc, s4, v3
/*000000000080*/ v_mov_b32       v7, s5
/*000000000084*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000088*/ s_mul_i32       s2, s0, s2
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ v_mov_b32       v6, 0
/*000000000094*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000009c*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ s_mul_i32       s2, s0, s3
/*0000000000a8*/ v_mov_b32       v3, s2
/*0000000000ac*/ v_mov_b32       v4, 0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ s_add_u32       s2, s9, s6
/*0000000000bc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ s_mul_i32       s0, s0, s1
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, 0
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel mul_long_get_work_dim_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v3, vcc, s1, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s2, v3
/*000000000050*/ v_mov_b32       v7, s3
/*000000000054*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000058*/ s_mul_i32       s0, s0, s0
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v6, 0
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ s_add_u32       s0, s5, s14
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000088*/ flat_store_dwordx2 v[0:1], v[5:6]
/*000000000090*/ s_add_u32       s0, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ac*/ flat_store_dwordx2 v[0:1], v[5:6]
/*0000000000b4*/ s_endpgm
.kernel mul_long_x_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ s_mul_i32       s0, s1, s1
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel mul_long_get_global_offset_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ s_mul_i32       s0, s0, s0
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel mul_long_get_local_id_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v1, vcc, s0, v0
/*000000000020*/ v_mov_b32       v2, 0
/*000000000024*/ v_lshlrev_b64   v[1:2], 3, v[1:2]
/*00000000002c*/ v_add_u32       v1, vcc, s2, v1
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000038*/ v_mul_i32_i24   v3, v0, v0
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ flat_store_dwordx2 v[1:2], v[3:4]
/*000000000048*/ s_endpgm
.kernel mul_long_get_group_id_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ s_mul_i32       s0, s6, s6
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel mul_long_get_local_size_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_lshlrev_b64   v[2:3], 12, 1
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel mul_long_get_global_id_64
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mul_lo_u32    v2, v0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v3, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel mul_long_get_global_size_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0xc
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_lshl_b32      s1, s8, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s1, s1, s2
/*000000000024*/ v_add_u32       v0, vcc, s1, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s4, v0
/*000000000038*/ v_mov_b32       v2, s5
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_mul_i32       s0, s0, s0
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ v_mov_b32       v3, 0
/*00000000004c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000054*/ s_endpgm
.kernel mul_long_get_num_groups_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0xc
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshr_b32      s0, s0, 6
/*000000000020*/ s_lshl_b32      s1, s8, 6
/*000000000024*/ s_add_u32       s1, s1, s2
/*000000000028*/ v_add_u32       v0, vcc, s1, v0
/*00000000002c*/ v_mov_b32       v1, 0
/*000000000030*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000038*/ v_add_u32       v0, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v2, s5
/*000000000040*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000044*/ s_mul_i32       s0, s0, s0
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel mul_long_get_work_dim
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_bfe_u32       s0, s0, 0x20010
/*000000000024*/ s_lshl_b32      s1, s8, 6
/*000000000028*/ s_add_u32       s1, s1, s2
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v2, s5
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ s_mul_i32       s0, s0, s0
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ v_mov_b32       v3, 0
/*000000000054*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000005c*/ s_endpgm
.kernel mul_long_x_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s3, s6, 3
/*000000000020*/ s_lshl_b32      s6, s7, 3
/*000000000024*/ s_add_u32       s0, s3, s0
/*000000000028*/ s_add_u32       s2, s6, s2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ v_add_u32       v1, vcc, s2, v1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_mul_lo_u32    v2, v1, s1
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s4, v0
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000058*/ v_mov_b32       v3, 0
/*00000000005c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000064*/ s_endpgm
.kernel mul_long_get_global_offset_8_8
    .config
        .dims x
        .cws 8, 8, 1
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s4, v0
/*000000000030*/ v_mov_b32       v2, s5
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ s_mul_i32       s0, s2, s0
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel mul_long_get_local_id_8_8
    .config
        .dims x, xy
        .cws 8, 8, 1
        .sgprsnum 13
        .vgprsnum 7
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0041
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v2, vcc, s0, v0
/*000000000020*/ v_mov_b32       v3, 0
/*000000000024*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*00000000002c*/ v_add_u32       v5, vcc, s2, v2
/*000000000030*/ v_mov_b32       v4, s3
/*000000000034*/ v_addc_u32      v6, vcc, v4, v3, vcc
/*000000000038*/ v_mul_i32_i24   v3, v1, v0
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000048*/ s_endpgm
.kernel mul_long_get_group_id_8_8
    .config
        .dims xy, x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ s_mul_i32       s0, s7, s6
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel mul_long_get_local_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
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
        .arg x, "int", int
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_lshlrev_b64   v[2:3], 0, 64
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel mul_long_get_global_id_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_lshl_b32      s3, s7, 3
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ s_add_u32       s1, s3, s2
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ v_mul_lo_u32    v2, v1, v0
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000040*/ v_add_u32       v0, vcc, s4, v0
/*000000000044*/ v_mov_b32       v3, s5
/*000000000048*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel mul_long_get_global_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s8, 3
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0xc
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ s_mul_i32       s0, s5, s4
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel mul_long_get_num_groups_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s8, 3
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000034*/ s_lshr_b32      s0, s2, 3
/*000000000038*/ s_lshr_b32      s1, s3, 3
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v2, s5
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ s_mul_i32       s0, s1, s0
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ v_mov_b32       v3, 0
/*000000000054*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000005c*/ s_endpgm
.kernel mul_long_get_work_dim_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s3, s8, 3
/*000000000020*/ s_lshl_b32      s6, s9, 3
/*000000000024*/ s_add_u32       s0, s3, s0
/*000000000028*/ s_add_u32       s2, s6, s2
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_bfe_u32       s1, s1, 0x20010
/*000000000038*/ v_add_u32       v0, vcc, s0, v0
/*00000000003c*/ v_add_u32       v1, vcc, s2, v1
/*000000000040*/ v_mul_lo_u32    v2, v1, s1
/*000000000048*/ v_mov_b32       v1, 0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000054*/ v_add_u32       v0, vcc, s4, v0
/*000000000058*/ v_mov_b32       v3, s5
/*00000000005c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000060*/ v_mov_b32       v3, 0
/*000000000064*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000006c*/ s_endpgm
.kernel mul_char_x_x
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_mul_i32       s0, s1, s1
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v1, s3
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ v_mov_b32       v2, s0
/*000000000044*/ flat_store_byte v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel mul_char_get_global_offset_x
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s6, s7, 4
/*00000000002c*/ s_add_u32       s3, s3, s0
/*000000000030*/ s_lshl_b32      s7, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s0, s0, s1
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ s_mul_i32       s0, s2, s1
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s2, s7, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s0
/*000000000074*/ s_mul_i32       s0, s10, s1
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s0
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_local_id_x
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 3
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 2
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ v_mul_lo_u32    v5, v0, s1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s10, v0
/*000000000048*/ v_mov_b32       v6, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_mul_lo_u32    v3, v1, s1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ flat_store_byte v[0:1], v3
/*000000000080*/ v_mul_lo_u32    v3, v2, s1
/*000000000088*/ s_add_u32       s0, s6, s4
/*00000000008c*/ v_add_u32       v0, vcc, s0, v2
/*000000000090*/ v_add_u32       v0, vcc, s10, v0
/*000000000094*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000009c*/ flat_store_byte v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_group_id_x
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s9, s7, 4
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s6, s6, s1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s9, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s6
/*000000000058*/ s_mul_i32       s2, s7, s1
/*00000000005c*/ v_add_u32       v1, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s3, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s2
/*000000000074*/ s_mul_i32       s1, s8, s1
/*000000000078*/ v_add_u32       v1, vcc, s0, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s1
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_local_size_x
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 2
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshl_b32      s0, s1, 1
/*000000000040*/ s_add_u32       s2, s6, s2
/*000000000044*/ v_add_u32       v9, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ v_add_u32       v1, vcc, s2, v1
/*00000000005c*/ s_add_u32       s0, s3, s10
/*000000000060*/ v_add_u32       v6, vcc, s4, v1
/*000000000064*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000006c*/ v_add_u32       v1, vcc, s0, v2
/*000000000070*/ s_lshl_b32      s0, s1, 2
/*000000000074*/ v_add_u32       v0, vcc, s4, v1
/*000000000078*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ flat_store_byte v[9:10], v5
/*00000000008c*/ flat_store_byte v[6:7], v5
/*000000000094*/ flat_store_byte v[0:1], v8
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_id_x
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_lshl_b32      s3, s6, 1
/*000000000020*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000028*/ v_add_u32       v0, vcc, s3, v0
/*00000000002c*/ s_lshl_b32      s3, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 2
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s3, s2
/*00000000003c*/ s_waitcnt       lgkmcnt(0)
/*000000000040*/ v_mul_lo_u32    v3, v3, s1
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s6, s10
/*000000000050*/ v_mul_lo_u32    v4, v1, s1
/*000000000058*/ v_add_u32       v2, vcc, s0, v2
/*00000000005c*/ v_mul_lo_u32    v5, v2, s1
/*000000000064*/ v_add_u32       v10, vcc, s4, v0
/*000000000068*/ v_mov_b32       v6, s5
/*00000000006c*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*000000000074*/ v_add_u32       v0, vcc, s4, v1
/*000000000078*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000080*/ v_add_u32       v7, vcc, s4, v2
/*000000000084*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*00000000008c*/ flat_store_byte v[10:11], v3
/*000000000094*/ flat_store_byte v[0:1], v4
/*00000000009c*/ flat_store_byte v[7:8], v5
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_global_size_x
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[6:7], 0x38
/*00000000001c*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_load_dword    s3, s[4:5], 0x14
/*000000000034*/ s_lshl_b32      s4, s8, 4
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s4, s0
/*000000000040*/ s_lshl_b32      s4, s10, 1
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s8, s12, s1
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ s_add_u32       s0, s5, s2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s8
/*000000000068*/ s_mul_i32       s2, s13, s1
/*00000000006c*/ v_add_u32       v1, vcc, s0, v1
/*000000000070*/ s_add_u32       s0, s4, s14
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s2
/*000000000084*/ s_mul_i32       s1, s3, s1
/*000000000088*/ v_add_u32       v1, vcc, s0, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s1
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_num_groups_x
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[6:7], 0x30
/*000000000018*/ s_load_dword    s3, s[4:5], 0x14
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s5, s8, 1
/*000000000038*/ s_lshr_b32      s0, s0, 1
/*00000000003c*/ s_lshl_b32      s8, s9, 1
/*000000000040*/ s_add_u32       s5, s5, s12
/*000000000044*/ s_lshr_b32      s1, s1, 1
/*000000000048*/ s_lshl_b32      s9, s10, 2
/*00000000004c*/ s_mul_i32       s0, s0, s2
/*000000000050*/ v_add_u32       v0, vcc, s5, v0
/*000000000054*/ s_add_u32       s5, s8, s14
/*000000000058*/ s_lshr_b32      s3, s3, 2
/*00000000005c*/ v_add_u32       v10, vcc, s6, v0
/*000000000060*/ v_mov_b32       v3, s7
/*000000000064*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_mul_i32       s0, s1, s2
/*000000000074*/ v_add_u32       v1, vcc, s5, v1
/*000000000078*/ s_add_u32       s1, s9, s4
/*00000000007c*/ v_add_u32       v6, vcc, s6, v1
/*000000000080*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v8, s0
/*00000000008c*/ s_mul_i32       s0, s3, s2
/*000000000090*/ v_add_u32       v1, vcc, s1, v2
/*000000000094*/ v_add_u32       v0, vcc, s6, v1
/*000000000098*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a0*/ v_mov_b32       v9, s0
/*0000000000a4*/ flat_store_byte v[10:11], v5
/*0000000000ac*/ flat_store_byte v[6:7], v8
/*0000000000b4*/ flat_store_byte v[0:1], v9
/*0000000000bc*/ s_endpgm
.kernel mul_char_get_work_dim_x
    .config
        .dims x
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dword    s1, s[6:7], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_add_u32       s2, s3, s2
/*000000000034*/ s_mul_i32       s0, s0, s1
/*000000000038*/ v_add_u32       v0, vcc, s2, v0
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v1, s5
/*000000000044*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_byte v[0:1], v2
/*000000000058*/ s_endpgm
.kernel mul_char_x_get_global_offset
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s3, s3, s0
/*000000000030*/ s_lshl_b32      s7, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s0, s0, s1
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ s_mul_i32       s0, s2, s1
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s2, s7, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s0
/*000000000074*/ s_mul_i32       s0, s10, s1
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s0
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_global_offset_get_global_offset
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_mul_i32       s0, s0, s0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s1, v1
/*000000000050*/ s_mul_i32       s0, s2, s2
/*000000000054*/ s_add_u32       s1, s6, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_mul_i32       s0, s10, s10
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_id_get_global_offset
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ v_mul_lo_u32    v5, v0, s0
/*000000000030*/ s_add_u32       s0, s1, s0
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ v_mul_lo_u32    v3, v1, s2
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ v_mul_lo_u32    v3, v2, s4
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel mul_char_get_group_id_get_global_offset
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s9, s8, 1
/*00000000002c*/ s_mul_i32       s0, s6, s0
/*000000000030*/ v_add_u32       v0, vcc, s1, v0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ s_mul_i32       s0, s7, s2
/*000000000050*/ v_add_u32       v1, vcc, s1, v1
/*000000000054*/ s_add_u32       s1, s9, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ s_mul_i32       s0, s8, s10
/*00000000006c*/ v_add_u32       v1, vcc, s1, v2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_size_get_global_offset
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_lshl_b32      s0, s0, 1
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s1, v1
/*000000000050*/ s_lshl_b32      s0, s2, 1
/*000000000054*/ s_add_u32       s1, s6, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_lshl_b32      s0, s10, 2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_global_id_get_global_offset
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s1, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, v3, s0
/*00000000003c*/ v_add_u32       v1, vcc, s1, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, v1, s2
/*00000000004c*/ v_add_u32       v2, vcc, s0, v2
/*000000000050*/ v_mul_lo_u32    v5, v2, s10
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v10, vcc, s4, v0
/*000000000060*/ v_mov_b32       v6, s5
/*000000000064*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*00000000006c*/ v_add_u32       v0, vcc, s4, v1
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ v_add_u32       v7, vcc, s4, v2
/*00000000007c*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[10:11], v3
/*00000000008c*/ flat_store_byte v[0:1], v4
/*000000000094*/ flat_store_byte v[7:8], v5
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_size_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s3, s3, s0
/*000000000038*/ s_lshl_b32      s5, s10, 1
/*00000000003c*/ s_mul_i32       s0, s12, s0
/*000000000040*/ v_add_u32       v0, vcc, s3, v0
/*000000000044*/ s_add_u32       s3, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ s_mul_i32       s0, s13, s2
/*000000000060*/ v_add_u32       v1, vcc, s3, v1
/*000000000064*/ s_add_u32       s2, s5, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_mul_i32       s0, s1, s14
/*000000000080*/ v_add_u32       v1, vcc, s2, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_num_groups_get_global_offset
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_mul_i32       s0, s0, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s1, s14
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s2, s4
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_global_offset
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ s_mul_i32       s7, s0, s12
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_mul_i32       s3, s0, s14
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_mul_i32       s0, s0, s2
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel mul_char_x_get_local_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ v_mul_lo_u32    v5, v0, s1
/*00000000003c*/ s_add_u32       s0, s3, s0
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s10, v0
/*000000000048*/ v_mov_b32       v6, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_mul_lo_u32    v3, v1, s1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ flat_store_byte v[0:1], v3
/*000000000080*/ v_mul_lo_u32    v3, v2, s1
/*000000000088*/ s_add_u32       s0, s6, s4
/*00000000008c*/ v_add_u32       v0, vcc, s0, v2
/*000000000090*/ v_add_u32       v0, vcc, s10, v0
/*000000000094*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000009c*/ flat_store_byte v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_global_offset_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ v_mul_lo_u32    v5, v0, s0
/*000000000030*/ s_add_u32       s0, s1, s0
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ v_mul_lo_u32    v3, v1, s2
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ v_mul_lo_u32    v3, v2, s4
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_id_get_local_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
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
/*000000000034*/ v_add_u32       v9, vcc, s4, v3
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*000000000044*/ v_mul_i32_i24   v0, v0, v0
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_mul_i32_i24   v1, v1, v1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_mul_i32_i24   v2, v2, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel mul_char_get_group_id_get_local_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ v_mul_lo_u32    v5, v0, s6
/*000000000030*/ s_add_u32       s0, s1, s0
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ v_mul_lo_u32    v3, v1, s7
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ v_mul_lo_u32    v3, v2, s8
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_size_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "uchar*", uchar*, global, 
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
/*000000000034*/ v_add_u32       v9, vcc, s4, v3
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*000000000044*/ v_lshlrev_b32   v0, 1, v0
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_lshlrev_b32   v1, 1, v1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_lshlrev_b32   v2, 2, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel mul_char_get_global_id_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v3, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v4, vcc, s0, v3
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v0, v0, v4
/*00000000003c*/ v_add_u32       v4, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v1, v1, v4
/*00000000004c*/ v_add_u32       v5, vcc, s0, v2
/*000000000050*/ v_mul_lo_u32    v2, v2, v5
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v9, vcc, s4, v3
/*000000000060*/ v_mov_b32       v6, s5
/*000000000064*/ v_addc_u32      v10, vcc, v6, 0, vcc
/*00000000006c*/ v_add_u32       v3, vcc, s4, v4
/*000000000070*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000078*/ v_add_u32       v5, vcc, s4, v5
/*00000000007c*/ v_addc_u32      v6, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[9:10], v0
/*00000000008c*/ flat_store_byte v[3:4], v1
/*000000000094*/ flat_store_byte v[5:6], v2
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_size_get_local_id
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ v_mul_lo_u32    v5, v0, s0
/*000000000040*/ s_add_u32       s0, s3, s12
/*000000000044*/ v_add_u32       v0, vcc, s0, v0
/*000000000048*/ v_add_u32       v3, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v6, s5
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ v_mul_lo_u32    v3, v1, s1
/*000000000068*/ s_add_u32       s0, s7, s14
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, v2, s2
/*00000000008c*/ s_add_u32       s0, s8, s6
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_num_groups_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ v_mul_lo_u32    v5, v0, s0
/*00000000004c*/ s_add_u32       s0, s3, s12
/*000000000050*/ v_add_u32       v0, vcc, s0, v0
/*000000000054*/ v_add_u32       v3, vcc, s4, v0
/*000000000058*/ v_mov_b32       v6, s5
/*00000000005c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[3:4], v5
/*00000000006c*/ v_mul_lo_u32    v3, v1, s1
/*000000000074*/ s_add_u32       s0, s7, s14
/*000000000078*/ v_add_u32       v0, vcc, s0, v1
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000088*/ flat_store_byte v[0:1], v3
/*000000000090*/ v_mul_lo_u32    v3, v2, s2
/*000000000098*/ s_add_u32       s0, s8, s6
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000ac*/ flat_store_byte v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ v_mul_lo_u32    v5, v0, s0
/*000000000040*/ s_add_u32       s1, s1, s12
/*000000000044*/ v_add_u32       v0, vcc, s1, v0
/*000000000048*/ v_add_u32       v3, vcc, s2, v0
/*00000000004c*/ v_mov_b32       v6, s3
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ v_mul_lo_u32    v3, v1, s0
/*000000000068*/ s_add_u32       s1, s5, s14
/*00000000006c*/ v_add_u32       v0, vcc, s1, v1
/*000000000070*/ v_add_u32       v0, vcc, s2, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, v2, s0
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s2, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel mul_char_x_get_group_id
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s9, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_mul_i32       s6, s6, s1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s9, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s6
/*000000000058*/ s_mul_i32       s2, s7, s1
/*00000000005c*/ v_add_u32       v1, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s3, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s2
/*000000000074*/ s_mul_i32       s1, s8, s1
/*000000000078*/ v_add_u32       v1, vcc, s0, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s1
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_global_offset_get_group_id
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s9, s8, 1
/*00000000002c*/ s_mul_i32       s0, s6, s0
/*000000000030*/ v_add_u32       v0, vcc, s1, v0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ s_mul_i32       s0, s7, s2
/*000000000050*/ v_add_u32       v1, vcc, s1, v1
/*000000000054*/ s_add_u32       s1, s9, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ s_mul_i32       s0, s8, s10
/*00000000006c*/ v_add_u32       v1, vcc, s1, v2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_id_get_group_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ v_mul_lo_u32    v5, s6, v0
/*000000000030*/ s_add_u32       s0, s1, s0
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ v_mul_lo_u32    v3, s7, v1
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ v_mul_lo_u32    v3, s8, v2
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel mul_char_get_group_id_get_group_id
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_mul_i32       s0, s6, s6
/*000000000034*/ s_add_u32       s2, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s2, v1
/*000000000050*/ s_mul_i32       s0, s7, s7
/*000000000054*/ s_add_u32       s1, s1, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_mul_i32       s0, s8, s8
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_size_get_group_id
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v10, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, s1
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s6, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_mov_b32       v8, s3
/*000000000060*/ v_add_u32       v1, vcc, s0, v2
/*000000000064*/ v_add_u32       v0, vcc, s4, v1
/*000000000068*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v9, s6
/*000000000074*/ flat_store_byte v[10:11], v5
/*00000000007c*/ flat_store_byte v[6:7], v8
/*000000000084*/ flat_store_byte v[0:1], v9
/*00000000008c*/ s_endpgm
.kernel mul_char_get_global_id_get_group_id
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, s6, v3
/*00000000003c*/ v_add_u32       v1, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, s7, v1
/*00000000004c*/ v_add_u32       v2, vcc, s0, v2
/*000000000050*/ v_mul_lo_u32    v5, s8, v2
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v10, vcc, s4, v0
/*000000000060*/ v_mov_b32       v6, s5
/*000000000064*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*00000000006c*/ v_add_u32       v0, vcc, s4, v1
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ v_add_u32       v7, vcc, s4, v2
/*00000000007c*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[10:11], v3
/*00000000008c*/ flat_store_byte v[0:1], v4
/*000000000094*/ flat_store_byte v[7:8], v5
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_size_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ s_mul_i32       s5, s8, s12
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ s_add_u32       s0, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ s_mul_i32       s2, s9, s13
/*000000000060*/ v_add_u32       v1, vcc, s0, v1
/*000000000064*/ s_add_u32       s0, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s2
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_mul_i32       s1, s10, s1
/*000000000080*/ v_add_u32       v1, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s1
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_num_groups_get_group_id
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 1
/*000000000040*/ s_lshl_b32      s11, s10, 2
/*000000000044*/ s_mul_i32       s0, s8, s0
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s9, s1
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s11, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s10, s2
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_group_id
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ s_mul_i32       s7, s8, s0
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_mul_i32       s3, s9, s0
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_mul_i32       s0, s10, s0
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel mul_char_x_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s8, 1
/*000000000034*/ v_add_u32       v0, vcc, s0, v0
/*000000000038*/ s_waitcnt       lgkmcnt(0)
/*00000000003c*/ s_lshl_b32      s0, s1, 4
/*000000000040*/ s_add_u32       s2, s6, s2
/*000000000044*/ v_add_u32       v9, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ v_add_u32       v1, vcc, s2, v1
/*00000000005c*/ s_lshl_b32      s0, s1, 1
/*000000000060*/ s_add_u32       s1, s3, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s0
/*000000000074*/ v_add_u32       v1, vcc, s1, v2
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000084*/ flat_store_byte v[9:10], v5
/*00000000008c*/ flat_store_byte v[6:7], v8
/*000000000094*/ flat_store_byte v[0:1], v8
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_offset_get_local_size
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_lshl_b32      s0, s0, 1
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s1, v1
/*000000000050*/ s_lshl_b32      s0, s2, 4
/*000000000054*/ s_add_u32       s1, s6, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_lshl_b32      s0, s10, 1
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_id_get_local_size
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
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
/*000000000034*/ v_add_u32       v9, vcc, s4, v3
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*000000000044*/ v_lshlrev_b32   v0, 3, v0
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_lshlrev_b32   v1, 2, v1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_lshlrev_b32   v2, 1, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel mul_char_get_group_id_get_local_size
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v10, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, s1
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s6, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_mov_b32       v8, s3
/*000000000060*/ v_add_u32       v1, vcc, s0, v2
/*000000000064*/ v_add_u32       v0, vcc, s4, v1
/*000000000068*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v9, s6
/*000000000074*/ flat_store_byte v[10:11], v5
/*00000000007c*/ flat_store_byte v[6:7], v8
/*000000000084*/ flat_store_byte v[0:1], v9
/*00000000008c*/ s_endpgm
.kernel mul_char_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v9, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 4
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v8, 16
/*000000000070*/ flat_store_byte v[9:10], v5
/*000000000078*/ flat_store_byte v[6:7], v5
/*000000000080*/ flat_store_byte v[0:1], v8
/*000000000088*/ s_endpgm
.kernel mul_char_get_global_id_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_add_u32       v10, vcc, s4, v0
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*000000000044*/ v_lshlrev_b32   v3, 1, v3
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v1
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_lshlrev_b32   v8, 1, v1
/*000000000060*/ v_add_u32       v1, vcc, s0, v2
/*000000000064*/ v_add_u32       v12, vcc, s4, v1
/*000000000068*/ v_addc_u32      v13, vcc, v4, 0, vcc
/*000000000070*/ v_lshlrev_b32   v9, 2, v1
/*000000000074*/ flat_store_byte v[10:11], v3
/*00000000007c*/ flat_store_byte v[5:6], v8
/*000000000084*/ flat_store_byte v[12:13], v9
/*00000000008c*/ s_endpgm
.kernel mul_char_get_global_size_get_local_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_lshl_b32      s0, s12, 4
/*000000000044*/ s_add_u32       s2, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_lshl_b32      s0, s13, 1
/*000000000064*/ s_add_u32       s2, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ s_waitcnt       lgkmcnt(0)
/*000000000080*/ s_lshl_b32      s0, s1, 1
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_num_groups_get_local_size
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ v_add_u32       v0, vcc, s3, v0
/*000000000048*/ s_lshl_b32      s0, s0, 1
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_add_u32       v1, vcc, s3, v1
/*00000000006c*/ s_lshl_b32      s0, s1, 1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ v_add_u32       v1, vcc, s1, v2
/*000000000088*/ s_lshl_b32      s0, s2, 2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ v_add_u32       v0, vcc, s1, v0
/*000000000040*/ s_lshl_b32      s1, s0, 1
/*000000000044*/ s_add_u32       s3, s3, s14
/*000000000048*/ v_add_u32       v9, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s1
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s1, s6, s2
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_add_u32       v1, vcc, s1, v2
/*000000000074*/ s_lshl_b32      s0, s0, 2
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s0
/*000000000088*/ flat_store_byte v[9:10], v5
/*000000000090*/ flat_store_byte v[6:7], v5
/*000000000098*/ flat_store_byte v[0:1], v8
/*0000000000a0*/ s_endpgm
.kernel mul_char_x_get_global_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x38
/*000000000014*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s5, s7, 1
/*000000000030*/ s_lshl_b32      s6, s8, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v0, vcc, s0, v0
/*00000000003c*/ v_mul_lo_u32    v5, v0, s1
/*000000000044*/ v_add_u32       v3, vcc, s10, v0
/*000000000048*/ v_mov_b32       v6, s11
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ s_add_u32       s0, s5, s2
/*000000000060*/ v_add_u32       v0, vcc, s0, v1
/*000000000064*/ v_mul_lo_u32    v3, v0, s1
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ flat_store_byte v[0:1], v3
/*000000000080*/ s_add_u32       s0, s6, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_mul_lo_u32    v2, v0, s1
/*000000000090*/ v_add_u32       v0, vcc, s10, v0
/*000000000094*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000009c*/ flat_store_byte v[0:1], v2
/*0000000000a4*/ s_endpgm
.kernel mul_char_get_global_offset_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ v_mul_lo_u32    v5, v0, s0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_mul_lo_u32    v3, v0, s2
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ s_add_u32       s0, s5, s4
/*000000000078*/ v_add_u32       v0, vcc, s0, v2
/*00000000007c*/ v_mul_lo_u32    v2, v0, s4
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v2
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_id_get_global_id
    .config
        .dims xyz
        .cws 8, 4, 2
        .sgprsnum 17
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ v_mul_lo_u32    v0, v0, v3
/*000000000038*/ v_add_u32       v3, vcc, s10, v3
/*00000000003c*/ v_mov_b32       v5, s11
/*000000000040*/ v_addc_u32      v4, vcc, v5, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v0
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_mul_lo_u32    v3, v1, v0
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ s_add_u32       s0, s5, s4
/*000000000078*/ v_add_u32       v0, vcc, s0, v2
/*00000000007c*/ v_mul_lo_u32    v2, v2, v0
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v2
/*000000000098*/ s_endpgm
.kernel mul_char_get_group_id_get_global_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 17
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ v_mul_lo_u32    v5, s6, v0
/*000000000038*/ v_add_u32       v3, vcc, s10, v0
/*00000000003c*/ v_mov_b32       v6, s11
/*000000000040*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000048*/ flat_store_byte v[3:4], v5
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_mul_lo_u32    v3, s7, v0
/*000000000060*/ v_add_u32       v0, vcc, s10, v0
/*000000000064*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v3
/*000000000074*/ s_add_u32       s0, s5, s4
/*000000000078*/ v_add_u32       v0, vcc, s0, v2
/*00000000007c*/ v_mul_lo_u32    v2, s8, v0
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v2
/*000000000098*/ s_endpgm
.kernel mul_char_get_local_size_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ s_lshl_b32      s1, s8, 2
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_add_u32       v2, vcc, s1, v2
/*000000000038*/ v_add_u32       v1, vcc, s2, v1
/*00000000003c*/ v_add_u32       v9, vcc, s10, v0
/*000000000040*/ v_mov_b32       v4, s11
/*000000000044*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*00000000004c*/ v_lshlrev_b32   v0, 1, v0
/*000000000050*/ v_add_u32       v5, vcc, s10, v1
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_lshlrev_b32   v1, 1, v1
/*000000000060*/ v_add_u32       v2, vcc, s4, v2
/*000000000064*/ v_add_u32       v3, vcc, s10, v2
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_lshlrev_b32   v2, 2, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel mul_char_get_global_id_get_global_id
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_mul_lo_u32    v3, v3, v3
/*00000000003c*/ v_add_u32       v1, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s10
/*000000000044*/ v_mul_lo_u32    v4, v1, v1
/*00000000004c*/ v_add_u32       v2, vcc, s0, v2
/*000000000050*/ v_mul_lo_u32    v5, v2, v2
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v10, vcc, s4, v0
/*000000000060*/ v_mov_b32       v6, s5
/*000000000064*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*00000000006c*/ v_add_u32       v0, vcc, s4, v1
/*000000000070*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000078*/ v_add_u32       v7, vcc, s4, v2
/*00000000007c*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[10:11], v3
/*00000000008c*/ flat_store_byte v[0:1], v4
/*000000000094*/ flat_store_byte v[7:8], v5
/*00000000009c*/ s_endpgm
.kernel mul_char_get_global_size_get_global_id
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 1
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ v_mul_lo_u32    v5, s0, v0
/*000000000048*/ v_add_u32       v3, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v6, s5
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ s_add_u32       s0, s7, s14
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mul_lo_u32    v3, s1, v0
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ s_add_u32       s0, s8, s6
/*000000000088*/ v_add_u32       v0, vcc, s0, v2
/*00000000008c*/ v_mul_lo_u32    v2, s2, v0
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v2
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_num_groups_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 1
/*000000000030*/ s_lshr_b32      s1, s1, 1
/*000000000034*/ s_lshr_b32      s2, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ v_mul_lo_u32    v5, s0, v0
/*000000000054*/ v_add_u32       v3, vcc, s4, v0
/*000000000058*/ v_mov_b32       v6, s5
/*00000000005c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[3:4], v5
/*00000000006c*/ s_add_u32       s0, s7, s14
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_mul_lo_u32    v3, s1, v0
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000088*/ flat_store_byte v[0:1], v3
/*000000000090*/ s_add_u32       s0, s8, s6
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mul_lo_u32    v2, s2, v0
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000ac*/ flat_store_byte v[0:1], v2
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s5, s9, 1
/*000000000034*/ s_lshl_b32      s6, s10, 2
/*000000000038*/ s_add_u32       s1, s1, s12
/*00000000003c*/ v_add_u32       v0, vcc, s1, v0
/*000000000040*/ v_mul_lo_u32    v5, s0, v0
/*000000000048*/ v_add_u32       v3, vcc, s2, v0
/*00000000004c*/ v_mov_b32       v6, s3
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ s_add_u32       s1, s5, s14
/*000000000064*/ v_add_u32       v0, vcc, s1, v1
/*000000000068*/ v_mul_lo_u32    v3, s0, v0
/*000000000070*/ v_add_u32       v0, vcc, s2, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ s_add_u32       s1, s6, s4
/*000000000088*/ v_add_u32       v0, vcc, s1, v2
/*00000000008c*/ v_mul_lo_u32    v2, s0, v0
/*000000000094*/ v_add_u32       v0, vcc, s2, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v2
/*0000000000a8*/ s_endpgm
.kernel mul_char_x_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[6:7], 0x38
/*00000000001c*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000024*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*00000000002c*/ s_load_dword    s3, s[4:5], 0x14
/*000000000034*/ s_lshl_b32      s4, s8, 4
/*000000000038*/ s_lshl_b32      s5, s9, 1
/*00000000003c*/ s_add_u32       s0, s4, s0
/*000000000040*/ s_lshl_b32      s4, s10, 1
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_mul_i32       s8, s12, s1
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ s_add_u32       s0, s5, s2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s8
/*000000000068*/ s_mul_i32       s2, s13, s1
/*00000000006c*/ v_add_u32       v1, vcc, s0, v1
/*000000000070*/ s_add_u32       s0, s4, s14
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s2
/*000000000084*/ s_mul_i32       s1, s3, s1
/*000000000088*/ v_add_u32       v1, vcc, s0, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s1
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_global_offset_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s4, s9, 4
/*000000000034*/ s_add_u32       s3, s3, s0
/*000000000038*/ s_lshl_b32      s5, s10, 1
/*00000000003c*/ s_mul_i32       s0, s12, s0
/*000000000040*/ v_add_u32       v0, vcc, s3, v0
/*000000000044*/ s_add_u32       s3, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ s_mul_i32       s0, s13, s2
/*000000000060*/ v_add_u32       v1, vcc, s3, v1
/*000000000064*/ s_add_u32       s2, s5, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_mul_i32       s0, s1, s14
/*000000000080*/ v_add_u32       v1, vcc, s2, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_local_id_get_global_size
    .config
        .dims xyz
        .cws 8, 4, 2
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_lshl_b32      s3, s8, 3
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshl_b32      s7, s9, 2
/*000000000034*/ s_lshl_b32      s8, s10, 1
/*000000000038*/ v_mul_lo_u32    v5, s0, v0
/*000000000040*/ s_add_u32       s0, s3, s12
/*000000000044*/ v_add_u32       v0, vcc, s0, v0
/*000000000048*/ v_add_u32       v3, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v6, s5
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ v_mul_lo_u32    v3, s1, v1
/*000000000068*/ s_add_u32       s0, s7, s14
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, s2, v2
/*00000000008c*/ s_add_u32       s0, s8, s6
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_group_id_get_global_size
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s4, s9, 4
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ s_mul_i32       s5, s12, s8
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ s_add_u32       s0, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ s_mul_i32       s2, s13, s9
/*000000000060*/ v_add_u32       v1, vcc, s0, v1
/*000000000064*/ s_add_u32       s0, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s2
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_mul_i32       s1, s1, s10
/*000000000080*/ v_add_u32       v1, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s1
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_local_size_get_global_size
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_lshl_b32      s0, s12, 1
/*000000000044*/ s_add_u32       s2, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_lshl_b32      s0, s13, 1
/*000000000064*/ s_add_u32       s2, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ s_waitcnt       lgkmcnt(0)
/*000000000080*/ s_lshl_b32      s0, s1, 2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_global_id_get_global_size
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x14
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000030*/ v_add_u32       v0, vcc, s3, v0
/*000000000034*/ s_lshl_b32      s3, s9, 1
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s3, s2
/*000000000044*/ v_mul_lo_u32    v3, s12, v3
/*00000000004c*/ v_add_u32       v1, vcc, s0, v1
/*000000000050*/ s_add_u32       s0, s6, s14
/*000000000054*/ v_mul_lo_u32    v4, s13, v1
/*00000000005c*/ v_add_u32       v2, vcc, s0, v2
/*000000000060*/ s_waitcnt       lgkmcnt(0)
/*000000000064*/ v_mul_lo_u32    v5, s1, v2
/*00000000006c*/ v_add_u32       v10, vcc, s4, v0
/*000000000070*/ v_mov_b32       v6, s5
/*000000000074*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000088*/ v_add_u32       v7, vcc, s4, v2
/*00000000008c*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[10:11], v3
/*00000000009c*/ flat_store_byte v[0:1], v4
/*0000000000a4*/ flat_store_byte v[7:8], v5
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_global_size_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[14:15], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ s_lshl_b32      s3, s10, 1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_mul_i32       s0, s12, s12
/*000000000044*/ s_add_u32       s2, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_mul_i32       s0, s13, s13
/*000000000064*/ s_add_u32       s2, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ s_waitcnt       lgkmcnt(0)
/*000000000080*/ s_mul_i32       s0, s1, s1
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel mul_char_get_num_groups_get_global_size
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s5, s0, 1
/*000000000034*/ s_lshl_b32      s8, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s9, s1, 1
/*000000000040*/ s_lshl_b32      s10, s10, 2
/*000000000044*/ s_mul_i32       s0, s0, s5
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s8, s14
/*000000000050*/ s_lshr_b32      s5, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s1, s9
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s10, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s2, s5
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 24
        .vgprsnum 12
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[16:17], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_load_dword    s1, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s8, 1
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_bfe_u32       s0, s0, 0x20010
/*000000000040*/ s_lshl_b32      s5, s9, 1
/*000000000044*/ s_add_u32       s4, s4, s12
/*000000000048*/ s_lshl_b32      s8, s10, 2
/*00000000004c*/ s_mul_i32       s2, s2, s0
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ s_add_u32       s4, s5, s14
/*000000000058*/ v_add_u32       v10, vcc, s6, v0
/*00000000005c*/ v_mov_b32       v3, s7
/*000000000060*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_mul_i32       s2, s3, s0
/*000000000070*/ v_add_u32       v1, vcc, s4, v1
/*000000000074*/ s_add_u32       s3, s8, s16
/*000000000078*/ v_add_u32       v6, vcc, s6, v1
/*00000000007c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s2
/*000000000088*/ s_mul_i32       s0, s1, s0
/*00000000008c*/ v_add_u32       v1, vcc, s3, v2
/*000000000090*/ v_add_u32       v0, vcc, s6, v1
/*000000000094*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000009c*/ v_mov_b32       v9, s0
/*0000000000a0*/ flat_store_byte v[10:11], v5
/*0000000000a8*/ flat_store_byte v[6:7], v8
/*0000000000b0*/ flat_store_byte v[0:1], v9
/*0000000000b8*/ s_endpgm
.kernel mul_char_x_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[6:7], 0x38
/*000000000018*/ s_load_dword    s3, s[4:5], 0x14
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s5, s8, 4
/*000000000038*/ s_lshr_b32      s0, s0, 4
/*00000000003c*/ s_lshl_b32      s8, s9, 1
/*000000000040*/ s_add_u32       s5, s5, s12
/*000000000044*/ s_lshr_b32      s1, s1, 1
/*000000000048*/ s_lshl_b32      s9, s10, 1
/*00000000004c*/ s_mul_i32       s0, s0, s2
/*000000000050*/ v_add_u32       v0, vcc, s5, v0
/*000000000054*/ s_add_u32       s5, s8, s14
/*000000000058*/ s_lshr_b32      s3, s3, 1
/*00000000005c*/ v_add_u32       v10, vcc, s6, v0
/*000000000060*/ v_mov_b32       v3, s7
/*000000000064*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_mul_i32       s0, s1, s2
/*000000000074*/ v_add_u32       v1, vcc, s5, v1
/*000000000078*/ s_add_u32       s1, s9, s4
/*00000000007c*/ v_add_u32       v6, vcc, s6, v1
/*000000000080*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v8, s0
/*00000000008c*/ s_mul_i32       s0, s3, s2
/*000000000090*/ v_add_u32       v1, vcc, s1, v2
/*000000000094*/ v_add_u32       v0, vcc, s6, v1
/*000000000098*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a0*/ v_mov_b32       v9, s0
/*0000000000a4*/ flat_store_byte v[10:11], v5
/*0000000000ac*/ flat_store_byte v[6:7], v8
/*0000000000b4*/ flat_store_byte v[0:1], v9
/*0000000000bc*/ s_endpgm
.kernel mul_char_get_global_offset_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 4
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 4
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ s_mul_i32       s0, s0, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s1, s14
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s2, s4
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_local_id_get_num_groups
    .config
        .dims xyz
        .cws 8, 4, 2
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s0, s0, 3
/*000000000030*/ s_lshr_b32      s1, s1, 2
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 3
/*00000000003c*/ s_lshl_b32      s7, s9, 2
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ v_mul_lo_u32    v5, s0, v0
/*00000000004c*/ s_add_u32       s0, s3, s12
/*000000000050*/ v_add_u32       v0, vcc, s0, v0
/*000000000054*/ v_add_u32       v3, vcc, s4, v0
/*000000000058*/ v_mov_b32       v6, s5
/*00000000005c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[3:4], v5
/*00000000006c*/ v_mul_lo_u32    v3, s1, v1
/*000000000074*/ s_add_u32       s0, s7, s14
/*000000000078*/ v_add_u32       v0, vcc, s0, v1
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000088*/ flat_store_byte v[0:1], v3
/*000000000090*/ v_mul_lo_u32    v3, s2, v2
/*000000000098*/ s_add_u32       s0, s8, s6
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000ac*/ flat_store_byte v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_group_id_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 4
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 4
/*000000000040*/ s_lshl_b32      s11, s10, 1
/*000000000044*/ s_mul_i32       s0, s0, s8
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s1, s9
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s11, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s2, s10
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_local_size_get_num_groups
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ v_add_u32       v0, vcc, s3, v0
/*000000000048*/ s_lshl_b32      s0, s0, 1
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_add_u32       v1, vcc, s3, v1
/*00000000006c*/ s_lshl_b32      s0, s1, 1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ v_add_u32       v1, vcc, s1, v2
/*000000000088*/ s_lshl_b32      s0, s2, 2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_global_id_get_num_groups
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s3, s[4:5], 0x14
/*000000000024*/ s_lshl_b32      s4, s8, 1
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ s_lshl_b32      s4, s9, 1
/*000000000038*/ s_lshr_b32      s0, s0, 1
/*00000000003c*/ s_lshl_b32      s5, s10, 2
/*000000000040*/ v_add_u32       v3, vcc, s12, v0
/*000000000044*/ s_add_u32       s4, s4, s14
/*000000000048*/ s_lshr_b32      s1, s1, 1
/*00000000004c*/ v_mul_lo_u32    v3, s0, v3
/*000000000054*/ v_add_u32       v1, vcc, s4, v1
/*000000000058*/ s_add_u32       s0, s5, s2
/*00000000005c*/ s_waitcnt       lgkmcnt(0)
/*000000000060*/ s_lshr_b32      s2, s3, 2
/*000000000064*/ v_mul_lo_u32    v4, s1, v1
/*00000000006c*/ v_add_u32       v2, vcc, s0, v2
/*000000000070*/ v_mul_lo_u32    v5, s2, v2
/*000000000078*/ v_add_u32       v10, vcc, s6, v0
/*00000000007c*/ v_mov_b32       v6, s7
/*000000000080*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*000000000088*/ v_add_u32       v0, vcc, s6, v1
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ v_add_u32       v7, vcc, s6, v2
/*000000000098*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[10:11], v3
/*0000000000a8*/ flat_store_byte v[0:1], v4
/*0000000000b0*/ flat_store_byte v[7:8], v5
/*0000000000b8*/ s_endpgm
.kernel mul_char_get_global_size_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000028*/ s_lshl_b32      s3, s8, 4
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s5, s0, 4
/*000000000034*/ s_lshl_b32      s8, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s9, s1, 1
/*000000000040*/ s_lshl_b32      s10, s10, 1
/*000000000044*/ s_mul_i32       s0, s5, s0
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s8, s14
/*000000000050*/ s_lshr_b32      s5, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_mul_i32       s0, s9, s1
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s10, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_mul_i32       s0, s5, s2
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_num_groups_get_num_groups
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s2, s[4:5], 0x14
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000028*/ s_lshl_b32      s3, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_lshr_b32      s0, s0, 1
/*000000000034*/ s_lshl_b32      s5, s9, 1
/*000000000038*/ s_add_u32       s3, s3, s12
/*00000000003c*/ s_lshr_b32      s1, s1, 1
/*000000000040*/ s_lshl_b32      s8, s10, 2
/*000000000044*/ v_add_u32       v0, vcc, s3, v0
/*000000000048*/ s_mul_i32       s0, s0, s0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_add_u32       v1, vcc, s3, v1
/*00000000006c*/ s_mul_i32       s0, s1, s1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ v_add_u32       v1, vcc, s1, v2
/*000000000088*/ s_mul_i32       s0, s2, s2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel mul_char_get_work_dim_get_num_groups
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s1, s[4:5], 0x14
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s5, s8, 1
/*000000000038*/ s_bfe_u32       s0, s0, 0x20010
/*000000000040*/ s_lshr_b32      s2, s2, 1
/*000000000044*/ s_lshl_b32      s8, s9, 1
/*000000000048*/ s_add_u32       s5, s5, s12
/*00000000004c*/ s_lshr_b32      s3, s3, 1
/*000000000050*/ s_lshl_b32      s9, s10, 2
/*000000000054*/ s_mul_i32       s2, s2, s0
/*000000000058*/ v_add_u32       v0, vcc, s5, v0
/*00000000005c*/ s_add_u32       s5, s8, s14
/*000000000060*/ s_lshr_b32      s1, s1, 2
/*000000000064*/ v_add_u32       v10, vcc, s6, v0
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v5, s2
/*000000000078*/ s_mul_i32       s2, s3, s0
/*00000000007c*/ v_add_u32       v1, vcc, s5, v1
/*000000000080*/ s_add_u32       s3, s9, s4
/*000000000084*/ v_add_u32       v6, vcc, s6, v1
/*000000000088*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v8, s2
/*000000000094*/ s_mul_i32       s0, s1, s0
/*000000000098*/ v_add_u32       v1, vcc, s3, v2
/*00000000009c*/ v_add_u32       v0, vcc, s6, v1
/*0000000000a0*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a8*/ v_mov_b32       v9, s0
/*0000000000ac*/ flat_store_byte v[10:11], v5
/*0000000000b4*/ flat_store_byte v[6:7], v8
/*0000000000bc*/ flat_store_byte v[0:1], v9
/*0000000000c4*/ s_endpgm
.kernel mul_char_x_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 10
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dword    s1, s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshl_b32      s3, s8, 4
/*000000000030*/ s_bfe_u32       s0, s0, 0x20010
/*000000000038*/ s_lshl_b32      s6, s9, 1
/*00000000003c*/ s_add_u32       s3, s3, s12
/*000000000040*/ s_lshl_b32      s7, s10, 1
/*000000000044*/ s_mul_i32       s0, s0, s1
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s1, s6, s14
/*000000000050*/ v_add_u32       v8, vcc, s4, v0
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000060*/ v_mov_b32       v5, s0
/*000000000064*/ v_add_u32       v1, vcc, s1, v1
/*000000000068*/ s_add_u32       s0, s7, s2
/*00000000006c*/ v_add_u32       v6, vcc, s4, v1
/*000000000070*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000078*/ v_add_u32       v1, vcc, s0, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ flat_store_byte v[8:9], v5
/*000000000090*/ flat_store_byte v[6:7], v5
/*000000000098*/ flat_store_byte v[0:1], v5
/*0000000000a0*/ s_endpgm
.kernel mul_char_get_global_offset_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 4
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 1
/*00000000003c*/ s_mul_i32       s7, s0, s12
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_mul_i32       s3, s0, s14
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_mul_i32       s0, s0, s2
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_local_id_get_work_dim
    .config
        .dims xyz
        .cws 8, 4, 2
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
        .arg x, "int", int
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s0, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 3
/*000000000030*/ s_lshl_b32      s5, s9, 2
/*000000000034*/ s_lshl_b32      s6, s10, 1
/*000000000038*/ v_mul_lo_u32    v5, s0, v0
/*000000000040*/ s_add_u32       s1, s1, s12
/*000000000044*/ v_add_u32       v0, vcc, s1, v0
/*000000000048*/ v_add_u32       v3, vcc, s2, v0
/*00000000004c*/ v_mov_b32       v6, s3
/*000000000050*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000058*/ flat_store_byte v[3:4], v5
/*000000000060*/ v_mul_lo_u32    v3, s0, v1
/*000000000068*/ s_add_u32       s1, s5, s14
/*00000000006c*/ v_add_u32       v0, vcc, s1, v1
/*000000000070*/ v_add_u32       v0, vcc, s2, v0
/*000000000074*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*00000000007c*/ flat_store_byte v[0:1], v3
/*000000000084*/ v_mul_lo_u32    v3, s0, v2
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s2, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_group_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 16, 2
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 4
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 1
/*00000000003c*/ s_mul_i32       s7, s0, s8
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_mul_i32       s3, s0, s9
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_mul_i32       s0, s0, s10
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_local_size_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 11
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ v_add_u32       v0, vcc, s1, v0
/*000000000040*/ s_lshl_b32      s1, s0, 1
/*000000000044*/ s_add_u32       s3, s3, s14
/*000000000048*/ v_add_u32       v9, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s1
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s1, s6, s2
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_add_u32       v1, vcc, s1, v2
/*000000000074*/ s_lshl_b32      s0, s0, 2
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s0
/*000000000088*/ flat_store_byte v[9:10], v5
/*000000000090*/ flat_store_byte v[6:7], v5
/*000000000098*/ flat_store_byte v[0:1], v8
/*0000000000a0*/ s_endpgm
.kernel mul_char_get_global_id_get_work_dim
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_lshl_b32      s1, s8, 1
/*00000000001c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000024*/ v_add_u32       v0, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s9, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_bfe_u32       s0, s0, 0x20010
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s12, v0
/*000000000040*/ s_add_u32       s1, s1, s14
/*000000000044*/ v_mul_lo_u32    v3, s0, v3
/*00000000004c*/ v_add_u32       v1, vcc, s1, v1
/*000000000050*/ s_add_u32       s1, s3, s2
/*000000000054*/ v_mul_lo_u32    v4, v1, s0
/*00000000005c*/ v_add_u32       v2, vcc, s1, v2
/*000000000060*/ v_mul_lo_u32    v5, v2, s0
/*000000000068*/ v_add_u32       v10, vcc, s4, v0
/*00000000006c*/ v_mov_b32       v6, s5
/*000000000070*/ v_addc_u32      v11, vcc, v6, 0, vcc
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ v_add_u32       v7, vcc, s4, v2
/*000000000088*/ v_addc_u32      v8, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[10:11], v3
/*000000000098*/ flat_store_byte v[0:1], v4
/*0000000000a0*/ flat_store_byte v[7:8], v5
/*0000000000a8*/ s_endpgm
.kernel mul_char_get_global_size_get_work_dim
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
        .vgprsnum 12
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
        .arg data, "char*", char*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[16:17], s[6:7], 0x10
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x30
/*000000000028*/ s_load_dword    s1, s[4:5], 0x14
/*000000000030*/ s_lshl_b32      s4, s8, 4
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_bfe_u32       s0, s0, 0x20010
/*000000000040*/ s_lshl_b32      s5, s9, 1
/*000000000044*/ s_add_u32       s4, s4, s12
/*000000000048*/ s_lshl_b32      s8, s10, 1
/*00000000004c*/ s_mul_i32       s2, s0, s2
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ s_add_u32       s4, s5, s14
/*000000000058*/ v_add_u32       v10, vcc, s6, v0
/*00000000005c*/ v_mov_b32       v3, s7
/*000000000060*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_mul_i32       s2, s0, s3
/*000000000070*/ v_add_u32       v1, vcc, s4, v1
/*000000000074*/ s_add_u32       s3, s8, s16
/*000000000078*/ v_add_u32       v6, vcc, s6, v1
/*00000000007c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s2
/*000000000088*/ s_mul_i32       s0, s0, s1
/*00000000008c*/ v_add_u32       v1, vcc, s3, v2
/*000000000090*/ v_add_u32       v0, vcc, s6, v1
/*000000000094*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000009c*/ v_mov_b32       v9, s0
/*0000000000a0*/ flat_store_byte v[10:11], v5
/*0000000000a8*/ flat_store_byte v[6:7], v8
/*0000000000b0*/ flat_store_byte v[0:1], v9
/*0000000000b8*/ s_endpgm
.kernel mul_char_get_num_groups_get_work_dim
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s1, s[4:5], 0x14
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s5, s8, 1
/*000000000038*/ s_bfe_u32       s0, s0, 0x20010
/*000000000040*/ s_lshr_b32      s2, s2, 1
/*000000000044*/ s_lshl_b32      s8, s9, 1
/*000000000048*/ s_add_u32       s5, s5, s12
/*00000000004c*/ s_lshr_b32      s3, s3, 1
/*000000000050*/ s_lshl_b32      s9, s10, 2
/*000000000054*/ s_mul_i32       s2, s0, s2
/*000000000058*/ v_add_u32       v0, vcc, s5, v0
/*00000000005c*/ s_add_u32       s5, s8, s14
/*000000000060*/ s_lshr_b32      s1, s1, 2
/*000000000064*/ v_add_u32       v10, vcc, s6, v0
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v5, s2
/*000000000078*/ s_mul_i32       s2, s0, s3
/*00000000007c*/ v_add_u32       v1, vcc, s5, v1
/*000000000080*/ s_add_u32       s3, s9, s4
/*000000000084*/ v_add_u32       v6, vcc, s6, v1
/*000000000088*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v8, s2
/*000000000094*/ s_mul_i32       s0, s0, s1
/*000000000098*/ v_add_u32       v1, vcc, s3, v2
/*00000000009c*/ v_add_u32       v0, vcc, s6, v1
/*0000000000a0*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a8*/ v_mov_b32       v9, s0
/*0000000000ac*/ flat_store_byte v[10:11], v5
/*0000000000b4*/ flat_store_byte v[6:7], v8
/*0000000000bc*/ flat_store_byte v[0:1], v9
/*0000000000c4*/ s_endpgm
.kernel mul_char_get_work_dim_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 10
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x10
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_lshl_b32      s1, s8, 1
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s0, s0, 0x20010
/*000000000030*/ s_lshl_b32      s3, s9, 1
/*000000000034*/ s_add_u32       s1, s1, s12
/*000000000038*/ s_lshl_b32      s6, s10, 2
/*00000000003c*/ v_add_u32       v0, vcc, s1, v0
/*000000000040*/ s_mul_i32       s0, s0, s0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v8, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s1, v1
/*000000000060*/ s_add_u32       s0, s6, s2
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_add_u32       v1, vcc, s0, v2
/*000000000074*/ v_add_u32       v0, vcc, s4, v1
/*000000000078*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000080*/ flat_store_byte v[8:9], v5
/*000000000088*/ flat_store_byte v[6:7], v5
/*000000000090*/ flat_store_byte v[0:1], v5
/*000000000098*/ s_endpgm
.kernel mul_char_x_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_mul_i32       s0, s1, s1
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v1, s3
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ v_mov_b32       v2, s0
/*000000000044*/ flat_store_byte v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel mul_char_get_global_offset_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_mul_i32       s0, s0, s0
/*000000000024*/ v_add_u32       v0, vcc, s2, v0
/*000000000028*/ v_mov_b32       v1, s3
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ v_mov_b32       v2, s0
/*000000000038*/ flat_store_byte v[0:1], v2
/*000000000040*/ s_endpgm
.kernel mul_char_get_local_id_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v1, vcc, s0, v0
/*000000000020*/ v_add_u32       v1, vcc, s2, v1
/*000000000024*/ v_mov_b32       v2, s3
/*000000000028*/ v_addc_u32      v2, vcc, v2, 0, vcc
/*000000000030*/ v_mul_i32_i24   v0, v0, v0
/*000000000034*/ flat_store_byte v[1:2], v0
/*00000000003c*/ s_endpgm
.kernel mul_char_get_group_id_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_lshl_b32      s0, s6, 6
/*000000000004*/ s_mul_i32       s1, s6, s6
/*000000000008*/ v_mov_b32       v2, s1
/*00000000000c*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s0, s2
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_add_u32       v0, vcc, s4, v0
/*00000000002c*/ v_mov_b32       v1, s5
/*000000000030*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000038*/ flat_store_byte v[0:1], v2
/*000000000040*/ s_endpgm
.kernel mul_char_get_local_size_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_add_u32       v0, vcc, s2, v0
/*000000000024*/ v_mov_b32       v1, s3
/*000000000028*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000030*/ v_mov_b32       v2, 0
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel mul_char_get_global_id_64
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 6
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mul_lo_u32    v2, v0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v1, s3
/*000000000034*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000003c*/ flat_store_byte v[0:1], v2
/*000000000044*/ s_endpgm
.kernel mul_char_get_global_size_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0xc
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_mul_i32       s0, s1, s1
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v1, s3
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ v_mov_b32       v2, s0
/*000000000044*/ flat_store_byte v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel mul_char_get_num_groups_64
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0xc
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_lshl_b32      s1, s8, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_lshr_b32      s0, s0, 6
/*000000000024*/ s_add_u32       s1, s1, s2
/*000000000028*/ v_add_u32       v0, vcc, s1, v0
/*00000000002c*/ s_mul_i32       s0, s0, s0
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ v_mov_b32       v1, s5
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ v_mov_b32       v2, s0
/*000000000044*/ flat_store_byte v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel mul_char_get_work_dim
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_lshl_b32      s1, s8, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_bfe_u32       s0, s0, 0x20010
/*000000000028*/ s_add_u32       s1, s1, s2
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_mul_i32       s0, s0, s0
/*000000000034*/ v_add_u32       v0, vcc, s4, v0
/*000000000038*/ v_mov_b32       v1, s5
/*00000000003c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ flat_store_byte v[0:1], v2
/*000000000050*/ s_endpgm
.kernel mul_char_x_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s3, s6, 3
/*000000000020*/ s_lshl_b32      s6, s7, 3
/*000000000024*/ s_add_u32       s2, s6, s2
/*000000000028*/ v_add_u32       v1, vcc, s2, v1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ v_mul_lo_u32    v2, v1, s1
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ v_add_u32       v0, vcc, s4, v0
/*000000000044*/ v_mov_b32       v1, s5
/*000000000048*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000050*/ flat_store_byte v[0:1], v2
/*000000000058*/ s_endpgm
.kernel mul_char_get_global_offset_8_8
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ s_mul_i32       s0, s2, s0
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ v_add_u32       v0, vcc, s4, v0
/*000000000028*/ v_mov_b32       v1, s5
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ v_mov_b32       v2, s0
/*000000000038*/ flat_store_byte v[0:1], v2
/*000000000040*/ s_endpgm
.kernel mul_char_get_local_id_8_8
    .config
        .dims x, xy
        .cws 8, 8, 1
        .sgprsnum 13
        .vgprsnum 3
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ v_mul_i32_i24   v2, v1, v0
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ v_add_u32       v0, vcc, s0, v0
/*000000000024*/ v_add_u32       v0, vcc, s2, v0
/*000000000028*/ v_mov_b32       v1, s3
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel mul_char_get_group_id_8_8
    .config
        .dims xy, x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_lshl_b32      s0, s6, 3
/*000000000004*/ s_mul_i32       s1, s7, s6
/*000000000008*/ v_mov_b32       v2, s1
/*00000000000c*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s0, s2
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_add_u32       v0, vcc, s4, v0
/*00000000002c*/ v_mov_b32       v1, s5
/*000000000030*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000038*/ flat_store_byte v[0:1], v2
/*000000000040*/ s_endpgm
.kernel mul_char_get_local_size_8_8
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_add_u32       v0, vcc, s2, v0
/*000000000024*/ v_mov_b32       v1, s3
/*000000000028*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000030*/ v_mov_b32       v2, 64
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel mul_char_get_global_id_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 3
/*000000000010*/ s_lshl_b32      s3, s7, 3
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ s_add_u32       s1, s3, s2
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ v_mul_lo_u32    v2, v1, v0
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_add_u32       v0, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v1, s5
/*000000000040*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000048*/ flat_store_byte v[0:1], v2
/*000000000050*/ s_endpgm
.kernel mul_char_get_global_size_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s8, 3
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ s_mul_i32       s1, s3, s2
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_add_u32       v0, vcc, s4, v0
/*000000000030*/ v_mov_b32       v1, s5
/*000000000034*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000003c*/ v_mov_b32       v2, s1
/*000000000040*/ flat_store_byte v[0:1], v2
/*000000000048*/ s_endpgm
.kernel mul_char_get_num_groups_8_8
    .config
        .dims x
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s3, s8, 3
/*000000000020*/ s_lshr_b32      s0, s0, 3
/*000000000024*/ s_lshr_b32      s1, s1, 3
/*000000000028*/ s_add_u32       s2, s3, s2
/*00000000002c*/ s_mul_i32       s0, s1, s0
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_add_u32       v0, vcc, s4, v0
/*000000000038*/ v_mov_b32       v1, s5
/*00000000003c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ flat_store_byte v[0:1], v2
/*000000000050*/ s_endpgm
.kernel mul_char_get_work_dim_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_lshl_b32      s3, s9, 3
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_add_u32       s2, s3, s2
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s1, s1, 0x20010
/*000000000030*/ v_add_u32       v1, vcc, s2, v1
/*000000000034*/ s_lshl_b32      s2, s8, 3
/*000000000038*/ v_mul_lo_u32    v2, v1, s1
/*000000000040*/ s_add_u32       s0, s2, s0
/*000000000044*/ v_add_u32       v0, vcc, s0, v0
/*000000000048*/ v_add_u32       v0, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v1, s5
/*000000000050*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000058*/ flat_store_byte v[0:1], v2
/*000000000060*/ s_endpgm
