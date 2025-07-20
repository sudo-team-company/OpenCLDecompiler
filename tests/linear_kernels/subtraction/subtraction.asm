.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel subtract_x_x
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
/*000000000038*/ v_mov_b32       v2, 0
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel subtract_get_global_offset_x
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
/*000000000048*/ s_sub_u32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_sub_u32       s0, s2, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_sub_u32       s0, s10, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel subtract_get_local_id_x
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
/*000000000034*/ v_subrev_u32    v5, vcc, s1, v0
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v6, s11
/*000000000054*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000058*/ flat_store_dword v[3:4], v5
/*000000000060*/ v_subrev_u32    v3, vcc, s1, v1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_mov_b32       v1, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ flat_store_dword v[0:1], v3
/*000000000088*/ v_subrev_u32    v3, vcc, s1, v2
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel subtract_get_group_id_x
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
/*000000000048*/ s_sub_u32       s2, s6, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_sub_u32       s0, s7, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_sub_u32       s0, s8, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel subtract_get_local_size_x
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
/*000000000054*/ s_sub_u32       s2, 2, s1
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
/*00000000008c*/ s_sub_u32       s0, 4, s1
/*000000000090*/ v_add_u32       v12, vcc, s4, v7
/*000000000094*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ flat_store_dword v[10:11], v5
/*0000000000a4*/ flat_store_dword v[1:2], v5
/*0000000000ac*/ flat_store_dword v[12:13], v7
/*0000000000b4*/ s_endpgm
.kernel subtract_get_global_id_x
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[12:13], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s4, s7, 1
/*00000000002c*/ v_add_u32       v5, vcc, s3, v0
/*000000000030*/ s_lshl_b32      s3, s8, 2
/*000000000034*/ s_add_u32       s2, s4, s2
/*000000000038*/ v_add_u32       v8, vcc, s2, v1
/*00000000003c*/ s_add_u32       s2, s3, s10
/*000000000040*/ v_mov_b32       v6, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*00000000004c*/ v_add_u32       v0, vcc, s0, v5
/*000000000050*/ v_add_u32       v10, vcc, s2, v2
/*000000000054*/ v_add_u32       v3, vcc, s12, v3
/*000000000058*/ v_mov_b32       v5, s13
/*00000000005c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000060*/ s_waitcnt       lgkmcnt(0)
/*000000000064*/ v_subrev_u32    v0, vcc, s1, v0
/*000000000068*/ v_mov_b32       v9, 0
/*00000000006c*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000074*/ v_subrev_u32    v1, vcc, s1, v8
/*000000000078*/ v_add_u32       v6, vcc, s12, v6
/*00000000007c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000080*/ v_mov_b32       v11, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*00000000008c*/ v_subrev_u32    v2, vcc, s1, v10
/*000000000090*/ v_add_u32       v8, vcc, s12, v8
/*000000000094*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*000000000098*/ flat_store_dword v[3:4], v0
/*0000000000a0*/ flat_store_dword v[6:7], v1
/*0000000000a8*/ flat_store_dword v[8:9], v2
/*0000000000b0*/ s_endpgm
.kernel subtract_get_global_size_x
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
/*000000000058*/ s_sub_u32       s2, s14, s1
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ s_sub_u32       s0, s15, s1
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ v_add_u32       v1, vcc, s6, v6
/*000000000090*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000094*/ v_mov_b32       v7, s0
/*000000000098*/ s_sub_u32       s0, s4, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ v_add_u32       v12, vcc, s6, v8
/*0000000000ac*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b0*/ v_mov_b32       v8, s0
/*0000000000b4*/ flat_store_dword v[10:11], v5
/*0000000000bc*/ flat_store_dword v[1:2], v7
/*0000000000c4*/ flat_store_dword v[12:13], v8
/*0000000000cc*/ s_endpgm
.kernel subtract_get_num_groups_x
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
/*000000000060*/ s_sub_u32       s2, s2, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ s_lshr_b32      s0, s3, 2
/*000000000078*/ v_add_u32       v10, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v3, s5
/*000000000080*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ s_sub_u32       s2, s6, s1
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000098*/ v_add_u32       v1, vcc, s4, v6
/*00000000009c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a0*/ v_mov_b32       v7, s2
/*0000000000a4*/ s_sub_u32       s0, s0, s1
/*0000000000a8*/ v_mov_b32       v9, 0
/*0000000000ac*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b4*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b8*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000bc*/ v_mov_b32       v8, s0
/*0000000000c0*/ flat_store_dword v[10:11], v5
/*0000000000c8*/ flat_store_dword v[1:2], v7
/*0000000000d0*/ flat_store_dword v[12:13], v8
/*0000000000d8*/ s_endpgm
.kernel subtract_get_work_dim_x
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
/*00000000003c*/ s_sub_u32       s0, s0, s2
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s4, v0
/*000000000050*/ v_mov_b32       v2, s5
/*000000000054*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000058*/ v_mov_b32       v2, s0
/*00000000005c*/ flat_store_dword v[0:1], v2
/*000000000064*/ s_endpgm
.kernel subtract_x_get_global_offset
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
/*000000000048*/ s_sub_u32       s0, s1, s0
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_sub_u32       s0, s1, s2
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_sub_u32       s0, s1, s10
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel subtract_get_global_offset_get_global_offset
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_local_id_get_global_offset
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
/*000000000030*/ v_subrev_u32    v0, vcc, s0, v0
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ v_add_u32       v3, vcc, s10, v3
/*000000000044*/ v_mov_b32       v5, s11
/*000000000048*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000004c*/ flat_store_dword v[3:4], v0
/*000000000054*/ v_subrev_u32    v3, vcc, s2, v1
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v3
/*00000000007c*/ v_subrev_u32    v3, vcc, s4, v2
/*000000000080*/ s_add_u32       s0, s5, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel subtract_get_group_id_get_global_offset
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
/*00000000003c*/ s_sub_u32       s0, s6, s0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ s_sub_u32       s0, s7, s2
/*000000000064*/ v_mov_b32       v7, 0
/*000000000068*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ s_sub_u32       s0, s8, s10
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_local_size_get_global_offset
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
/*000000000048*/ s_sub_u32       s0, 2, s0
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_sub_u32       s0, 2, s2
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_sub_u32       s0, 4, s10
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_global_id_get_global_offset
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x8
/*000000000010*/ s_lshl_b32      s2, s6, 1
/*000000000014*/ v_add_u32       v6, vcc, s2, v0
/*000000000018*/ s_lshl_b32      s2, s7, 1
/*00000000001c*/ v_add_u32       v4, vcc, s2, v1
/*000000000020*/ s_lshl_b32      s2, s8, 2
/*000000000024*/ v_add_u32       v2, vcc, s2, v2
/*000000000028*/ v_mov_b32       v7, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_add_u32       v0, vcc, s0, v0
/*00000000003c*/ v_mov_b32       v5, s1
/*000000000040*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000044*/ flat_store_dword v[0:1], v6
/*00000000004c*/ v_add_u32       v0, vcc, s12, v4
/*000000000050*/ v_mov_b32       v1, 0
/*000000000054*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000005c*/ v_add_u32       v0, vcc, s0, v0
/*000000000060*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000064*/ flat_store_dword v[0:1], v4
/*00000000006c*/ v_add_u32       v0, vcc, s14, v2
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s0, v0
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v2
/*00000000008c*/ s_endpgm
.kernel subtract_get_global_size_get_global_offset
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
/*00000000004c*/ s_sub_u32       s0, s14, s0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s1, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_sub_u32       s0, s15, s2
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_sub_u32       s0, s3, s12
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_num_groups_get_global_offset
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
/*000000000054*/ s_sub_u32       s0, s6, s0
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s3, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s1, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ s_sub_u32       s0, s7, s2
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ s_sub_u32       s0, s1, s14
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_work_dim_get_global_offset
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
/*000000000050*/ s_sub_u32       s0, s1, s0
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s3, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s0
/*000000000074*/ s_sub_u32       s0, s1, s2
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_sub_u32       s0, s1, s4
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_x_get_local_id
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
/*000000000034*/ v_sub_u32       v5, vcc, s1, v0
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v6, s11
/*000000000054*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000058*/ flat_store_dword v[3:4], v5
/*000000000060*/ v_sub_u32       v3, vcc, s1, v1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_mov_b32       v1, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ flat_store_dword v[0:1], v3
/*000000000088*/ v_sub_u32       v3, vcc, s1, v2
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel subtract_get_global_offset_get_local_id
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
/*000000000030*/ v_sub_u32       v0, vcc, s0, v0
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ v_add_u32       v3, vcc, s10, v3
/*000000000044*/ v_mov_b32       v5, s11
/*000000000048*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000004c*/ flat_store_dword v[3:4], v0
/*000000000054*/ v_sub_u32       v3, vcc, s2, v1
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v3
/*00000000007c*/ v_sub_u32       v3, vcc, s4, v2
/*000000000080*/ s_add_u32       s0, s5, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel subtract_get_local_id_get_local_id
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_group_id_get_local_id
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
/*000000000030*/ v_sub_u32       v0, vcc, s6, v0
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ v_add_u32       v3, vcc, s10, v3
/*000000000044*/ v_mov_b32       v5, s11
/*000000000048*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000004c*/ flat_store_dword v[3:4], v0
/*000000000054*/ v_sub_u32       v3, vcc, s7, v1
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v3
/*00000000007c*/ v_sub_u32       v3, vcc, s8, v2
/*000000000080*/ s_add_u32       s0, s5, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel subtract_get_local_size_get_local_id
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
/*000000000058*/ v_sub_u32       v0, vcc, 2, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_sub_u32       v1, vcc, 2, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_sub_u32       v2, vcc, 4, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_global_id_get_local_id
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
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ v_add_u32       v7, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ s_add_u32       s2, s3, s2
/*000000000030*/ v_add_u32       v11, vcc, s2, v1
/*000000000034*/ s_add_u32       s1, s1, s10
/*000000000038*/ v_mov_b32       v8, 0
/*00000000003c*/ v_lshlrev_b64   v[5:6], 2, v[7:8]
/*000000000044*/ v_add_u32       v3, vcc, s0, v7
/*000000000048*/ v_add_u32       v13, vcc, s1, v2
/*00000000004c*/ v_add_u32       v5, vcc, s4, v5
/*000000000050*/ v_mov_b32       v8, s5
/*000000000054*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000058*/ v_sub_u32       v0, vcc, v3, v0
/*00000000005c*/ v_mov_b32       v12, 0
/*000000000060*/ v_lshlrev_b64   v[9:10], 2, v[11:12]
/*000000000068*/ v_sub_u32       v1, vcc, v11, v1
/*00000000006c*/ v_add_u32       v3, vcc, s4, v9
/*000000000070*/ v_addc_u32      v4, vcc, v8, v10, vcc
/*000000000074*/ v_mov_b32       v14, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[13:14]
/*000000000080*/ v_sub_u32       v2, vcc, v13, v2
/*000000000084*/ v_add_u32       v7, vcc, s4, v9
/*000000000088*/ v_addc_u32      v8, vcc, v8, v10, vcc
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[3:4], v1
/*00000000009c*/ flat_store_dword v[7:8], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_global_size_get_local_id
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
/*000000000040*/ v_sub_u32       v0, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s4, v3
/*000000000054*/ v_mov_b32       v5, s5
/*000000000058*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v0
/*000000000064*/ v_sub_u32       v3, vcc, s1, v1
/*000000000068*/ s_add_u32       s0, s7, s14
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v3
/*00000000008c*/ v_sub_u32       v3, vcc, s2, v2
/*000000000090*/ s_add_u32       s0, s8, s6
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel subtract_get_num_groups_get_local_id
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
/*00000000004c*/ v_sub_u32       v0, vcc, s0, v0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s4, v3
/*000000000060*/ v_mov_b32       v5, s5
/*000000000064*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000068*/ flat_store_dword v[3:4], v0
/*000000000070*/ v_sub_u32       v3, vcc, s1, v1
/*000000000074*/ s_add_u32       s0, s7, s14
/*000000000078*/ v_add_u32       v0, vcc, s0, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000090*/ flat_store_dword v[0:1], v3
/*000000000098*/ v_sub_u32       v3, vcc, s2, v2
/*00000000009c*/ s_add_u32       s0, s8, s6
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel subtract_get_work_dim_get_local_id
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
/*000000000038*/ v_sub_u32       v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s1, s1, s12
/*000000000040*/ v_add_u32       v3, vcc, s1, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s2, v3
/*000000000054*/ v_mov_b32       v6, s3
/*000000000058*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v5
/*000000000064*/ v_sub_u32       v3, vcc, s0, v1
/*000000000068*/ s_add_u32       s1, s5, s14
/*00000000006c*/ v_add_u32       v0, vcc, s1, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s2, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v3
/*00000000008c*/ v_sub_u32       v3, vcc, s0, v2
/*000000000090*/ s_add_u32       s0, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel subtract_x_get_group_id
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
/*000000000048*/ s_sub_u32       s2, s1, s6
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_sub_u32       s0, s1, s7
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_sub_u32       s0, s1, s8
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel subtract_get_global_offset_get_group_id
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
/*00000000003c*/ s_sub_u32       s0, s0, s6
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ s_sub_u32       s0, s2, s7
/*000000000064*/ v_mov_b32       v7, 0
/*000000000068*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ s_sub_u32       s0, s10, s8
/*000000000080*/ v_mov_b32       v9, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_local_id_get_group_id
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
/*000000000030*/ v_subrev_u32    v0, vcc, s6, v0
/*000000000034*/ v_mov_b32       v4, 0
/*000000000038*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000040*/ v_add_u32       v3, vcc, s10, v3
/*000000000044*/ v_mov_b32       v5, s11
/*000000000048*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000004c*/ flat_store_dword v[3:4], v0
/*000000000054*/ v_subrev_u32    v3, vcc, s7, v1
/*000000000058*/ s_add_u32       s0, s3, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v3
/*00000000007c*/ v_subrev_u32    v3, vcc, s8, v2
/*000000000080*/ s_add_u32       s0, s5, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v3
/*0000000000a4*/ s_endpgm
.kernel subtract_get_group_id_get_group_id
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_local_size_get_group_id
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
/*000000000048*/ s_sub_u32       s1, 2, s6
/*00000000004c*/ v_add_u32       v8, vcc, s0, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_sub_u32       s0, 2, s7
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_sub_u32       s0, 4, s8
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_global_id_get_group_id
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
/*000000000058*/ v_subrev_u32    v0, vcc, s6, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000068*/ v_subrev_u32    v1, vcc, s7, v8
/*00000000006c*/ v_add_u32       v6, vcc, s4, v6
/*000000000070*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000080*/ v_subrev_u32    v2, vcc, s8, v10
/*000000000084*/ v_add_u32       v8, vcc, s4, v8
/*000000000088*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*00000000008c*/ flat_store_dword v[3:4], v0
/*000000000094*/ flat_store_dword v[6:7], v1
/*00000000009c*/ flat_store_dword v[8:9], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_global_size_get_group_id
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
/*00000000004c*/ s_sub_u32       s1, s14, s8
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ s_sub_u32       s0, s15, s9
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_sub_u32       s0, s3, s10
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_num_groups_get_group_id
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
/*000000000054*/ s_sub_u32       s2, s2, s8
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_sub_u32       s1, s3, s9
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ s_sub_u32       s0, s0, s10
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_work_dim_get_group_id
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
/*000000000050*/ s_sub_u32       s2, s1, s8
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s2
/*000000000074*/ s_sub_u32       s0, s1, s9
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_sub_u32       s0, s1, s10
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_x_get_local_size
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
/*000000000054*/ s_add_u32       s2, s1, -16
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ v_mov_b32       v7, 0
/*000000000070*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000078*/ s_add_u32       s0, s1, -2
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
.kernel subtract_get_global_offset_get_local_size
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
/*000000000048*/ s_add_u32       s0, s0, -2
/*00000000004c*/ v_add_u32       v8, vcc, s1, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s0
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_add_u32       s0, s2, -16
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_add_u32       s0, s10, -2
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_local_id_get_local_size
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
/*000000000058*/ v_add_u32       v0, vcc, -8, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_add_u32       v1, vcc, -4, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_add_u32       v2, vcc, -2, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_group_id_get_local_size
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
/*000000000048*/ s_add_u32       s1, s6, -2
/*00000000004c*/ v_add_u32       v8, vcc, s0, v2
/*000000000050*/ v_add_u32       v10, vcc, s4, v3
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000006c*/ s_add_u32       s0, s7, -16
/*000000000070*/ v_add_u32       v1, vcc, s4, v6
/*000000000074*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000078*/ v_mov_b32       v7, s0
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000088*/ s_add_u32       s0, s8, -2
/*00000000008c*/ v_add_u32       v12, vcc, s4, v8
/*000000000090*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*000000000094*/ v_mov_b32       v8, s0
/*000000000098*/ flat_store_dword v[10:11], v5
/*0000000000a0*/ flat_store_dword v[1:2], v7
/*0000000000a8*/ flat_store_dword v[12:13], v8
/*0000000000b0*/ s_endpgm
.kernel subtract_get_local_size_get_local_size
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_global_id_get_local_size
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
/*000000000058*/ v_add_u32       v0, vcc, -2, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000068*/ v_add_u32       v6, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000070*/ v_add_u32       v1, vcc, -2, v8
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000080*/ v_add_u32       v8, vcc, s4, v8
/*000000000084*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*000000000088*/ v_add_u32       v2, vcc, -4, v10
/*00000000008c*/ flat_store_dword v[3:4], v0
/*000000000094*/ flat_store_dword v[6:7], v1
/*00000000009c*/ flat_store_dword v[8:9], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_global_size_get_local_size
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
/*000000000058*/ s_add_u32       s1, s14, -16
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_add_u32       s0, s15, -2
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_add_u32       s0, s3, -2
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_num_groups_get_local_size
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
/*000000000060*/ s_add_u32       s2, s2, -2
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_add_u32       s1, s3, -2
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_add_u32       s0, s0, -4
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_work_dim_get_local_size
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
/*00000000005c*/ s_add_u32       s2, s1, -2
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
/*000000000094*/ s_add_u32       s0, s1, -4
/*000000000098*/ v_add_u32       v12, vcc, s6, v7
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*0000000000a0*/ v_mov_b32       v7, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[12:13], v7
/*0000000000bc*/ s_endpgm
.kernel subtract_x_get_global_id
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
/*00000000003c*/ v_sub_u32       v0, vcc, s1, v3
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v5, s11
/*000000000054*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000058*/ flat_store_dword v[3:4], v0
/*000000000060*/ s_add_u32       s0, s5, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_sub_u32       v3, vcc, s1, v0
/*00000000006c*/ v_mov_b32       v1, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000080*/ flat_store_dword v[0:1], v3
/*000000000088*/ s_add_u32       s0, s6, s4
/*00000000008c*/ v_add_u32       v0, vcc, s0, v2
/*000000000090*/ v_sub_u32       v2, vcc, s1, v0
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v2
/*0000000000b0*/ s_endpgm
.kernel subtract_get_global_offset_get_global_id
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
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 4
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ v_add_u32       v5, vcc, s0, v0
/*000000000034*/ v_add_u32       v2, vcc, s1, v2
/*000000000038*/ v_add_u32       v8, vcc, s2, v1
/*00000000003c*/ v_mov_b32       v6, 0
/*000000000040*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*000000000048*/ v_add_u32       v10, vcc, s10, v2
/*00000000004c*/ v_add_u32       v5, vcc, s4, v5
/*000000000050*/ v_mov_b32       v7, s5
/*000000000054*/ v_addc_u32      v6, vcc, v7, v6, vcc
/*000000000058*/ v_sub_u32       v0, vcc, 0, v0
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000068*/ v_add_u32       v12, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v13, vcc, v7, v9, vcc
/*000000000070*/ v_sub_u32       v1, vcc, 0, v1
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[9:10], 2, v[10:11]
/*000000000080*/ v_add_u32       v3, vcc, s4, v9
/*000000000084*/ v_addc_u32      v4, vcc, v7, v10, vcc
/*000000000088*/ v_sub_u32       v2, vcc, 0, v2
/*00000000008c*/ flat_store_dword v[5:6], v0
/*000000000094*/ flat_store_dword v[12:13], v1
/*00000000009c*/ flat_store_dword v[3:4], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_local_id_get_global_id
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
/*000000000038*/ v_sub_u32       v0, vcc, v0, v3
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000048*/ v_add_u32       v3, vcc, s10, v3
/*00000000004c*/ v_mov_b32       v6, s11
/*000000000050*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000054*/ flat_store_dword v[3:4], v0
/*00000000005c*/ v_sub_u32       v3, vcc, v1, v7
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[7:8]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v3
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_sub_u32       v2, vcc, v2, v0
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_group_id_get_global_id
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
/*000000000038*/ v_sub_u32       v4, vcc, s6, v0
/*00000000003c*/ v_mov_b32       v1, 0
/*000000000040*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000048*/ v_add_u32       v0, vcc, s10, v0
/*00000000004c*/ v_mov_b32       v5, s11
/*000000000050*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000054*/ flat_store_dword v[0:1], v4
/*00000000005c*/ v_sub_u32       v4, vcc, s7, v6
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000074*/ flat_store_dword v[0:1], v4
/*00000000007c*/ s_add_u32       s0, s5, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_sub_u32       v2, vcc, s8, v0
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*00000000009c*/ flat_store_dword v[0:1], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_local_size_get_global_id
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
/*00000000002c*/ v_add_u32       v6, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v7, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 2, v[6:7]
/*000000000048*/ v_add_u32       v10, vcc, s0, v2
/*00000000004c*/ v_add_u32       v3, vcc, s4, v3
/*000000000050*/ v_mov_b32       v5, s5
/*000000000054*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000058*/ v_sub_u32       v0, vcc, 2, v6
/*00000000005c*/ v_mov_b32       v9, 0
/*000000000060*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000068*/ v_add_u32       v6, vcc, s4, v6
/*00000000006c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000070*/ v_sub_u32       v1, vcc, 2, v8
/*000000000074*/ v_mov_b32       v11, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000080*/ v_add_u32       v8, vcc, s4, v8
/*000000000084*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*000000000088*/ v_sub_u32       v2, vcc, 4, v10
/*00000000008c*/ flat_store_dword v[3:4], v0
/*000000000094*/ flat_store_dword v[6:7], v1
/*00000000009c*/ flat_store_dword v[8:9], v2
/*0000000000a4*/ s_endpgm
.kernel subtract_get_global_id_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 16
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_lshl_b32      s3, s7, 1
/*00000000001c*/ v_add_u32       v3, vcc, s1, v0
/*000000000020*/ s_lshl_b32      s1, s8, 2
/*000000000024*/ s_add_u32       s0, s3, s0
/*000000000028*/ v_add_u32       v6, vcc, s0, v1
/*00000000002c*/ s_add_u32       s0, s1, s2
/*000000000030*/ v_mov_b32       v4, 0
/*000000000034*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000003c*/ v_add_u32       v8, vcc, s0, v2
/*000000000040*/ v_add_u32       v10, vcc, s4, v3
/*000000000044*/ v_mov_b32       v3, s5
/*000000000048*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000004c*/ v_mov_b32       v5, 0
/*000000000050*/ v_mov_b32       v7, 0
/*000000000054*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000005c*/ v_add_u32       v1, vcc, s4, v6
/*000000000060*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000064*/ v_mov_b32       v9, 0
/*000000000068*/ v_lshlrev_b64   v[7:8], 2, v[8:9]
/*000000000070*/ v_add_u32       v6, vcc, s4, v7
/*000000000074*/ v_addc_u32      v7, vcc, v3, v8, vcc
/*000000000078*/ flat_store_dword v[10:11], v5
/*000000000080*/ flat_store_dword v[1:2], v5
/*000000000088*/ flat_store_dword v[6:7], v5
/*000000000090*/ s_endpgm
.kernel subtract_get_global_size_get_global_id
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
/*000000000048*/ v_sub_u32       v4, vcc, s0, v0
/*00000000004c*/ v_mov_b32       v1, 0
/*000000000050*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000058*/ v_add_u32       v0, vcc, s4, v0
/*00000000005c*/ v_mov_b32       v5, s5
/*000000000060*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000064*/ flat_store_dword v[0:1], v4
/*00000000006c*/ v_sub_u32       v4, vcc, s1, v6
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v4
/*00000000008c*/ s_add_u32       s0, s8, s6
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_sub_u32       v2, vcc, s2, v0
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v2
/*0000000000b4*/ s_endpgm
.kernel subtract_get_num_groups_get_global_id
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
/*000000000054*/ v_sub_u32       v4, vcc, s0, v0
/*000000000058*/ v_mov_b32       v1, 0
/*00000000005c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000064*/ v_add_u32       v0, vcc, s4, v0
/*000000000068*/ v_mov_b32       v5, s5
/*00000000006c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000070*/ flat_store_dword v[0:1], v4
/*000000000078*/ v_sub_u32       v4, vcc, s1, v6
/*00000000007c*/ v_mov_b32       v7, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 2, v[6:7]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000090*/ flat_store_dword v[0:1], v4
/*000000000098*/ s_add_u32       s0, s8, s6
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_sub_u32       v2, vcc, s2, v0
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v2
/*0000000000c0*/ s_endpgm
.kernel subtract_get_work_dim_get_global_id
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
/*000000000040*/ v_sub_u32       v0, vcc, s0, v3
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s2, v3
/*000000000054*/ v_mov_b32       v5, s3
/*000000000058*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v0
/*000000000064*/ s_add_u32       s1, s5, s14
/*000000000068*/ v_add_u32       v0, vcc, s1, v1
/*00000000006c*/ v_sub_u32       v3, vcc, s0, v0
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s2, v0
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v3
/*00000000008c*/ s_add_u32       s1, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s1, v2
/*000000000094*/ v_sub_u32       v2, vcc, s0, v0
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v2
/*0000000000b4*/ s_endpgm
.kernel subtract_x_get_global_size
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
/*000000000058*/ s_sub_u32       s2, s1, s14
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ s_sub_u32       s0, s1, s15
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ v_add_u32       v1, vcc, s6, v6
/*000000000090*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000094*/ v_mov_b32       v7, s0
/*000000000098*/ s_sub_u32       s0, s1, s4
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ v_add_u32       v12, vcc, s6, v8
/*0000000000ac*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b0*/ v_mov_b32       v8, s0
/*0000000000b4*/ flat_store_dword v[10:11], v5
/*0000000000bc*/ flat_store_dword v[1:2], v7
/*0000000000c4*/ flat_store_dword v[12:13], v8
/*0000000000cc*/ s_endpgm
.kernel subtract_get_global_offset_get_global_size
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
/*00000000004c*/ s_sub_u32       s0, s0, s14
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s1, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_sub_u32       s0, s2, s15
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_sub_u32       s0, s12, s3
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_local_id_get_global_size
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
/*000000000040*/ v_subrev_u32    v0, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s4, v3
/*000000000054*/ v_mov_b32       v5, s5
/*000000000058*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v0
/*000000000064*/ v_subrev_u32    v3, vcc, s1, v1
/*000000000068*/ s_add_u32       s0, s7, s14
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v3
/*00000000008c*/ v_subrev_u32    v3, vcc, s2, v2
/*000000000090*/ s_add_u32       s0, s8, s6
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel subtract_get_group_id_get_global_size
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
/*00000000004c*/ s_sub_u32       s1, s8, s14
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ s_sub_u32       s0, s9, s15
/*000000000074*/ v_mov_b32       v7, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ s_waitcnt       lgkmcnt(0)
/*000000000090*/ s_sub_u32       s0, s10, s3
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_local_size_get_global_size
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
/*000000000058*/ s_sub_u32       s1, 2, s14
/*00000000005c*/ v_add_u32       v8, vcc, s0, v2
/*000000000060*/ v_add_u32       v10, vcc, s6, v3
/*000000000064*/ v_mov_b32       v3, s7
/*000000000068*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000006c*/ v_mov_b32       v5, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ s_sub_u32       s0, 2, s15
/*000000000080*/ v_add_u32       v1, vcc, s6, v6
/*000000000084*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000088*/ v_mov_b32       v7, s0
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_sub_u32       s0, 4, s3
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_global_id_get_global_size
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s8, 1
/*000000000028*/ s_lshl_b32      s3, s9, 1
/*00000000002c*/ s_load_dword    s4, s[4:5], 0x14
/*000000000034*/ v_add_u32       v5, vcc, s1, v0
/*000000000038*/ s_lshl_b32      s1, s10, 2
/*00000000003c*/ s_add_u32       s2, s3, s2
/*000000000040*/ v_add_u32       v8, vcc, s2, v1
/*000000000044*/ s_add_u32       s1, s1, s12
/*000000000048*/ v_mov_b32       v6, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000054*/ v_add_u32       v0, vcc, s0, v5
/*000000000058*/ v_add_u32       v10, vcc, s1, v2
/*00000000005c*/ v_add_u32       v3, vcc, s6, v3
/*000000000060*/ v_mov_b32       v5, s7
/*000000000064*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000068*/ v_subrev_u32    v0, vcc, s14, v0
/*00000000006c*/ v_mov_b32       v9, 0
/*000000000070*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000078*/ v_subrev_u32    v1, vcc, s15, v8
/*00000000007c*/ v_add_u32       v6, vcc, s6, v6
/*000000000080*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000084*/ v_mov_b32       v11, 0
/*000000000088*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000090*/ s_waitcnt       lgkmcnt(0)
/*000000000094*/ v_subrev_u32    v2, vcc, s4, v10
/*000000000098*/ v_add_u32       v8, vcc, s6, v8
/*00000000009c*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*0000000000a0*/ flat_store_dword v[3:4], v0
/*0000000000a8*/ flat_store_dword v[6:7], v1
/*0000000000b0*/ flat_store_dword v[8:9], v2
/*0000000000b8*/ s_endpgm
.kernel subtract_get_global_size_get_global_size
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_num_groups_get_global_size
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
/*000000000054*/ s_sub_u32       s2, s2, s12
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_sub_u32       s2, s3, s13
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s2
/*00000000009c*/ s_sub_u32       s0, s0, s1
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_work_dim_get_global_size
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
/*000000000060*/ s_sub_u32       s2, s1, s14
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ v_add_u32       v10, vcc, s6, v3
/*000000000078*/ v_mov_b32       v3, s7
/*00000000007c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ s_sub_u32       s0, s1, s15
/*000000000088*/ v_mov_b32       v7, 0
/*00000000008c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000094*/ v_add_u32       v1, vcc, s6, v6
/*000000000098*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000009c*/ v_mov_b32       v7, s0
/*0000000000a0*/ s_sub_u32       s0, s1, s4
/*0000000000a4*/ v_mov_b32       v9, 0
/*0000000000a8*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000b4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b8*/ v_mov_b32       v8, s0
/*0000000000bc*/ flat_store_dword v[10:11], v5
/*0000000000c4*/ flat_store_dword v[1:2], v7
/*0000000000cc*/ flat_store_dword v[12:13], v8
/*0000000000d4*/ s_endpgm
.kernel subtract_x_get_num_groups
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
/*000000000060*/ s_sub_u32       s2, s1, s2
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ s_lshr_b32      s0, s3, 1
/*000000000078*/ v_add_u32       v10, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v3, s5
/*000000000080*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ s_sub_u32       s2, s1, s6
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000098*/ v_add_u32       v1, vcc, s4, v6
/*00000000009c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a0*/ v_mov_b32       v7, s2
/*0000000000a4*/ s_sub_u32       s0, s1, s0
/*0000000000a8*/ v_mov_b32       v9, 0
/*0000000000ac*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b4*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b8*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000bc*/ v_mov_b32       v8, s0
/*0000000000c0*/ flat_store_dword v[10:11], v5
/*0000000000c8*/ flat_store_dword v[1:2], v7
/*0000000000d0*/ flat_store_dword v[12:13], v8
/*0000000000d8*/ s_endpgm
.kernel subtract_get_global_offset_get_num_groups
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
/*000000000054*/ s_sub_u32       s0, s0, s6
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s3, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s1, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s0
/*000000000080*/ s_sub_u32       s0, s2, s7
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ s_sub_u32       s0, s14, s1
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_local_id_get_num_groups
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
/*00000000004c*/ v_subrev_u32    v0, vcc, s0, v0
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s4, v3
/*000000000060*/ v_mov_b32       v5, s5
/*000000000064*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000068*/ flat_store_dword v[3:4], v0
/*000000000070*/ v_subrev_u32    v3, vcc, s1, v1
/*000000000074*/ s_add_u32       s0, s7, s14
/*000000000078*/ v_add_u32       v0, vcc, s0, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*000000000090*/ flat_store_dword v[0:1], v3
/*000000000098*/ v_subrev_u32    v3, vcc, s2, v2
/*00000000009c*/ s_add_u32       s0, s8, s6
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v5, v1, vcc
/*0000000000b8*/ flat_store_dword v[0:1], v3
/*0000000000c0*/ s_endpgm
.kernel subtract_get_group_id_get_num_groups
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
/*000000000054*/ s_sub_u32       s2, s8, s2
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_sub_u32       s1, s9, s3
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ s_sub_u32       s0, s10, s0
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_local_size_get_num_groups
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
/*000000000060*/ s_sub_u32       s2, 2, s2
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 2
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ s_sub_u32       s1, 2, s3
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ s_sub_u32       s0, 4, s0
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_global_id_get_num_groups
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s1, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s3, s8, 1
/*000000000030*/ s_lshl_b32      s4, s9, 1
/*000000000034*/ v_add_u32       v5, vcc, s3, v0
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ s_add_u32       s2, s4, s2
/*000000000040*/ v_add_u32       v8, vcc, s2, v1
/*000000000044*/ s_add_u32       s2, s3, s12
/*000000000048*/ s_lshr_b32      s3, s14, 1
/*00000000004c*/ v_mov_b32       v6, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000058*/ v_add_u32       v0, vcc, s0, v5
/*00000000005c*/ v_add_u32       v10, vcc, s2, v2
/*000000000060*/ s_lshr_b32      s0, s15, 1
/*000000000064*/ v_add_u32       v3, vcc, s6, v3
/*000000000068*/ v_mov_b32       v5, s7
/*00000000006c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000070*/ v_subrev_u32    v0, vcc, s3, v0
/*000000000074*/ v_mov_b32       v9, 0
/*000000000078*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000080*/ s_waitcnt       lgkmcnt(0)
/*000000000084*/ s_lshr_b32      s1, s1, 2
/*000000000088*/ v_subrev_u32    v1, vcc, s0, v8
/*00000000008c*/ v_add_u32       v6, vcc, s6, v6
/*000000000090*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000094*/ v_mov_b32       v11, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*0000000000a0*/ v_subrev_u32    v2, vcc, s1, v10
/*0000000000a4*/ v_add_u32       v8, vcc, s6, v8
/*0000000000a8*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*0000000000ac*/ flat_store_dword v[3:4], v0
/*0000000000b4*/ flat_store_dword v[6:7], v1
/*0000000000bc*/ flat_store_dword v[8:9], v2
/*0000000000c4*/ s_endpgm
.kernel subtract_get_global_size_get_num_groups
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
/*000000000054*/ s_sub_u32       s2, s12, s2
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000064*/ v_add_u32       v8, vcc, s0, v2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s0, s1, 1
/*000000000070*/ v_add_u32       v10, vcc, s4, v3
/*000000000074*/ v_mov_b32       v3, s5
/*000000000078*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s2
/*000000000080*/ s_sub_u32       s2, s13, s3
/*000000000084*/ v_mov_b32       v7, 0
/*000000000088*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000090*/ v_add_u32       v1, vcc, s4, v6
/*000000000094*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000098*/ v_mov_b32       v7, s2
/*00000000009c*/ s_sub_u32       s0, s1, s0
/*0000000000a0*/ v_mov_b32       v9, 0
/*0000000000a4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000ac*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b4*/ v_mov_b32       v8, s0
/*0000000000b8*/ flat_store_dword v[10:11], v5
/*0000000000c0*/ flat_store_dword v[1:2], v7
/*0000000000c8*/ flat_store_dword v[12:13], v8
/*0000000000d0*/ s_endpgm
.kernel subtract_get_num_groups_get_num_groups
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_get_work_dim_get_num_groups
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
/*000000000068*/ s_sub_u32       s2, s1, s2
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000078*/ v_add_u32       v8, vcc, s0, v2
/*00000000007c*/ s_lshr_b32      s0, s3, 2
/*000000000080*/ v_add_u32       v10, vcc, s4, v3
/*000000000084*/ v_mov_b32       v3, s5
/*000000000088*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ s_sub_u32       s2, s1, s6
/*000000000094*/ v_mov_b32       v7, 0
/*000000000098*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*0000000000a0*/ v_add_u32       v1, vcc, s4, v6
/*0000000000a4*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a8*/ v_mov_b32       v7, s2
/*0000000000ac*/ s_sub_u32       s0, s1, s0
/*0000000000b0*/ v_mov_b32       v9, 0
/*0000000000b4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000bc*/ v_add_u32       v12, vcc, s4, v8
/*0000000000c0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000c4*/ v_mov_b32       v8, s0
/*0000000000c8*/ flat_store_dword v[10:11], v5
/*0000000000d0*/ flat_store_dword v[1:2], v7
/*0000000000d8*/ flat_store_dword v[12:13], v8
/*0000000000e0*/ s_endpgm
.kernel subtract_x_get_work_dim
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
/*000000000058*/ s_sub_u32       s1, s3, s1
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
.kernel subtract_get_global_offset_get_work_dim
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
/*000000000050*/ s_sub_u32       s0, s0, s1
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s3, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s0
/*000000000074*/ s_sub_u32       s0, s2, s1
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_sub_u32       s0, s4, s1
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_local_id_get_work_dim
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
/*000000000038*/ v_subrev_u32    v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s1, s1, s12
/*000000000040*/ v_add_u32       v3, vcc, s1, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s2, v3
/*000000000054*/ v_mov_b32       v6, s3
/*000000000058*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*00000000005c*/ flat_store_dword v[3:4], v5
/*000000000064*/ v_subrev_u32    v3, vcc, s0, v1
/*000000000068*/ s_add_u32       s1, s5, s14
/*00000000006c*/ v_add_u32       v0, vcc, s1, v1
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s2, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000084*/ flat_store_dword v[0:1], v3
/*00000000008c*/ v_subrev_u32    v3, vcc, s0, v2
/*000000000090*/ s_add_u32       s0, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ac*/ flat_store_dword v[0:1], v3
/*0000000000b4*/ s_endpgm
.kernel subtract_get_group_id_get_work_dim
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
/*000000000050*/ s_sub_u32       s2, s8, s1
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v10, vcc, s6, v3
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000070*/ v_mov_b32       v5, s2
/*000000000074*/ s_sub_u32       s0, s9, s1
/*000000000078*/ v_mov_b32       v7, 0
/*00000000007c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000084*/ v_add_u32       v1, vcc, s6, v6
/*000000000088*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000008c*/ v_mov_b32       v7, s0
/*000000000090*/ s_sub_u32       s0, s10, s1
/*000000000094*/ v_mov_b32       v9, 0
/*000000000098*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000a4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a8*/ v_mov_b32       v8, s0
/*0000000000ac*/ flat_store_dword v[10:11], v5
/*0000000000b4*/ flat_store_dword v[1:2], v7
/*0000000000bc*/ flat_store_dword v[12:13], v8
/*0000000000c4*/ s_endpgm
.kernel subtract_get_local_size_get_work_dim
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
/*00000000005c*/ s_sub_u32       s2, 2, s1
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
/*000000000094*/ s_sub_u32       s0, 4, s1
/*000000000098*/ v_add_u32       v12, vcc, s6, v7
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*0000000000a0*/ v_mov_b32       v7, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v5
/*0000000000b4*/ flat_store_dword v[12:13], v7
/*0000000000bc*/ s_endpgm
.kernel subtract_get_global_id_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 20
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
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x0
/*00000000001c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_lshl_b32      s6, s9, 1
/*00000000002c*/ v_add_u32       v5, vcc, s3, v0
/*000000000030*/ s_lshl_b32      s3, s10, 2
/*000000000034*/ s_add_u32       s2, s6, s2
/*000000000038*/ v_add_u32       v8, vcc, s2, v1
/*00000000003c*/ s_add_u32       s2, s3, s12
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ s_bfe_u32       s1, s1, 0x20010
/*00000000004c*/ v_mov_b32       v6, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000058*/ v_add_u32       v0, vcc, s0, v5
/*00000000005c*/ v_add_u32       v10, vcc, s2, v2
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v5, s5
/*000000000068*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*00000000006c*/ v_subrev_u32    v0, vcc, s1, v0
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*00000000007c*/ v_subrev_u32    v1, vcc, s1, v8
/*000000000080*/ v_add_u32       v6, vcc, s4, v6
/*000000000084*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*000000000094*/ v_subrev_u32    v2, vcc, s1, v10
/*000000000098*/ v_add_u32       v8, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*0000000000a0*/ flat_store_dword v[3:4], v0
/*0000000000a8*/ flat_store_dword v[6:7], v1
/*0000000000b0*/ flat_store_dword v[8:9], v2
/*0000000000b8*/ s_endpgm
.kernel subtract_get_global_size_get_work_dim
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
/*000000000060*/ s_sub_u32       s2, s14, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ v_add_u32       v10, vcc, s6, v3
/*000000000078*/ v_mov_b32       v3, s7
/*00000000007c*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ s_sub_u32       s0, s15, s1
/*000000000088*/ v_mov_b32       v7, 0
/*00000000008c*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000094*/ v_add_u32       v1, vcc, s6, v6
/*000000000098*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*00000000009c*/ v_mov_b32       v7, s0
/*0000000000a0*/ s_sub_u32       s0, s4, s1
/*0000000000a4*/ v_mov_b32       v9, 0
/*0000000000a8*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b0*/ v_add_u32       v12, vcc, s6, v8
/*0000000000b4*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b8*/ v_mov_b32       v8, s0
/*0000000000bc*/ flat_store_dword v[10:11], v5
/*0000000000c4*/ flat_store_dword v[1:2], v7
/*0000000000cc*/ flat_store_dword v[12:13], v8
/*0000000000d4*/ s_endpgm
.kernel subtract_get_num_groups_get_work_dim
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
/*000000000068*/ s_sub_u32       s2, s2, s1
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000078*/ v_add_u32       v8, vcc, s0, v2
/*00000000007c*/ s_lshr_b32      s0, s3, 2
/*000000000080*/ v_add_u32       v10, vcc, s4, v3
/*000000000084*/ v_mov_b32       v3, s5
/*000000000088*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ s_sub_u32       s2, s6, s1
/*000000000094*/ v_mov_b32       v7, 0
/*000000000098*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*0000000000a0*/ v_add_u32       v1, vcc, s4, v6
/*0000000000a4*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a8*/ v_mov_b32       v7, s2
/*0000000000ac*/ s_sub_u32       s0, s0, s1
/*0000000000b0*/ v_mov_b32       v9, 0
/*0000000000b4*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000bc*/ v_add_u32       v12, vcc, s4, v8
/*0000000000c0*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000c4*/ v_mov_b32       v8, s0
/*0000000000c8*/ flat_store_dword v[10:11], v5
/*0000000000d0*/ flat_store_dword v[1:2], v7
/*0000000000d8*/ flat_store_dword v[12:13], v8
/*0000000000e0*/ s_endpgm
.kernel subtract_get_work_dim_get_work_dim
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
/*000000000058*/ v_mov_b32       v5, 0
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
.kernel subtract_x_64
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
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_sub_u32       v0, vcc, s1, v0
/*00000000003c*/ v_add_u32       v1, vcc, s2, v1
/*000000000040*/ v_mov_b32       v3, s3
/*000000000044*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000048*/ flat_store_dword v[1:2], v0
/*000000000050*/ s_endpgm
.kernel subtract_get_global_offset_64
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
/*000000000018*/ s_add_u32       s1, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*00000000002c*/ v_sub_u32       v0, vcc, s0, v0
/*000000000030*/ v_add_u32       v1, vcc, s2, v1
/*000000000034*/ v_mov_b32       v3, s3
/*000000000038*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*00000000003c*/ flat_store_dword v[1:2], v0
/*000000000044*/ s_endpgm
.kernel subtract_get_local_id_64
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
/*000000000024*/ v_lshlrev_b64   v[2:3], 2, v[1:2]
/*00000000002c*/ v_sub_u32       v0, vcc, v0, v1
/*000000000030*/ v_add_u32       v1, vcc, s2, v2
/*000000000034*/ v_mov_b32       v2, s3
/*000000000038*/ v_addc_u32      v2, vcc, v2, v3, vcc
/*00000000003c*/ flat_store_dword v[1:2], v0
/*000000000044*/ s_endpgm
.kernel subtract_get_group_id_64
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
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*00000000002c*/ v_sub_u32       v0, vcc, s6, v0
/*000000000030*/ v_add_u32       v1, vcc, s2, v1
/*000000000034*/ v_mov_b32       v3, s3
/*000000000038*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*00000000003c*/ flat_store_dword v[1:2], v0
/*000000000044*/ s_endpgm
.kernel subtract_get_local_size_64
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
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*00000000002c*/ v_add_u32       v1, vcc, s2, v1
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000038*/ v_sub_u32       v0, vcc, 64, v0
/*00000000003c*/ flat_store_dword v[1:2], v0
/*000000000044*/ s_endpgm
.kernel subtract_get_global_id_64
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
/*000000000038*/ v_mov_b32       v2, 0
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel subtract_get_global_size_64
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
/*00000000002c*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_sub_u32       v0, vcc, s1, v0
/*00000000003c*/ v_add_u32       v1, vcc, s2, v1
/*000000000040*/ v_mov_b32       v3, s3
/*000000000044*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000048*/ flat_store_dword v[1:2], v0
/*000000000050*/ s_endpgm
.kernel subtract_get_num_groups_64
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
/*000000000034*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*00000000003c*/ v_sub_u32       v0, vcc, s0, v0
/*000000000040*/ v_add_u32       v1, vcc, s2, v1
/*000000000044*/ v_mov_b32       v3, s3
/*000000000048*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*00000000004c*/ flat_store_dword v[1:2], v0
/*000000000054*/ s_endpgm
.kernel subtract_get_work_dim
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
/*000000000038*/ v_lshlrev_b64   v[1:2], 2, v[0:1]
/*000000000040*/ v_sub_u32       v0, vcc, s0, v0
/*000000000044*/ v_add_u32       v1, vcc, s2, v1
/*000000000048*/ v_mov_b32       v3, s3
/*00000000004c*/ v_addc_u32      v2, vcc, v3, v2, vcc
/*000000000050*/ flat_store_dword v[1:2], v0
/*000000000058*/ s_endpgm
.kernel subtract_x_8_8
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
/*000000000014*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s3, s6, 3
/*000000000020*/ s_lshl_b32      s6, s7, 3
/*000000000024*/ s_add_u32       s2, s6, s2
/*000000000028*/ v_add_u32       v1, vcc, s2, v1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ v_sub_u32       v2, vcc, s1, v1
/*000000000034*/ s_add_u32       s0, s3, s0
/*000000000038*/ v_add_u32       v0, vcc, s0, v0
/*00000000003c*/ v_mov_b32       v1, 0
/*000000000040*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000048*/ v_add_u32       v0, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000054*/ flat_store_dword v[0:1], v2
/*00000000005c*/ s_endpgm
.kernel subtract_get_global_offset_8_8
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
/*000000000020*/ s_sub_u32       s0, s0, s2
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ v_mov_b32       v2, s5
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_get_local_id_8_8
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
/*000000000018*/ v_sub_u32       v2, vcc, v0, v1
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ v_add_u32       v0, vcc, s0, v0
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v3, s3
/*000000000038*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel subtract_get_group_id_8_8
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
/*000000000020*/ s_sub_u32       s0, s6, s7
/*000000000024*/ v_mov_b32       v1, 0
/*000000000028*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v2, s3
/*000000000038*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_get_local_size_8_8
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
/*000000000038*/ v_mov_b32       v2, 0
/*00000000003c*/ flat_store_dword v[0:1], v2
/*000000000044*/ s_endpgm
.kernel subtract_get_global_id_8_8
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
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_lshl_b32      s3, s7, 3
/*00000000001c*/ s_add_u32       s2, s3, s2
/*000000000020*/ v_add_u32       v1, vcc, s2, v1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_sub_u32       v2, vcc, v0, v1
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v3, s5
/*000000000044*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel subtract_get_global_size_8_8
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
/*000000000028*/ s_sub_u32       s0, s2, s3
/*00000000002c*/ v_mov_b32       v1, 0
/*000000000030*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000038*/ v_add_u32       v0, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v2, s5
/*000000000040*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel subtract_get_num_groups_8_8
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
/*000000000030*/ s_sub_u32       s0, s0, s1
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ v_add_u32       v0, vcc, s4, v0
/*000000000044*/ v_mov_b32       v2, s5
/*000000000048*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
.kernel subtract_get_work_dim_8_8
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
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s3, s8, 3
/*000000000020*/ s_add_u32       s0, s3, s0
/*000000000024*/ s_lshl_b32      s3, s9, 3
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ s_add_u32       s0, s3, s2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s1, s1, 0x20010
/*00000000003c*/ v_add_u32       v2, vcc, s0, v1
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_sub_u32       v2, vcc, s1, v2
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000005c*/ flat_store_dword v[0:1], v2
/*000000000064*/ s_endpgm
.kernel subtract_long_x_x
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
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_lshlrev_b64   v[2:3], 0, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_global_offset_x
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
/*00000000005c*/ s_sub_u32       s0, s0, s1
/*000000000060*/ v_mov_b32       v3, s0
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000070*/ v_mov_b32       v8, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000084*/ s_sub_u32       s0, s2, s1
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s6, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b0*/ s_sub_u32       s0, s4, s1
/*0000000000b4*/ v_mov_b32       v2, s0
/*0000000000b8*/ v_mov_b32       v3, 0
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c4*/ s_endpgm
.kernel subtract_long_get_local_id_x
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
/*000000000068*/ v_subrev_u32    v7, vcc, s1, v0
/*00000000006c*/ v_mov_b32       v8, 0
/*000000000070*/ flat_store_dwordx2 v[5:6], v[7:8]
/*000000000078*/ v_add_u32       v5, vcc, s10, v3
/*00000000007c*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000080*/ v_subrev_u32    v3, vcc, s1, v1
/*000000000084*/ v_mov_b32       v4, 0
/*000000000088*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000090*/ s_add_u32       s0, s6, s4
/*000000000094*/ v_add_u32       v0, vcc, s0, v2
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000ac*/ v_subrev_u32    v2, vcc, s1, v2
/*0000000000b0*/ v_mov_b32       v3, 0
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_group_id_x
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
/*000000000068*/ s_sub_u32       s0, s6, s1
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ v_mov_b32       v6, 0
/*000000000074*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000084*/ s_sub_u32       s0, s7, s1
/*000000000088*/ v_mov_b32       v3, s0
/*00000000008c*/ v_mov_b32       v4, 0
/*000000000090*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000098*/ s_add_u32       s0, s9, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ s_sub_u32       s0, s8, s1
/*0000000000b8*/ v_mov_b32       v2, s0
/*0000000000bc*/ v_mov_b32       v3, 0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_local_size_x
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
/*000000000054*/ s_sub_u32       s0, 2, s1
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
/*0000000000a8*/ s_sub_u32       s0, 4, s1
/*0000000000ac*/ v_mov_b32       v2, s0
/*0000000000b0*/ v_mov_b32       v3, 0
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_global_id_x
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
/*000000000054*/ v_subrev_u32    v5, vcc, s1, v0
/*000000000058*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000060*/ s_add_u32       s0, s3, s2
/*000000000064*/ v_add_u32       v3, vcc, s0, v1
/*000000000068*/ v_mov_b32       v4, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 3, v[3:4]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000007c*/ v_subrev_u32    v3, vcc, s1, v3
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ s_add_u32       s0, s5, s4
/*00000000008c*/ v_add_u32       v2, vcc, s0, v2
/*000000000090*/ v_mov_b32       v3, 0
/*000000000094*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*00000000009c*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ v_subrev_u32    v2, vcc, s1, v2
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b0*/ s_endpgm
.kernel subtract_long_get_global_size_x
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
/*000000000074*/ s_sub_u32       s0, s0, s3
/*000000000078*/ v_mov_b32       v5, s0
/*00000000007c*/ v_mov_b32       v6, 0
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_sub_u32       s0, s1, s3
/*000000000094*/ v_mov_b32       v3, s0
/*000000000098*/ v_mov_b32       v4, 0
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ s_add_u32       s0, s9, s6
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c0*/ s_sub_u32       s0, s2, s3
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, 0
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_num_groups_x
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
/*000000000080*/ s_sub_u32       s0, s0, s3
/*000000000084*/ v_mov_b32       v5, s0
/*000000000088*/ v_mov_b32       v6, 0
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ s_sub_u32       s0, s1, s3
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ v_mov_b32       v4, 0
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s9, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ s_sub_u32       s0, s2, s3
/*0000000000d0*/ v_mov_b32       v2, s0
/*0000000000d4*/ v_mov_b32       v3, 0
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_work_dim_x
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
/*000000000054*/ s_sub_u32       s0, s0, s5
/*000000000058*/ v_mov_b32       v2, s0
/*00000000005c*/ v_mov_b32       v3, 0
/*000000000060*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000068*/ s_endpgm
.kernel subtract_long_x_get_global_offset
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dword    s16, s[4:5], 0x38
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_lshl_b32      s1, s6, 4
/*000000000024*/ s_lshl_b32      s6, s7, 1
/*000000000028*/ s_lshl_b32      s7, s8, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_ashr_i32      s17, s16, 31
/*000000000034*/ s_sub_u32       s10, s16, s12
/*000000000038*/ s_subb_u32      s11, s17, s13
/*00000000003c*/ s_add_u32       s0, s1, s12
/*000000000040*/ v_add_u32       v3, vcc, s0, v0
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s2, v3
/*000000000054*/ v_mov_b32       v7, s3
/*000000000058*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000005c*/ v_mov_b32       v5, s10
/*000000000060*/ v_mov_b32       v6, s11
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ s_sub_u32       s0, s16, s14
/*000000000070*/ s_subb_u32      s1, s17, s15
/*000000000074*/ s_add_u32       s3, s6, s14
/*000000000078*/ v_add_u32       v0, vcc, s3, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ v_mov_b32       v3, s0
/*000000000094*/ v_mov_b32       v4, s1
/*000000000098*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a0*/ s_sub_u32       s0, s16, s4
/*0000000000a4*/ s_subb_u32      s1, s17, s5
/*0000000000a8*/ s_add_u32       s3, s7, s4
/*0000000000ac*/ v_add_u32       v0, vcc, s3, v2
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s2, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_global_offset_get_global_offset
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
/*000000000018*/ s_lshl_b32      s6, s6, 1
/*00000000001c*/ s_lshl_b32      s7, s7, 4
/*000000000020*/ s_lshl_b32      s8, s8, 1
/*000000000024*/ s_movk_i32      s13, 0x0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_sub_u32       s12, s0, s0
/*000000000030*/ s_subb_u32      s13, s13, s1
/*000000000034*/ s_add_u32       s0, s6, s0
/*000000000038*/ v_add_u32       v3, vcc, s0, v0
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000048*/ v_add_u32       v3, vcc, s10, v3
/*00000000004c*/ v_mov_b32       v7, s11
/*000000000050*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000054*/ v_mov_b32       v5, s12
/*000000000058*/ v_mov_b32       v6, s13
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ s_movk_i32      s1, 0x0
/*000000000068*/ s_sub_u32       s0, s2, s2
/*00000000006c*/ s_subb_u32      s1, s1, s3
/*000000000070*/ s_add_u32       s2, s7, s2
/*000000000074*/ v_add_u32       v0, vcc, s2, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000008c*/ v_mov_b32       v3, s0
/*000000000090*/ v_mov_b32       v4, s1
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_movk_i32      s1, 0x0
/*0000000000a0*/ s_sub_u32       s0, s4, s4
/*0000000000a4*/ s_subb_u32      s1, s1, s5
/*0000000000a8*/ s_add_u32       s2, s8, s4
/*0000000000ac*/ v_add_u32       v0, vcc, s2, v2
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_local_id_get_global_offset
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
/*000000000030*/ v_sub_u32       v5, vcc, v0, s0
/*000000000038*/ v_mov_b32       v0, s1
/*00000000003c*/ v_subb_u32      v6, vcc, 0, v0, vcc
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v7, s11
/*000000000054*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000058*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000060*/ v_sub_u32       v3, vcc, v1, s2
/*000000000068*/ v_mov_b32       v0, s3
/*00000000006c*/ v_subb_u32      v4, vcc, 0, v0, vcc
/*000000000070*/ s_add_u32       s0, s7, s2
/*000000000074*/ v_add_u32       v0, vcc, s0, v1
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ v_sub_u32       v3, vcc, v2, s4
/*00000000009c*/ v_mov_b32       v0, s5
/*0000000000a0*/ v_subb_u32      v4, vcc, 0, v0, vcc
/*0000000000a4*/ s_add_u32       s0, s8, s4
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_group_id_get_global_offset
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
/*000000000030*/ s_mov_b32       s14, s6
/*000000000034*/ s_movk_i32      s15, 0x0
/*000000000038*/ s_sub_u32       s0, s6, s0
/*00000000003c*/ s_subb_u32      s1, s15, s1
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v7, s11
/*000000000054*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_mov_b32       v6, s1
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ s_movk_i32      s1, 0x0
/*00000000006c*/ s_sub_u32       s0, s7, s2
/*000000000070*/ s_subb_u32      s1, s1, s3
/*000000000074*/ s_add_u32       s2, s12, s2
/*000000000078*/ v_add_u32       v0, vcc, s2, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s10, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ v_mov_b32       v3, s0
/*000000000094*/ v_mov_b32       v4, s1
/*000000000098*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a0*/ s_movk_i32      s9, 0x0
/*0000000000a4*/ s_sub_u32       s0, s8, s4
/*0000000000a8*/ s_subb_u32      s1, s9, s5
/*0000000000ac*/ s_add_u32       s2, s13, s4
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c8*/ v_mov_b32       v2, s0
/*0000000000cc*/ v_mov_b32       v3, s1
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d8*/ s_endpgm
.kernel subtract_long_get_local_size_get_global_offset
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
/*000000000048*/ s_sub_u32       s0, 2, s0
/*00000000004c*/ s_subb_u32      s1, 0, s1
/*000000000050*/ v_mov_b32       v5, s0
/*000000000054*/ v_mov_b32       v6, s1
/*000000000058*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000060*/ s_add_u32       s0, s7, s2
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s10, v0
/*000000000078*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000007c*/ s_sub_u32       s0, 2, s2
/*000000000080*/ s_subb_u32      s1, 0, s3
/*000000000084*/ v_mov_b32       v3, s0
/*000000000088*/ v_mov_b32       v4, s1
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s8, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ s_sub_u32       s0, 4, s4
/*0000000000b4*/ s_subb_u32      s1, 0, s5
/*0000000000b8*/ v_mov_b32       v2, s0
/*0000000000bc*/ v_mov_b32       v3, s1
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_global_id_get_global_offset
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
/*000000000048*/ v_sub_u32       v5, vcc, v0, s12
/*000000000050*/ v_mov_b32       v0, s13
/*000000000054*/ v_subb_u32      v6, vcc, 0, v0, vcc
/*000000000058*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000060*/ s_add_u32       s1, s4, s14
/*000000000064*/ v_add_u32       v0, vcc, s1, v1
/*000000000068*/ v_sub_u32       v3, vcc, v0, s14
/*000000000070*/ v_mov_b32       v1, s15
/*000000000074*/ v_subb_u32      v4, vcc, 0, v1, vcc
/*000000000078*/ v_mov_b32       v1, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000084*/ v_add_u32       v0, vcc, s0, v0
/*000000000088*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s1, s5, s2
/*000000000098*/ v_add_u32       v0, vcc, s1, v2
/*00000000009c*/ v_sub_u32       v2, vcc, v0, s2
/*0000000000a4*/ v_mov_b32       v1, s3
/*0000000000a8*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_global_size_get_global_offset
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
/*000000000040*/ s_movk_i32      s11, 0x0
/*000000000044*/ s_sub_u32       s10, s0, s12
/*000000000048*/ s_subb_u32      s11, s11, s13
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000058*/ v_add_u32       v3, vcc, s4, v3
/*00000000005c*/ v_mov_b32       v7, s5
/*000000000060*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000064*/ v_mov_b32       v5, s10
/*000000000068*/ v_mov_b32       v6, s11
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ s_mov_b32       s0, s1
/*000000000078*/ s_movk_i32      s1, 0x0
/*00000000007c*/ s_sub_u32       s0, s0, s14
/*000000000080*/ s_subb_u32      s1, s1, s15
/*000000000084*/ s_add_u32       s3, s8, s14
/*000000000088*/ v_add_u32       v0, vcc, s3, v1
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s4, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a0*/ v_mov_b32       v3, s0
/*0000000000a4*/ v_mov_b32       v4, s1
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_movk_i32      s3, 0x0
/*0000000000b4*/ s_sub_u32       s0, s2, s6
/*0000000000b8*/ s_subb_u32      s1, s3, s7
/*0000000000bc*/ s_add_u32       s2, s9, s6
/*0000000000c0*/ v_add_u32       v0, vcc, s2, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, s1
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel subtract_long_get_num_groups_get_global_offset
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
/*00000000003c*/ s_lshl_b32      s8, s9, 1
/*000000000040*/ s_lshl_b32      s9, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v3, vcc, s3, v0
/*00000000004c*/ s_movk_i32      s17, 0x0
/*000000000050*/ s_sub_u32       s10, s16, s12
/*000000000054*/ s_subb_u32      s11, s17, s13
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v7, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000070*/ v_mov_b32       v5, s10
/*000000000074*/ v_mov_b32       v6, s11
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ s_movk_i32      s1, 0x0
/*000000000084*/ s_sub_u32       s0, s0, s14
/*000000000088*/ s_subb_u32      s1, s1, s15
/*00000000008c*/ s_add_u32       s3, s8, s14
/*000000000090*/ v_add_u32       v0, vcc, s3, v1
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a8*/ v_mov_b32       v3, s0
/*0000000000ac*/ v_mov_b32       v4, s1
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ s_movk_i32      s3, 0x0
/*0000000000bc*/ s_sub_u32       s0, s2, s6
/*0000000000c0*/ s_subb_u32      s1, s3, s7
/*0000000000c4*/ s_add_u32       s2, s9, s6
/*0000000000c8*/ v_add_u32       v0, vcc, s2, v2
/*0000000000cc*/ v_mov_b32       v1, 0
/*0000000000d0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000dc*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000e0*/ v_mov_b32       v2, s0
/*0000000000e4*/ v_mov_b32       v3, s1
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_get_work_dim_get_global_offset
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
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000010*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_bfe_u32       s16, s0, 0x20010
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ s_lshl_b32      s6, s9, 1
/*000000000034*/ s_lshl_b32      s7, s10, 2
/*000000000038*/ s_movk_i32      s17, 0x0
/*00000000003c*/ s_sub_u32       s10, s16, s12
/*000000000040*/ s_subb_u32      s11, s17, s13
/*000000000044*/ s_add_u32       s0, s1, s12
/*000000000048*/ v_add_u32       v3, vcc, s0, v0
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000058*/ v_add_u32       v3, vcc, s2, v3
/*00000000005c*/ v_mov_b32       v7, s3
/*000000000060*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000064*/ v_mov_b32       v5, s10
/*000000000068*/ v_mov_b32       v6, s11
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ s_sub_u32       s0, s16, s14
/*000000000078*/ s_subb_u32      s1, s17, s15
/*00000000007c*/ s_add_u32       s3, s6, s14
/*000000000080*/ v_add_u32       v0, vcc, s3, v1
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s2, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ v_mov_b32       v3, s0
/*00000000009c*/ v_mov_b32       v4, s1
/*0000000000a0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a8*/ s_sub_u32       s0, s16, s4
/*0000000000ac*/ s_subb_u32      s1, s17, s5
/*0000000000b0*/ s_add_u32       s3, s7, s4
/*0000000000b4*/ v_add_u32       v0, vcc, s3, v2
/*0000000000b8*/ v_mov_b32       v1, 0
/*0000000000bc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000c8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000cc*/ v_mov_b32       v2, s0
/*0000000000d0*/ v_mov_b32       v3, s1
/*0000000000d4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000dc*/ s_endpgm
.kernel subtract_long_x_get_local_id
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
/*000000000040*/ v_sub_u32       v5, vcc, s1, v0
/*000000000044*/ v_mov_b32       v7, s0
/*000000000048*/ v_subb_u32      v6, vcc, v7, 0, vcc
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s10, v3
/*000000000060*/ v_mov_b32       v8, s11
/*000000000064*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000068*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000070*/ v_sub_u32       v3, vcc, s1, v1
/*000000000074*/ v_subb_u32      v4, vcc, v7, 0, vcc
/*00000000007c*/ s_add_u32       s0, s5, s2
/*000000000080*/ v_add_u32       v0, vcc, s0, v1
/*000000000084*/ v_mov_b32       v1, 0
/*000000000088*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000090*/ v_add_u32       v0, vcc, s10, v0
/*000000000094*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000098*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a0*/ v_sub_u32       v3, vcc, s1, v2
/*0000000000a4*/ v_subb_u32      v4, vcc, v7, 0, vcc
/*0000000000ac*/ s_add_u32       s0, s6, s4
/*0000000000b0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d0*/ s_endpgm
.kernel subtract_long_get_global_offset_get_local_id
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
/*000000000038*/ v_sub_u32       v5, vcc, s0, v0
/*00000000003c*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v8, s11
/*000000000058*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ v_sub_u32       v3, vcc, s2, v1
/*000000000068*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000070*/ v_mov_b32       v10, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ v_sub_u32       v3, vcc, s4, v2
/*000000000090*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000098*/ s_add_u32       s0, s5, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_local_id_get_local_id
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
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 3
/*000000000020*/ s_lshl_b32      s3, s7, 2
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
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
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_get_group_id_get_local_id
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
/*000000000038*/ v_sub_u32       v5, vcc, s6, v0
/*00000000003c*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000044*/ v_mov_b32       v4, 0
/*000000000048*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000050*/ v_add_u32       v3, vcc, s10, v3
/*000000000054*/ v_mov_b32       v8, s11
/*000000000058*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ v_sub_u32       v3, vcc, s7, v1
/*000000000068*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000070*/ v_mov_b32       v10, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ v_sub_u32       v3, vcc, s8, v2
/*000000000090*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000098*/ s_add_u32       s0, s5, s4
/*00000000009c*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_local_size_get_local_id
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
/*00000000005c*/ v_sub_u32       v7, vcc, 2, v0
/*000000000060*/ v_subb_u32      v8, vcc, 0, 0, vcc
/*000000000068*/ flat_store_dwordx2 v[5:6], v[7:8]
/*000000000070*/ v_add_u32       v6, vcc, s10, v3
/*000000000074*/ v_addc_u32      v7, vcc, v9, v4, vcc
/*000000000078*/ v_sub_u32       v3, vcc, 2, v1
/*00000000007c*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000084*/ flat_store_dwordx2 v[6:7], v[3:4]
/*00000000008c*/ s_add_u32       s0, s5, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000a8*/ v_sub_u32       v2, vcc, 4, v2
/*0000000000ac*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_global_id_get_local_id
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
/*000000000050*/ v_sub_u32       v5, vcc, v5, v0
/*000000000054*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ v_sub_u32       v3, vcc, v9, v1
/*000000000068*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000070*/ v_mov_b32       v10, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_add_u32       s0, s3, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_sub_u32       v2, vcc, v0, v2
/*000000000098*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000bc*/ s_endpgm
.kernel subtract_long_get_global_size_get_local_id
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
/*000000000048*/ v_sub_u32       v5, vcc, s0, v0
/*00000000004c*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000054*/ v_mov_b32       v4, 0
/*000000000058*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000060*/ v_add_u32       v3, vcc, s4, v3
/*000000000064*/ v_mov_b32       v8, s5
/*000000000068*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ v_sub_u32       v3, vcc, s1, v1
/*000000000078*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000080*/ v_mov_b32       v10, 0
/*000000000084*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*00000000008c*/ v_add_u32       v0, vcc, s4, v0
/*000000000090*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ v_sub_u32       v3, vcc, s2, v2
/*0000000000a0*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*0000000000a8*/ s_add_u32       s0, s8, s6
/*0000000000ac*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b0*/ v_mov_b32       v1, 0
/*0000000000b4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000bc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000cc*/ s_endpgm
.kernel subtract_long_get_num_groups_get_local_id
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
/*000000000054*/ v_sub_u32       v5, vcc, s0, v0
/*000000000058*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v8, s5
/*000000000074*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ v_sub_u32       v3, vcc, s1, v1
/*000000000084*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*00000000008c*/ v_mov_b32       v10, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000098*/ v_add_u32       v0, vcc, s4, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a8*/ v_sub_u32       v3, vcc, s2, v2
/*0000000000ac*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*0000000000b4*/ s_add_u32       s0, s8, s6
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d8*/ s_endpgm
.kernel subtract_long_get_work_dim_get_local_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 20
        .vgprsnum 15
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[12:13], s[6:7], 0x10
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x0
/*00000000001c*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000024*/ s_lshl_b32      s3, s8, 1
/*000000000028*/ s_lshl_b32      s6, s9, 1
/*00000000002c*/ s_add_u32       s0, s3, s0
/*000000000030*/ s_lshl_b32      s3, s10, 2
/*000000000034*/ v_add_u32       v5, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s6, s2
/*00000000003c*/ v_add_u32       v9, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s3, s12
/*000000000044*/ s_waitcnt       lgkmcnt(0)
/*000000000048*/ s_bfe_u32       s1, s1, 0x20010
/*000000000050*/ v_mov_b32       v6, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 3, v[5:6]
/*00000000005c*/ v_add_u32       v11, vcc, s0, v2
/*000000000060*/ v_sub_u32       v13, vcc, s1, v0
/*000000000064*/ v_subb_u32      v14, vcc, 0, 0, vcc
/*00000000006c*/ v_add_u32       v5, vcc, s4, v5
/*000000000070*/ v_mov_b32       v8, s5
/*000000000074*/ v_addc_u32      v6, vcc, v8, v6, vcc
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[9:10], 3, v[9:10]
/*000000000084*/ v_sub_u32       v0, vcc, s1, v1
/*000000000088*/ v_subb_u32      v1, vcc, 0, 0, vcc
/*000000000090*/ v_add_u32       v9, vcc, s4, v9
/*000000000094*/ v_addc_u32      v10, vcc, v8, v10, vcc
/*000000000098*/ v_mov_b32       v12, 0
/*00000000009c*/ v_lshlrev_b64   v[11:12], 3, v[11:12]
/*0000000000a4*/ v_sub_u32       v2, vcc, s1, v2
/*0000000000a8*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000b0*/ v_add_u32       v7, vcc, s4, v11
/*0000000000b4*/ v_addc_u32      v8, vcc, v8, v12, vcc
/*0000000000b8*/ flat_store_dwordx2 v[5:6], v[13:14]
/*0000000000c0*/ flat_store_dwordx2 v[9:10], v[0:1]
/*0000000000c8*/ flat_store_dwordx2 v[7:8], v[2:3]
/*0000000000d0*/ s_endpgm
.kernel subtract_long_x_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dword    s14, s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[10:11], s[4:5], 0x30
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s3, s6, 4
/*000000000028*/ s_lshl_b32      s5, s7, 1
/*00000000002c*/ s_lshl_b32      s9, s8, 1
/*000000000030*/ s_add_u32       s0, s3, s0
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_ashr_i32      s15, s14, 31
/*00000000003c*/ s_movk_i32      s13, 0x0
/*000000000040*/ s_sub_u32       s12, s14, s6
/*000000000044*/ s_subb_u32      s13, s15, s13
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v7, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000060*/ v_mov_b32       v5, s12
/*000000000064*/ v_mov_b32       v6, s13
/*000000000068*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000070*/ s_mov_b32       s6, s7
/*000000000074*/ s_movk_i32      s7, 0x0
/*000000000078*/ s_sub_u32       s6, s14, s6
/*00000000007c*/ s_subb_u32      s7, s15, s7
/*000000000080*/ s_add_u32       s2, s5, s2
/*000000000084*/ v_add_u32       v0, vcc, s2, v1
/*000000000088*/ v_mov_b32       v1, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ v_mov_b32       v3, s6
/*0000000000a0*/ v_mov_b32       v4, s7
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_movk_i32      s3, 0x0
/*0000000000b0*/ s_sub_u32       s0, s14, s8
/*0000000000b4*/ s_subb_u32      s1, s15, s3
/*0000000000b8*/ s_add_u32       s2, s9, s4
/*0000000000bc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s10, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ v_mov_b32       v2, s0
/*0000000000d8*/ v_mov_b32       v3, s1
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel subtract_long_get_global_offset_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 21
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
/*000000000010*/ s_load_dwordx2  s[14:15], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_lshl_b32      s5, s8, 1
/*000000000028*/ s_add_u32       s1, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s1, v0
/*000000000030*/ s_add_u32       s1, s3, s2
/*000000000034*/ v_add_u32       v7, vcc, s1, v1
/*000000000038*/ s_movk_i32      s1, 0x0
/*00000000003c*/ s_mov_b32       s12, s6
/*000000000040*/ s_movk_i32      s13, 0x0
/*000000000044*/ s_sub_u32       s0, s0, s6
/*000000000048*/ s_subb_u32      s1, s1, s13
/*00000000004c*/ v_mov_b32       v1, 0
/*000000000050*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_mov_b32       v6, s11
/*000000000060*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000064*/ v_mov_b32       v3, s0
/*000000000068*/ v_mov_b32       v4, s1
/*00000000006c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000074*/ s_mov_b32       s0, s2
/*000000000078*/ s_movk_i32      s1, 0x0
/*00000000007c*/ s_movk_i32      s3, 0x0
/*000000000080*/ s_sub_u32       s0, s0, s7
/*000000000084*/ s_subb_u32      s1, s1, s3
/*000000000088*/ v_mov_b32       v8, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000094*/ v_add_u32       v0, vcc, s10, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000009c*/ v_mov_b32       v3, s0
/*0000000000a0*/ v_mov_b32       v4, s1
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_movk_i32      s15, 0x0
/*0000000000b0*/ s_movk_i32      s9, 0x0
/*0000000000b4*/ s_sub_u32       s0, s14, s8
/*0000000000b8*/ s_subb_u32      s1, s15, s9
/*0000000000bc*/ s_add_u32       s2, s5, s14
/*0000000000c0*/ v_add_u32       v0, vcc, s2, v2
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, s1
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel subtract_long_get_local_id_get_group_id
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
/*000000000038*/ v_sub_u32       v5, vcc, v0, s6
/*000000000040*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000048*/ v_mov_b32       v4, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000054*/ v_add_u32       v3, vcc, s10, v3
/*000000000058*/ v_mov_b32       v8, s11
/*00000000005c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000060*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000068*/ v_sub_u32       v3, vcc, v1, s7
/*000000000070*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000078*/ v_mov_b32       v10, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ v_sub_u32       v3, vcc, v2, s8
/*00000000009c*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*0000000000a4*/ s_add_u32       s0, s5, s4
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_group_id_get_group_id
    .config
        .dims xyz
        .cws 2, 16, 2
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
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 4
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_lshl_b32      s1, s8, 1
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
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_get_local_size_get_group_id
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
/*00000000005c*/ s_movk_i32      s1, 0x0
/*000000000060*/ s_sub_u32       s0, 2, s6
/*000000000064*/ s_subb_u32      s1, 0, s1
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ v_mov_b32       v6, s1
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ s_movk_i32      s1, 0x0
/*000000000084*/ s_sub_u32       s0, 2, s7
/*000000000088*/ s_subb_u32      s1, 0, s1
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
/*0000000000bc*/ s_sub_u32       s0, 4, s8
/*0000000000c0*/ s_subb_u32      s1, 0, s9
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_global_id_get_group_id
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
/*000000000050*/ v_sub_u32       v3, vcc, v0, s6
/*000000000058*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000060*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000068*/ v_sub_u32       v3, vcc, v10, s7
/*000000000070*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000078*/ v_mov_b32       v11, 0
/*00000000007c*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s0, s3, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_sub_u32       v2, vcc, v0, s8
/*0000000000a4*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_global_size_get_group_id
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 24
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s16, s[4:5], 0x14
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
/*000000000048*/ s_movk_i32      s13, 0x0
/*00000000004c*/ s_mov_b32       s14, s8
/*000000000050*/ s_movk_i32      s15, 0x0
/*000000000054*/ s_sub_u32       s12, s0, s8
/*000000000058*/ s_subb_u32      s13, s13, s15
/*00000000005c*/ v_mov_b32       v1, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_mov_b32       v6, s5
/*000000000070*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000074*/ v_mov_b32       v3, s12
/*000000000078*/ v_mov_b32       v4, s13
/*00000000007c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000084*/ s_mov_b32       s0, s1
/*000000000088*/ s_movk_i32      s1, 0x0
/*00000000008c*/ s_mov_b32       s8, s9
/*000000000090*/ s_movk_i32      s9, 0x0
/*000000000094*/ s_sub_u32       s0, s0, s8
/*000000000098*/ s_subb_u32      s1, s1, s9
/*00000000009c*/ v_mov_b32       v8, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b0*/ v_mov_b32       v3, s0
/*0000000000b4*/ v_mov_b32       v4, s1
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c0*/ s_movk_i32      s17, 0x0
/*0000000000c4*/ s_movk_i32      s3, 0x0
/*0000000000c8*/ s_sub_u32       s0, s16, s10
/*0000000000cc*/ s_subb_u32      s1, s17, s3
/*0000000000d0*/ s_add_u32       s2, s11, s6
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v2
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ec*/ v_mov_b32       v2, s0
/*0000000000f0*/ v_mov_b32       v3, s1
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel subtract_long_get_num_groups_get_group_id
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
/*000000000034*/ s_lshr_b32      s18, s2, 2
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 1
/*000000000040*/ s_lshl_b32      s11, s10, 2
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ s_movk_i32      s17, 0x0
/*000000000058*/ s_mov_b32       s14, s8
/*00000000005c*/ s_movk_i32      s15, 0x0
/*000000000060*/ s_sub_u32       s12, s16, s8
/*000000000064*/ s_subb_u32      s13, s17, s15
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_mov_b32       v6, s5
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ v_mov_b32       v3, s12
/*000000000084*/ v_mov_b32       v4, s13
/*000000000088*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000090*/ s_movk_i32      s1, 0x0
/*000000000094*/ s_mov_b32       s8, s9
/*000000000098*/ s_movk_i32      s9, 0x0
/*00000000009c*/ s_sub_u32       s0, s0, s8
/*0000000000a0*/ s_subb_u32      s1, s1, s9
/*0000000000a4*/ v_mov_b32       v8, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ v_mov_b32       v3, s0
/*0000000000bc*/ v_mov_b32       v4, s1
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_movk_i32      s19, 0x0
/*0000000000cc*/ s_movk_i32      s3, 0x0
/*0000000000d0*/ s_sub_u32       s0, s18, s10
/*0000000000d4*/ s_subb_u32      s1, s19, s3
/*0000000000d8*/ s_add_u32       s2, s11, s6
/*0000000000dc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f4*/ v_mov_b32       v2, s0
/*0000000000f8*/ v_mov_b32       v3, s1
/*0000000000fc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000104*/ s_endpgm
.kernel subtract_long_get_work_dim_get_group_id
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
/*000000000040*/ s_movk_i32      s1, 0x0
/*000000000044*/ s_movk_i32      s13, 0x0
/*000000000048*/ s_sub_u32       s12, s0, s8
/*00000000004c*/ s_subb_u32      s13, s1, s13
/*000000000050*/ v_mov_b32       v4, 0
/*000000000054*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000005c*/ v_add_u32       v3, vcc, s2, v3
/*000000000060*/ v_mov_b32       v7, s3
/*000000000064*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000068*/ v_mov_b32       v5, s12
/*00000000006c*/ v_mov_b32       v6, s13
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ s_mov_b32       s8, s9
/*00000000007c*/ s_movk_i32      s9, 0x0
/*000000000080*/ s_sub_u32       s8, s0, s8
/*000000000084*/ s_subb_u32      s9, s1, s9
/*000000000088*/ s_add_u32       s3, s5, s14
/*00000000008c*/ v_add_u32       v0, vcc, s3, v1
/*000000000090*/ v_mov_b32       v1, 0
/*000000000094*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000009c*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ v_mov_b32       v3, s8
/*0000000000a8*/ v_mov_b32       v4, s9
/*0000000000ac*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b4*/ s_movk_i32      s11, 0x0
/*0000000000b8*/ s_sub_u32       s0, s0, s10
/*0000000000bc*/ s_subb_u32      s1, s1, s11
/*0000000000c0*/ s_add_u32       s3, s6, s4
/*0000000000c4*/ v_add_u32       v0, vcc, s3, v2
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000dc*/ v_mov_b32       v2, s0
/*0000000000e0*/ v_mov_b32       v3, s1
/*0000000000e4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000ec*/ s_endpgm
.kernel subtract_long_x_get_local_size
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
/*000000000054*/ s_add_u32       s8, s12, -16
/*000000000058*/ s_addc_u32      s9, s13, -1
/*00000000005c*/ v_mov_b32       v5, s8
/*000000000060*/ v_mov_b32       v6, s9
/*000000000064*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000006c*/ s_add_u32       s2, s5, s2
/*000000000070*/ v_add_u32       v0, vcc, s2, v1
/*000000000074*/ v_mov_b32       v1, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000088*/ s_add_u32       s0, s12, -2
/*00000000008c*/ s_addc_u32      s1, s13, -1
/*000000000090*/ v_mov_b32       v3, s0
/*000000000094*/ v_mov_b32       v4, s1
/*000000000098*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a0*/ s_add_u32       s0, s6, s4
/*0000000000a4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a8*/ v_mov_b32       v1, 0
/*0000000000ac*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b4*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_endpgm
.kernel subtract_long_get_global_offset_get_local_size
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
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000044*/ v_add_u32       v0, vcc, s10, v0
/*000000000048*/ v_mov_b32       v6, s11
/*00000000004c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000050*/ s_movk_i32      s1, 0x0
/*000000000054*/ s_add_u32       s0, s0, -2
/*000000000058*/ s_addc_u32      s1, s1, -1
/*00000000005c*/ v_mov_b32       v3, s0
/*000000000060*/ v_mov_b32       v4, s1
/*000000000064*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000006c*/ v_mov_b32       v8, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ s_movk_i32      s1, 0x0
/*000000000084*/ s_add_u32       s0, s2, -16
/*000000000088*/ s_addc_u32      s1, s1, -1
/*00000000008c*/ v_mov_b32       v3, s0
/*000000000090*/ v_mov_b32       v4, s1
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s0, s5, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s0, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ s_movk_i32      s5, 0x0
/*0000000000bc*/ s_add_u32       s0, s4, -2
/*0000000000c0*/ s_addc_u32      s1, s5, -1
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_local_id_get_local_size
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
/*00000000005c*/ v_add_u32       v7, vcc, v0, -8
/*000000000064*/ v_addc_u32      v8, vcc, 0, -1, vcc
/*00000000006c*/ flat_store_dwordx2 v[5:6], v[7:8]
/*000000000074*/ v_add_u32       v6, vcc, s10, v3
/*000000000078*/ v_addc_u32      v7, vcc, v9, v4, vcc
/*00000000007c*/ v_add_u32       v3, vcc, v1, -4
/*000000000084*/ v_addc_u32      v4, vcc, 0, -1, vcc
/*00000000008c*/ flat_store_dwordx2 v[6:7], v[3:4]
/*000000000094*/ s_add_u32       s0, s5, s4
/*000000000098*/ v_add_u32       v0, vcc, s0, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b0*/ v_add_u32       v2, vcc, v2, -2
/*0000000000b8*/ v_addc_u32      v3, vcc, 0, -1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_group_id_get_local_size
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
/*00000000005c*/ s_movk_i32      s1, 0x0
/*000000000060*/ s_add_u32       s0, s6, -2
/*000000000064*/ s_addc_u32      s1, s1, -1
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ v_mov_b32       v6, s1
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ s_movk_i32      s1, 0x0
/*000000000084*/ s_add_u32       s0, s7, -16
/*000000000088*/ s_addc_u32      s1, s1, -1
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
/*0000000000bc*/ s_add_u32       s0, s8, -2
/*0000000000c0*/ s_addc_u32      s1, s9, -1
/*0000000000c4*/ v_mov_b32       v2, s0
/*0000000000c8*/ v_mov_b32       v3, s1
/*0000000000cc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d4*/ s_endpgm
.kernel subtract_long_get_local_size_get_local_size
    .config
        .dims xyz
        .cws 2, 2, 4
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
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_get_global_id_get_local_size
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
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s3, s6, 1
/*000000000020*/ v_add_u32       v5, vcc, s3, v0
/*000000000024*/ s_lshl_b32      s3, s7, 1
/*000000000028*/ s_lshl_b32      s4, s8, 2
/*00000000002c*/ v_mov_b32       v6, 0
/*000000000030*/ v_lshlrev_b64   v[3:4], 3, v[5:6]
/*000000000038*/ v_add_u32       v3, vcc, s0, v3
/*00000000003c*/ v_mov_b32       v7, s1
/*000000000040*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000044*/ v_add_u32       v0, vcc, s12, v5
/*000000000048*/ v_add_u32       v5, vcc, v0, -2
/*000000000050*/ v_addc_u32      v6, vcc, 0, -1, vcc
/*000000000058*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000060*/ s_add_u32       s1, s3, s14
/*000000000064*/ v_add_u32       v3, vcc, s1, v1
/*000000000068*/ v_mov_b32       v4, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 3, v[3:4]
/*000000000074*/ v_add_u32       v0, vcc, s0, v0
/*000000000078*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000007c*/ v_add_u32       v3, vcc, v3, -2
/*000000000084*/ v_addc_u32      v4, vcc, 0, -1, vcc
/*00000000008c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000094*/ s_add_u32       s1, s4, s2
/*000000000098*/ v_add_u32       v2, vcc, s1, v2
/*00000000009c*/ v_mov_b32       v3, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b0*/ v_add_u32       v2, vcc, v2, -4
/*0000000000b8*/ v_addc_u32      v3, vcc, 0, -1, vcc
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_global_size_get_local_size
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
/*00000000006c*/ s_movk_i32      s11, 0x0
/*000000000070*/ s_add_u32       s10, s0, -16
/*000000000074*/ s_addc_u32      s11, s11, -1
/*000000000078*/ v_mov_b32       v5, s10
/*00000000007c*/ v_mov_b32       v6, s11
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_mov_b32       s0, s1
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_add_u32       s0, s0, -2
/*00000000009c*/ s_addc_u32      s1, s1, -1
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
/*0000000000d0*/ s_add_u32       s0, s2, -2
/*0000000000d4*/ s_addc_u32      s1, s3, -1
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, s1
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel subtract_long_get_num_groups_get_local_size
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
/*00000000007c*/ s_add_u32       s10, s16, -2
/*000000000080*/ s_addc_u32      s11, s17, -1
/*000000000084*/ v_mov_b32       v5, s10
/*000000000088*/ v_mov_b32       v6, s11
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ s_movk_i32      s1, 0x0
/*0000000000a0*/ s_add_u32       s0, s0, -2
/*0000000000a4*/ s_addc_u32      s1, s1, -1
/*0000000000a8*/ v_mov_b32       v3, s0
/*0000000000ac*/ v_mov_b32       v4, s1
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ s_add_u32       s0, s8, s6
/*0000000000bc*/ v_add_u32       v0, vcc, s0, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ s_movk_i32      s3, 0x0
/*0000000000d8*/ s_add_u32       s0, s2, -4
/*0000000000dc*/ s_addc_u32      s1, s3, -1
/*0000000000e0*/ v_mov_b32       v2, s0
/*0000000000e4*/ v_mov_b32       v3, s1
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_get_work_dim_get_local_size
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
/*00000000005c*/ s_add_u32       s8, s0, -2
/*000000000060*/ s_addc_u32      s9, s1, -1
/*000000000064*/ v_mov_b32       v5, s8
/*000000000068*/ v_mov_b32       v6, s9
/*00000000006c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000074*/ s_add_u32       s3, s5, s14
/*000000000078*/ v_add_u32       v0, vcc, s3, v1
/*00000000007c*/ v_mov_b32       v1, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ flat_store_dwordx2 v[0:1], v[5:6]
/*000000000098*/ s_add_u32       s3, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s3, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ s_add_u32       s0, s0, -4
/*0000000000b8*/ s_addc_u32      s1, s1, -1
/*0000000000bc*/ v_mov_b32       v2, s0
/*0000000000c0*/ v_mov_b32       v3, s1
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000cc*/ s_endpgm
.kernel subtract_long_x_get_global_id
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
/*000000000060*/ v_sub_u32       v10, vcc, s9, v1
/*000000000064*/ v_mov_b32       v8, s1
/*000000000068*/ v_subb_u32      v11, vcc, v8, v2, vcc
/*00000000006c*/ v_add_u32       v0, vcc, s0, v0
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s10, v0
/*000000000080*/ v_mov_b32       v9, s11
/*000000000084*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*000000000088*/ flat_store_dwordx2 v[0:1], v[10:11]
/*000000000090*/ v_sub_u32       v2, vcc, s9, v6
/*000000000094*/ v_subb_u32      v3, vcc, v8, v7, vcc
/*000000000098*/ v_add_u32       v0, vcc, s2, v4
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b8*/ v_add_u32       v0, vcc, v5, s4
/*0000000000c0*/ v_mov_b32       v1, s5
/*0000000000c4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000c8*/ v_sub_u32       v2, vcc, s9, v0
/*0000000000cc*/ v_subb_u32      v3, vcc, v8, v1, vcc
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v5
/*0000000000d4*/ v_mov_b32       v1, 0
/*0000000000d8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000e4*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_get_global_offset_get_global_id
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
/*000000000054*/ v_sub_u32       v9, vcc, s0, v1
/*000000000058*/ v_subb_u32      v10, vcc, 0, v2, vcc
/*00000000005c*/ v_add_u32       v0, vcc, s0, v0
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_mov_b32       v8, s11
/*000000000074*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000078*/ flat_store_dwordx2 v[0:1], v[9:10]
/*000000000080*/ v_sub_u32       v2, vcc, s2, v6
/*000000000084*/ v_subb_u32      v3, vcc, 0, v7, vcc
/*000000000088*/ v_add_u32       v0, vcc, s2, v4
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000a8*/ v_add_u32       v0, vcc, v5, s4
/*0000000000b0*/ v_mov_b32       v1, s5
/*0000000000b4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000b8*/ v_sub_u32       v2, vcc, s4, v0
/*0000000000bc*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v5
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_local_id_get_global_id
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
/*000000000024*/ v_add_u32       v4, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 1
/*00000000002c*/ v_add_u32       v5, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v6, vcc, s0, v3
/*000000000038*/ v_add_u32       v3, vcc, v3, s0
/*000000000040*/ v_mov_b32       v7, s1
/*000000000044*/ v_addc_u32      v7, vcc, 0, v7, vcc
/*000000000048*/ v_add_u32       v8, vcc, v4, s2
/*000000000050*/ v_mov_b32       v9, s3
/*000000000054*/ v_addc_u32      v9, vcc, 0, v9, vcc
/*000000000058*/ v_sub_u32       v11, vcc, v0, v3
/*00000000005c*/ v_subb_u32      v12, vcc, 0, v7, vcc
/*000000000060*/ v_mov_b32       v7, 0
/*000000000064*/ v_lshlrev_b64   v[6:7], 3, v[6:7]
/*00000000006c*/ v_add_u32       v6, vcc, s10, v6
/*000000000070*/ v_mov_b32       v10, s11
/*000000000074*/ v_addc_u32      v7, vcc, v10, v7, vcc
/*000000000078*/ flat_store_dwordx2 v[6:7], v[11:12]
/*000000000080*/ v_sub_u32       v0, vcc, v1, v8
/*000000000084*/ v_subb_u32      v1, vcc, 0, v9, vcc
/*000000000088*/ v_add_u32       v3, vcc, s2, v4
/*00000000008c*/ v_mov_b32       v4, 0
/*000000000090*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000098*/ v_add_u32       v3, vcc, s10, v3
/*00000000009c*/ v_addc_u32      v4, vcc, v10, v4, vcc
/*0000000000a0*/ flat_store_dwordx2 v[3:4], v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, v5, s4
/*0000000000b0*/ v_mov_b32       v1, s5
/*0000000000b4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000b8*/ v_sub_u32       v0, vcc, v2, v0
/*0000000000bc*/ v_subb_u32      v1, vcc, 0, v1, vcc
/*0000000000c0*/ v_add_u32       v2, vcc, s4, v5
/*0000000000c4*/ v_mov_b32       v3, 0
/*0000000000c8*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*0000000000d0*/ v_add_u32       v2, vcc, s10, v2
/*0000000000d4*/ v_addc_u32      v3, vcc, v10, v3, vcc
/*0000000000d8*/ flat_store_dwordx2 v[2:3], v[0:1]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_group_id_get_global_id
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
/*000000000058*/ v_sub_u32       v10, vcc, s6, v0
/*00000000005c*/ v_subb_u32      v11, vcc, 0, v2, vcc
/*000000000060*/ v_mov_b32       v9, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*00000000006c*/ v_add_u32       v0, vcc, s10, v0
/*000000000070*/ v_mov_b32       v8, s11
/*000000000074*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000078*/ flat_store_dwordx2 v[0:1], v[10:11]
/*000000000080*/ v_sub_u32       v2, vcc, s7, v6
/*000000000084*/ v_subb_u32      v3, vcc, 0, v7, vcc
/*000000000088*/ v_add_u32       v0, vcc, s2, v4
/*00000000008c*/ v_mov_b32       v1, 0
/*000000000090*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000098*/ v_add_u32       v0, vcc, s10, v0
/*00000000009c*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000a8*/ v_add_u32       v0, vcc, v5, s4
/*0000000000b0*/ v_mov_b32       v1, s5
/*0000000000b4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000b8*/ v_sub_u32       v2, vcc, s8, v0
/*0000000000bc*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v5
/*0000000000c4*/ v_mov_b32       v1, 0
/*0000000000c8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000d4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_local_size_get_global_id
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
/*00000000001c*/ v_add_u32       v4, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 1
/*000000000024*/ v_add_u32       v6, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v7, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v2, vcc, s0, v4
/*000000000038*/ v_add_u32       v0, vcc, s2, v6
/*00000000003c*/ v_mov_b32       v1, 0
/*000000000040*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000048*/ v_mov_b32       v3, 0
/*00000000004c*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000000054*/ v_add_u32       v2, vcc, s10, v2
/*000000000058*/ v_mov_b32       v8, s11
/*00000000005c*/ v_addc_u32      v3, vcc, v8, v3, vcc
/*000000000060*/ v_add_u32       v4, vcc, v4, s0
/*000000000068*/ v_mov_b32       v5, s1
/*00000000006c*/ v_addc_u32      v5, vcc, 0, v5, vcc
/*000000000070*/ v_sub_u32       v4, vcc, 2, v4
/*000000000074*/ v_subb_u32      v5, vcc, 0, v5, vcc
/*000000000078*/ flat_store_dwordx2 v[2:3], v[4:5]
/*000000000080*/ v_add_u32       v0, vcc, s10, v0
/*000000000084*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000088*/ v_add_u32       v2, vcc, v6, s2
/*000000000090*/ v_mov_b32       v3, s3
/*000000000094*/ v_addc_u32      v3, vcc, 0, v3, vcc
/*000000000098*/ v_sub_u32       v2, vcc, 2, v2
/*00000000009c*/ v_subb_u32      v3, vcc, 0, v3, vcc
/*0000000000a0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000a8*/ v_add_u32       v0, vcc, s4, v7
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b8*/ v_add_u32       v0, vcc, s10, v0
/*0000000000bc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000c0*/ v_add_u32       v2, vcc, v7, s4
/*0000000000c8*/ v_mov_b32       v3, s5
/*0000000000cc*/ v_addc_u32      v3, vcc, 0, v3, vcc
/*0000000000d0*/ v_sub_u32       v2, vcc, 4, v2
/*0000000000d4*/ v_subb_u32      v3, vcc, 0, v3, vcc
/*0000000000d8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_global_id_get_global_id
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
/*00000000001c*/ v_add_u32       v6, vcc, s6, v0
/*000000000020*/ s_lshl_b32      s6, s7, 1
/*000000000024*/ v_add_u32       v1, vcc, s6, v1
/*000000000028*/ s_lshl_b32      s6, s8, 2
/*00000000002c*/ v_add_u32       v2, vcc, s6, v2
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ v_add_u32       v3, vcc, v6, s0
/*00000000003c*/ v_mov_b32       v4, s1
/*000000000040*/ v_addc_u32      v4, vcc, 0, v4, vcc
/*000000000044*/ v_add_u32       v5, vcc, s0, v6
/*000000000048*/ v_sub_u32       v3, vcc, v5, v3
/*00000000004c*/ v_subb_u32      v4, vcc, 0, v4, vcc
/*000000000050*/ v_mov_b32       v7, 0
/*000000000054*/ v_lshlrev_b64   v[5:6], 3, v[6:7]
/*00000000005c*/ v_add_u32       v7, vcc, s10, v5
/*000000000060*/ v_mov_b32       v5, s11
/*000000000064*/ v_addc_u32      v8, vcc, v5, v6, vcc
/*000000000068*/ flat_store_dwordx2 v[7:8], v[3:4]
/*000000000070*/ v_add_u32       v0, vcc, v1, s2
/*000000000078*/ v_mov_b32       v3, s3
/*00000000007c*/ v_addc_u32      v3, vcc, 0, v3, vcc
/*000000000080*/ v_add_u32       v6, vcc, s2, v1
/*000000000084*/ v_sub_u32       v0, vcc, v6, v0
/*000000000088*/ v_subb_u32      v1, vcc, 0, v3, vcc
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 3, v[6:7]
/*000000000098*/ v_add_u32       v6, vcc, s10, v6
/*00000000009c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*0000000000a0*/ flat_store_dwordx2 v[6:7], v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, v2, s4
/*0000000000b0*/ v_mov_b32       v1, s5
/*0000000000b4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000b8*/ v_add_u32       v2, vcc, s4, v2
/*0000000000bc*/ v_sub_u32       v0, vcc, v2, v0
/*0000000000c0*/ v_subb_u32      v1, vcc, 0, v1, vcc
/*0000000000c4*/ v_mov_b32       v3, 0
/*0000000000c8*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*0000000000d0*/ v_add_u32       v2, vcc, s10, v2
/*0000000000d4*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*0000000000d8*/ flat_store_dwordx2 v[2:3], v[0:1]
/*0000000000e0*/ s_endpgm
.kernel subtract_long_get_global_size_get_global_id
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
/*000000000068*/ v_sub_u32       v10, vcc, s0, v0
/*00000000006c*/ v_subb_u32      v11, vcc, 0, v2, vcc
/*000000000070*/ v_mov_b32       v9, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*00000000007c*/ v_add_u32       v0, vcc, s4, v0
/*000000000080*/ v_mov_b32       v8, s5
/*000000000084*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000088*/ flat_store_dwordx2 v[0:1], v[10:11]
/*000000000090*/ v_sub_u32       v2, vcc, s1, v6
/*000000000094*/ v_subb_u32      v3, vcc, 0, v7, vcc
/*000000000098*/ v_add_u32       v0, vcc, s14, v4
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b8*/ v_add_u32       v0, vcc, v5, s6
/*0000000000c0*/ v_mov_b32       v1, s7
/*0000000000c4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000c8*/ v_sub_u32       v2, vcc, s2, v0
/*0000000000cc*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000d0*/ v_add_u32       v0, vcc, s6, v5
/*0000000000d4*/ v_mov_b32       v1, 0
/*0000000000d8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_get_num_groups_get_global_id
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
/*000000000074*/ v_sub_u32       v10, vcc, s0, v0
/*000000000078*/ v_subb_u32      v11, vcc, 0, v2, vcc
/*00000000007c*/ v_mov_b32       v9, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 3, v[8:9]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_mov_b32       v8, s5
/*000000000090*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000094*/ flat_store_dwordx2 v[0:1], v[10:11]
/*00000000009c*/ v_sub_u32       v2, vcc, s1, v6
/*0000000000a0*/ v_subb_u32      v3, vcc, 0, v7, vcc
/*0000000000a4*/ v_add_u32       v0, vcc, s14, v4
/*0000000000a8*/ v_mov_b32       v1, 0
/*0000000000ac*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c4*/ v_add_u32       v0, vcc, v5, s6
/*0000000000cc*/ v_mov_b32       v1, s7
/*0000000000d0*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000d4*/ v_sub_u32       v2, vcc, s2, v0
/*0000000000d8*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000dc*/ v_add_u32       v0, vcc, s6, v5
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel subtract_long_get_work_dim_get_global_id
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
/*000000000064*/ v_sub_u32       v9, vcc, s0, v1
/*000000000068*/ v_subb_u32      v10, vcc, 0, v2, vcc
/*00000000006c*/ v_add_u32       v0, vcc, s12, v0
/*000000000070*/ v_mov_b32       v1, 0
/*000000000074*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000007c*/ v_add_u32       v0, vcc, s2, v0
/*000000000080*/ v_mov_b32       v8, s3
/*000000000084*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*000000000088*/ flat_store_dwordx2 v[0:1], v[9:10]
/*000000000090*/ v_sub_u32       v2, vcc, s0, v6
/*000000000094*/ v_subb_u32      v3, vcc, 0, v7, vcc
/*000000000098*/ v_add_u32       v0, vcc, s14, v4
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b8*/ v_add_u32       v0, vcc, v5, s4
/*0000000000c0*/ v_mov_b32       v1, s5
/*0000000000c4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000c8*/ v_sub_u32       v2, vcc, s0, v0
/*0000000000cc*/ v_subb_u32      v3, vcc, 0, v1, vcc
/*0000000000d0*/ v_add_u32       v0, vcc, s4, v5
/*0000000000d4*/ v_mov_b32       v1, 0
/*0000000000d8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000e4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_x_get_global_size
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s16, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshl_b32      s7, s8, 4
/*000000000038*/ s_lshl_b32      s8, s9, 1
/*00000000003c*/ s_lshl_b32      s9, s10, 1
/*000000000040*/ s_add_u32       s7, s7, s12
/*000000000044*/ v_add_u32       v3, vcc, s7, v0
/*000000000048*/ s_ashr_i32      s17, s16, 31
/*00000000004c*/ s_movk_i32      s13, 0x0
/*000000000050*/ s_sub_u32       s12, s16, s0
/*000000000054*/ s_subb_u32      s13, s17, s13
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v7, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000070*/ v_mov_b32       v5, s12
/*000000000074*/ v_mov_b32       v6, s13
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ s_mov_b32       s0, s1
/*000000000084*/ s_movk_i32      s1, 0x0
/*000000000088*/ s_sub_u32       s0, s16, s0
/*00000000008c*/ s_subb_u32      s1, s17, s1
/*000000000090*/ s_add_u32       s3, s8, s14
/*000000000094*/ v_add_u32       v0, vcc, s3, v1
/*000000000098*/ v_mov_b32       v1, 0
/*00000000009c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ac*/ v_mov_b32       v3, s0
/*0000000000b0*/ v_mov_b32       v4, s1
/*0000000000b4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000bc*/ s_movk_i32      s3, 0x0
/*0000000000c0*/ s_sub_u32       s0, s16, s2
/*0000000000c4*/ s_subb_u32      s1, s17, s3
/*0000000000c8*/ s_add_u32       s2, s9, s6
/*0000000000cc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000d0*/ v_mov_b32       v1, 0
/*0000000000d4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000dc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000e4*/ v_mov_b32       v2, s0
/*0000000000e8*/ v_mov_b32       v3, s1
/*0000000000ec*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f4*/ s_endpgm
.kernel subtract_long_get_global_offset_get_global_size
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
/*000000000048*/ s_mov_b32       s10, s12
/*00000000004c*/ s_movk_i32      s11, 0x0
/*000000000050*/ s_mov_b32       s12, s0
/*000000000054*/ s_movk_i32      s13, 0x0
/*000000000058*/ s_sub_u32       s10, s10, s0
/*00000000005c*/ s_subb_u32      s11, s11, s13
/*000000000060*/ v_mov_b32       v1, 0
/*000000000064*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000006c*/ v_add_u32       v0, vcc, s4, v0
/*000000000070*/ v_mov_b32       v6, s5
/*000000000074*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000078*/ v_mov_b32       v3, s10
/*00000000007c*/ v_mov_b32       v4, s11
/*000000000080*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000088*/ s_mov_b32       s10, s14
/*00000000008c*/ s_movk_i32      s11, 0x0
/*000000000090*/ s_mov_b32       s0, s1
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_sub_u32       s0, s14, s0
/*00000000009c*/ s_subb_u32      s1, s11, s1
/*0000000000a0*/ v_mov_b32       v8, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s0
/*0000000000b8*/ v_mov_b32       v4, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s7, 0x0
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_sub_u32       s0, s6, s2
/*0000000000d0*/ s_subb_u32      s1, s7, s3
/*0000000000d4*/ s_add_u32       s2, s8, s6
/*0000000000d8*/ v_add_u32       v0, vcc, s2, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ v_mov_b32       v3, s1
/*0000000000f8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000100*/ s_endpgm
.kernel subtract_long_get_local_id_get_global_size
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
/*000000000048*/ v_sub_u32       v5, vcc, v0, s0
/*000000000050*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000058*/ v_mov_b32       v4, 0
/*00000000005c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v8, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*000000000070*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000078*/ v_sub_u32       v3, vcc, v1, s1
/*000000000080*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000088*/ v_mov_b32       v10, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ v_sub_u32       v3, vcc, v2, s2
/*0000000000ac*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*0000000000b4*/ s_add_u32       s0, s8, s6
/*0000000000b8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000d8*/ s_endpgm
.kernel subtract_long_get_group_id_get_global_size
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
/*000000000048*/ s_movk_i32      s13, 0x0
/*00000000004c*/ s_mov_b32       s14, s0
/*000000000050*/ s_movk_i32      s15, 0x0
/*000000000054*/ s_sub_u32       s12, s8, s0
/*000000000058*/ s_subb_u32      s13, s13, s15
/*00000000005c*/ v_mov_b32       v1, 0
/*000000000060*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_mov_b32       v6, s5
/*000000000070*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000074*/ v_mov_b32       v3, s12
/*000000000078*/ v_mov_b32       v4, s13
/*00000000007c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000084*/ s_mov_b32       s8, s9
/*000000000088*/ s_movk_i32      s9, 0x0
/*00000000008c*/ s_mov_b32       s0, s1
/*000000000090*/ s_movk_i32      s1, 0x0
/*000000000094*/ s_sub_u32       s0, s8, s0
/*000000000098*/ s_subb_u32      s1, s9, s1
/*00000000009c*/ v_mov_b32       v8, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000a8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b0*/ v_mov_b32       v3, s0
/*0000000000b4*/ v_mov_b32       v4, s1
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c0*/ s_movk_i32      s1, 0x0
/*0000000000c4*/ s_movk_i32      s3, 0x0
/*0000000000c8*/ s_sub_u32       s0, s10, s2
/*0000000000cc*/ s_subb_u32      s1, s1, s3
/*0000000000d0*/ s_add_u32       s2, s11, s6
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v2
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000ec*/ v_mov_b32       v2, s0
/*0000000000f0*/ v_mov_b32       v3, s1
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel subtract_long_get_local_size_get_global_size
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
/*00000000006c*/ s_movk_i32      s11, 0x0
/*000000000070*/ s_sub_u32       s10, 2, s0
/*000000000074*/ s_subb_u32      s11, 0, s11
/*000000000078*/ v_mov_b32       v5, s10
/*00000000007c*/ v_mov_b32       v6, s11
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000090*/ s_mov_b32       s0, s1
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_sub_u32       s0, 2, s0
/*00000000009c*/ s_subb_u32      s1, 0, s1
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
/*0000000000d0*/ s_sub_u32       s0, 4, s2
/*0000000000d4*/ s_subb_u32      s1, 0, s3
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, s1
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel subtract_long_get_global_id_get_global_size
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
/*000000000060*/ v_sub_u32       v3, vcc, v0, s0
/*000000000068*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000070*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000078*/ v_sub_u32       v3, vcc, v10, s1
/*000000000080*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000088*/ v_mov_b32       v11, 0
/*00000000008c*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000009c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000a4*/ s_add_u32       s0, s7, s6
/*0000000000a8*/ v_add_u32       v0, vcc, s0, v2
/*0000000000ac*/ v_sub_u32       v2, vcc, v0, s2
/*0000000000b4*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000bc*/ v_mov_b32       v1, 0
/*0000000000c0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000cc*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000d0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000d8*/ s_endpgm
.kernel subtract_long_get_global_size_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "long*", long*, global, 
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
/*000000000034*/ v_add_u32       v7, vcc, s0, v1
/*000000000038*/ s_add_u32       s0, s1, s10
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000048*/ v_add_u32       v9, vcc, s0, v2
/*00000000004c*/ v_add_u32       v11, vcc, s4, v3
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v12, vcc, v3, v4, vcc
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_get_num_groups_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 1
/*000000000030*/ s_lshr_b32      s18, s1, 1
/*000000000034*/ s_lshr_b32      s20, s2, 2
/*000000000038*/ s_lshl_b32      s8, s8, 1
/*00000000003c*/ s_lshl_b32      s9, s9, 1
/*000000000040*/ s_lshl_b32      s10, s10, 2
/*000000000044*/ s_add_u32       s8, s8, s12
/*000000000048*/ v_add_u32       v0, vcc, s8, v0
/*00000000004c*/ s_add_u32       s8, s9, s14
/*000000000050*/ v_add_u32       v7, vcc, s8, v1
/*000000000054*/ s_movk_i32      s17, 0x0
/*000000000058*/ s_mov_b32       s12, s0
/*00000000005c*/ s_movk_i32      s13, 0x0
/*000000000060*/ s_sub_u32       s8, s16, s0
/*000000000064*/ s_subb_u32      s9, s17, s13
/*000000000068*/ v_mov_b32       v1, 0
/*00000000006c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_mov_b32       v6, s5
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ v_mov_b32       v3, s8
/*000000000084*/ v_mov_b32       v4, s9
/*000000000088*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000090*/ s_movk_i32      s19, 0x0
/*000000000094*/ s_mov_b32       s0, s1
/*000000000098*/ s_movk_i32      s1, 0x0
/*00000000009c*/ s_sub_u32       s0, s18, s0
/*0000000000a0*/ s_subb_u32      s1, s19, s1
/*0000000000a4*/ v_mov_b32       v8, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000b0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b8*/ v_mov_b32       v3, s0
/*0000000000bc*/ v_mov_b32       v4, s1
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c8*/ s_movk_i32      s21, 0x0
/*0000000000cc*/ s_movk_i32      s3, 0x0
/*0000000000d0*/ s_sub_u32       s0, s20, s2
/*0000000000d4*/ s_subb_u32      s1, s21, s3
/*0000000000d8*/ s_add_u32       s2, s10, s6
/*0000000000dc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f4*/ v_mov_b32       v2, s0
/*0000000000f8*/ v_mov_b32       v3, s1
/*0000000000fc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000104*/ s_endpgm
.kernel subtract_long_get_work_dim_get_global_size
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 25
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
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s18, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s16, s0, 0x20010
/*00000000003c*/ s_lshl_b32      s7, s8, 1
/*000000000040*/ s_lshl_b32      s8, s9, 1
/*000000000044*/ s_lshl_b32      s9, s10, 2
/*000000000048*/ s_add_u32       s7, s7, s12
/*00000000004c*/ v_add_u32       v3, vcc, s7, v0
/*000000000050*/ s_movk_i32      s17, 0x0
/*000000000054*/ s_movk_i32      s13, 0x0
/*000000000058*/ s_sub_u32       s12, s16, s2
/*00000000005c*/ s_subb_u32      s13, s17, s13
/*000000000060*/ v_mov_b32       v4, 0
/*000000000064*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*00000000006c*/ v_add_u32       v3, vcc, s4, v3
/*000000000070*/ v_mov_b32       v7, s5
/*000000000074*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000078*/ v_mov_b32       v5, s12
/*00000000007c*/ v_mov_b32       v6, s13
/*000000000080*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000088*/ s_mov_b32       s2, s3
/*00000000008c*/ s_movk_i32      s3, 0x0
/*000000000090*/ s_sub_u32       s2, s16, s2
/*000000000094*/ s_subb_u32      s3, s17, s3
/*000000000098*/ s_add_u32       s0, s8, s14
/*00000000009c*/ v_add_u32       v0, vcc, s0, v1
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s2
/*0000000000b8*/ v_mov_b32       v4, s3
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s19, 0x0
/*0000000000c8*/ s_sub_u32       s0, s16, s18
/*0000000000cc*/ s_subb_u32      s1, s17, s19
/*0000000000d0*/ s_add_u32       s2, s9, s6
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v2
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ec*/ v_mov_b32       v2, s0
/*0000000000f0*/ v_mov_b32       v3, s1
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel subtract_long_x_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 25
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dword    s16, s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_lshr_b32      s18, s0, 4
/*000000000038*/ s_lshr_b32      s0, s1, 1
/*00000000003c*/ s_lshr_b32      s2, s2, 1
/*000000000040*/ s_lshl_b32      s7, s8, 4
/*000000000044*/ s_lshl_b32      s8, s9, 1
/*000000000048*/ s_lshl_b32      s9, s10, 1
/*00000000004c*/ s_add_u32       s7, s7, s12
/*000000000050*/ v_add_u32       v3, vcc, s7, v0
/*000000000054*/ s_ashr_i32      s17, s16, 31
/*000000000058*/ s_movk_i32      s19, 0x0
/*00000000005c*/ s_sub_u32       s12, s16, s18
/*000000000060*/ s_subb_u32      s13, s17, s19
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v7, s5
/*000000000078*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*00000000007c*/ v_mov_b32       v5, s12
/*000000000080*/ v_mov_b32       v6, s13
/*000000000084*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000008c*/ s_movk_i32      s1, 0x0
/*000000000090*/ s_sub_u32       s0, s16, s0
/*000000000094*/ s_subb_u32      s1, s17, s1
/*000000000098*/ s_add_u32       s3, s8, s14
/*00000000009c*/ v_add_u32       v0, vcc, s3, v1
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s0
/*0000000000b8*/ v_mov_b32       v4, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s3, 0x0
/*0000000000c8*/ s_sub_u32       s0, s16, s2
/*0000000000cc*/ s_subb_u32      s1, s17, s3
/*0000000000d0*/ s_add_u32       s2, s9, s6
/*0000000000d4*/ v_add_u32       v0, vcc, s2, v2
/*0000000000d8*/ v_mov_b32       v1, 0
/*0000000000dc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000ec*/ v_mov_b32       v2, s0
/*0000000000f0*/ v_mov_b32       v3, s1
/*0000000000f4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000fc*/ s_endpgm
.kernel subtract_long_get_global_offset_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 1
/*000000000030*/ s_lshr_b32      s0, s1, 4
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 4
/*000000000040*/ s_lshl_b32      s8, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ s_movk_i32      s11, 0x0
/*000000000058*/ s_movk_i32      s17, 0x0
/*00000000005c*/ s_sub_u32       s10, s12, s16
/*000000000060*/ s_subb_u32      s11, s11, s17
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s10
/*000000000080*/ v_mov_b32       v4, s11
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_mov_b32       s10, s14
/*000000000090*/ s_movk_i32      s11, 0x0
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_sub_u32       s0, s14, s0
/*00000000009c*/ s_subb_u32      s1, s11, s1
/*0000000000a0*/ v_mov_b32       v8, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s0
/*0000000000b8*/ v_mov_b32       v4, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s7, 0x0
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_sub_u32       s0, s6, s2
/*0000000000d0*/ s_subb_u32      s1, s7, s3
/*0000000000d4*/ s_add_u32       s2, s8, s6
/*0000000000d8*/ v_add_u32       v0, vcc, s2, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ v_mov_b32       v3, s1
/*0000000000f8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000100*/ s_endpgm
.kernel subtract_long_get_local_id_get_num_groups
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
/*000000000054*/ v_sub_u32       v5, vcc, v0, s0
/*00000000005c*/ v_subb_u32      v6, vcc, 0, 0, vcc
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000070*/ v_add_u32       v3, vcc, s4, v3
/*000000000074*/ v_mov_b32       v8, s5
/*000000000078*/ v_addc_u32      v4, vcc, v8, v4, vcc
/*00000000007c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000084*/ v_sub_u32       v3, vcc, v1, s1
/*00000000008c*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000094*/ v_mov_b32       v10, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[9:10]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ v_sub_u32       v3, vcc, v2, s2
/*0000000000b8*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*0000000000c0*/ s_add_u32       s0, s8, s6
/*0000000000c4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v8, v1, vcc
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000e4*/ s_endpgm
.kernel subtract_long_get_group_id_get_num_groups
    .config
        .dims xyz
        .cws 2, 16, 2
        .sgprsnum 24
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
        .arg data, "long*", long*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s2, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 1
