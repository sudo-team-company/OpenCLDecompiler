.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel copy_get_local_id
    .config
        .dims xyz
        .cws 4, 4, 4
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
/*00000000001c*/ s_lshl_b32      s1, s6, 2
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
