/* Disassembling 'linear_kernels/work_item_built_in_functions/copy_get_local_size/copy_get_local_size.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
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
