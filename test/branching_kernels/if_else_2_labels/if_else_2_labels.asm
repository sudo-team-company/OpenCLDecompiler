/* Disassembling 'if_else_2_labels.bin' */
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
        .vgprsnum 6
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
/*000000000028*/ s_load_dword    s0, s[4:5], 0x30
/*000000000030*/ s_load_dword    s1, s[4:5], 0x40
/*000000000038*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000040*/ s_and_saveexec_b64 s[4:5], vcc
/*000000000044*/ v_mov_b32       v1, 0
/*000000000048*/ s_cbranch_execz .L112_0
/*00000000004c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000054*/ s_waitcnt       lgkmcnt(0)
/*000000000058*/ v_add_u32       v0, vcc, s2, v0
/*00000000005c*/ v_mov_b32       v3, s3
/*000000000060*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000064*/ v_mul_lo_u32    v3, v2, s0
/*00000000006c*/ v_subrev_u32    v4, vcc, s1, v3
.L112_0:
/*000000000070*/ s_andn2_b64     exec, s[4:5], exec
/*000000000074*/ s_cbranch_execz .L156_0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_mul_i32       s1, s1, s0
/*000000000080*/ v_mov_b32       v1, 0
/*000000000084*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000008c*/ v_add_u32       v0, vcc, s2, v0
/*000000000090*/ v_mov_b32       v3, s3
/*000000000094*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000098*/ v_mov_b32       v4, s1
.L156_0:
/*00000000009c*/ s_mov_b64       exec, s[4:5]
/*0000000000a0*/ v_mov_b32       v3, 0
/*0000000000a4*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*0000000000ac*/ s_waitcnt       lgkmcnt(0)
/*0000000000b0*/ v_add_u32       v2, vcc, s2, v2
/*0000000000b4*/ v_mov_b32       v5, s3
/*0000000000b8*/ v_addc_u32      v3, vcc, v5, v3, vcc
/*0000000000bc*/ v_mov_b32       v5, s0
/*0000000000c0*/ flat_store_dword v[0:1], v4
/*0000000000c8*/ flat_store_dword v[2:3], v5
/*0000000000d0*/ s_endpgm
