/* Disassembling 'different_flags\flag_auto_parse\flag_auto_parse.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel sum
    .config
        .dims , x
        .sgprsnum 16
        .vgprsnum 8
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x00000010
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
        .arg A, "short*", short*, global, const, rdonly
        .arg C, "ulong*", ulong*, global, 
        .arg size, "uint", uint
        .arg L, "ulong*", ulong*, local, 
    .text
/*000000000000*/ s_mov_b32       m0, 0x10000
/*000000000008*/ s_load_dword    s0, s[4:5], 0x4
/*000000000010*/ s_load_dword    s1, s[6:7], 0x40
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_and_b32       s0, s0, 0xffff
/*000000000024*/ v_cmp_gt_u32    vcc, s1, v0
/*000000000028*/ s_and_saveexec_b64 s[2:3], vcc
/*00000000002c*/ s_cbranch_execz .L168_0
/*000000000030*/ s_load_dwordx2  s[4:5], s[6:7], 0x30
/*000000000038*/ s_mov_b64       s[8:9], exec
/*00000000003c*/ v_mov_b32       v1, 0
/*000000000040*/ v_mov_b32       v2, 0
/*000000000044*/ v_mov_b32       v3, v0
/*000000000048*/ s_nop           0x0
/*00000000004c*/ s_nop           0x0
/*000000000050*/ s_nop           0x0
/*000000000054*/ s_nop           0x0
/*000000000058*/ s_nop           0x0
/*00000000005c*/ s_nop           0x0
.L96_0:
/*000000000060*/ v_ashrrev_i32   v4, 31, v3
/*000000000064*/ v_lshlrev_b64   v[4:5], 1, v[3:4]
/*00000000006c*/ s_waitcnt       lgkmcnt(0)
/*000000000070*/ v_add_u32       v4, vcc, s4, v4
/*000000000074*/ v_mov_b32       v6, s5
/*000000000078*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*00000000007c*/ flat_load_sshort v4, v[4:5]
/*000000000084*/ v_add_u32       v3, vcc, s0, v3
/*000000000088*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*00000000008c*/ v_ashrrev_i32   v5, 31, v4
/*000000000090*/ v_add_u32       v1, vcc, v4, v1
/*000000000094*/ v_addc_u32      v2, vcc, v5, v2, vcc
/*000000000098*/ v_cmp_gt_u32    vcc, s1, v3
/*00000000009c*/ s_and_b64       exec, exec, vcc
/*0000000000a0*/ s_cbranch_execnz .L96_0
/*0000000000a4*/ s_mov_b64       exec, s[8:9]
.L168_0:
/*0000000000a8*/ s_andn2_b64     exec, s[2:3], exec
/*0000000000ac*/ v_mov_b32       v1, 0
/*0000000000b0*/ v_mov_b32       v2, 0
/*0000000000b4*/ s_mov_b64       exec, s[2:3]
/*0000000000b8*/ s_load_dword    s1, s[6:7], 0x48
/*0000000000c0*/ v_lshlrev_b32   v3, 3, v0
/*0000000000c4*/ s_lshr_b32      s0, s0, 1
/*0000000000c8*/ s_waitcnt       lgkmcnt(0)
/*0000000000cc*/ v_add_u32       v3, vcc, s1, v3
/*0000000000d0*/ ds_write_b64    v3, v[1:2]
/*0000000000d8*/ s_cmp_eq_i32    s0, 0
/*0000000000dc*/ s_cbranch_scc1  .L348_0
/*0000000000e0*/ v_mov_b32       v1, 0
/*0000000000e4*/ s_nop           0x0
/*0000000000e8*/ s_nop           0x0
/*0000000000ec*/ s_nop           0x0
/*0000000000f0*/ s_nop           0x0
/*0000000000f4*/ s_nop           0x0
/*0000000000f8*/ s_nop           0x0
/*0000000000fc*/ s_nop           0x0
.L256_0:
/*000000000100*/ s_waitcnt       lgkmcnt(0)
/*000000000104*/ s_barrier
/*000000000108*/ v_mov_b32       v4, s0
/*00000000010c*/ v_mov_b32       v5, 0
/*000000000110*/ v_cmp_gt_u64    vcc, v[4:5], v[0:1]
/*000000000114*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000118*/ v_add_u32       v4, vcc, s0, v0
/*00000000011c*/ s_cbranch_execz .L332_0
/*000000000120*/ v_lshlrev_b32   v4, 3, v4
/*000000000124*/ v_add_u32       v4, vcc, s1, v4
/*000000000128*/ ds_read_b64     v[4:5], v4
/*000000000130*/ ds_read_b64     v[6:7], v3
/*000000000138*/ s_waitcnt       lgkmcnt(0)
/*00000000013c*/ v_add_u32       v4, vcc, v6, v4
/*000000000140*/ v_addc_u32      v5, vcc, v7, v5, vcc
/*000000000144*/ ds_write_b64    v3, v[4:5]
.L332_0:
/*00000000014c*/ s_mov_b64       exec, s[2:3]
/*000000000150*/ s_lshr_b32      s0, s0, 1
/*000000000154*/ s_cmp_eq_i32    s0, 0
/*000000000158*/ s_cbranch_scc0  .L256_0
.L348_0:
/*00000000015c*/ v_cmp_eq_i32    vcc, 0, v0
/*000000000160*/ s_and_saveexec_b64 s[2:3], vcc
/*000000000164*/ v_mov_b32       v0, s1
/*000000000168*/ s_cbranch_execz .L400_0
/*00000000016c*/ s_load_dwordx2  s[0:1], s[6:7], 0x38
/*000000000174*/ ds_read_b64     v[0:1], v0
/*00000000017c*/ s_waitcnt       lgkmcnt(0)
/*000000000180*/ v_mov_b32       v2, s0
/*000000000184*/ v_mov_b32       v3, s1
/*000000000188*/ flat_store_dwordx2 v[2:3], v[0:1]
.L400_0:
/*000000000190*/ s_waitcnt       lgkmcnt(0)
/*000000000194*/ s_barrier
/*000000000198*/ s_endpgm
