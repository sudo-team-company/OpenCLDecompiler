/* Disassembling 'different_types\uint8_type_test\uint8_type_test.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel uint8_type_test
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
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
        .arg param1, "uint8", uint8
        .arg data, "uint*", uint*, global, 
        .arg param2, "uint", uint
        .arg param3, "uint8", uint8
        .arg param5, "ulong", ulong
        .arg param6, "long", long
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x34
/*000000000010*/ s_load_dwordx2  s[8:9], s[4:5], 0x88
/*000000000018*/ s_load_dwordx2  s[4:5], s[4:5], 0x50
/*000000000020*/ s_waitcnt       lgkmcnt(0)
/*000000000024*/ s_lshl_b32      s1, s6, 6
/*000000000028*/ s_add_u32       s0, s1, s0
/*00000000002c*/ v_add_u32       v0, vcc, s0, v0
/*000000000030*/ s_add_u32       s0, s2, s3
/*000000000034*/ s_add_u32       s0, s0, s8
/*000000000038*/ v_mov_b32       v1, 0
/*00000000003c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000044*/ v_add_u32       v0, vcc, s4, v0
/*000000000048*/ v_mov_b32       v2, s5
/*00000000004c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000050*/ v_mov_b32       v2, s0
/*000000000054*/ flat_store_dword v[0:1], v2
/*00000000005c*/ s_endpgm
