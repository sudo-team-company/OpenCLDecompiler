/* Disassembling 'branching_kernels\if_else_in_else_of_if_else\if_else_in_else_of_if_else-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel if_else_in_else_of_if_else_1
    .config
        .dims xyz
        .sgprsnum 24
        .vgprsnum 8
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0081
        .pgmrsrc2 0x0000138c
        .codeversion 1, 2
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 12
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_else_in_else_of_if_else_1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 12
        .max_flat_work_group_size 64
        .arg x, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg y, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel if_else_in_else_of_if_else_2
    .config
        .dims xyz
        .sgprsnum 24
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0080
        .pgmrsrc2 0x0000138c
        .codeversion 1, 2
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 8
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_else_in_else_of_if_else_2@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 8
        .max_flat_work_group_size 64
        .arg x, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg y, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
if_else_in_else_of_if_else_1:
.skip 256
/*000000000100*/ s_clause        0x3
/*000000000104*/ s_load_dwordx4  s[12:15], s[4:5], 0x18
/*00000000010c*/ s_load_dword    s0, s[4:5], 0x0
/*000000000114*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*00000000011c*/ s_load_dword    s1, s[4:5], 0x10
/*000000000124*/ v_lshl_or_b32   v0, s6, 2, v0
/*00000000012c*/ v_lshl_or_b32   v1, s7, 2, v1
/*000000000134*/ s_waitcnt       lgkmcnt(0)
/*000000000138*/ v_add_co_u32    v6, s[6:7], s12, v0
/*000000000140*/ v_add_co_u32    v0, s[6:7], s14, v1
/*000000000148*/ v_cmp_lg_u32    vcc, 1, v6
/*00000000014c*/ s_and_saveexec_b32 s6, vcc_lo
/*000000000150*/ s_xor_b32       s6, exec_lo, s6
/*000000000154*/ s_cbranch_execz .L444_0
/*000000000158*/ s_load_dwordx2  s[4:5], s[4:5], 0x28
/*000000000160*/ v_mov_b32       v7, 0
/*000000000164*/ v_lshl_or_b32   v5, s8, 2, v2
/*00000000016c*/ v_mul_lo_u32    v11, v6, s1
/*000000000174*/ s_cmp_ge_i32    s0, s1
/*000000000178*/ v_lshlrev_b64   v[3:4], 2, v[6:7]
/*000000000180*/ v_add_co_u32    v1, vcc, s2, v3
/*000000000188*/ v_add_co_ci_u32 v2, vcc, s3, v4, vcc
/*00000000018c*/ global_store_dword v[1:2], v11, off
/*000000000194*/ s_waitcnt       lgkmcnt(0)
/*000000000198*/ v_add_co_u32    v4, s[4:5], s4, v5
/*0000000001a0*/ s_cbranch_scc0  .L436_0
/*0000000001a4*/ v_add_nc_u32    v3, s1, v0
/*0000000001a8*/ v_mov_b32       v5, v7
/*0000000001ac*/ s_cbranch_execz .L436_0
/*0000000001b0*/ s_branch        .L444_0
.L436_0:
/*0000000001b4*/ v_add_nc_u32    v3, s0, v4
/*0000000001b8*/ v_mov_b32       v5, 0
.L444_0:
/*0000000001bc*/ s_or_saveexec_b32 s4, s6
/*0000000001c0*/ s_xor_b32       exec_lo, exec_lo, s4
/*0000000001c4*/ v_mul_lo_u32    v1, v0, s0
/*0000000001cc*/ v_mov_b32       v4, 1
/*0000000001d0*/ v_mov_b32       v5, 0
/*0000000001d4*/ v_subrev_nc_u32 v3, s1, v1
/*0000000001d8*/ s_or_b32        exec_lo, exec_lo, s4
/*0000000001dc*/ v_mov_b32       v1, 0
/*0000000001e0*/ v_lshlrev_b64   v[4:5], 2, v[4:5]
/*0000000001e8*/ v_mov_b32       v2, s0
/*0000000001ec*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000001f4*/ v_add_co_u32    v4, vcc, s2, v4
/*0000000001fc*/ v_add_co_ci_u32 v5, vcc, s3, v5, vcc
/*000000000200*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000208*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*00000000020c*/ global_store_dword v[4:5], v3, off
/*000000000214*/ global_store_dword v[0:1], v2, off
/*00000000021c*/ s_endpgm
/*000000000220*/ s_nop           0x0
/*000000000224*/ s_nop           0x0
/*000000000228*/ s_nop           0x0
/*00000000022c*/ s_nop           0x0
/*000000000230*/ s_nop           0x0
/*000000000234*/ s_nop           0x0
/*000000000238*/ s_nop           0x0
/*00000000023c*/ s_nop           0x0
/*000000000240*/ s_nop           0x0
/*000000000244*/ s_nop           0x0
/*000000000248*/ s_nop           0x0
/*00000000024c*/ s_nop           0x0
/*000000000250*/ s_nop           0x0
/*000000000254*/ s_nop           0x0
/*000000000258*/ s_nop           0x0
/*00000000025c*/ s_nop           0x0
/*000000000260*/ s_nop           0x0
/*000000000264*/ s_nop           0x0
/*000000000268*/ s_nop           0x0
/*00000000026c*/ s_nop           0x0
/*000000000270*/ s_nop           0x0
/*000000000274*/ s_nop           0x0
/*000000000278*/ s_nop           0x0
/*00000000027c*/ s_nop           0x0
/*000000000280*/ s_nop           0x0
/*000000000284*/ s_nop           0x0
/*000000000288*/ s_nop           0x0
/*00000000028c*/ s_nop           0x0
/*000000000290*/ s_nop           0x0
/*000000000294*/ s_nop           0x0
/*000000000298*/ s_nop           0x0
/*00000000029c*/ s_nop           0x0
/*0000000002a0*/ s_nop           0x0
/*0000000002a4*/ s_nop           0x0
/*0000000002a8*/ s_nop           0x0
/*0000000002ac*/ s_nop           0x0
/*0000000002b0*/ s_nop           0x0
/*0000000002b4*/ s_nop           0x0
/*0000000002b8*/ s_nop           0x0
/*0000000002bc*/ s_nop           0x0
/*0000000002c0*/ s_nop           0x0
/*0000000002c4*/ s_nop           0x0
/*0000000002c8*/ s_nop           0x0
/*0000000002cc*/ s_nop           0x0
/*0000000002d0*/ s_nop           0x0
/*0000000002d4*/ s_nop           0x0
/*0000000002d8*/ s_nop           0x0
/*0000000002dc*/ s_nop           0x0
/*0000000002e0*/ s_nop           0x0
/*0000000002e4*/ s_nop           0x0
/*0000000002e8*/ s_nop           0x0
/*0000000002ec*/ s_nop           0x0
/*0000000002f0*/ s_nop           0x0
/*0000000002f4*/ s_nop           0x0
/*0000000002f8*/ s_nop           0x0
/*0000000002fc*/ s_nop           0x0
if_else_in_else_of_if_else_2:
.skip 256
/*000000000400*/ s_clause        0x4
/*000000000404*/ s_load_dwordx2  s[10:11], s[4:5], 0x18
/*00000000040c*/ s_load_dwordx4  s[12:15], s[4:5], 0x20
/*000000000414*/ s_load_dword    s2, s[4:5], 0x0
/*00000000041c*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000424*/ s_load_dword    s3, s[4:5], 0x10
/*00000000042c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000434*/ v_lshl_or_b32   v2, s8, 2, v2
/*00000000043c*/ v_lshl_or_b32   v4, s7, 2, v1
/*000000000444*/ s_waitcnt       lgkmcnt(0)
/*000000000448*/ v_add_co_u32    v1, s[4:5], s10, v0
/*000000000450*/ v_add_co_u32    v3, s[4:5], s14, v2
/*000000000458*/ v_add_co_u32    v0, s[4:5], s12, v4
/*000000000460*/ v_cmp_lg_u32    vcc, 1, v1
/*000000000464*/ s_and_saveexec_b32 s4, vcc_lo
/*000000000468*/ s_xor_b32       s4, exec_lo, s4
/*00000000046c*/ s_cbranch_execz .L1232_0
/*000000000470*/ v_mov_b32       v2, 0
/*000000000474*/ v_mul_lo_u32    v7, v1, s3
/*00000000047c*/ v_lshlrev_b64   v[4:5], 2, v[1:2]
/*000000000484*/ v_add_co_u32    v1, vcc, s0, v4
/*00000000048c*/ v_add_co_ci_u32 v2, vcc, s1, v5, vcc
/*000000000490*/ v_cmp_ge_u32    vcc, v0, v3
/*000000000494*/ global_store_dword v[1:2], v7, off
/*00000000049c*/ s_and_saveexec_b32 s5, vcc_lo
/*0000000004a0*/ s_xor_b32       s5, exec_lo, s5
/*0000000004a4*/ v_mov_b32       v1, 0
/*0000000004a8*/ v_add_nc_u32    v2, s3, v0
/*0000000004ac*/ v_mov_b32       v5, v1
/*0000000004b0*/ v_mov_b32       v4, v0
/*0000000004b4*/ s_or_saveexec_b32 s5, s5
/*0000000004b8*/ s_xor_b32       exec_lo, exec_lo, s5
/*0000000004bc*/ v_mov_b32       v4, 0
/*0000000004c0*/ v_add_nc_u32    v2, s2, v3
/*0000000004c4*/ v_mov_b32       v5, v4
/*0000000004c8*/ v_mov_b32       v4, v3
/*0000000004cc*/ s_or_b32        exec_lo, exec_lo, s5
.L1232_0:
/*0000000004d0*/ s_or_saveexec_b32 s4, s4
/*0000000004d4*/ s_xor_b32       exec_lo, exec_lo, s4
/*0000000004d8*/ v_mul_lo_u32    v0, v0, s2
/*0000000004e0*/ v_mov_b32       v4, 1
/*0000000004e4*/ v_mov_b32       v5, 0
/*0000000004e8*/ v_subrev_nc_u32 v2, s3, v0
/*0000000004ec*/ s_or_b32        exec_lo, exec_lo, s4
/*0000000004f0*/ v_lshlrev_b64   v[0:1], 2, v[4:5]
/*0000000004f8*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000500*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000504*/ global_store_dword v[0:1], v2, off
/*00000000050c*/ s_endpgm
/*000000000510*/ s_code_end
/*000000000514*/ s_code_end
/*000000000518*/ s_code_end
/*00000000051c*/ s_code_end
/*000000000520*/ s_code_end
/*000000000524*/ s_code_end
/*000000000528*/ s_code_end
/*00000000052c*/ s_code_end
/*000000000530*/ s_code_end
/*000000000534*/ s_code_end
/*000000000538*/ s_code_end
/*00000000053c*/ s_code_end
/*000000000540*/ s_code_end
/*000000000544*/ s_code_end
/*000000000548*/ s_code_end
/*00000000054c*/ s_code_end
/*000000000550*/ s_code_end
/*000000000554*/ s_code_end
/*000000000558*/ s_code_end
/*00000000055c*/ s_code_end
/*000000000560*/ s_code_end
/*000000000564*/ s_code_end
/*000000000568*/ s_code_end
/*00000000056c*/ s_code_end
/*000000000570*/ s_code_end
/*000000000574*/ s_code_end
/*000000000578*/ s_code_end
/*00000000057c*/ s_code_end
/*000000000580*/ s_code_end
/*000000000584*/ s_code_end
/*000000000588*/ s_code_end
/*00000000058c*/ s_code_end
/*000000000590*/ s_code_end
/*000000000594*/ s_code_end
/*000000000598*/ s_code_end
/*00000000059c*/ s_code_end
/*0000000005a0*/ s_code_end
/*0000000005a4*/ s_code_end
/*0000000005a8*/ s_code_end
/*0000000005ac*/ s_code_end
/*0000000005b0*/ s_code_end
/*0000000005b4*/ s_code_end
/*0000000005b8*/ s_code_end
/*0000000005bc*/ s_code_end
/*0000000005c0*/ s_code_end
/*0000000005c4*/ s_code_end
/*0000000005c8*/ s_code_end
/*0000000005cc*/ s_code_end
/*0000000005d0*/ s_code_end
/*0000000005d4*/ s_code_end
/*0000000005d8*/ s_code_end
/*0000000005dc*/ s_code_end
/*0000000005e0*/ s_code_end
/*0000000005e4*/ s_code_end
/*0000000005e8*/ s_code_end
/*0000000005ec*/ s_code_end
/*0000000005f0*/ s_code_end
/*0000000005f4*/ s_code_end
/*0000000005f8*/ s_code_end
/*0000000005fc*/ s_code_end
