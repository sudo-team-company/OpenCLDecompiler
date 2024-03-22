/* Disassembling 'loops_kernels\simple_loop_1_kernels\simple_loop_1_kernels-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel loop_coherent_body_kernel
    .config
        .dims x
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 9
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_coherent_body_kernel@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 3
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg iters_num, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel loop_incoherent_body_kernel
    .config
        .dims x
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 9
        .workitem_vgpr_count 5
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_incoherent_body_kernel@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 5
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg iters_num, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
loop_incoherent_body_kernel:
.skip 256
/*000000000100*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000108*/ s_waitcnt       lgkmcnt(0)
/*00000000010c*/ s_cmp_eq_u32    s2, 0
/*000000000110*/ s_cbranch_scc1  .L392_0
/*000000000114*/ s_clause        0x1
/*000000000118*/ s_load_dword    s3, s[4:5], 0x18
/*000000000120*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000128*/ s_lshl_b32      s6, s6, 6
/*00000000012c*/ v_mov_b32       v1, 0
/*000000000130*/ s_waitcnt       lgkmcnt(0)
/*000000000134*/ v_add3_u32      v0, s3, s6, v0
/*00000000013c*/ v_mul_lo_u32    v0, v0, s2
.L324_0:
/*000000000144*/ v_lshlrev_b64   v[2:3], 2, v[0:1]
/*00000000014c*/ v_add_nc_u32    v0, 1, v0
/*000000000150*/ s_add_i32       s2, s2, -1
/*000000000154*/ s_cmp_eq_u32    s2, 0
/*000000000158*/ v_add_co_u32    v2, vcc, s4, v2
/*000000000160*/ v_add_co_ci_u32 v3, vcc, s5, v3, vcc
/*000000000164*/ global_load_dword v4, v[2:3], off
/*00000000016c*/ s_waitcnt       vmcnt(0)
/*000000000170*/ v_mul_lo_u32    v4, v4, s0
/*000000000178*/ v_add_nc_u32    v4, s1, v4
/*00000000017c*/ global_store_dword v[2:3], v4, off
/*000000000184*/ s_cbranch_scc0  .L324_0
.L392_0:
/*000000000188*/ s_endpgm
/*00000000018c*/ s_nop           0x0
/*000000000190*/ s_nop           0x0
/*000000000194*/ s_nop           0x0
/*000000000198*/ s_nop           0x0
/*00000000019c*/ s_nop           0x0
/*0000000001a0*/ s_nop           0x0
/*0000000001a4*/ s_nop           0x0
/*0000000001a8*/ s_nop           0x0
/*0000000001ac*/ s_nop           0x0
/*0000000001b0*/ s_nop           0x0
/*0000000001b4*/ s_nop           0x0
/*0000000001b8*/ s_nop           0x0
/*0000000001bc*/ s_nop           0x0
/*0000000001c0*/ s_nop           0x0
/*0000000001c4*/ s_nop           0x0
/*0000000001c8*/ s_nop           0x0
/*0000000001cc*/ s_nop           0x0
/*0000000001d0*/ s_nop           0x0
/*0000000001d4*/ s_nop           0x0
/*0000000001d8*/ s_nop           0x0
/*0000000001dc*/ s_nop           0x0
/*0000000001e0*/ s_nop           0x0
/*0000000001e4*/ s_nop           0x0
/*0000000001e8*/ s_nop           0x0
/*0000000001ec*/ s_nop           0x0
/*0000000001f0*/ s_nop           0x0
/*0000000001f4*/ s_nop           0x0
/*0000000001f8*/ s_nop           0x0
/*0000000001fc*/ s_nop           0x0
loop_coherent_body_kernel:
.skip 256
/*000000000300*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000308*/ s_waitcnt       lgkmcnt(0)
/*00000000030c*/ s_cmp_eq_u32    s2, 0
/*000000000310*/ s_cbranch_scc1  .L892_0
/*000000000314*/ s_clause        0x1
/*000000000318*/ s_load_dword    s3, s[4:5], 0x18
/*000000000320*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000328*/ s_lshl_b32      s6, s6, 6
/*00000000032c*/ v_mov_b32       v1, 0
/*000000000330*/ s_waitcnt       lgkmcnt(0)
/*000000000334*/ v_add3_u32      v0, s3, s6, v0
/*00000000033c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000344*/ v_add_co_u32    v0, vcc, s4, v0
/*00000000034c*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000350*/ global_load_dword v2, v[0:1], off
.L856_0:
/*000000000358*/ s_waitcnt       vmcnt(0)
/*00000000035c*/ v_mul_lo_u32    v2, v2, s0
/*000000000364*/ s_add_i32       s2, s2, -1
/*000000000368*/ s_cmp_eq_u32    s2, 0
/*00000000036c*/ v_add_nc_u32    v2, s1, v2
/*000000000370*/ s_cbranch_scc0  .L856_0
/*000000000374*/ global_store_dword v[0:1], v2, off
.L892_0:
/*00000000037c*/ s_endpgm
/*000000000380*/ s_code_end
/*000000000384*/ s_code_end
/*000000000388*/ s_code_end
/*00000000038c*/ s_code_end
/*000000000390*/ s_code_end
/*000000000394*/ s_code_end
/*000000000398*/ s_code_end
/*00000000039c*/ s_code_end
/*0000000003a0*/ s_code_end
/*0000000003a4*/ s_code_end
/*0000000003a8*/ s_code_end
/*0000000003ac*/ s_code_end
/*0000000003b0*/ s_code_end
/*0000000003b4*/ s_code_end
/*0000000003b8*/ s_code_end
/*0000000003bc*/ s_code_end
/*0000000003c0*/ s_code_end
/*0000000003c4*/ s_code_end
/*0000000003c8*/ s_code_end
/*0000000003cc*/ s_code_end
/*0000000003d0*/ s_code_end
/*0000000003d4*/ s_code_end
/*0000000003d8*/ s_code_end
/*0000000003dc*/ s_code_end
/*0000000003e0*/ s_code_end
/*0000000003e4*/ s_code_end
/*0000000003e8*/ s_code_end
/*0000000003ec*/ s_code_end
/*0000000003f0*/ s_code_end
/*0000000003f4*/ s_code_end
/*0000000003f8*/ s_code_end
/*0000000003fc*/ s_code_end
/*000000000400*/ s_code_end
/*000000000404*/ s_code_end
/*000000000408*/ s_code_end
/*00000000040c*/ s_code_end
/*000000000410*/ s_code_end
/*000000000414*/ s_code_end
/*000000000418*/ s_code_end
/*00000000041c*/ s_code_end
/*000000000420*/ s_code_end
/*000000000424*/ s_code_end
/*000000000428*/ s_code_end
/*00000000042c*/ s_code_end
/*000000000430*/ s_code_end
/*000000000434*/ s_code_end
/*000000000438*/ s_code_end
/*00000000043c*/ s_code_end
