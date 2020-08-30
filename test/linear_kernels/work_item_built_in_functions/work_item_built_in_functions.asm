/* Disassembling 'linear_kernels\work_item_built_in_functions\work_item_built_in_functions.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel copy_x
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
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel copy_get_global_offset
    .config
        .dims xyz
        .cws 4, 16, 2
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
/*00000000001c*/ s_lshl_b32      s1, s6, 2
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s1, s1, s0
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v3, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v6, vcc, s1, v1
/*000000000038*/ s_add_u32       s1, s6, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v8, vcc, s1, v2
/*00000000004c*/ v_add_u32       v10, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v7, s2
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000080*/ v_add_u32       v12, vcc, s4, v8
/*000000000084*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000088*/ v_mov_b32       v8, s10
/*00000000008c*/ flat_store_dword v[10:11], v5
/*000000000094*/ flat_store_dword v[1:2], v7
/*00000000009c*/ flat_store_dword v[12:13], v8
/*0000000000a4*/ s_endpgm
.kernel copy_get_local_id
    .config
        .dims xyz
        .cws 8, 4, 4
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
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_lshl_b32      s6, s8, 2
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v5, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s6, s10
/*000000000034*/ v_add_u32       v3, vcc, s0, v2
/*000000000038*/ v_mov_b32       v4, 0
/*00000000003c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000044*/ v_mov_b32       v6, 0
/*000000000048*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*000000000050*/ v_add_u32       v5, vcc, s4, v5
/*000000000054*/ v_mov_b32       v7, s5
/*000000000058*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*00000000005c*/ flat_store_dword v[5:6], v0
/*000000000064*/ v_add_u32       v5, vcc, s4, v3
/*000000000068*/ v_addc_u32      v6, vcc, v7, v4, vcc
/*00000000006c*/ s_add_u32       s0, s3, s2
/*000000000070*/ v_add_u32       v3, vcc, s0, v1
/*000000000074*/ v_mov_b32       v4, 0
/*000000000078*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000080*/ v_add_u32       v3, vcc, s4, v3
/*000000000084*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000088*/ flat_store_dword v[3:4], v1
/*000000000090*/ flat_store_dword v[5:6], v2
/*000000000098*/ s_endpgm
.kernel copy_get_group_id
    .config
        .dims xyz
        .cws 4, 16, 2
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
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 2
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ s_add_u32       s1, s1, s10
/*000000000038*/ v_add_u32       v8, vcc, s0, v1
/*00000000003c*/ v_add_u32       v2, vcc, s1, v2
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v11, vcc, s4, v0
/*000000000050*/ v_mov_b32       v5, s5
/*000000000054*/ v_addc_u32      v12, vcc, v5, v1, vcc
/*000000000058*/ v_mov_b32       v7, s6
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 2, v[8:9]
/*000000000068*/ v_mov_b32       v3, 0
/*00000000006c*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000007c*/ v_mov_b32       v10, s7
/*000000000080*/ v_add_u32       v2, vcc, s4, v2
/*000000000084*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*000000000088*/ v_mov_b32       v5, s8
/*00000000008c*/ flat_store_dword v[11:12], v7
/*000000000094*/ flat_store_dword v[0:1], v10
/*00000000009c*/ flat_store_dword v[2:3], v5
/*0000000000a4*/ s_endpgm
.kernel copy_get_local_size
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
/*000000000058*/ v_mov_b32       v5, 2
/*00000000005c*/ v_mov_b32       v7, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000068*/ v_add_u32       v1, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*00000000007c*/ v_add_u32       v12, vcc, s4, v7
/*000000000080*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*000000000084*/ v_mov_b32       v7, 4
/*000000000088*/ flat_store_dword v[10:11], v5
/*000000000090*/ flat_store_dword v[1:2], v5
/*000000000098*/ flat_store_dword v[12:13], v7
/*0000000000a0*/ s_endpgm
.kernel copy_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v3, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v3
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000003c*/ v_add_u32       v3, vcc, s10, v3
/*000000000040*/ v_mov_b32       v5, s11
/*000000000044*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000048*/ flat_store_dword v[3:4], v0
/*000000000050*/ s_add_u32       s0, s1, s2
/*000000000054*/ v_add_u32       v3, vcc, s0, v1
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*000000000064*/ v_add_u32       v0, vcc, s10, v0
/*000000000068*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000006c*/ flat_store_dword v[0:1], v3
/*000000000074*/ s_add_u32       s0, s3, s4
/*000000000078*/ v_add_u32       v2, vcc, s0, v2
/*00000000007c*/ v_mov_b32       v3, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*000000000088*/ v_add_u32       v0, vcc, s10, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000090*/ flat_store_dword v[0:1], v2
/*000000000098*/ s_endpgm
.kernel copy_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 21
        .vgprsnum 13
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
/*000000000028*/ s_lshl_b32      s3, s9, 1
/*00000000002c*/ s_add_u32       s0, s1, s0
/*000000000030*/ s_load_dword    s1, s[4:5], 0x14
/*000000000038*/ s_lshl_b32      s4, s10, 1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s3, s2
/*000000000044*/ s_add_u32       s2, s4, s12
/*000000000048*/ v_add_u32       v8, vcc, s0, v1
/*00000000004c*/ v_add_u32       v2, vcc, s2, v2
/*000000000050*/ v_mov_b32       v1, 0
/*000000000054*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000005c*/ v_add_u32       v11, vcc, s6, v0
/*000000000060*/ v_mov_b32       v5, s7
/*000000000064*/ v_addc_u32      v12, vcc, v5, v1, vcc
/*000000000068*/ v_mov_b32       v7, s14
/*00000000006c*/ v_mov_b32       v9, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[8:9]
/*000000000078*/ v_mov_b32       v3, 0
/*00000000007c*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000084*/ v_add_u32       v0, vcc, s6, v0
/*000000000088*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000008c*/ v_mov_b32       v10, s15
/*000000000090*/ v_add_u32       v2, vcc, s6, v2
/*000000000094*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ v_mov_b32       v5, s1
/*0000000000a0*/ flat_store_dword v[11:12], v7
/*0000000000a8*/ flat_store_dword v[0:1], v10
/*0000000000b0*/ flat_store_dword v[2:3], v5
/*0000000000b8*/ s_endpgm
.kernel copy_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 21
        .vgprsnum 13
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
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s4, s2
/*000000000044*/ s_add_u32       s1, s1, s12
/*000000000048*/ v_add_u32       v8, vcc, s0, v1
/*00000000004c*/ s_lshr_b32      s0, s14, 1
/*000000000050*/ v_add_u32       v2, vcc, s1, v2
/*000000000054*/ v_mov_b32       v1, 0
/*000000000058*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000060*/ s_lshr_b32      s1, s15, 1
/*000000000064*/ v_add_u32       v11, vcc, s6, v0
/*000000000068*/ v_mov_b32       v5, s7
/*00000000006c*/ v_addc_u32      v12, vcc, v5, v1, vcc
/*000000000070*/ v_mov_b32       v7, s0
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 2, v[8:9]
/*000000000080*/ s_waitcnt       lgkmcnt(0)
/*000000000084*/ s_lshr_b32      s0, s3, 2
/*000000000088*/ v_mov_b32       v3, 0
/*00000000008c*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000094*/ v_add_u32       v0, vcc, s6, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ v_mov_b32       v10, s1
/*0000000000a0*/ v_add_u32       v2, vcc, s6, v2
/*0000000000a4*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*0000000000a8*/ v_mov_b32       v5, s0
/*0000000000ac*/ flat_store_dword v[11:12], v7
/*0000000000b4*/ flat_store_dword v[0:1], v10
/*0000000000bc*/ flat_store_dword v[2:3], v5
/*0000000000c4*/ s_endpgm
.kernel copy_get_work_dim
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
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 1
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s1, 0x20010
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ v_add_u32       v0, vcc, s2, v0
/*000000000044*/ v_mov_b32       v2, s3
/*000000000048*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
