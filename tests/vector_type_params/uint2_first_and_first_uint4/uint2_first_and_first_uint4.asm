/* Disassembling 'vector_type_params\uint2_first_and_first_uint4\uint2_first_and_first_uint4.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel uint2_first_and_first_uint4
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 17
        .vgprsnum 7
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
        .arg edges1, "uint2*", uint2*, global, restrict
        .arg edges2, "uint4*", uint4*, global, const restrict, rdonly
        .arg edges3, "uint4*", uint4*, global, const restrict, rdonly
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx4  s[8:11], s[4:5], 0x30
/*000000000010*/ s_load_dwordx2  s[2:3], s[4:5], 0x40
/*000000000018*/ s_lshl_b32      s1, s6, 6
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[2:3], 4, v[0:1]
/*000000000034*/ v_add_u32       v4, vcc, s10, v2
/*000000000038*/ v_mov_b32       v5, s11
/*00000000003c*/ v_addc_u32      v5, vcc, v5, v3, vcc
/*000000000040*/ v_add_u32       v2, vcc, s2, v2
/*000000000044*/ v_mov_b32       v6, s3
/*000000000048*/ v_addc_u32      v3, vcc, v6, v3, vcc
/*00000000004c*/ flat_load_dword v4, v[4:5]
/*000000000054*/ flat_load_dword v5, v[2:3]
/*00000000005c*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*000000000064*/ v_add_u32       v0, vcc, s8, v0
/*000000000068*/ v_mov_b32       v3, s9
/*00000000006c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000070*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000074*/ flat_store_dwordx2 v[0:1], v[4:5]
/*00000000007c*/ s_endpgm
