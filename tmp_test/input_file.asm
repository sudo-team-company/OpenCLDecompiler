.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel add_x_x
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
/*000000000038*/ s_lshl_b32      s0, s1, 1
/*00000000003c*/ v_add_u32       v0, vcc, s2, v0
/*000000000040*/ v_mov_b32       v2, s3
/*000000000044*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000048*/ v_mov_b32       v2, s0
/*00000000004c*/ flat_store_dword v[0:1], v2
/*000000000054*/ s_endpgm
.kernel add_get_global_offset_x
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
/*000000000048*/ s_add_u32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_add_u32       s0, s2, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_add_u32       s0, s10, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel add_get_local_id_x
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
/*000000000034*/ v_add_u32       v5, vcc, s1, v0
/*000000000038*/ s_add_u32       s0, s3, s0
/*00000000003c*/ v_add_u32       v3, vcc, s0, v0
/*000000000040*/ v_mov_b32       v4, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*00000000004c*/ v_add_u32       v3, vcc, s10, v3
/*000000000050*/ v_mov_b32       v6, s11
/*000000000054*/ v_addc_u32      v4, vcc, v6, v4, vcc
/*000000000058*/ flat_store_dword v[3:4], v5
/*000000000060*/ v_add_u32       v3, vcc, s1, v1
/*000000000064*/ s_add_u32       s0, s5, s2
/*000000000068*/ v_add_u32       v0, vcc, s0, v1
/*00000000006c*/ v_mov_b32       v1, 0
/*000000000070*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000078*/ v_add_u32       v0, vcc, s10, v0
/*00000000007c*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000080*/ flat_store_dword v[0:1], v3
/*000000000088*/ v_add_u32       v3, vcc, s1, v2
/*00000000008c*/ s_add_u32       s0, s6, s4
/*000000000090*/ v_add_u32       v0, vcc, s0, v2
/*000000000094*/ v_mov_b32       v1, 0
/*000000000098*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000a0*/ v_add_u32       v0, vcc, s10, v0
/*0000000000a4*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*0000000000a8*/ flat_store_dword v[0:1], v3
/*0000000000b0*/ s_endpgm
.kernel add_get_group_id_x
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
/*000000000048*/ s_add_u32       s2, s6, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s0, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s2
/*00000000006c*/ s_add_u32       s0, s7, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_add_u32       s0, s8, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel add_get_local_size_x
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
/*000000000054*/ s_add_u32       s2, s1, 2
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
/*00000000008c*/ s_add_u32       s0, s1, 4
/*000000000090*/ v_add_u32       v12, vcc, s4, v7
/*000000000094*/ v_addc_u32      v13, vcc, v3, v8, vcc
/*000000000098*/ v_mov_b32       v7, s0
/*00000000009c*/ flat_store_dword v[10:11], v5
/*0000000000a4*/ flat_store_dword v[1:2], v5
/*0000000000ac*/ flat_store_dword v[12:13], v7
/*0000000000b4*/ s_endpgm
.kernel add_get_global_id_x
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
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000024*/ s_lshl_b32      s3, s6, 1
/*000000000028*/ s_lshl_b32      s6, s7, 1
/*00000000002c*/ v_add_u32       v6, vcc, s3, v0
/*000000000030*/ s_lshl_b32      s3, s8, 2
/*000000000034*/ s_add_u32       s2, s6, s2
/*000000000038*/ v_add_u32       v8, vcc, s2, v1
/*00000000003c*/ s_add_u32       s2, s3, s10
/*000000000040*/ v_mov_b32       v7, 0
/*000000000044*/ v_lshlrev_b64   v[3:4], 2, v[6:7]
/*00000000004c*/ s_waitcnt       lgkmcnt(0)
/*000000000050*/ s_add_u32       s0, s0, s1
/*000000000054*/ v_add_u32       v10, vcc, s2, v2
/*000000000058*/ v_add_u32       v3, vcc, s4, v3
/*00000000005c*/ v_mov_b32       v5, s5
/*000000000060*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000064*/ v_add_u32       v0, vcc, s0, v6
/*000000000068*/ v_mov_b32       v9, 0
/*00000000006c*/ v_lshlrev_b64   v[6:7], 2, v[8:9]
/*000000000074*/ v_add_u32       v1, vcc, s1, v8
/*000000000078*/ v_add_u32       v6, vcc, s4, v6
/*00000000007c*/ v_addc_u32      v7, vcc, v5, v7, vcc
/*000000000080*/ v_mov_b32       v11, 0
/*000000000084*/ v_lshlrev_b64   v[8:9], 2, v[10:11]
/*00000000008c*/ v_add_u32       v2, vcc, s1, v10
/*000000000090*/ v_add_u32       v8, vcc, s4, v8
/*000000000094*/ v_addc_u32      v9, vcc, v5, v9, vcc
/*000000000098*/ flat_store_dword v[3:4], v0
/*0000000000a0*/ flat_store_dword v[6:7], v1
/*0000000000a8*/ flat_store_dword v[8:9], v2
/*0000000000b0*/ s_endpgm
.kernel add_get_global_size_x
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
/*000000000058*/ s_add_u32       s2, s14, s1
/*00000000005c*/ v_mov_b32       v4, 0
/*000000000060*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000068*/ v_add_u32       v8, vcc, s0, v2
/*00000000006c*/ v_add_u32       v10, vcc, s6, v3
/*000000000070*/ v_mov_b32       v3, s7
/*000000000074*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000078*/ v_mov_b32       v5, s2
/*00000000007c*/ s_add_u32       s0, s15, s1
/*000000000080*/ v_mov_b32       v7, 0
/*000000000084*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000008c*/ v_add_u32       v1, vcc, s6, v6
/*000000000090*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000094*/ v_mov_b32       v7, s0
/*000000000098*/ s_add_u32       s0, s4, s1
/*00000000009c*/ v_mov_b32       v9, 0
/*0000000000a0*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000a8*/ v_add_u32       v12, vcc, s6, v8
/*0000000000ac*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000b0*/ v_mov_b32       v8, s0
/*0000000000b4*/ flat_store_dword v[10:11], v5
/*0000000000bc*/ flat_store_dword v[1:2], v7
/*0000000000c4*/ flat_store_dword v[12:13], v8
/*0000000000cc*/ s_endpgm
.kernel add_get_num_groups_x
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
/*000000000060*/ s_add_u32       s2, s2, s1
/*000000000064*/ v_mov_b32       v4, 0
/*000000000068*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000070*/ v_add_u32       v8, vcc, s0, v2
/*000000000074*/ s_lshr_b32      s0, s3, 2
/*000000000078*/ v_add_u32       v10, vcc, s4, v3
/*00000000007c*/ v_mov_b32       v3, s5
/*000000000080*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000084*/ v_mov_b32       v5, s2
/*000000000088*/ s_add_u32       s2, s6, s1
/*00000000008c*/ v_mov_b32       v7, 0
/*000000000090*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*000000000098*/ v_add_u32       v1, vcc, s4, v6
/*00000000009c*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*0000000000a0*/ v_mov_b32       v7, s2
/*0000000000a4*/ s_add_u32       s0, s0, s1
/*0000000000a8*/ v_mov_b32       v9, 0
/*0000000000ac*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*0000000000b4*/ v_add_u32       v12, vcc, s4, v8
/*0000000000b8*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000bc*/ v_mov_b32       v8, s0
/*0000000000c0*/ flat_store_dword v[10:11], v5
/*0000000000c8*/ flat_store_dword v[1:2], v7
/*0000000000d0*/ flat_store_dword v[12:13], v8
/*0000000000d8*/ s_endpgm
.kernel add_get_work_dim_x
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
/*00000000003c*/ s_add_u32       s0, s0, s2
/*000000000040*/ v_mov_b32       v1, 0
/*000000000044*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000004c*/ v_add_u32       v0, vcc, s4, v0
/*000000000050*/ v_mov_b32       v2, s5
/*000000000054*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000058*/ v_mov_b32       v2, s0
/*00000000005c*/ flat_store_dword v[0:1], v2
/*000000000064*/ s_endpgm
.kernel add_x_get_global_offset
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
/*000000000048*/ s_add_u32       s0, s0, s1
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*000000000058*/ v_add_u32       v8, vcc, s3, v2
/*00000000005c*/ v_add_u32       v10, vcc, s4, v3
/*000000000060*/ v_mov_b32       v3, s5
/*000000000064*/ v_addc_u32      v11, vcc, v3, v4, vcc
/*000000000068*/ v_mov_b32       v5, s0
/*00000000006c*/ s_add_u32       s0, s2, s1
/*000000000070*/ v_mov_b32       v7, 0
/*000000000074*/ v_lshlrev_b64   v[6:7], 2, v[6:7]
/*00000000007c*/ v_add_u32       v1, vcc, s4, v6
/*000000000080*/ v_addc_u32      v2, vcc, v3, v7, vcc
/*000000000084*/ v_mov_b32       v7, s0
/*000000000088*/ s_add_u32       s0, s10, s1
/*00000000008c*/ v_mov_b32       v9, 0
/*000000000090*/ v_lshlrev_b64   v[8:9], 2, v[8:9]
/*000000000098*/ v_add_u32       v12, vcc, s4, v8
/*00000000009c*/ v_addc_u32      v13, vcc, v3, v9, vcc
/*0000000000a0*/ v_mov_b32       v8, s0
/*0000000000a4*/ flat_store_dword v[10:11], v5
/*0000000000ac*/ flat_store_dword v[1:2], v7
/*0000000000b4*/ flat_store_dword v[12:13], v8
/*0000000000bc*/ s_endpgm
.kernel add_get_global_offset_get_global_offset
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
/*00000000006c*/ s_lshl_b32      s0, s2, 1
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