/*000000000030*/ s_lshr_b32      s0, s1, 4
/*000000000034*/ s_lshr_b32      s2, s2, 1
/*000000000038*/ s_lshl_b32      s3, s8, 1
/*00000000003c*/ s_lshl_b32      s7, s9, 4
/*000000000040*/ s_lshl_b32      s11, s10, 1
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s7, s14
/*000000000050*/ v_add_u32       v7, vcc, s3, v1
/*000000000054*/ s_movk_i32      s13, 0x0
/*000000000058*/ s_movk_i32      s17, 0x0
/*00000000005c*/ s_sub_u32       s12, s8, s16
/*000000000060*/ s_subb_u32      s13, s13, s17
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s12
/*000000000080*/ v_mov_b32       v4, s13
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_mov_b32       s8, s9
/*000000000090*/ s_movk_i32      s9, 0x0
/*000000000094*/ s_movk_i32      s1, 0x0
/*000000000098*/ s_sub_u32       s0, s8, s0
/*00000000009c*/ s_subb_u32      s1, s9, s1
/*0000000000a0*/ v_mov_b32       v8, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s0
/*0000000000b8*/ v_mov_b32       v4, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s1, 0x0
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_sub_u32       s0, s10, s2
/*0000000000d0*/ s_subb_u32      s1, s1, s3
/*0000000000d4*/ s_add_u32       s2, s11, s6
/*0000000000d8*/ v_add_u32       v0, vcc, s2, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ v_mov_b32       v3, s1
/*0000000000f8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000100*/ s_endpgm
.kernel subtract_long_get_local_size_get_num_groups
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
/*00000000007c*/ s_sub_u32       s10, 2, s16
/*000000000080*/ s_subb_u32      s11, 0, s17
/*000000000084*/ v_mov_b32       v5, s10
/*000000000088*/ v_mov_b32       v6, s11
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*00000000009c*/ s_movk_i32      s1, 0x0
/*0000000000a0*/ s_sub_u32       s0, 2, s0
/*0000000000a4*/ s_subb_u32      s1, 0, s1
/*0000000000a8*/ v_mov_b32       v3, s0
/*0000000000ac*/ v_mov_b32       v4, s1
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ s_add_u32       s0, s8, s6
/*0000000000bc*/ v_add_u32       v0, vcc, s0, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ s_movk_i32      s3, 0x0
/*0000000000d8*/ s_sub_u32       s0, 4, s2
/*0000000000dc*/ s_subb_u32      s1, 0, s3
/*0000000000e0*/ v_mov_b32       v2, s0
/*0000000000e4*/ v_mov_b32       v3, s1
/*0000000000e8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000f0*/ s_endpgm
.kernel subtract_long_get_global_id_get_num_groups
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
/*00000000006c*/ v_sub_u32       v3, vcc, v0, s0
/*000000000074*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*00000000007c*/ flat_store_dwordx2 v[8:9], v[3:4]
/*000000000084*/ v_sub_u32       v3, vcc, v10, s1
/*00000000008c*/ v_subb_u32      v4, vcc, 0, 0, vcc
/*000000000094*/ v_mov_b32       v11, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[10:11]
/*0000000000a0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b0*/ s_add_u32       s0, s7, s6
/*0000000000b4*/ v_add_u32       v0, vcc, s0, v2
/*0000000000b8*/ v_sub_u32       v2, vcc, v0, s2
/*0000000000c0*/ v_subb_u32      v3, vcc, 0, 0, vcc
/*0000000000c8*/ v_mov_b32       v1, 0
/*0000000000cc*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000d4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d8*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000dc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e4*/ s_endpgm
.kernel subtract_long_get_global_size_get_num_groups
    .config
        .dims xyz
        .cws 16, 2, 2
        .sgprsnum 28
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
        .arg data, "long*", long*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0xc
