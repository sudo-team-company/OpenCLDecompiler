/* Disassembling 'linear_kernels\work_item_built_in_functions\copy_get_group_id\copy_get_group_id.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel copy_get_group_id
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
