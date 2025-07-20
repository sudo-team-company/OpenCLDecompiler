.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel if_else_in_if_and_else_of_if_else_1
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
        .machine 1, 10, 1, 0
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
        .md_symname "if_else_in_if_and_else_of_if_else_1@kd"
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
.kernel if_else_in_if_and_else_of_if_else_2
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
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 10
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_else_in_if_and_else_of_if_else_2@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 10
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
if_else_in_if_and_else_of_if_else_1:
.skip 256
/*000000000100*/ s_clause        0x4
/*000000000104*/ s_load_dwordx4  s[12:15], s[4:5], 0x18
/*00000000010c*/ s_load_dwordx2  s[10:11], s[4:5], 0x28
/*000000000114*/ s_load_dword    s0, s[4:5], 0x0
/*00000000011c*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*000000000124*/ s_load_dword    s1, s[4:5], 0x10
/*00000000012c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000134*/ v_lshl_or_b32   v2, s8, 2, v2
/*00000000013c*/ v_lshl_or_b32   v1, s7, 2, v1
/*000000000144*/ s_waitcnt       lgkmcnt(0)
/*000000000148*/ v_add_co_u32    v3, s[4:5], s12, v0
/*000000000150*/ v_add_co_u32    v0, s[4:5], s14, v1
/*000000000158*/ v_add_co_u32    v2, s[4:5], s10, v2
/*000000000160*/ v_cmp_lg_u32    vcc, 1, v3
/*000000000164*/ s_and_saveexec_b32 s4, vcc_lo
/*000000000168*/ s_xor_b32       s4, exec_lo, s4
/*00000000016c*/ s_cbranch_execz .L432_0
/*000000000170*/ v_mov_b32       v4, 0
/*000000000174*/ v_mul_lo_u32    v1, v3, s1
/*00000000017c*/ s_cmp_ge_i32    s0, s1
/*000000000180*/ v_lshlrev_b64   v[4:5], 2, v[3:4]
/*000000000188*/ v_add_co_u32    v3, vcc, s2, v4
/*000000000190*/ v_add_co_ci_u32 v4, vcc, s3, v5, vcc
/*000000000194*/ global_store_dword v[3:4], v1, off
/*00000000019c*/ s_cbranch_scc0  .L428_0
/*0000000001a0*/ v_add_nc_u32    v4, s1, v0
/*0000000001a4*/ s_cbranch_execz .L428_0
/*0000000001a8*/ s_branch        .L432_0
.L428_0:
/*0000000001ac*/ v_add_nc_u32    v4, s0, v2
.L432_0:
/*0000000001b0*/ s_or_saveexec_b32 s4, s4
/*0000000001b4*/ s_waitcnt_decptr 0xffe3
/*0000000001b8*/ s_xor_b32       exec_lo, exec_lo, s4
/*0000000001bc*/ s_cbranch_execz .L508_0
/*0000000001c0*/ v_mul_lo_u32    v1, v0, s0
/*0000000001c8*/ v_mov_b32       v4, s3
/*0000000001cc*/ v_mov_b32       v3, s2
/*0000000001d0*/ s_cmp_ge_i32    s0, s1
/*0000000001d4*/ v_subrev_nc_u32 v1, s1, v1
/*0000000001d8*/ global_store_dword v[3:4], v1, off inst_offset:4
/*0000000001e0*/ s_cbranch_scc0  .L500_0
/*0000000001e4*/ v_mul_lo_u32    v4, v0, s1
/*0000000001ec*/ s_cbranch_execz .L500_0
/*0000000001f0*/ s_branch        .L508_0
.L500_0:
/*0000000001f4*/ v_mul_lo_u32    v4, v2, s0
.L508_0:
/*0000000001fc*/ s_waitcnt_decptr 0xffe3
/*000000000200*/ s_or_b32        exec_lo, exec_lo, s4
/*000000000204*/ v_mov_b32       v3, 0
/*000000000208*/ v_mov_b32       v7, s0
/*00000000020c*/ v_mov_b32       v1, v3
/*000000000210*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*000000000218*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000220*/ v_add_co_u32    v2, vcc, s2, v2
/*000000000228*/ v_add_co_ci_u32 v3, vcc, s3, v3, vcc
/*00000000022c*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000234*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*000000000238*/ global_store_dword v[2:3], v4, off
/*000000000240*/ global_store_dword v[0:1], v7, off
/*000000000248*/ s_endpgm
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
if_else_in_if_and_else_of_if_else_2:
.skip 256
/*000000000400*/ s_clause        0x4
/*000000000404*/ s_load_dwordx4  s[12:15], s[4:5], 0x18
/*00000000040c*/ s_load_dwordx2  s[10:11], s[4:5], 0x28
/*000000000414*/ s_load_dword    s2, s[4:5], 0x0
/*00000000041c*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000424*/ s_load_dword    s3, s[4:5], 0x10
/*00000000042c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000434*/ v_lshl_or_b32   v2, s8, 2, v2
/*00000000043c*/ s_waitcnt       lgkmcnt(0)
/*000000000440*/ v_add_co_u32    v3, s[4:5], s12, v0
/*000000000448*/ s_lshl_b32      s4, s7, 2
/*00000000044c*/ v_add3_u32      v1, s14, s4, v1
/*000000000454*/ v_add_co_u32    v0, s[4:5], s10, v2
/*00000000045c*/ v_cmp_lg_u32    vcc, 1, v3
/*000000000460*/ s_and_saveexec_b32 s4, vcc_lo
/*000000000464*/ s_xor_b32       s4, exec_lo, s4
/*000000000468*/ s_cbranch_execz .L1208_0
/*00000000046c*/ v_mov_b32       v4, 0
/*000000000470*/ v_mul_lo_u32    v9, v3, s3
/*000000000478*/ v_lshlrev_b64   v[4:5], 2, v[3:4]
/*000000000480*/ v_add_co_u32    v2, vcc, s0, v4
/*000000000488*/ v_add_co_ci_u32 v3, vcc, s1, v5, vcc
/*00000000048c*/ v_cmp_lg_u32    vcc, v1, v0
/*000000000490*/ global_store_dword v[2:3], v9, off
/*000000000498*/ s_and_saveexec_b32 s5, vcc_lo
/*00000000049c*/ s_xor_b32       s5, exec_lo, s5
/*0000000004a0*/ v_add_nc_u32    v2, s3, v1
/*0000000004a4*/ s_or_saveexec_b32 s5, s5
/*0000000004a8*/ s_waitcnt_decptr 0xffe3
/*0000000004ac*/ s_xor_b32       exec_lo, exec_lo, s5
/*0000000004b0*/ v_add_nc_u32    v2, s2, v1
/*0000000004b4*/ s_or_b32        exec_lo, exec_lo, s5
.L1208_0:
/*0000000004b8*/ s_or_saveexec_b32 s4, s4
/*0000000004bc*/ s_xor_b32       exec_lo, exec_lo, s4
/*0000000004c0*/ s_cbranch_execz .L1292_0
/*0000000004c4*/ v_mul_lo_u32    v2, v1, s2
/*0000000004cc*/ v_cmp_ge_u32    vcc, v1, v0
/*0000000004d0*/ v_subrev_nc_u32 v4, s3, v2
/*0000000004d4*/ v_mov_b32       v3, s1
/*0000000004d8*/ v_mov_b32       v2, s0
/*0000000004dc*/ global_store_dword v[2:3], v4, off inst_offset:4
/*0000000004e4*/ s_and_saveexec_b32 s5, vcc_lo
/*0000000004e8*/ s_xor_b32       s5, exec_lo, s5
/*0000000004ec*/ v_mul_lo_u32    v2, v1, s3
/*0000000004f4*/ s_or_saveexec_b32 s3, s5
/*0000000004f8*/ s_waitcnt_decptr 0xffe3
/*0000000004fc*/ s_xor_b32       exec_lo, exec_lo, s3
/*000000000500*/ v_mul_lo_u32    v2, v0, s2
/*000000000508*/ s_or_b32        exec_lo, exec_lo, s3
.L1292_0:
/*00000000050c*/ s_or_b32        exec_lo, exec_lo, s4
/*000000000510*/ v_mov_b32       v1, 0
/*000000000514*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000051c*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000524*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000528*/ global_store_dword v[0:1], v2, off
/*000000000530*/ s_endpgm
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
