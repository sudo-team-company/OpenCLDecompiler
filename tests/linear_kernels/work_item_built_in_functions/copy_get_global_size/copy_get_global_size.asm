.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
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