/*000000000008*/ s_load_dword    s20, s[4:5], 0x14
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000020*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_lshr_b32      s16, s0, 4
/*000000000030*/ s_lshr_b32      s18, s1, 1
/*000000000034*/ s_lshr_b32      s2, s20, 1
/*000000000038*/ s_lshl_b32      s8, s8, 4
/*00000000003c*/ s_lshl_b32      s9, s9, 1
/*000000000040*/ s_lshl_b32      s10, s10, 1
/*000000000044*/ s_add_u32       s8, s8, s12
/*000000000048*/ v_add_u32       v0, vcc, s8, v0
/*00000000004c*/ s_add_u32       s8, s9, s14
/*000000000050*/ v_add_u32       v7, vcc, s8, v1
/*000000000054*/ s_movk_i32      s9, 0x0
/*000000000058*/ s_movk_i32      s17, 0x0
/*00000000005c*/ s_sub_u32       s8, s0, s16
/*000000000060*/ s_subb_u32      s9, s9, s17
/*000000000064*/ v_mov_b32       v1, 0
/*000000000068*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000070*/ v_add_u32       v0, vcc, s4, v0
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*00000000007c*/ v_mov_b32       v3, s8
/*000000000080*/ v_mov_b32       v4, s9
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_mov_b32       s0, s1
/*000000000090*/ s_movk_i32      s1, 0x0
/*000000000094*/ s_movk_i32      s19, 0x0
/*000000000098*/ s_sub_u32       s0, s0, s18
/*00000000009c*/ s_subb_u32      s1, s1, s19
/*0000000000a0*/ v_mov_b32       v8, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*0000000000ac*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ v_mov_b32       v3, s0
/*0000000000b8*/ v_mov_b32       v4, s1
/*0000000000bc*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000c4*/ s_movk_i32      s21, 0x0
/*0000000000c8*/ s_movk_i32      s3, 0x0
/*0000000000cc*/ s_sub_u32       s0, s20, s2
/*0000000000d0*/ s_subb_u32      s1, s21, s3
/*0000000000d4*/ s_add_u32       s2, s10, s6
/*0000000000d8*/ v_add_u32       v0, vcc, s2, v2
/*0000000000dc*/ v_mov_b32       v1, 0
/*0000000000e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000e8*/ v_add_u32       v0, vcc, s4, v0
/*0000000000ec*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000f0*/ v_mov_b32       v2, s0
/*0000000000f4*/ v_mov_b32       v3, s1
/*0000000000f8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000100*/ s_endpgm
.kernel subtract_long_get_num_groups_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
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
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_get_work_dim_get_num_groups
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 28
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
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000010*/ s_load_dword    s1, s[4:5], 0x14
/*000000000018*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000020*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*000000000028*/ s_load_dwordx2  s[6:7], s[6:7], 0x10
/*000000000030*/ s_waitcnt       lgkmcnt(0)
/*000000000034*/ s_bfe_u32       s16, s0, 0x20010
/*00000000003c*/ s_lshr_b32      s18, s2, 1
/*000000000040*/ s_lshr_b32      s2, s3, 1
/*000000000044*/ s_lshr_b32      s20, s1, 2
/*000000000048*/ s_lshl_b32      s7, s8, 1
/*00000000004c*/ s_lshl_b32      s8, s9, 1
/*000000000050*/ s_lshl_b32      s9, s10, 2
/*000000000054*/ s_add_u32       s7, s7, s12
/*000000000058*/ v_add_u32       v3, vcc, s7, v0
/*00000000005c*/ s_movk_i32      s17, 0x0
/*000000000060*/ s_movk_i32      s19, 0x0
/*000000000064*/ s_sub_u32       s12, s16, s18
/*000000000068*/ s_subb_u32      s13, s17, s19
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000000078*/ v_add_u32       v3, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v7, s5
/*000000000080*/ v_addc_u32      v4, vcc, v7, v4, vcc
/*000000000084*/ v_mov_b32       v5, s12
/*000000000088*/ v_mov_b32       v6, s13
/*00000000008c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000094*/ s_movk_i32      s3, 0x0
/*000000000098*/ s_sub_u32       s2, s16, s2
/*00000000009c*/ s_subb_u32      s3, s17, s3
/*0000000000a0*/ s_add_u32       s0, s8, s14
/*0000000000a4*/ v_add_u32       v0, vcc, s0, v1
/*0000000000a8*/ v_mov_b32       v1, 0
/*0000000000ac*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b4*/ v_add_u32       v0, vcc, s4, v0
/*0000000000b8*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000bc*/ v_mov_b32       v3, s2
/*0000000000c0*/ v_mov_b32       v4, s3
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000cc*/ s_movk_i32      s21, 0x0
/*0000000000d0*/ s_sub_u32       s0, s16, s20
/*0000000000d4*/ s_subb_u32      s1, s17, s21
/*0000000000d8*/ s_add_u32       s2, s9, s6
/*0000000000dc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ec*/ v_add_u32       v0, vcc, s4, v0
/*0000000000f0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000f4*/ v_mov_b32       v2, s0
/*0000000000f8*/ v_mov_b32       v3, s1
/*0000000000fc*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000104*/ s_endpgm
.kernel subtract_long_x_get_work_dim
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
/*000000000060*/ s_sub_u32       s0, s1, s0
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
.kernel subtract_long_get_global_offset_get_work_dim
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
/*000000000060*/ s_sub_u32       s1, s12, s0
/*000000000064*/ v_mov_b32       v3, s1
/*000000000068*/ v_mov_b32       v4, 0
/*00000000006c*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000074*/ v_mov_b32       v8, 0
/*000000000078*/ v_lshlrev_b64   v[0:1], 3, v[7:8]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000088*/ s_sub_u32       s1, s14, s0
/*00000000008c*/ v_mov_b32       v3, s1
/*000000000090*/ flat_store_dwordx2 v[0:1], v[3:4]
/*000000000098*/ s_add_u32       s1, s6, s4
/*00000000009c*/ v_add_u32       v0, vcc, s1, v2
/*0000000000a0*/ v_mov_b32       v1, 0
/*0000000000a4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000ac*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b0*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000b4*/ s_sub_u32       s0, s4, s0
/*0000000000b8*/ v_mov_b32       v2, s0
/*0000000000bc*/ v_mov_b32       v3, 0
/*0000000000c0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c8*/ s_endpgm
.kernel subtract_long_get_local_id_get_work_dim
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
/*00000000006c*/ v_subrev_u32    v7, vcc, s0, v0
/*000000000070*/ v_mov_b32       v8, 0
/*000000000074*/ flat_store_dwordx2 v[5:6], v[7:8]
/*00000000007c*/ v_add_u32       v5, vcc, s2, v3
/*000000000080*/ v_addc_u32      v6, vcc, v9, v4, vcc
/*000000000084*/ v_subrev_u32    v3, vcc, s0, v1
/*000000000088*/ v_mov_b32       v4, 0
/*00000000008c*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000094*/ s_add_u32       s1, s6, s4
/*000000000098*/ v_add_u32       v0, vcc, s1, v2
/*00000000009c*/ v_mov_b32       v1, 0
/*0000000000a0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000a8*/ v_add_u32       v0, vcc, s2, v0
/*0000000000ac*/ v_addc_u32      v1, vcc, v9, v1, vcc
/*0000000000b0*/ v_subrev_u32    v2, vcc, s0, v2
/*0000000000b4*/ v_mov_b32       v3, 0
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c0*/ s_endpgm
.kernel subtract_long_get_group_id_get_work_dim
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
/*00000000006c*/ s_sub_u32       s1, s8, s0
/*000000000070*/ v_mov_b32       v5, s1
/*000000000074*/ v_mov_b32       v6, 0
/*000000000078*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000080*/ v_add_u32       v0, vcc, s2, v0
/*000000000084*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000088*/ s_sub_u32       s1, s9, s0
/*00000000008c*/ v_mov_b32       v3, s1
/*000000000090*/ v_mov_b32       v4, 0
/*000000000094*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000009c*/ s_add_u32       s1, s6, s4
/*0000000000a0*/ v_add_u32       v0, vcc, s1, v2
/*0000000000a4*/ v_mov_b32       v1, 0
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000b4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000b8*/ s_sub_u32       s0, s10, s0
/*0000000000bc*/ v_mov_b32       v2, s0
/*0000000000c0*/ v_mov_b32       v3, 0
/*0000000000c4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000cc*/ s_endpgm
.kernel subtract_long_get_local_size_get_work_dim
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
/*000000000058*/ s_sub_u32       s1, 2, s0
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
/*0000000000ac*/ s_sub_u32       s0, 4, s0
/*0000000000b0*/ v_mov_b32       v2, s0
/*0000000000b4*/ v_mov_b32       v3, 0
/*0000000000b8*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000c0*/ s_endpgm
.kernel subtract_long_get_global_id_get_work_dim
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
/*000000000058*/ v_subrev_u32    v5, vcc, s0, v0
/*00000000005c*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000064*/ s_add_u32       s1, s1, s14
/*000000000068*/ v_add_u32       v3, vcc, s1, v1
/*00000000006c*/ v_mov_b32       v4, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 3, v[3:4]
/*000000000078*/ v_add_u32       v0, vcc, s2, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000080*/ v_subrev_u32    v3, vcc, s0, v3
/*000000000084*/ flat_store_dwordx2 v[0:1], v[3:4]
/*00000000008c*/ s_add_u32       s1, s5, s4
/*000000000090*/ v_add_u32       v2, vcc, s1, v2
/*000000000094*/ v_mov_b32       v3, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*0000000000a0*/ v_add_u32       v0, vcc, s2, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a8*/ v_subrev_u32    v2, vcc, s0, v2
/*0000000000ac*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000b4*/ s_endpgm
.kernel subtract_long_get_global_size_get_work_dim
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
/*00000000007c*/ s_sub_u32       s2, s2, s0
/*000000000080*/ v_mov_b32       v5, s2
/*000000000084*/ v_mov_b32       v6, 0
/*000000000088*/ flat_store_dwordx2 v[3:4], v[5:6]
/*000000000090*/ v_add_u32       v0, vcc, s4, v0
/*000000000094*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*000000000098*/ s_sub_u32       s2, s3, s0
/*00000000009c*/ v_mov_b32       v3, s2
/*0000000000a0*/ v_mov_b32       v4, 0
/*0000000000a4*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000ac*/ s_add_u32       s2, s9, s6
/*0000000000b0*/ v_add_u32       v0, vcc, s2, v2
/*0000000000b4*/ v_mov_b32       v1, 0
/*0000000000b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000c0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000c4*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000c8*/ s_sub_u32       s0, s1, s0
/*0000000000cc*/ v_mov_b32       v2, s0
/*0000000000d0*/ v_mov_b32       v3, 0
/*0000000000d4*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000dc*/ s_endpgm
.kernel subtract_long_get_num_groups_get_work_dim
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
/*000000000088*/ s_sub_u32       s2, s2, s0
/*00000000008c*/ v_mov_b32       v5, s2
/*000000000090*/ v_mov_b32       v6, 0
/*000000000094*/ flat_store_dwordx2 v[3:4], v[5:6]
/*00000000009c*/ v_add_u32       v0, vcc, s4, v0
/*0000000000a0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000a4*/ s_sub_u32       s2, s3, s0
/*0000000000a8*/ v_mov_b32       v3, s2
/*0000000000ac*/ v_mov_b32       v4, 0
/*0000000000b0*/ flat_store_dwordx2 v[0:1], v[3:4]
/*0000000000b8*/ s_add_u32       s2, s9, s6
/*0000000000bc*/ v_add_u32       v0, vcc, s2, v2
/*0000000000c0*/ v_mov_b32       v1, 0
/*0000000000c4*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000000cc*/ v_add_u32       v0, vcc, s4, v0
/*0000000000d0*/ v_addc_u32      v1, vcc, v7, v1, vcc
/*0000000000d4*/ s_sub_u32       s0, s1, s0
/*0000000000d8*/ v_mov_b32       v2, s0
/*0000000000dc*/ v_mov_b32       v3, 0
/*0000000000e0*/ flat_store_dwordx2 v[0:1], v[2:3]
/*0000000000e8*/ s_endpgm
.kernel subtract_long_get_work_dim_get_work_dim
    .config
        .dims xyz
        .cws 2, 2, 4
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
/*000000000058*/ v_lshlrev_b64   v[5:6], 0, 0
/*000000000060*/ v_mov_b32       v8, 0
/*000000000064*/ v_lshlrev_b64   v[7:8], 3, v[7:8]
/*00000000006c*/ v_add_u32       v1, vcc, s4, v7
/*000000000070*/ v_addc_u32      v2, vcc, v3, v8, vcc
/*000000000074*/ v_mov_b32       v10, 0
/*000000000078*/ v_lshlrev_b64   v[8:9], 3, v[9:10]
/*000000000080*/ v_add_u32       v7, vcc, s4, v8
/*000000000084*/ v_addc_u32      v8, vcc, v3, v9, vcc
/*000000000088*/ flat_store_dwordx2 v[11:12], v[5:6]
/*000000000090*/ flat_store_dwordx2 v[1:2], v[5:6]
/*000000000098*/ flat_store_dwordx2 v[7:8], v[5:6]
/*0000000000a0*/ s_endpgm
.kernel subtract_long_x_64
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
/*000000000018*/ s_load_dword    s4, s[4:5], 0x30
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v2, vcc, s0, v0
/*000000000028*/ v_mov_b32       v3, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v3, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_sub_u32       v2, vcc, s4, v2
/*000000000048*/ v_mov_b32       v3, 0
/*00000000004c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000054*/ s_endpgm
.kernel subtract_long_get_global_offset_64
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
/*00000000001c*/ v_add_u32       v2, vcc, s1, v0
/*000000000020*/ v_mov_b32       v3, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000038*/ v_sub_u32       v2, vcc, s0, v2
/*00000000003c*/ v_mov_b32       v3, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_local_id_64
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
/*000000000024*/ v_lshlrev_b64   v[2:3], 3, v[1:2]
/*00000000002c*/ v_add_u32       v5, vcc, s2, v2
/*000000000030*/ v_mov_b32       v4, s3
/*000000000034*/ v_addc_u32      v6, vcc, v4, v3, vcc
/*000000000038*/ v_sub_u32       v3, vcc, v0, v1
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_group_id_64
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
/*00000000001c*/ v_add_u32       v2, vcc, s0, v0
/*000000000020*/ v_mov_b32       v3, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000038*/ v_sub_u32       v2, vcc, s6, v2
/*00000000003c*/ v_mov_b32       v3, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_local_size_64
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
/*00000000001c*/ v_add_u32       v2, vcc, s0, v0
/*000000000020*/ v_mov_b32       v3, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v3, s3
/*000000000034*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000038*/ v_sub_u32       v2, vcc, 64, v2
/*00000000003c*/ v_mov_b32       v3, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_global_id_64
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
/*000000000038*/ v_lshlrev_b64   v[2:3], 0, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_global_size_64
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s8, 6
/*000000000018*/ s_load_dword    s4, s[4:5], 0xc
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v2, vcc, s0, v0
/*000000000028*/ v_mov_b32       v3, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v3, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_sub_u32       v2, vcc, s4, v2
/*000000000048*/ v_mov_b32       v3, 0
/*00000000004c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000054*/ s_endpgm
.kernel subtract_long_get_num_groups_64
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0xc
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v2, vcc, s0, v0
/*000000000028*/ v_mov_b32       v3, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_lshr_b32      s0, s1, 6
/*00000000003c*/ v_add_u32       v0, vcc, s2, v0
/*000000000040*/ v_mov_b32       v3, s3
/*000000000044*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000048*/ v_sub_u32       v2, vcc, s0, v2
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel subtract_long_get_work_dim
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
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v2, vcc, s0, v0
/*000000000028*/ v_mov_b32       v3, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 3, v[2:3]
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ s_bfe_u32       s0, s1, 0x20010
/*000000000040*/ v_add_u32       v0, vcc, s2, v0
/*000000000044*/ v_mov_b32       v3, s3
/*000000000048*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000004c*/ v_sub_u32       v2, vcc, s0, v2
/*000000000050*/ v_mov_b32       v3, 0
/*000000000054*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000005c*/ s_endpgm
.kernel subtract_long_x_8_8
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[8:9], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s3, s6, 3
/*000000000020*/ s_lshl_b32      s4, s7, 3
/*000000000024*/ s_add_u32       s0, s3, s0
/*000000000028*/ v_add_u32       v2, vcc, s0, v0
/*00000000002c*/ v_mov_b32       v3, 0
/*000000000030*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000000038*/ v_add_u32       v4, vcc, s8, v2
/*00000000003c*/ v_mov_b32       v2, s9
/*000000000040*/ v_addc_u32      v5, vcc, v2, v3, vcc
/*000000000044*/ s_add_u32       s0, s4, s2
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ v_sub_u32       v2, vcc, s1, v1
/*000000000054*/ v_mov_b32       v3, 0
/*000000000058*/ flat_store_dwordx2 v[4:5], v[2:3]
/*000000000060*/ s_endpgm
.kernel subtract_long_get_global_offset_8_8
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
/*000000000038*/ s_sub_u32       s0, s0, s2
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel subtract_long_get_local_id_8_8
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
/*000000000038*/ v_sub_u32       v3, vcc, v0, v1
/*00000000003c*/ v_mov_b32       v4, 0
/*000000000040*/ flat_store_dwordx2 v[5:6], v[3:4]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_group_id_8_8
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
/*000000000038*/ s_sub_u32       s0, s6, s7
/*00000000003c*/ v_mov_b32       v2, s0
/*000000000040*/ v_mov_b32       v3, 0
/*000000000044*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000004c*/ s_endpgm
.kernel subtract_long_get_local_size_8_8
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
/*000000000038*/ v_lshlrev_b64   v[2:3], 0, 0
/*000000000040*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000048*/ s_endpgm
.kernel subtract_long_get_global_id_8_8
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
/*00000000001c*/ s_add_u32       s2, s3, s2
/*000000000020*/ v_add_u32       v1, vcc, s2, v1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_sub_u32       v2, vcc, v0, v1
/*000000000030*/ v_mov_b32       v1, 0
/*000000000034*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v3, s5
/*000000000044*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000048*/ v_mov_b32       v3, 0
/*00000000004c*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000054*/ s_endpgm
.kernel subtract_long_get_global_size_8_8
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
/*000000000044*/ s_sub_u32       s0, s4, s5
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ v_mov_b32       v3, 0
/*000000000050*/ flat_store_dwordx2 v[0:1], v[2:3]
/*000000000058*/ s_endpgm
.kernel subtract_long_get_num_groups_8_8
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
/*000000000048*/ s_sub_u32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ v_mov_b32       v3, 0
/*000000000054*/ flat_store_dwordx2 v[0:1], v[2:3]
/*00000000005c*/ s_endpgm
.kernel subtract_long_get_work_dim_8_8
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
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
        .arg data, "ulong*", ulong*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s3, s8, 3
