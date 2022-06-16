/* Disassembling 'real_kernels\bellmanFordInit_ver1\bellmanFordInit_ver1-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel bellmanFordIter_ver1
    .config
        .dims x
        .sgprsnum 16
        .vgprsnum 8
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0041
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 96
        .wavefront_sgpr_count 9
        .workitem_vgpr_count 10
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "bellmanFordIter_ver1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 96
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 10
        .max_flat_work_group_size 64
        .arg nEdges, "uint", 4, 4, value, struct
        .arg edges, "uint2*", 8, 8, globalbuf, struct, global, default const restrict
        .arg weights, "double*", 8, 8, globalbuf, struct, global, default const restrict
        .arg d, "double*", 8, 8, globalbuf, struct, global, default restrict
        .arg changed, "uint*", 8, 8, globalbuf, struct, global, default restrict
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
bellmanFordIter_ver1:
.skip 256
/*000000000100*/ s_load_dwordx2  s[0:1], s[4:5], 0x28
/*000000000108*/ s_waitcnt       lgkmcnt(0)
/*00000000010c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000114*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000011c*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000124*/ s_waitcnt       lgkmcnt(0)
/*000000000128*/ v_cmp_gt_u32    vcc, s1, v0
/*00000000012c*/ s_and_saveexec_b32 s0, vcc_lo
/*000000000130*/ s_cbranch_execz .L576_0
/*000000000134*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*00000000013c*/ v_mov_b32       v1, 0
/*000000000140*/ s_load_dwordx2  s[0:1], s[4:5], 0x18
/*000000000148*/ v_lshlrev_b64   v[2:3], 3, v[0:1]
/*000000000150*/ v_mov_b32       v5, v1
/*000000000154*/ s_waitcnt       lgkmcnt(0)
/*000000000158*/ v_add_co_u32    v2, vcc, s2, v2
/*000000000160*/ s_mov_b32       s2, 0xa2000000
/*000000000168*/ v_add_co_ci_u32 v3, vcc, s3, v3, vcc
/*00000000016c*/ s_mov_b32       s3, 0x426d1a94
/*000000000174*/ global_load_dwordx2 v[2:3], v[2:3], off
/*00000000017c*/ s_waitcnt       vmcnt(0)
/*000000000180*/ v_mov_b32       v4, v2
/*000000000184*/ v_lshlrev_b64   v[4:5], 3, v[4:5]
/*00000000018c*/ v_add_co_u32    v4, vcc, s0, v4
/*000000000194*/ v_add_co_ci_u32 v5, vcc, s1, v5, vcc
/*000000000198*/ global_load_dwordx2 v[4:5], v[4:5], off
/*0000000001a0*/ s_waitcnt       vmcnt(0)
/*0000000001a4*/ v_cmp_gt_f64    vcc, s[2:3], v[4:5]
/*0000000001a8*/ s_and_b32       exec_lo, exec_lo, vcc_lo
/*0000000001ac*/ s_cbranch_execz .L576_0
/*0000000001b0*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*0000000001b8*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000001c0*/ s_waitcnt       lgkmcnt(0)
/*0000000001c4*/ v_add_co_u32    v0, vcc, s2, v0
/*0000000001cc*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*0000000001d0*/ global_load_dwordx2 v[6:7], v[0:1], off
/*0000000001d8*/ v_mov_b32       v0, v3
/*0000000001dc*/ v_mov_b32       v1, 0
/*0000000001e0*/ v_lshlrev_b64   v[0:1], 3, v[0:1]
/*0000000001e8*/ v_add_co_u32    v0, vcc, s0, v0
/*0000000001f0*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*0000000001f4*/ global_load_dwordx2 v[8:9], v[0:1], off
/*0000000001fc*/ s_waitcnt       vmcnt(1)
/*000000000200*/ v_add_f64       v[2:3], v[4:5], v[6:7]
/*000000000208*/ s_waitcnt       vmcnt(0)
/*00000000020c*/ v_cmp_gt_f64    vcc, v[8:9], v[2:3]
/*000000000210*/ s_and_b32       exec_lo, exec_lo, vcc_lo
/*000000000214*/ s_cbranch_execz .L576_0
/*000000000218*/ s_load_dwordx2  s[0:1], s[4:5], 0x20
/*000000000220*/ v_mov_b32       v6, 1
/*000000000224*/ s_waitcnt       lgkmcnt(0)
/*000000000228*/ v_mov_b32       v5, s1
/*00000000022c*/ v_mov_b32       v4, s0
/*000000000230*/ global_store_dwordx2 v[0:1], v[2:3], off
/*000000000238*/ global_store_dword v[4:5], v6, off
.L576_0:
/*000000000240*/ s_endpgm
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
