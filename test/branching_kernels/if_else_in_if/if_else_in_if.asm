/* Disassembling 'if_else_in_if.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel localVarExample
    .config
        .dims xyz
        .cws 16, 16, 16
        .sgprsnum 20
        .vgprsnum 5
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
        .arg y, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 4
/*000000000010*/ v_add_u32       v0, vcc, s1, v0
/*000000000014*/ v_add_u32       v3, vcc, s0, v0
/*000000000018*/ v_cmp_eq_i32    vcc, 0, v3
/*00000000001c*/ s_load_dwordx2  s[0:1], s[4:5], 0x38
/*000000000024*/ s_load_dword    s2, s[4:5], 0x40
/*00000000002c*/ s_and_saveexec_b64 s[10:11], vcc
/*000000000030*/ s_cbranch_execz .L220_0
/*000000000034*/ s_load_dwordx2  s[12:13], s[4:5], 0x8
/*00000000003c*/ s_lshl_b32      s3, s7, 4
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ s_add_u32       s3, s3, s12
/*000000000048*/ v_add_u32       v0, vcc, s3, v1
/*00000000004c*/ v_mov_b32       v1, 0
/*000000000050*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000058*/ v_add_u32       v0, vcc, s0, v0
/*00000000005c*/ v_mov_b32       v4, s1
/*000000000060*/ v_addc_u32      v1, vcc, v4, v1, vcc
/*000000000064*/ flat_load_dword v4, v[0:1]
/*00000000006c*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000070*/ v_cmp_gt_i32    vcc, s2, v4
/*000000000074*/ s_and_saveexec_b64 s[6:7], vcc
/*000000000078*/ s_cbranch_execz .L200_0
/*00000000007c*/ s_load_dwordx2  s[12:13], s[4:5], 0x10
/*000000000084*/ s_lshl_b32      s3, s8, 4
/*000000000088*/ s_load_dword    s4, s[4:5], 0x30
/*000000000090*/ v_add_u32       v0, vcc, s3, v2
/*000000000094*/ s_waitcnt       lgkmcnt(0)
/*000000000098*/ v_add_u32       v0, vcc, v0, s12
/*0000000000a0*/ v_mov_b32       v1, s13
/*0000000000a4*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*0000000000a8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000b0*/ v_add_u32       v0, vcc, s0, v0
/*0000000000b4*/ v_mov_b32       v2, s1
/*0000000000b8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000000bc*/ v_mov_b32       v2, s4
/*0000000000c0*/ flat_store_dword v[0:1], v2
.L200_0:
/*0000000000c8*/ s_andn2_b64     exec, s[6:7], exec
/*0000000000cc*/ v_mov_b32       v2, 0
/*0000000000d0*/ s_cbranch_execz .L220_0
/*0000000000d4*/ flat_store_dword v[0:1], v2
.L220_0:
/*0000000000dc*/ s_mov_b64       exec, s[10:11]
/*0000000000e0*/ v_mov_b32       v0, v3
/*0000000000e4*/ v_mov_b32       v1, 0
/*0000000000e8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000000f0*/ s_waitcnt       lgkmcnt(0)
/*0000000000f4*/ v_add_u32       v0, vcc, s0, v0
/*0000000000f8*/ v_mov_b32       v2, s1
/*0000000000fc*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000100*/ v_mov_b32       v2, s2
/*000000000104*/ flat_store_dword v[0:1], v2
/*00000000010c*/ s_endpgm