/*000000000020*/ s_add_u32       s0, s3, s0
/*000000000024*/ v_add_u32       v2, vcc, s0, v0
/*000000000028*/ s_lshl_b32      s0, s9, 3
/*00000000002c*/ v_mov_b32       v3, 0
/*000000000030*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000000038*/ s_add_u32       s0, s0, s2
/*00000000003c*/ s_waitcnt       lgkmcnt(0)
/*000000000040*/ s_bfe_u32       s1, s1, 0x20010
/*000000000048*/ v_add_u32       v4, vcc, s4, v2
/*00000000004c*/ v_mov_b32       v2, s5
/*000000000050*/ v_addc_u32      v5, vcc, v2, v3, vcc
/*000000000054*/ v_add_u32       v1, vcc, s0, v1
/*000000000058*/ v_sub_u32       v2, vcc, s1, v1
/*00000000005c*/ v_mov_b32       v3, 0
/*000000000060*/ flat_store_dwordx2 v[4:5], v[2:3]
/*000000000068*/ s_endpgm
.kernel subtract_char_x_x
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
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
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
.kernel subtract_char_get_global_offset_x
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
/*000000000038*/ s_sub_u32       s0, s0, s1
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ s_sub_u32       s0, s2, s1
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s2, s7, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s0
/*000000000074*/ s_sub_u32       s0, s10, s1
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s0
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_local_id_x
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
/*000000000034*/ v_subrev_u32    v5, vcc, s1, v0
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ v_add_u32       v3, vcc, s10, v0
/*000000000044*/ v_mov_b32       v6, s11
/*000000000048*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000050*/ flat_store_byte v[3:4], v5
/*000000000058*/ v_subrev_u32    v3, vcc, s1, v1
/*00000000005c*/ s_add_u32       s0, s5, s2
/*000000000060*/ v_add_u32       v0, vcc, s0, v1
/*000000000064*/ v_add_u32       v0, vcc, s10, v0
/*000000000068*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000070*/ flat_store_byte v[0:1], v3
/*000000000078*/ v_subrev_u32    v3, vcc, s1, v2
/*00000000007c*/ s_add_u32       s0, s6, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel subtract_char_get_group_id_x
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
/*000000000038*/ s_sub_u32       s6, s6, s1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s9, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s6
/*000000000058*/ s_sub_u32       s2, s7, s1
/*00000000005c*/ v_add_u32       v1, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s3, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s2
/*000000000074*/ s_sub_u32       s1, s8, s1
/*000000000078*/ v_add_u32       v1, vcc, s0, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s1
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_local_size_x
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
/*00000000003c*/ s_sub_u32       s0, 2, s1
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
/*000000000070*/ s_sub_u32       s0, 4, s1
/*000000000074*/ v_add_u32       v0, vcc, s4, v1
/*000000000078*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ flat_store_byte v[9:10], v5
/*00000000008c*/ flat_store_byte v[6:7], v5
/*000000000094*/ flat_store_byte v[0:1], v8
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_global_id_x
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg x, "int", int
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[12:13], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ v_add_u32       v0, vcc, s3, v0
/*00000000002c*/ s_lshl_b32      s3, s7, 1
/*000000000030*/ s_lshl_b32      s4, s8, 2
/*000000000034*/ v_add_u32       v3, vcc, s0, v0
/*000000000038*/ s_add_u32       s0, s3, s2
/*00000000003c*/ v_add_u32       v10, vcc, s12, v0
/*000000000040*/ v_mov_b32       v4, s13
/*000000000044*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ v_subrev_u32    v3, vcc, s1, v3
/*000000000054*/ v_add_u32       v1, vcc, s0, v1
/*000000000058*/ s_add_u32       s0, s4, s10
/*00000000005c*/ v_subrev_u32    v6, vcc, s1, v1
/*000000000060*/ v_add_u32       v7, vcc, s12, v1
/*000000000064*/ v_addc_u32      v8, vcc, v4, 0, vcc
/*00000000006c*/ v_add_u32       v1, vcc, s0, v2
/*000000000070*/ v_subrev_u32    v2, vcc, s1, v1
/*000000000074*/ v_add_u32       v0, vcc, s12, v1
/*000000000078*/ v_addc_u32      v1, vcc, v4, 0, vcc
/*000000000080*/ flat_store_byte v[10:11], v3
/*000000000088*/ flat_store_byte v[7:8], v6
/*000000000090*/ flat_store_byte v[0:1], v2
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_size_x
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
/*000000000048*/ s_sub_u32       s8, s12, s1
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ s_add_u32       s0, s5, s2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s8
/*000000000068*/ s_sub_u32       s2, s13, s1
/*00000000006c*/ v_add_u32       v1, vcc, s0, v1
/*000000000070*/ s_add_u32       s0, s4, s14
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s2
/*000000000084*/ s_sub_u32       s1, s3, s1
/*000000000088*/ v_add_u32       v1, vcc, s0, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s1
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_num_groups_x
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
/*00000000004c*/ s_sub_u32       s0, s0, s2
/*000000000050*/ v_add_u32       v0, vcc, s5, v0
/*000000000054*/ s_add_u32       s5, s8, s14
/*000000000058*/ s_lshr_b32      s3, s3, 2
/*00000000005c*/ v_add_u32       v10, vcc, s6, v0
/*000000000060*/ v_mov_b32       v3, s7
/*000000000064*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_sub_u32       s0, s1, s2
/*000000000074*/ v_add_u32       v1, vcc, s5, v1
/*000000000078*/ s_add_u32       s1, s9, s4
/*00000000007c*/ v_add_u32       v6, vcc, s6, v1
/*000000000080*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v8, s0
/*00000000008c*/ s_sub_u32       s0, s3, s2
/*000000000090*/ v_add_u32       v1, vcc, s1, v2
/*000000000094*/ v_add_u32       v0, vcc, s6, v1
/*000000000098*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a0*/ v_mov_b32       v9, s0
/*0000000000a4*/ flat_store_byte v[10:11], v5
/*0000000000ac*/ flat_store_byte v[6:7], v8
/*0000000000b4*/ flat_store_byte v[0:1], v9
/*0000000000bc*/ s_endpgm
.kernel subtract_char_get_work_dim_x
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
/*000000000034*/ s_sub_u32       s0, s0, s1
/*000000000038*/ v_add_u32       v0, vcc, s2, v0
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v1, s5
/*000000000044*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_byte v[0:1], v2
/*000000000058*/ s_endpgm
.kernel subtract_char_x_get_global_offset
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
/*000000000038*/ s_sub_u32       s0, s1, s0
/*00000000003c*/ v_add_u32       v0, vcc, s3, v0
/*000000000040*/ s_add_u32       s3, s6, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s0
/*000000000058*/ s_sub_u32       s0, s1, s2
/*00000000005c*/ v_add_u32       v1, vcc, s3, v1
/*000000000060*/ s_add_u32       s2, s7, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s0
/*000000000074*/ s_sub_u32       s0, s1, s10
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s0
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_global_offset_get_global_offset
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
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_local_id_get_global_offset
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
/*000000000028*/ v_subrev_u32    v5, vcc, s0, v0
/*00000000002c*/ s_add_u32       s0, s1, s0
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_add_u32       v3, vcc, s10, v0
/*000000000038*/ v_mov_b32       v6, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v5
/*00000000004c*/ v_subrev_u32    v3, vcc, s2, v1
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ v_subrev_u32    v3, vcc, s4, v2
/*000000000070*/ s_add_u32       s0, s5, s4
/*000000000074*/ v_add_u32       v0, vcc, s0, v2
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v3
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_group_id_get_global_offset
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
/*00000000002c*/ s_sub_u32       s0, s6, s0
/*000000000030*/ v_add_u32       v0, vcc, s1, v0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ s_sub_u32       s0, s7, s2
/*000000000050*/ v_add_u32       v1, vcc, s1, v1
/*000000000054*/ s_add_u32       s1, s9, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ s_sub_u32       s0, s8, s10
/*00000000006c*/ v_add_u32       v1, vcc, s1, v2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_local_size_get_global_offset
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
/*000000000030*/ s_sub_u32       s0, 2, s0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s1, v1
/*000000000050*/ s_sub_u32       s0, 2, s2
/*000000000054*/ s_add_u32       s1, s6, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_sub_u32       s0, 4, s10
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_id_get_global_offset
    .config
        .dims xyz
        .cws 2, 2, 4
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000008*/ s_load_dwordx4  s[12:15], s[4:5], 0x8
/*000000000010*/ s_lshl_b32      s2, s6, 1
/*000000000014*/ v_add_u32       v3, vcc, s2, v0
/*000000000018*/ s_lshl_b32      s2, s7, 1
/*00000000001c*/ v_add_u32       v4, vcc, s2, v1
/*000000000020*/ s_lshl_b32      s2, s8, 2
/*000000000024*/ v_add_u32       v2, vcc, s2, v2
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ v_add_u32       v0, vcc, s0, v3
/*000000000030*/ v_mov_b32       v5, s1
/*000000000034*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*00000000003c*/ flat_store_byte v[0:1], v3
/*000000000044*/ v_add_u32       v0, vcc, s12, v4
/*000000000048*/ v_add_u32       v0, vcc, s0, v0
/*00000000004c*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*000000000054*/ flat_store_byte v[0:1], v4
/*00000000005c*/ v_add_u32       v0, vcc, s14, v2
/*000000000060*/ v_add_u32       v0, vcc, s0, v0
/*000000000064*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*00000000006c*/ flat_store_byte v[0:1], v2
/*000000000074*/ s_endpgm
.kernel subtract_char_get_global_size_get_global_offset
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
/*00000000003c*/ s_sub_u32       s0, s12, s0
/*000000000040*/ v_add_u32       v0, vcc, s3, v0
/*000000000044*/ s_add_u32       s3, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ s_sub_u32       s0, s13, s2
/*000000000060*/ v_add_u32       v1, vcc, s3, v1
/*000000000064*/ s_add_u32       s2, s5, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_sub_u32       s0, s1, s14
/*000000000080*/ v_add_u32       v1, vcc, s2, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_num_groups_get_global_offset
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
/*000000000044*/ s_sub_u32       s0, s0, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s1, s14
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s2, s4
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_work_dim_get_global_offset
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
/*00000000003c*/ s_sub_u32       s7, s0, s12
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_sub_u32       s3, s0, s14
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_sub_u32       s0, s0, s2
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel subtract_char_x_get_local_id
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
/*000000000034*/ v_sub_u32       v5, vcc, s1, v0
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ v_add_u32       v3, vcc, s10, v0
/*000000000044*/ v_mov_b32       v6, s11
/*000000000048*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000050*/ flat_store_byte v[3:4], v5
/*000000000058*/ v_sub_u32       v3, vcc, s1, v1
/*00000000005c*/ s_add_u32       s0, s5, s2
/*000000000060*/ v_add_u32       v0, vcc, s0, v1
/*000000000064*/ v_add_u32       v0, vcc, s10, v0
/*000000000068*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000070*/ flat_store_byte v[0:1], v3
/*000000000078*/ v_sub_u32       v3, vcc, s1, v2
/*00000000007c*/ s_add_u32       s0, s6, s4
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v3
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_offset_get_local_id
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
/*000000000028*/ v_sub_u32       v5, vcc, s0, v0
/*00000000002c*/ s_add_u32       s0, s1, s0
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_add_u32       v3, vcc, s10, v0
/*000000000038*/ v_mov_b32       v6, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v5
/*00000000004c*/ v_sub_u32       v3, vcc, s2, v1
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ v_sub_u32       v3, vcc, s4, v2
/*000000000070*/ s_add_u32       s0, s5, s4
/*000000000074*/ v_add_u32       v0, vcc, s0, v2
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v3
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_local_id_get_local_id
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
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_group_id_get_local_id
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
/*000000000028*/ v_sub_u32       v5, vcc, s6, v0
/*00000000002c*/ s_add_u32       s0, s1, s0
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_add_u32       v3, vcc, s10, v0
/*000000000038*/ v_mov_b32       v6, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v5
/*00000000004c*/ v_sub_u32       v3, vcc, s7, v1
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ v_sub_u32       v3, vcc, s8, v2
/*000000000070*/ s_add_u32       s0, s5, s4
/*000000000074*/ v_add_u32       v0, vcc, s0, v2
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v3
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_local_size_get_local_id
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
/*000000000044*/ v_sub_u32       v0, vcc, 2, v0
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_sub_u32       v1, vcc, 2, v1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_sub_u32       v2, vcc, 4, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_global_id_get_local_id
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
/*000000000020*/ v_add_u32       v3, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v4, vcc, s0, v3
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_add_u32       v9, vcc, s4, v3
/*000000000038*/ v_mov_b32       v5, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v5, 0, vcc
/*000000000044*/ v_sub_u32       v0, vcc, v4, v0
/*000000000048*/ v_add_u32       v4, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s10
/*000000000050*/ v_sub_u32       v1, vcc, v4, v1
/*000000000054*/ v_add_u32       v3, vcc, s4, v4
/*000000000058*/ v_addc_u32      v4, vcc, v5, 0, vcc
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_sub_u32       v2, vcc, v8, v2
/*000000000068*/ v_add_u32       v6, vcc, s4, v8
/*00000000006c*/ v_addc_u32      v7, vcc, v5, 0, vcc
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[3:4], v1
/*000000000084*/ flat_store_byte v[6:7], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_global_size_get_local_id
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
/*000000000038*/ v_sub_u32       v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s3, s12
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s4, v0
/*000000000048*/ v_mov_b32       v6, s5
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_sub_u32       v3, vcc, s1, v1
/*000000000060*/ s_add_u32       s0, s7, s14
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ v_sub_u32       v3, vcc, s2, v2
/*000000000080*/ s_add_u32       s0, s8, s6
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v3
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_num_groups_get_local_id
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
/*000000000044*/ v_sub_u32       v5, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s3, s12
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ v_add_u32       v3, vcc, s4, v0
/*000000000054*/ v_mov_b32       v6, s5
/*000000000058*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000060*/ flat_store_byte v[3:4], v5
/*000000000068*/ v_sub_u32       v3, vcc, s1, v1
/*00000000006c*/ s_add_u32       s0, s7, s14
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000080*/ flat_store_byte v[0:1], v3
/*000000000088*/ v_sub_u32       v3, vcc, s2, v2
/*00000000008c*/ s_add_u32       s0, s8, s6
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel subtract_char_get_work_dim_get_local_id
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
/*000000000038*/ v_sub_u32       v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s1, s1, s12
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ v_add_u32       v3, vcc, s2, v0
/*000000000048*/ v_mov_b32       v6, s3
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_sub_u32       v3, vcc, s0, v1
/*000000000060*/ s_add_u32       s1, s5, s14
/*000000000064*/ v_add_u32       v0, vcc, s1, v1
/*000000000068*/ v_add_u32       v0, vcc, s2, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ v_sub_u32       v3, vcc, s0, v2
/*000000000080*/ s_add_u32       s0, s6, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v3
/*00000000009c*/ s_endpgm
.kernel subtract_char_x_get_group_id
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
/*000000000038*/ s_sub_u32       s6, s1, s6
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s9, s2
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000054*/ v_mov_b32       v5, s6
/*000000000058*/ s_sub_u32       s2, s1, s7
/*00000000005c*/ v_add_u32       v1, vcc, s0, v1
/*000000000060*/ s_add_u32       s0, s3, s10
/*000000000064*/ v_add_u32       v6, vcc, s4, v1
/*000000000068*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000070*/ v_mov_b32       v8, s2
/*000000000074*/ s_sub_u32       s1, s1, s8
/*000000000078*/ v_add_u32       v1, vcc, s0, v2
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s1
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_global_offset_get_group_id
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
/*00000000002c*/ s_sub_u32       s0, s0, s6
/*000000000030*/ v_add_u32       v0, vcc, s1, v0
/*000000000034*/ s_add_u32       s1, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ s_sub_u32       s0, s2, s7
/*000000000050*/ v_add_u32       v1, vcc, s1, v1
/*000000000054*/ s_add_u32       s1, s9, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ s_sub_u32       s0, s10, s8
/*00000000006c*/ v_add_u32       v1, vcc, s1, v2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_local_id_get_group_id
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
/*000000000028*/ v_subrev_u32    v5, vcc, s6, v0
/*00000000002c*/ s_add_u32       s0, s1, s0
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_add_u32       v3, vcc, s10, v0
/*000000000038*/ v_mov_b32       v6, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v5
/*00000000004c*/ v_subrev_u32    v3, vcc, s7, v1
/*000000000050*/ s_add_u32       s0, s3, s2
/*000000000054*/ v_add_u32       v0, vcc, s0, v1
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ v_subrev_u32    v3, vcc, s8, v2
/*000000000070*/ s_add_u32       s0, s5, s4
/*000000000074*/ v_add_u32       v0, vcc, s0, v2
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v3
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_group_id_get_group_id
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
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_local_size_get_group_id
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
/*000000000028*/ s_lshl_b32      s1, s8, 2
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_sub_u32       s0, 2, s6
/*000000000034*/ s_add_u32       s2, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s2, v1
/*000000000050*/ s_sub_u32       s0, 2, s7
/*000000000054*/ s_add_u32       s1, s1, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_sub_u32       s0, 4, s8
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_id_get_group_id
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
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 1
/*000000000028*/ s_lshl_b32      s3, s8, 2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s1, s2
/*000000000034*/ v_add_u32       v10, vcc, s4, v0
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*000000000044*/ v_subrev_u32    v3, vcc, s6, v3
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s3, s10
/*000000000050*/ v_subrev_u32    v6, vcc, s7, v1
/*000000000054*/ v_add_u32       v7, vcc, s4, v1
/*000000000058*/ v_addc_u32      v8, vcc, v4, 0, vcc
/*000000000060*/ v_add_u32       v1, vcc, s0, v2
/*000000000064*/ v_subrev_u32    v2, vcc, s8, v1
/*000000000068*/ v_add_u32       v0, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v1, vcc, v4, 0, vcc
/*000000000074*/ flat_store_byte v[10:11], v3
/*00000000007c*/ flat_store_byte v[7:8], v6
/*000000000084*/ flat_store_byte v[0:1], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_global_size_get_group_id
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
/*00000000003c*/ s_sub_u32       s5, s12, s8
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ s_add_u32       s0, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ s_sub_u32       s2, s13, s9
/*000000000060*/ v_add_u32       v1, vcc, s0, v1
/*000000000064*/ s_add_u32       s0, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s2
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_sub_u32       s1, s1, s10
/*000000000080*/ v_add_u32       v1, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s1
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_num_groups_get_group_id
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
/*000000000044*/ s_sub_u32       s0, s0, s8
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s1, s9
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s11, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s2, s10
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_work_dim_get_group_id
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
/*00000000003c*/ s_sub_u32       s7, s0, s8
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_sub_u32       s3, s0, s9
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_sub_u32       s0, s0, s10
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel subtract_char_x_get_local_size
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
/*00000000003c*/ s_add_u32       s0, s1, 0xf0
/*000000000044*/ s_add_u32       s2, s6, s2
/*000000000048*/ v_add_u32       v9, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_add_u32       s0, s1, 0xfe
/*000000000068*/ s_add_u32       s1, s3, s10
/*00000000006c*/ v_add_u32       v6, vcc, s4, v1
/*000000000070*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000078*/ v_mov_b32       v8, s0
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ flat_store_byte v[9:10], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v8
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_global_offset_get_local_size
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
/*000000000030*/ s_add_u32       s0, s0, 0xfe
/*000000000038*/ s_add_u32       s1, s3, s2
/*00000000003c*/ v_add_u32       v10, vcc, s4, v0
/*000000000040*/ v_mov_b32       v3, s5
/*000000000044*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*00000000004c*/ v_mov_b32       v5, s0
/*000000000050*/ v_add_u32       v1, vcc, s1, v1
/*000000000054*/ s_add_u32       s0, s2, 0xf0
/*00000000005c*/ s_add_u32       s1, s6, s10
/*000000000060*/ v_add_u32       v6, vcc, s4, v1
/*000000000064*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v8, s0
/*000000000070*/ v_add_u32       v1, vcc, s1, v2
/*000000000074*/ s_add_u32       s0, s10, 0xfe
/*00000000007c*/ v_add_u32       v0, vcc, s4, v1
/*000000000080*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v9, s0
/*00000000008c*/ flat_store_byte v[10:11], v5
/*000000000094*/ flat_store_byte v[6:7], v8
/*00000000009c*/ flat_store_byte v[0:1], v9
/*0000000000a4*/ s_endpgm
.kernel subtract_char_get_local_id_get_local_size
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
/*000000000044*/ v_add_u32       v0, vcc, -8, v0
/*000000000048*/ v_add_u32       v6, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, -4, v1
/*000000000060*/ v_add_u32       v8, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_add_u32       v2, vcc, -2, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_group_id_get_local_size
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
/*000000000030*/ s_add_u32       s0, s6, -2
/*000000000034*/ s_add_u32       s2, s3, s2
/*000000000038*/ v_add_u32       v10, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000048*/ v_mov_b32       v5, s0
/*00000000004c*/ v_add_u32       v1, vcc, s2, v1
/*000000000050*/ s_add_u32       s0, s7, -16
/*000000000054*/ s_add_u32       s1, s1, s10
/*000000000058*/ v_add_u32       v6, vcc, s4, v1
/*00000000005c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v8, s0
/*000000000068*/ v_add_u32       v1, vcc, s1, v2
/*00000000006c*/ s_add_u32       s0, s8, -2
/*000000000070*/ v_add_u32       v0, vcc, s4, v1
/*000000000074*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000007c*/ v_mov_b32       v9, s0
/*000000000080*/ flat_store_byte v[10:11], v5
/*000000000088*/ flat_store_byte v[6:7], v8
/*000000000090*/ flat_store_byte v[0:1], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_local_size_get_local_size
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
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_global_id_get_local_size
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
/*000000000044*/ v_add_u32       v3, vcc, 0xfe, v3
/*00000000004c*/ v_add_u32       v1, vcc, s0, v1
/*000000000050*/ s_add_u32       s0, s3, s10
/*000000000054*/ v_add_u32       v5, vcc, s4, v1
/*000000000058*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*000000000060*/ v_add_u32       v8, vcc, 0xfe, v1
/*000000000068*/ v_add_u32       v1, vcc, s0, v2
/*00000000006c*/ v_add_u32       v12, vcc, s4, v1
/*000000000070*/ v_addc_u32      v13, vcc, v4, 0, vcc
/*000000000078*/ v_add_u32       v9, vcc, 0xfc, v1
/*000000000080*/ flat_store_byte v[10:11], v3
/*000000000088*/ flat_store_byte v[5:6], v8
/*000000000090*/ flat_store_byte v[12:13], v9
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_size_get_local_size
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
/*000000000040*/ s_add_u32       s0, s12, -16
/*000000000044*/ s_add_u32       s2, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_add_u32       s0, s13, -2
/*000000000064*/ s_add_u32       s2, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ s_waitcnt       lgkmcnt(0)
/*000000000080*/ s_add_u32       s0, s1, -2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_num_groups_get_local_size
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
/*000000000048*/ s_add_u32       s0, s0, -2
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_add_u32       v1, vcc, s3, v1
/*00000000006c*/ s_add_u32       s0, s1, -2
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ v_add_u32       v1, vcc, s1, v2
/*000000000088*/ s_add_u32       s0, s2, -4
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_work_dim_get_local_size
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
/*000000000040*/ s_add_u32       s1, s0, 0xfe
/*000000000048*/ s_add_u32       s3, s3, s14
/*00000000004c*/ v_add_u32       v9, vcc, s4, v0
/*000000000050*/ v_mov_b32       v3, s5
/*000000000054*/ v_addc_u32      v10, vcc, v3, 0, vcc
/*00000000005c*/ v_mov_b32       v5, s1
/*000000000060*/ v_add_u32       v1, vcc, s3, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_add_u32       v1, vcc, s1, v2
/*000000000078*/ s_add_u32       s0, s0, 0xfc
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v8, s0
/*000000000090*/ flat_store_byte v[9:10], v5
/*000000000098*/ flat_store_byte v[6:7], v5
/*0000000000a0*/ flat_store_byte v[0:1], v8
/*0000000000a8*/ s_endpgm
.kernel subtract_char_x_get_global_id
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
/*00000000003c*/ v_sub_u32       v5, vcc, s1, v0
/*000000000040*/ v_add_u32       v3, vcc, s10, v0
/*000000000044*/ v_mov_b32       v6, s11
/*000000000048*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000050*/ flat_store_byte v[3:4], v5
/*000000000058*/ s_add_u32       s0, s5, s2
/*00000000005c*/ v_add_u32       v0, vcc, s0, v1
/*000000000060*/ v_sub_u32       v3, vcc, s1, v0
/*000000000064*/ v_add_u32       v0, vcc, s10, v0
/*000000000068*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000070*/ flat_store_byte v[0:1], v3
/*000000000078*/ s_add_u32       s0, s6, s4
/*00000000007c*/ v_add_u32       v0, vcc, s0, v2
/*000000000080*/ v_sub_u32       v2, vcc, s1, v0
/*000000000084*/ v_add_u32       v0, vcc, s10, v0
/*000000000088*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000090*/ flat_store_byte v[0:1], v2
/*000000000098*/ s_endpgm
.kernel subtract_char_get_global_offset_get_global_id
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
        .arg data, "char*", char*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x38
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x10
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ s_lshl_b32      s1, s7, 4
/*000000000028*/ v_add_u32       v1, vcc, s1, v1
/*00000000002c*/ s_lshl_b32      s1, s8, 1
/*000000000030*/ v_add_u32       v3, vcc, s0, v0
/*000000000034*/ v_add_u32       v2, vcc, s1, v2
/*000000000038*/ v_add_u32       v9, vcc, s10, v3
/*00000000003c*/ v_mov_b32       v4, s11
/*000000000040*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*000000000048*/ v_sub_u32       v0, vcc, 0, v0
/*00000000004c*/ v_add_u32       v6, vcc, s2, v1
/*000000000050*/ v_add_u32       v5, vcc, s10, v6
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_sub_u32       v1, vcc, 0, v1
/*000000000060*/ v_add_u32       v8, vcc, s4, v2
/*000000000064*/ v_add_u32       v3, vcc, s10, v8
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_sub_u32       v2, vcc, 0, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_local_id_get_global_id
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
/*000000000030*/ v_sub_u32       v0, vcc, v0, v3
/*000000000034*/ v_add_u32       v3, vcc, s10, v3
/*000000000038*/ v_mov_b32       v5, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v5, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v0
/*00000000004c*/ s_add_u32       s0, s3, s2
/*000000000050*/ v_add_u32       v0, vcc, s0, v1
/*000000000054*/ v_sub_u32       v3, vcc, v1, v0
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ s_add_u32       s0, s5, s4
/*000000000070*/ v_add_u32       v0, vcc, s0, v2
/*000000000074*/ v_sub_u32       v2, vcc, v2, v0
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v5, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_group_id_get_global_id
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
/*000000000030*/ v_sub_u32       v5, vcc, s6, v0
/*000000000034*/ v_add_u32       v3, vcc, s10, v0
/*000000000038*/ v_mov_b32       v6, s11
/*00000000003c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000044*/ flat_store_byte v[3:4], v5
/*00000000004c*/ s_add_u32       s0, s3, s2
/*000000000050*/ v_add_u32       v0, vcc, s0, v1
/*000000000054*/ v_sub_u32       v3, vcc, s7, v0
/*000000000058*/ v_add_u32       v0, vcc, s10, v0
/*00000000005c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000064*/ flat_store_byte v[0:1], v3
/*00000000006c*/ s_add_u32       s0, s5, s4
/*000000000070*/ v_add_u32       v0, vcc, s0, v2
/*000000000074*/ v_sub_u32       v2, vcc, s8, v0
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000084*/ flat_store_byte v[0:1], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_local_size_get_global_id
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
/*000000000038*/ v_mov_b32       v4, s5
/*00000000003c*/ v_addc_u32      v10, vcc, v4, 0, vcc
/*000000000044*/ v_sub_u32       v0, vcc, 2, v0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v5, vcc, s4, v1
/*000000000054*/ v_addc_u32      v6, vcc, v4, 0, vcc
/*00000000005c*/ v_sub_u32       v1, vcc, 2, v1
/*000000000060*/ v_add_u32       v2, vcc, s0, v2
/*000000000064*/ v_add_u32       v3, vcc, s4, v2
/*000000000068*/ v_addc_u32      v4, vcc, v4, 0, vcc
/*000000000070*/ v_sub_u32       v2, vcc, 4, v2
/*000000000074*/ flat_store_byte v[9:10], v0
/*00000000007c*/ flat_store_byte v[5:6], v1
/*000000000084*/ flat_store_byte v[3:4], v2
/*00000000008c*/ s_endpgm
.kernel subtract_char_get_global_id_get_global_id
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 16
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
        .arg data, "uchar*", uchar*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ s_lshl_b32      s3, s7, 1
