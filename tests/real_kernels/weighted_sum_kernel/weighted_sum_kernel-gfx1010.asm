/* Disassembling 'real_kernels\weighted_sum_kernel\weighted_sum_kernel-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel weighted_sum_kernel
    .config
        .dims xyz
        .sgprsnum 32
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 8
        .pgmrsrc1 0x60af00c0
        .pgmrsrc2 0x00001390
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_dispatch_ptr
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 96
        .wavefront_sgpr_count 26
        .workitem_vgpr_count 8
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "weighted_sum_kernel@kd"
        .md_language "OpenCL C", 1, 2
        .md_kernarg_segment_size 96
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 26
        .md_vgprsnum 8
        .max_flat_work_group_size 256
        .arg n, "int", 4, 4, value, struct
        .arg a, "float*", 8, 8, globalbuf, struct, global, default
        .arg b, "float*", 8, 8, globalbuf, struct, global, default
        .arg s, "float*", 8, 8, globalbuf, struct, global, default
        .arg c, "float*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
weighted_sum_kernel:
.skip 256
/*000000000100*/ s_load_dword    s11, s[4:5], 0x8
/*000000000108*/ s_load_dwordx2  s[0:1], s[6:7], 0x38
/*000000000110*/ s_load_dwordx2  s[2:3], s[4:5], 0xc
/*000000000118*/ s_waitcnt       lgkmcnt(0)
/*00000000011c*/ s_load_dword    s1, s[4:5], 0x4
/*000000000124*/ s_mov_b32       s4, 0xffff
/*00000000012c*/ s_clause        0x1
/*000000000130*/ s_load_dwordx4  s[20:23], s[6:7], 0x28
/*000000000138*/ s_load_dwordx8  s[12:19], s[6:7], 0x8
/*000000000140*/ s_and_b32       s5, s11, s4
/*000000000144*/ s_mul_i32       s10, s10, s5
/*000000000148*/ v_add_nc_u32    v2, s10, v2
/*00000000014c*/ v_add_co_u32    v2, s[0:1], s0, v2
/*000000000154*/ s_waitcnt       lgkmcnt(0)
/*000000000158*/ s_lshr_b32      s0, s1, 16
/*00000000015c*/ s_mul_i32       s9, s9, s0
/*000000000160*/ s_and_b32       s0, s1, s4
/*000000000164*/ v_mul_lo_u32    v2, v2, s3
/*00000000016c*/ v_add_nc_u32    v1, s9, v1
/*000000000170*/ s_mul_i32       s8, s8, s0
/*000000000174*/ s_load_dword    s0, s[6:7], 0x0
/*00000000017c*/ v_add_nc_u32    v0, s8, v0
/*000000000180*/ s_cmp_eq_u64    s[14:15], 0
/*000000000184*/ v_add_co_u32    v2, vcc, v2, s22
/*00000000018c*/ v_add_co_u32    v0, s[1:2], s20, v0
/*000000000194*/ v_add_co_u32    v1, vcc, v2, v1
/*00000000019c*/ v_mul_lo_u32    v1, v1, s2
/*0000000001a4*/ v_add_co_u32    v1, vcc, v0, v1
/*0000000001ac*/ v_mov_b32       v0, 0
/*0000000001b0*/ v_ashrrev_i32   v2, 31, v1
/*0000000001b4*/ s_cbranch_scc0  .L460_0
/*0000000001b8*/ s_waitcnt       lgkmcnt(0)
/*0000000001bc*/ v_cmp_gt_i32    vcc, s0, v1
/*0000000001c0*/ s_and_saveexec_b32 s0, vcc_lo
/*0000000001c4*/ s_cbranch_execnz .L504_0
.L456_0:
/*0000000001c8*/ s_endpgm
.L460_0:
/*0000000001cc*/ v_lshlrev_b64   v[3:4], 2, v[1:2]
/*0000000001d4*/ v_add_co_u32    v3, vcc, s14, v3
/*0000000001dc*/ v_add_co_ci_u32 v4, vcc, s15, v4, vcc
/*0000000001e0*/ global_load_dword v0, v[3:4], off
/*0000000001e8*/ s_waitcnt       lgkmcnt(0)
/*0000000001ec*/ v_cmp_gt_i32    vcc, s0, v1
/*0000000001f0*/ s_and_saveexec_b32 s0, vcc_lo
/*0000000001f4*/ s_cbranch_execz .L456_0
.L504_0:
/*0000000001f8*/ v_lshlrev_b64   v[1:2], 2, v[1:2]
/*000000000200*/ v_add_co_u32    v3, vcc, s16, v1
/*000000000208*/ v_add_co_ci_u32 v4, vcc, s17, v2, vcc
/*00000000020c*/ global_load_dword v5, v[3:4], off
/*000000000214*/ v_add_co_u32    v3, vcc, s12, v1
/*00000000021c*/ v_add_co_ci_u32 v4, vcc, s13, v2, vcc
/*000000000220*/ global_load_dword v3, v[3:4], off
/*000000000228*/ s_waitcnt       vmcnt(1)
/*00000000022c*/ v_sub_f32       v7, 1.0, v5
/*000000000230*/ v_mul_f32       v6, v0, v7
/*000000000234*/ v_add_co_u32    v0, vcc, s18, v1
/*00000000023c*/ v_add_co_ci_u32 v1, vcc, s19, v2, vcc
/*000000000240*/ s_waitcnt       vmcnt(0)
/*000000000244*/ v_fmac_f32      v6, v5, v3
/*000000000248*/ global_store_dword v[0:1], v6, off
/*000000000250*/ s_endpgm
/*000000000254*/ s_code_end
/*000000000258*/ s_code_end
/*00000000025c*/ s_code_end
/*000000000260*/ s_code_end
/*000000000264*/ s_code_end
/*000000000268*/ s_code_end
/*00000000026c*/ s_code_end
/*000000000270*/ s_code_end
/*000000000274*/ s_code_end
/*000000000278*/ s_code_end
/*00000000027c*/ s_code_end
/*000000000280*/ s_code_end
/*000000000284*/ s_code_end
/*000000000288*/ s_code_end
/*00000000028c*/ s_code_end
/*000000000290*/ s_code_end
/*000000000294*/ s_code_end
/*000000000298*/ s_code_end
/*00000000029c*/ s_code_end
/*0000000002a0*/ s_code_end
/*0000000002a4*/ s_code_end
/*0000000002a8*/ s_code_end
/*0000000002ac*/ s_code_end
/*0000000002b0*/ s_code_end
/*0000000002b4*/ s_code_end
/*0000000002b8*/ s_code_end
/*0000000002bc*/ s_code_end
/*0000000002c0*/ s_code_end
/*0000000002c4*/ s_code_end
/*0000000002c8*/ s_code_end
/*0000000002cc*/ s_code_end
/*0000000002d0*/ s_code_end
/*0000000002d4*/ s_code_end
/*0000000002d8*/ s_code_end
/*0000000002dc*/ s_code_end
/*0000000002e0*/ s_code_end
/*0000000002e4*/ s_code_end
/*0000000002e8*/ s_code_end
/*0000000002ec*/ s_code_end
/*0000000002f0*/ s_code_end
/*0000000002f4*/ s_code_end
/*0000000002f8*/ s_code_end
/*0000000002fc*/ s_code_end
/*000000000300*/ s_code_end
/*000000000304*/ s_code_end
/*000000000308*/ s_code_end
/*00000000030c*/ s_code_end
/*000000000310*/ s_code_end
/*000000000314*/ s_code_end
/*000000000318*/ s_code_end
/*00000000031c*/ s_code_end
/*000000000320*/ s_code_end
/*000000000324*/ s_code_end
/*000000000328*/ s_code_end
/*00000000032c*/ s_code_end
/*000000000330*/ s_code_end
/*000000000334*/ s_code_end
/*000000000338*/ s_code_end
/*00000000033c*/ s_code_end
