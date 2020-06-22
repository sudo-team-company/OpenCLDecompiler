/* Disassembling 'if_1.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel localVarExample
    .config
        .dims xy
        .cws 16, 16, 1
        .sgprsnum 16
        .vgprsnum 5
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
        .arg data, "int*", int*, global, 
        .arg y, "int", int
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 4
/*000000000010*/ v_add_u32       v0, vcc, s1, v0
/*000000000014*/ s_lshl_b32      s1, s7, 4
/*000000000018*/ s_add_u32       s1, s1, s2
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_add_u32       v2, vcc, s1, v1
/*000000000024*/ v_cmp_eq_i32    vcc, 1, v0
/*000000000028*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000030*/ s_load_dword    s2, s[4:5], 0x30
/*000000000038*/ s_and_saveexec_b64 s[6:7], vcc
/*00000000003c*/ s_cbranch_execz .L120_0
/*000000000040*/ s_load_dword    s3, s[4:5], 0x40
/*000000000048*/ s_waitcnt       lgkmcnt(0)
/*00000000004c*/ v_mul_lo_u32    v3, v2, s2
/*000000000054*/ v_mov_b32       v1, 0
/*000000000058*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000060*/ v_add_u32       v0, vcc, s0, v0
/*000000000064*/ v_mov_b32       v4, s1
/*000000000068*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*00000000006c*/ v_subrev_u32    v3, vcc, s3, v3
/*000000000070*/ flat_store_dword v[0:1], v3
.L120_0:
/*000000000078*/ s_mov_b64       exec, s[6:7]
/*00000000007c*/ v_mov_b32       v3, 0
/*000000000080*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*000000000088*/ s_waitcnt       lgkmcnt(0)
/*00000000008c*/ v_add_u32       v0, vcc, s0, v0
/*000000000090*/ v_mov_b32       v2, s1
/*000000000094*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000098*/ v_mov_b32       v2, s2
/*00000000009c*/ flat_store_dword v[0:1], v2
/*0000000000a4*/ s_endpgm