/*00000000001c*/ v_add_u32       v0, vcc, s1, v0
/*000000000020*/ s_lshl_b32      s1, s8, 2
/*000000000024*/ s_add_u32       s0, s3, s0
/*000000000028*/ v_add_u32       v8, vcc, s4, v0
/*00000000002c*/ v_mov_b32       v3, s5
/*000000000030*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000038*/ v_mov_b32       v5, 0
/*00000000003c*/ v_add_u32       v1, vcc, s0, v1
/*000000000040*/ s_add_u32       s0, s1, s2
/*000000000044*/ v_add_u32       v6, vcc, s4, v1
/*000000000048*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000050*/ v_add_u32       v1, vcc, s0, v2
/*000000000054*/ v_add_u32       v0, vcc, s4, v1
/*000000000058*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000060*/ flat_store_byte v[8:9], v5
/*000000000068*/ flat_store_byte v[6:7], v5
/*000000000070*/ flat_store_byte v[0:1], v5
/*000000000078*/ s_endpgm
.kernel subtract_char_get_global_size_get_global_id
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
/*000000000040*/ v_sub_u32       v5, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s4, v0
/*000000000048*/ v_mov_b32       v6, s5
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ s_add_u32       s0, s7, s14
/*000000000060*/ v_add_u32       v0, vcc, s0, v1
/*000000000064*/ v_sub_u32       v3, vcc, s1, v0
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ s_add_u32       s0, s8, s6
/*000000000080*/ v_add_u32       v0, vcc, s0, v2
/*000000000084*/ v_sub_u32       v2, vcc, s2, v0
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v2
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_num_groups_get_global_id
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
/*00000000004c*/ v_sub_u32       v5, vcc, s0, v0
/*000000000050*/ v_add_u32       v3, vcc, s4, v0
/*000000000054*/ v_mov_b32       v6, s5
/*000000000058*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000060*/ flat_store_byte v[3:4], v5
/*000000000068*/ s_add_u32       s0, s7, s14
/*00000000006c*/ v_add_u32       v0, vcc, s0, v1
/*000000000070*/ v_sub_u32       v3, vcc, s1, v0
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000080*/ flat_store_byte v[0:1], v3
/*000000000088*/ s_add_u32       s0, s8, s6
/*00000000008c*/ v_add_u32       v0, vcc, s0, v2
/*000000000090*/ v_sub_u32       v2, vcc, s2, v0
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v2
/*0000000000a8*/ s_endpgm
.kernel subtract_char_get_work_dim_get_global_id
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
/*000000000040*/ v_sub_u32       v5, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s2, v0
/*000000000048*/ v_mov_b32       v6, s3
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ s_add_u32       s1, s5, s14
/*000000000060*/ v_add_u32       v0, vcc, s1, v1
/*000000000064*/ v_sub_u32       v3, vcc, s0, v0
/*000000000068*/ v_add_u32       v0, vcc, s2, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ s_add_u32       s1, s6, s4
/*000000000080*/ v_add_u32       v0, vcc, s1, v2
/*000000000084*/ v_sub_u32       v2, vcc, s0, v0
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v2
/*00000000009c*/ s_endpgm
.kernel subtract_char_x_get_global_size
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
/*000000000048*/ s_sub_u32       s8, s1, s12
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ s_add_u32       s0, s5, s2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s8
/*000000000068*/ s_sub_u32       s2, s1, s13
/*00000000006c*/ v_add_u32       v1, vcc, s0, v1
/*000000000070*/ s_add_u32       s0, s4, s14
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s2
/*000000000084*/ s_sub_u32       s1, s1, s3
/*000000000088*/ v_add_u32       v1, vcc, s0, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s1
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_global_offset_get_global_size
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
/*00000000003c*/ s_sub_u32       s0, s0, s12
/*000000000040*/ v_add_u32       v0, vcc, s3, v0
/*000000000044*/ s_add_u32       s3, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ s_sub_u32       s0, s2, s13
/*000000000060*/ v_add_u32       v1, vcc, s3, v1
/*000000000064*/ s_add_u32       s2, s5, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_sub_u32       s0, s14, s1
/*000000000080*/ v_add_u32       v1, vcc, s2, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_local_id_get_global_size
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
/*000000000038*/ v_subrev_u32    v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s0, s3, s12
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ v_add_u32       v3, vcc, s4, v0
/*000000000048*/ v_mov_b32       v6, s5
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_subrev_u32    v3, vcc, s1, v1
/*000000000060*/ s_add_u32       s0, s7, s14
/*000000000064*/ v_add_u32       v0, vcc, s0, v1
/*000000000068*/ v_add_u32       v0, vcc, s4, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ v_subrev_u32    v3, vcc, s2, v2
/*000000000080*/ s_add_u32       s0, s8, s6
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_add_u32       v0, vcc, s4, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v3
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_group_id_get_global_size
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
/*00000000003c*/ s_sub_u32       s5, s8, s12
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ s_add_u32       s0, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s5
/*00000000005c*/ s_sub_u32       s2, s9, s13
/*000000000060*/ v_add_u32       v1, vcc, s0, v1
/*000000000064*/ s_add_u32       s0, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s2
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_sub_u32       s1, s10, s1
/*000000000080*/ v_add_u32       v1, vcc, s0, v2
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s1
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_local_size_get_global_size
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
/*000000000040*/ s_sub_u32       s0, 2, s12
/*000000000044*/ s_add_u32       s2, s4, s2
/*000000000048*/ v_add_u32       v10, vcc, s6, v0
/*00000000004c*/ v_mov_b32       v3, s7
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s0
/*00000000005c*/ v_add_u32       v1, vcc, s2, v1
/*000000000060*/ s_sub_u32       s0, 2, s13
/*000000000064*/ s_add_u32       s2, s3, s14
/*000000000068*/ v_add_u32       v6, vcc, s6, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s0
/*000000000078*/ v_add_u32       v1, vcc, s2, v2
/*00000000007c*/ s_waitcnt       lgkmcnt(0)
/*000000000080*/ s_sub_u32       s0, 4, s1
/*000000000084*/ v_add_u32       v0, vcc, s6, v1
/*000000000088*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v9, s0
/*000000000094*/ flat_store_byte v[10:11], v5
/*00000000009c*/ flat_store_byte v[6:7], v8
/*0000000000a4*/ flat_store_byte v[0:1], v9
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_global_id_get_global_size
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
/*000000000030*/ v_add_u32       v0, vcc, s3, v0
/*000000000034*/ s_lshl_b32      s3, s9, 1
/*000000000038*/ s_lshl_b32      s4, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ s_add_u32       s0, s3, s2
/*000000000044*/ v_add_u32       v10, vcc, s6, v0
/*000000000048*/ v_mov_b32       v4, s7
/*00000000004c*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*000000000054*/ v_subrev_u32    v3, vcc, s12, v3
/*000000000058*/ v_add_u32       v1, vcc, s0, v1
/*00000000005c*/ s_add_u32       s0, s4, s14
/*000000000060*/ v_subrev_u32    v6, vcc, s13, v1
/*000000000064*/ v_add_u32       v7, vcc, s6, v1
/*000000000068*/ v_addc_u32      v8, vcc, v4, 0, vcc
/*000000000070*/ v_add_u32       v1, vcc, s0, v2
/*000000000074*/ s_waitcnt       lgkmcnt(0)
/*000000000078*/ v_subrev_u32    v2, vcc, s1, v1
/*00000000007c*/ v_add_u32       v0, vcc, s6, v1
/*000000000080*/ v_addc_u32      v1, vcc, v4, 0, vcc
/*000000000088*/ flat_store_byte v[10:11], v3
/*000000000090*/ flat_store_byte v[7:8], v6
/*000000000098*/ flat_store_byte v[0:1], v2
/*0000000000a0*/ s_endpgm
.kernel subtract_char_get_global_size_get_global_size
    .config
        .dims xyz
        .cws 16, 2, 2
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
        .arg data, "char*", char*, global, 
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
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s3, s2
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_num_groups_get_global_size
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
/*000000000044*/ s_sub_u32       s0, s5, s0
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s8, s14
/*000000000050*/ s_lshr_b32      s5, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s9, s1
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s10, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s5, s2
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_work_dim_get_global_size
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
/*00000000004c*/ s_sub_u32       s2, s0, s2
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ s_add_u32       s4, s5, s14
/*000000000058*/ v_add_u32       v10, vcc, s6, v0
/*00000000005c*/ v_mov_b32       v3, s7
/*000000000060*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_sub_u32       s2, s0, s3
/*000000000070*/ v_add_u32       v1, vcc, s4, v1
/*000000000074*/ s_add_u32       s3, s8, s16
/*000000000078*/ v_add_u32       v6, vcc, s6, v1
/*00000000007c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s2
/*000000000088*/ s_sub_u32       s0, s0, s1
/*00000000008c*/ v_add_u32       v1, vcc, s3, v2
/*000000000090*/ v_add_u32       v0, vcc, s6, v1
/*000000000094*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000009c*/ v_mov_b32       v9, s0
/*0000000000a0*/ flat_store_byte v[10:11], v5
/*0000000000a8*/ flat_store_byte v[6:7], v8
/*0000000000b0*/ flat_store_byte v[0:1], v9
/*0000000000b8*/ s_endpgm
.kernel subtract_char_x_get_num_groups
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
/*00000000004c*/ s_sub_u32       s0, s2, s0
/*000000000050*/ v_add_u32       v0, vcc, s5, v0
/*000000000054*/ s_add_u32       s5, s8, s14
/*000000000058*/ s_lshr_b32      s3, s3, 1
/*00000000005c*/ v_add_u32       v10, vcc, s6, v0
/*000000000060*/ v_mov_b32       v3, s7
/*000000000064*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*00000000006c*/ v_mov_b32       v5, s0
/*000000000070*/ s_sub_u32       s0, s2, s1
/*000000000074*/ v_add_u32       v1, vcc, s5, v1
/*000000000078*/ s_add_u32       s1, s9, s4
/*00000000007c*/ v_add_u32       v6, vcc, s6, v1
/*000000000080*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000088*/ v_mov_b32       v8, s0
/*00000000008c*/ s_sub_u32       s0, s2, s3
/*000000000090*/ v_add_u32       v1, vcc, s1, v2
/*000000000094*/ v_add_u32       v0, vcc, s6, v1
/*000000000098*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a0*/ v_mov_b32       v9, s0
/*0000000000a4*/ flat_store_byte v[10:11], v5
/*0000000000ac*/ flat_store_byte v[6:7], v8
/*0000000000b4*/ flat_store_byte v[0:1], v9
/*0000000000bc*/ s_endpgm
.kernel subtract_char_get_global_offset_get_num_groups
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
/*000000000044*/ s_sub_u32       s0, s12, s0
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s14, s1
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s4, s2
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_local_id_get_num_groups
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
/*000000000044*/ v_subrev_u32    v5, vcc, s0, v0
/*000000000048*/ s_add_u32       s0, s3, s12
/*00000000004c*/ v_add_u32       v0, vcc, s0, v0
/*000000000050*/ v_add_u32       v3, vcc, s4, v0
/*000000000054*/ v_mov_b32       v6, s5
/*000000000058*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000060*/ flat_store_byte v[3:4], v5
/*000000000068*/ v_subrev_u32    v3, vcc, s1, v1
/*00000000006c*/ s_add_u32       s0, s7, s14
/*000000000070*/ v_add_u32       v0, vcc, s0, v1
/*000000000074*/ v_add_u32       v0, vcc, s4, v0
/*000000000078*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000080*/ flat_store_byte v[0:1], v3
/*000000000088*/ v_subrev_u32    v3, vcc, s2, v2
/*00000000008c*/ s_add_u32       s0, s8, s6
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_add_u32       v0, vcc, s4, v0
/*000000000098*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*0000000000a0*/ flat_store_byte v[0:1], v3
/*0000000000a8*/ s_endpgm
.kernel subtract_char_get_group_id_get_num_groups
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
/*000000000044*/ s_sub_u32       s0, s8, s0
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s9, s1
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s11, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s10, s2
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_local_size_get_num_groups
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
/*000000000048*/ s_sub_u32       s0, 2, s0
/*00000000004c*/ s_add_u32       s3, s5, s14
/*000000000050*/ s_lshr_b32      s2, s2, 2
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ v_add_u32       v1, vcc, s3, v1
/*00000000006c*/ s_sub_u32       s0, 2, s1
/*000000000070*/ s_add_u32       s1, s8, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ v_add_u32       v1, vcc, s1, v2
/*000000000088*/ s_sub_u32       s0, 4, s2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_global_id_get_num_groups
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
/*000000000018*/ s_load_dwordx2  s[6:7], s[6:7], 0x38
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_load_dword    s3, s[4:5], 0x14
/*00000000002c*/ s_lshl_b32      s4, s8, 1
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ s_lshl_b32      s4, s9, 1
/*000000000038*/ s_lshr_b32      s0, s0, 1
/*00000000003c*/ s_lshl_b32      s5, s10, 2
/*000000000040*/ v_add_u32       v3, vcc, s12, v0
/*000000000044*/ s_add_u32       s4, s4, s14
/*000000000048*/ s_lshr_b32      s1, s1, 1
/*00000000004c*/ v_add_u32       v10, vcc, s6, v0
/*000000000050*/ v_mov_b32       v4, s7
/*000000000054*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*00000000005c*/ v_subrev_u32    v3, vcc, s0, v3
/*000000000060*/ v_add_u32       v1, vcc, s4, v1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ s_waitcnt       lgkmcnt(0)
/*00000000006c*/ s_lshr_b32      s2, s3, 2
/*000000000070*/ v_subrev_u32    v6, vcc, s1, v1
/*000000000074*/ v_add_u32       v7, vcc, s6, v1
/*000000000078*/ v_addc_u32      v8, vcc, v4, 0, vcc
/*000000000080*/ v_add_u32       v1, vcc, s0, v2
/*000000000084*/ v_subrev_u32    v2, vcc, s2, v1
/*000000000088*/ v_add_u32       v0, vcc, s6, v1
/*00000000008c*/ v_addc_u32      v1, vcc, v4, 0, vcc
/*000000000094*/ flat_store_byte v[10:11], v3
/*00000000009c*/ flat_store_byte v[7:8], v6
/*0000000000a4*/ flat_store_byte v[0:1], v2
/*0000000000ac*/ s_endpgm
.kernel subtract_char_get_global_size_get_num_groups
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
/*000000000044*/ s_sub_u32       s0, s0, s5
/*000000000048*/ v_add_u32       v0, vcc, s3, v0
/*00000000004c*/ s_add_u32       s3, s8, s14
/*000000000050*/ s_lshr_b32      s5, s2, 1
/*000000000054*/ v_add_u32       v10, vcc, s6, v0
/*000000000058*/ v_mov_b32       v3, s7
/*00000000005c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000064*/ v_mov_b32       v5, s0
/*000000000068*/ s_sub_u32       s0, s1, s9
/*00000000006c*/ v_add_u32       v1, vcc, s3, v1
/*000000000070*/ s_add_u32       s1, s10, s4
/*000000000074*/ v_add_u32       v6, vcc, s6, v1
/*000000000078*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000080*/ v_mov_b32       v8, s0
/*000000000084*/ s_sub_u32       s0, s2, s5
/*000000000088*/ v_add_u32       v1, vcc, s1, v2
/*00000000008c*/ v_add_u32       v0, vcc, s6, v1
/*000000000090*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000098*/ v_mov_b32       v9, s0
/*00000000009c*/ flat_store_byte v[10:11], v5
/*0000000000a4*/ flat_store_byte v[6:7], v8
/*0000000000ac*/ flat_store_byte v[0:1], v9
/*0000000000b4*/ s_endpgm
.kernel subtract_char_get_num_groups_get_num_groups
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
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_get_work_dim_get_num_groups
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
/*000000000054*/ s_sub_u32       s2, s0, s2
/*000000000058*/ v_add_u32       v0, vcc, s5, v0
/*00000000005c*/ s_add_u32       s5, s8, s14
/*000000000060*/ s_lshr_b32      s1, s1, 2
/*000000000064*/ v_add_u32       v10, vcc, s6, v0
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v5, s2
/*000000000078*/ s_sub_u32       s2, s0, s3
/*00000000007c*/ v_add_u32       v1, vcc, s5, v1
/*000000000080*/ s_add_u32       s3, s9, s4
/*000000000084*/ v_add_u32       v6, vcc, s6, v1
/*000000000088*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v8, s2
/*000000000094*/ s_sub_u32       s0, s0, s1
/*000000000098*/ v_add_u32       v1, vcc, s3, v2
/*00000000009c*/ v_add_u32       v0, vcc, s6, v1
/*0000000000a0*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a8*/ v_mov_b32       v9, s0
/*0000000000ac*/ flat_store_byte v[10:11], v5
/*0000000000b4*/ flat_store_byte v[6:7], v8
/*0000000000bc*/ flat_store_byte v[0:1], v9
/*0000000000c4*/ s_endpgm
.kernel subtract_char_x_get_work_dim
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
/*000000000044*/ s_sub_u32       s0, s1, s0
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
.kernel subtract_char_get_global_offset_get_work_dim
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
/*00000000003c*/ s_sub_u32       s7, s12, s0
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_sub_u32       s3, s14, s0
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_sub_u32       s0, s2, s0
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel subtract_char_get_local_id_get_work_dim
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
/*000000000038*/ v_subrev_u32    v5, vcc, s0, v0
/*00000000003c*/ s_add_u32       s1, s1, s12
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ v_add_u32       v3, vcc, s2, v0
/*000000000048*/ v_mov_b32       v6, s3
/*00000000004c*/ v_addc_u32      v4, vcc, v6, 0, vcc
/*000000000054*/ flat_store_byte v[3:4], v5
/*00000000005c*/ v_subrev_u32    v3, vcc, s0, v1
/*000000000060*/ s_add_u32       s1, s5, s14
/*000000000064*/ v_add_u32       v0, vcc, s1, v1
/*000000000068*/ v_add_u32       v0, vcc, s2, v0
/*00000000006c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000074*/ flat_store_byte v[0:1], v3
/*00000000007c*/ v_subrev_u32    v3, vcc, s0, v2
/*000000000080*/ s_add_u32       s0, s6, s4
/*000000000084*/ v_add_u32       v0, vcc, s0, v2
/*000000000088*/ v_add_u32       v0, vcc, s2, v0
/*00000000008c*/ v_addc_u32      v1, vcc, v6, 0, vcc
/*000000000094*/ flat_store_byte v[0:1], v3
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_group_id_get_work_dim
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
/*00000000003c*/ s_sub_u32       s7, s8, s0
/*000000000040*/ v_add_u32       v0, vcc, s1, v0
/*000000000044*/ s_add_u32       s1, s3, s14
/*000000000048*/ v_add_u32       v10, vcc, s4, v0
/*00000000004c*/ v_mov_b32       v3, s5
/*000000000050*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000058*/ v_mov_b32       v5, s7
/*00000000005c*/ s_sub_u32       s3, s9, s0
/*000000000060*/ v_add_u32       v1, vcc, s1, v1
/*000000000064*/ s_add_u32       s1, s6, s2
/*000000000068*/ v_add_u32       v6, vcc, s4, v1
/*00000000006c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v8, s3
/*000000000078*/ s_sub_u32       s0, s10, s0
/*00000000007c*/ v_add_u32       v1, vcc, s1, v2
/*000000000080*/ v_add_u32       v0, vcc, s4, v1
/*000000000084*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000008c*/ v_mov_b32       v9, s0
/*000000000090*/ flat_store_byte v[10:11], v5
/*000000000098*/ flat_store_byte v[6:7], v8
/*0000000000a0*/ flat_store_byte v[0:1], v9
/*0000000000a8*/ s_endpgm
.kernel subtract_char_get_local_size_get_work_dim
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
/*000000000040*/ s_sub_u32       s1, 2, s0
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
/*000000000074*/ s_sub_u32       s0, 4, s0
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s0
/*000000000088*/ flat_store_byte v[9:10], v5
/*000000000090*/ flat_store_byte v[6:7], v5
/*000000000098*/ flat_store_byte v[0:1], v8
/*0000000000a0*/ s_endpgm
.kernel subtract_char_get_global_id_get_work_dim
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
/*000000000024*/ v_add_u32       v0, vcc, s1, v0
/*000000000028*/ s_lshl_b32      s1, s9, 1
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_bfe_u32       s0, s0, 0x20010
/*000000000038*/ s_lshl_b32      s3, s10, 2
/*00000000003c*/ v_add_u32       v3, vcc, s12, v0
/*000000000040*/ s_add_u32       s1, s1, s14
/*000000000044*/ v_add_u32       v10, vcc, s4, v0
/*000000000048*/ v_mov_b32       v4, s5
/*00000000004c*/ v_addc_u32      v11, vcc, v4, 0, vcc
/*000000000054*/ v_subrev_u32    v3, vcc, s0, v3
/*000000000058*/ v_add_u32       v1, vcc, s1, v1
/*00000000005c*/ s_add_u32       s1, s3, s2
/*000000000060*/ v_subrev_u32    v6, vcc, s0, v1
/*000000000064*/ v_add_u32       v7, vcc, s4, v1
/*000000000068*/ v_addc_u32      v8, vcc, v4, 0, vcc
/*000000000070*/ v_add_u32       v1, vcc, s1, v2
/*000000000074*/ v_subrev_u32    v2, vcc, s0, v1
/*000000000078*/ v_add_u32       v0, vcc, s4, v1
/*00000000007c*/ v_addc_u32      v1, vcc, v4, 0, vcc
/*000000000084*/ flat_store_byte v[10:11], v3
/*00000000008c*/ flat_store_byte v[7:8], v6
/*000000000094*/ flat_store_byte v[0:1], v2
/*00000000009c*/ s_endpgm
.kernel subtract_char_get_global_size_get_work_dim
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
/*00000000004c*/ s_sub_u32       s2, s2, s0
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ s_add_u32       s4, s5, s14
/*000000000058*/ v_add_u32       v10, vcc, s6, v0
/*00000000005c*/ v_mov_b32       v3, s7
/*000000000060*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_sub_u32       s2, s3, s0
/*000000000070*/ v_add_u32       v1, vcc, s4, v1
/*000000000074*/ s_add_u32       s3, s8, s16
/*000000000078*/ v_add_u32       v6, vcc, s6, v1
/*00000000007c*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000084*/ v_mov_b32       v8, s2
/*000000000088*/ s_sub_u32       s0, s1, s0
/*00000000008c*/ v_add_u32       v1, vcc, s3, v2
/*000000000090*/ v_add_u32       v0, vcc, s6, v1
/*000000000094*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000009c*/ v_mov_b32       v9, s0
/*0000000000a0*/ flat_store_byte v[10:11], v5
/*0000000000a8*/ flat_store_byte v[6:7], v8
/*0000000000b0*/ flat_store_byte v[0:1], v9
/*0000000000b8*/ s_endpgm
.kernel subtract_char_get_num_groups_get_work_dim
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
/*000000000054*/ s_sub_u32       s2, s2, s0
/*000000000058*/ v_add_u32       v0, vcc, s5, v0
/*00000000005c*/ s_add_u32       s5, s8, s14
/*000000000060*/ s_lshr_b32      s1, s1, 2
/*000000000064*/ v_add_u32       v10, vcc, s6, v0
/*000000000068*/ v_mov_b32       v3, s7
/*00000000006c*/ v_addc_u32      v11, vcc, v3, 0, vcc
/*000000000074*/ v_mov_b32       v5, s2
/*000000000078*/ s_sub_u32       s2, s3, s0
/*00000000007c*/ v_add_u32       v1, vcc, s5, v1
/*000000000080*/ s_add_u32       s3, s9, s4
/*000000000084*/ v_add_u32       v6, vcc, s6, v1
/*000000000088*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*000000000090*/ v_mov_b32       v8, s2
/*000000000094*/ s_sub_u32       s0, s1, s0
/*000000000098*/ v_add_u32       v1, vcc, s3, v2
/*00000000009c*/ v_add_u32       v0, vcc, s6, v1
/*0000000000a0*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*0000000000a8*/ v_mov_b32       v9, s0
/*0000000000ac*/ flat_store_byte v[10:11], v5
/*0000000000b4*/ flat_store_byte v[6:7], v8
/*0000000000bc*/ flat_store_byte v[0:1], v9
/*0000000000c4*/ s_endpgm
.kernel subtract_char_get_work_dim_get_work_dim
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
/*000000000034*/ v_add_u32       v8, vcc, s4, v0
/*000000000038*/ v_mov_b32       v3, s5
/*00000000003c*/ v_addc_u32      v9, vcc, v3, 0, vcc
/*000000000044*/ v_mov_b32       v5, 0
/*000000000048*/ v_add_u32       v1, vcc, s0, v1
/*00000000004c*/ s_add_u32       s0, s1, s10
/*000000000050*/ v_add_u32       v6, vcc, s4, v1
/*000000000054*/ v_addc_u32      v7, vcc, v3, 0, vcc
/*00000000005c*/ v_add_u32       v1, vcc, s0, v2
/*000000000060*/ v_add_u32       v0, vcc, s4, v1
/*000000000064*/ v_addc_u32      v1, vcc, v3, 0, vcc
/*00000000006c*/ flat_store_byte v[8:9], v5
/*000000000074*/ flat_store_byte v[6:7], v5
/*00000000007c*/ flat_store_byte v[0:1], v5
/*000000000084*/ s_endpgm
.kernel subtract_char_x_64
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
/*00000000002c*/ v_sub_u32       v2, vcc, s1, v0
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v1, s3
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ flat_store_byte v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_char_get_global_offset_64
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
/*000000000020*/ v_sub_u32       v2, vcc, s0, v0
/*000000000024*/ v_add_u32       v0, vcc, s2, v0
/*000000000028*/ v_mov_b32       v1, s3
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_local_id_64
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
/*000000000020*/ v_sub_u32       v0, vcc, v0, v1
/*000000000024*/ v_add_u32       v1, vcc, s2, v1
/*000000000028*/ v_mov_b32       v2, s3
/*00000000002c*/ v_addc_u32      v2, vcc, v2, 0, vcc
/*000000000034*/ flat_store_byte v[1:2], v0
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_group_id_64
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
/*000000000020*/ v_sub_u32       v2, vcc, s6, v0
/*000000000024*/ v_add_u32       v0, vcc, s2, v0
/*000000000028*/ v_mov_b32       v1, s3
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_local_size_64
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
/*000000000020*/ v_add_u32       v1, vcc, s2, v0
/*000000000024*/ v_mov_b32       v2, s3
/*000000000028*/ v_addc_u32      v2, vcc, v2, 0, vcc
/*000000000030*/ v_sub_u32       v0, vcc, 64, v0
/*000000000034*/ flat_store_byte v[1:2], v0
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_global_id_64
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
.kernel subtract_char_get_global_size_64
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
/*00000000002c*/ v_sub_u32       v2, vcc, s1, v0
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_mov_b32       v1, s3
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ flat_store_byte v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_char_get_num_groups_64
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
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_lshr_b32      s1, s1, 6
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ v_sub_u32       v2, vcc, s1, v0
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v1, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000044*/ flat_store_byte v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel subtract_char_get_work_dim
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
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ s_waitcnt       lgkmcnt(0)
/*000000000028*/ s_bfe_u32       s1, s1, 0x20010
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ v_sub_u32       v2, vcc, s1, v0
/*000000000038*/ v_add_u32       v0, vcc, s2, v0
/*00000000003c*/ v_mov_b32       v1, s3
/*000000000040*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000048*/ flat_store_byte v[0:1], v2
/*000000000050*/ s_endpgm
.kernel subtract_char_x_8_8
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
/*000000000028*/ s_add_u32       s0, s3, s0
/*00000000002c*/ v_add_u32       v1, vcc, s2, v1
/*000000000030*/ v_add_u32       v0, vcc, s0, v0
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_sub_u32       v2, vcc, s1, v1
/*00000000003c*/ v_add_u32       v0, vcc, s4, v0
/*000000000040*/ v_mov_b32       v1, s5
/*000000000044*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000004c*/ flat_store_byte v[0:1], v2
/*000000000054*/ s_endpgm
.kernel subtract_char_get_global_offset_8_8
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
/*00000000001c*/ s_sub_u32       s0, s0, s2
/*000000000020*/ v_add_u32       v0, vcc, s1, v0
/*000000000024*/ v_add_u32       v0, vcc, s4, v0
/*000000000028*/ v_mov_b32       v1, s5
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ v_mov_b32       v2, s0
/*000000000038*/ flat_store_byte v[0:1], v2
/*000000000040*/ s_endpgm
.kernel subtract_char_get_local_id_8_8
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
/*000000000018*/ v_sub_u32       v2, vcc, v0, v1
/*00000000001c*/ s_add_u32       s0, s1, s0
/*000000000020*/ v_add_u32       v0, vcc, s0, v0
/*000000000024*/ v_add_u32       v0, vcc, s2, v0
/*000000000028*/ v_mov_b32       v1, s3
/*00000000002c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_group_id_8_8
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
/*000000000004*/ s_sub_u32       s1, s6, s7
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
.kernel subtract_char_get_local_size_8_8
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
/*000000000030*/ v_mov_b32       v2, 0
/*000000000034*/ flat_store_byte v[0:1], v2
/*00000000003c*/ s_endpgm
.kernel subtract_char_get_global_id_8_8
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
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_lshl_b32      s3, s7, 3
/*00000000001c*/ s_add_u32       s2, s3, s2
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v1, vcc, s2, v1
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_sub_u32       v2, vcc, v0, v1
/*000000000030*/ v_add_u32       v0, vcc, s4, v0
/*000000000034*/ v_mov_b32       v1, s5
/*000000000038*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000040*/ flat_store_byte v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_char_get_global_size_8_8
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
/*000000000024*/ s_sub_u32       s1, s2, s3
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_add_u32       v0, vcc, s4, v0
/*000000000030*/ v_mov_b32       v1, s5
/*000000000034*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*00000000003c*/ v_mov_b32       v2, s1
/*000000000040*/ flat_store_byte v[0:1], v2
/*000000000048*/ s_endpgm
.kernel subtract_char_get_num_groups_8_8
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
/*00000000002c*/ s_sub_u32       s0, s0, s1
/*000000000030*/ v_add_u32       v0, vcc, s2, v0
/*000000000034*/ v_add_u32       v0, vcc, s4, v0
/*000000000038*/ v_mov_b32       v1, s5
/*00000000003c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000044*/ v_mov_b32       v2, s0
/*000000000048*/ flat_store_byte v[0:1], v2
/*000000000050*/ s_endpgm
.kernel subtract_char_get_work_dim_8_8
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
/*000000000014*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s3, s8, 3
/*000000000020*/ s_lshl_b32      s6, s9, 3
/*000000000024*/ s_add_u32       s2, s6, s2
/*000000000028*/ s_add_u32       s0, s3, s0
/*00000000002c*/ s_waitcnt       lgkmcnt(0)
/*000000000030*/ s_bfe_u32       s1, s1, 0x20010
/*000000000038*/ v_add_u32       v1, vcc, s2, v1
/*00000000003c*/ v_add_u32       v0, vcc, s0, v0
/*000000000040*/ v_sub_u32       v2, vcc, s1, v1
/*000000000044*/ v_add_u32       v0, vcc, s4, v0
/*000000000048*/ v_mov_b32       v1, s5
/*00000000004c*/ v_addc_u32      v1, vcc, v1, 0, vcc
/*000000000054*/ flat_store_byte v[0:1], v2
/*00000000005c*/ s_endpgm
