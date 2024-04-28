/* Disassembling 'loops_kernels\loop_with_unrolling_breaker\loop_with_unrolling_breaker-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel loop_with_unrolling_breaker
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
        .kernarg_segment_size 72
        .wavefront_sgpr_count 9
        .workitem_vgpr_count 6
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_with_unrolling_breaker@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 6
        .max_flat_work_group_size 64
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg x, "int", 4, 4, value, struct
        .arg unrollingBreaker, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
loop_with_unrolling_breaker:
.skip 256
/*000000000100*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000108*/ s_waitcnt       lgkmcnt(0)
/*00000000010c*/ s_cmp_lt_i32    s1, 0
/*000000000110*/ s_cbranch_scc1  .L452_0
/*000000000114*/ s_clause        0x1
/*000000000118*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000120*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000128*/ v_lshl_or_b32   v0, s6, 6, v0
/*000000000130*/ v_mov_b32       v1, 0
/*000000000134*/ s_waitcnt       lgkmcnt(0)
/*000000000138*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000140*/ s_mov_b32       s2, s1
/*000000000144*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*000000000148*/ v_cmp_lt_u32    s[1:2], s1, 63
/*000000000150*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000158*/ v_cndmask_b32   v3, 63, s2, s[1:2]
/*000000000160*/ s_mov_b64       s[2:3], 0
/*000000000164*/ v_add_co_u32    v0, vcc, s4, v0
/*00000000016c*/ v_sub_co_u32    v3, s[1:2], 0, v3
/*000000000174*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000178*/ v_sub_co_ci_u32 v4, s[1:2], 0, 0, s[1:2]
/*000000000180*/ s_mov_b64       s[4:5], 1
/*000000000184*/ global_load_dword v2, v[0:1], off
.L396_0:
/*00000000018c*/ s_waitcnt       vmcnt(0)
/*000000000190*/ v_mul_lo_u32    v5, v2, s0
/*000000000198*/ v_add_nc_u32    v2, s2, v5
/*00000000019c*/ s_add_u32       s2, s2, 1
/*0000000001a0*/ s_addc_u32      s3, s3, 0
/*0000000001a4*/ s_add_u32       s4, s4, -1
/*0000000001a8*/ s_addc_u32      s5, s5, -1
/*0000000001ac*/ v_cmp_lg_u64    vcc, s[4:5], v[3:4]
/*0000000001b0*/ s_and_b32       vcc_lo, exec_lo, vcc_lo
/*0000000001b4*/ s_cbranch_vccnz .L396_0
/*0000000001b8*/ v_sub_nc_u32    v2, v5, v3
/*0000000001bc*/ global_store_dword v[0:1], v2, off
.L452_0:
/*0000000001c4*/ s_endpgm
/*0000000001c8*/ s_code_end
/*0000000001cc*/ s_code_end
/*0000000001d0*/ s_code_end
/*0000000001d4*/ s_code_end
/*0000000001d8*/ s_code_end
/*0000000001dc*/ s_code_end
/*0000000001e0*/ s_code_end
/*0000000001e4*/ s_code_end
/*0000000001e8*/ s_code_end
/*0000000001ec*/ s_code_end
/*0000000001f0*/ s_code_end
/*0000000001f4*/ s_code_end
/*0000000001f8*/ s_code_end
/*0000000001fc*/ s_code_end
/*000000000200*/ s_code_end
/*000000000204*/ s_code_end
/*000000000208*/ s_code_end
/*00000000020c*/ s_code_end
/*000000000210*/ s_code_end
/*000000000214*/ s_code_end
/*000000000218*/ s_code_end
/*00000000021c*/ s_code_end
/*000000000220*/ s_code_end
/*000000000224*/ s_code_end
/*000000000228*/ s_code_end
/*00000000022c*/ s_code_end
/*000000000230*/ s_code_end
/*000000000234*/ s_code_end
/*000000000238*/ s_code_end
/*00000000023c*/ s_code_end
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
