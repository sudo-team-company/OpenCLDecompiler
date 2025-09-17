.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel uint4_float4
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 6
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
        .arg smth2, "float4", float4
        .arg smth3, "int", int
        .arg smth4, "int", int
        .arg smth5, "int", int
        .arg smth, "int4*", int4*, global, restrict
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x50
/*000000000010*/ s_lshl_b32      s1, s6, 6
/*000000000014*/ s_load_dwordx4  s[4:7], s[4:5], 0x30
/*00000000001c*/ s_waitcnt       lgkmcnt(0)
/*000000000020*/ s_add_u32       s0, s1, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 4, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ v_cvt_i32_f32   v2, s4
/*000000000044*/ v_cvt_i32_f32   v3, s5
/*000000000048*/ v_cvt_i32_f32   v4, s6
/*00000000004c*/ v_cvt_i32_f32   v5, s7
/*000000000050*/ flat_store_dwordx4 v[0:1], v[2:5]
/*000000000058*/ s_endpgm
