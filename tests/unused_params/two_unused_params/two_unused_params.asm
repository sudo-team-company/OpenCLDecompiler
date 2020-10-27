/* Disassembling 'unused_params\two_unused_params\two_unused_params.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel two_unused_params
    .config
        .dims xy
        .sgprsnum 20
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x00000990
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
        .arg n, "int", int
        .arg w, "int", int
        .arg z, "int", int
        .arg data, "int*", int*, global, 
        .arg data1, "int*", int*, global, , rdonly
        .arg x, "int", int
        .arg y, "int", int
    .text
/*000000000000*/ s_load_dword    s0, s[4:5], 0x4
/*000000000008*/ s_load_dwordx2  s[2:3], s[6:7], 0x0
/*000000000010*/ s_load_dword    s1, s[6:7], 0x30
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_and_b32       s3, s0, 0xffff
/*000000000024*/ s_mul_i32       s3, s3, s8
/*000000000028*/ s_add_u32       s2, s3, s2
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_cmp_gt_i32    vcc, s1, v0
/*000000000034*/ s_load_dwordx2  s[2:3], s[6:7], 0x40
/*00000000003c*/ s_and_saveexec_b64 s[4:5], vcc
/*000000000040*/ s_cbranch_execz .L116_0
/*000000000044*/ s_load_dword    s1, s[6:7], 0x50
/*00000000004c*/ v_ashrrev_i32   v1, 31, v0
/*000000000050*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000058*/ s_waitcnt       lgkmcnt(0)
/*00000000005c*/ v_add_u32       v0, vcc, s2, v0
/*000000000060*/ v_mov_b32       v2, s3
/*000000000064*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000068*/ v_mov_b32       v2, s1
/*00000000006c*/ flat_store_dword v[0:1], v2
.L116_0:
/*000000000074*/ s_andn2_b64     exec, s[4:5], exec
/*000000000078*/ s_cbranch_execz .L232_0
/*00000000007c*/ s_load_dwordx2  s[10:11], s[6:7], 0x8
/*000000000084*/ s_bfe_u32       s0, s0, 0x100010
/*00000000008c*/ s_load_dwordx2  s[12:13], s[6:7], 0x48
/*000000000094*/ s_mul_i32       s0, s0, s9
/*000000000098*/ s_waitcnt       lgkmcnt(0)
/*00000000009c*/ s_add_u32       s0, s0, s10
/*0000000000a0*/ v_add_u32       v1, vcc, s0, v1
/*0000000000a4*/ v_mov_b32       v0, 0
/*0000000000a8*/ v_ashrrev_i64   v[0:1], 30, v[0:1]
/*0000000000b0*/ v_add_u32       v2, vcc, s12, v0
/*0000000000b4*/ v_mov_b32       v3, s13
/*0000000000b8*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*0000000000bc*/ flat_load_dword v2, v[2:3]
/*0000000000c4*/ s_load_dword    s0, s[6:7], 0x54
/*0000000000cc*/ v_add_u32       v0, vcc, s2, v0
/*0000000000d0*/ v_mov_b32       v3, s3
/*0000000000d4*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*0000000000d8*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000000dc*/ v_add_u32       v2, vcc, s0, v2
/*0000000000e0*/ flat_store_dword v[0:1], v2
.L232_0:
/*0000000000e8*/ s_endpgm
