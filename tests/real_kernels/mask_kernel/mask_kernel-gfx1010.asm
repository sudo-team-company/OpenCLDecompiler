/* Disassembling 'real_kernels\mask_kernel\mask_kernel-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel mask_kernel
    .config
        .dims xyz
        .sgprsnum 24
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 8
        .pgmrsrc1 0x60af0080
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
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "mask_kernel@kd"
        .md_language "OpenCL C", 1, 2
        .md_kernarg_segment_size 96
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 3
        .max_flat_work_group_size 256
        .arg n, "int", 4, 4, value, struct
        .arg x, "float*", 8, 8, globalbuf, struct, global, default
        .arg mask_num, "float", 4, 4, value, struct
        .arg mask, "float*", 8, 8, globalbuf, struct, global, default
        .arg scale, "float", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
mask_kernel:
.skip 256
/*000000000100*/ s_load_dword    s0, s[4:5], 0x8
/*000000000108*/ s_load_dwordx2  s[12:13], s[6:7], 0x38
/*000000000110*/ s_clause        0x1
/*000000000114*/ s_load_dwordx2  s[14:15], s[4:5], 0xc
/*00000000011c*/ s_load_dword    s4, s[4:5], 0x4
/*000000000124*/ s_mov_b32       s5, 0xffff
/*00000000012c*/ s_waitcnt       lgkmcnt(0)
/*000000000130*/ s_and_b32       s0, s0, s5
/*000000000134*/ s_mul_i32       s10, s10, s0
/*000000000138*/ s_load_dwordx4  s[0:3], s[6:7], 0x28
/*000000000140*/ v_add_nc_u32    v2, s10, v2
/*000000000144*/ s_waitcnt       lgkmcnt(0)
/*000000000148*/ v_add_co_u32    v2, s[1:2], s12, v2
/*000000000150*/ s_lshr_b32      s1, s4, 16
/*000000000154*/ s_mul_i32       s9, s9, s1
/*000000000158*/ s_load_dword    s1, s[6:7], 0x0
/*000000000160*/ v_mul_lo_u32    v2, v2, s15
/*000000000168*/ v_add_nc_u32    v1, s9, v1
/*00000000016c*/ v_add_co_u32    v2, vcc, v2, s2
/*000000000174*/ s_and_b32       s2, s4, s5
/*000000000178*/ s_mul_i32       s8, s8, s2
/*00000000017c*/ v_add_co_u32    v1, vcc, v2, v1
/*000000000184*/ v_add_nc_u32    v0, s8, v0
/*000000000188*/ v_mul_lo_u32    v1, v1, s14
/*000000000190*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000198*/ v_add_co_u32    v0, vcc, v0, v1
/*0000000001a0*/ s_waitcnt       lgkmcnt(0)
/*0000000001a4*/ v_cmp_gt_i32    vcc, s1, v0
/*0000000001a8*/ s_and_saveexec_b32 s0, vcc_lo
/*0000000001ac*/ s_cbranch_execz .L572_0
/*0000000001b0*/ s_load_dwordx2  s[0:1], s[6:7], 0x18
/*0000000001b8*/ v_mov_b32       v1, 0
/*0000000001bc*/ v_mov_b32       v2, v0
/*0000000001c0*/ v_ashrrev_i64   v[1:2], 30, v[1:2]
/*0000000001c8*/ s_waitcnt       lgkmcnt(0)
/*0000000001cc*/ v_add_co_u32    v1, vcc, s0, v1
/*0000000001d4*/ s_load_dword    s0, s[6:7], 0x10
/*0000000001dc*/ v_add_co_ci_u32 v2, vcc, s1, v2, vcc
/*0000000001e0*/ global_load_dword v2, v[1:2], off
/*0000000001e8*/ v_ashrrev_i32   v1, 31, v0
/*0000000001ec*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000001f0*/ v_cmp_eq_f32    vcc, s0, v2
/*0000000001f4*/ s_and_b32       exec_lo, exec_lo, vcc_lo
/*0000000001f8*/ s_cbranch_execz .L572_0
/*0000000001fc*/ s_load_dwordx2  s[0:1], s[6:7], 0x8
/*000000000204*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000020c*/ s_load_dword    s2, s[6:7], 0x20
/*000000000214*/ s_waitcnt       lgkmcnt(0)
/*000000000218*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000220*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000224*/ global_load_dword v2, v[0:1], off
/*00000000022c*/ s_waitcnt       vmcnt(0)
/*000000000230*/ v_mul_f32       v2, s2, v2
/*000000000234*/ global_store_dword v[0:1], v2, off
.L572_0:
/*00000000023c*/ s_endpgm
/*000000000240*/ s_code_end
/*000000000244*/ s_code_end
/*000000000248*/ s_code_end
/*00000000024c*/ s_code_end
/*000000000250*/ s_code_end
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
