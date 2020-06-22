/* Disassembling 'if_else_0_labels.bin' */
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
        .vgprsnum 7
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
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x30
/*000000000014*/ s_lshl_b32      s3, s7, 4
/*000000000018*/ s_add_u32       s2, s3, s2
/*00000000001c*/ s_load_dword    s3, s[4:5], 0x40
/*000000000024*/ v_add_u32       v1, vcc, s2, v1
/*000000000028*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000030*/ s_lshl_b32      s2, s6, 4
/*000000000034*/ s_waitcnt       lgkmcnt(0)
/*000000000038*/ v_mul_lo_u32    v2, v1, s1
/*000000000040*/ v_add_u32       v0, vcc, s2, v0
/*000000000044*/ v_add_u32       v5, vcc, s0, v0
/*000000000048*/ v_mov_b32       v6, 0
/*00000000004c*/ v_lshlrev_b64   v[3:4], 2, v[5:6]
/*000000000054*/ v_cmp_lg_i32    s[6:7], v5, 1
/*00000000005c*/ v_subrev_u32    v0, vcc, s3, v2
/*000000000060*/ v_mov_b32       v2, s3
/*000000000064*/ v_add_u32       v3, vcc, s4, v3
/*000000000068*/ v_mov_b32       v5, s5
/*00000000006c*/ v_addc_u32      v4, vcc, v5, v4, vcc
/*000000000070*/ v_cndmask_b32   v0, v0, v2, s[6:7]
/*000000000078*/ v_mov_b32       v2, 0
/*00000000007c*/ v_lshlrev_b64   v[1:2], 2, v[1:2]
/*000000000084*/ v_add_u32       v1, vcc, s4, v1
/*000000000088*/ v_addc_u32      v2, vcc, v5, v2, vcc
/*00000000008c*/ v_mov_b32       v5, s1
/*000000000090*/ flat_store_dword v[3:4], v0
/*000000000098*/ flat_store_dword v[1:2], v5
/*0000000000a0*/ s_endpgm
