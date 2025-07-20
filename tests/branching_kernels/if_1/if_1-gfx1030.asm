.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel if_1
    .config
        .dims xy
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x0000098c
        .codeversion 1, 2
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 14
        .workitem_vgpr_count 4
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 8, 8, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 14
        .md_vgprsnum 4
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
if_1:
.skip 256
/*000000000100*/ s_clause        0x2
/*000000000104*/ s_load_dwordx4  s[8:11], s[4:5], 0x18
/*00000000010c*/ s_load_dword    s0, s[4:5], 0x0
/*000000000114*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*00000000011c*/ s_lshl_b32      s1, s6, 3
/*000000000120*/ v_lshl_or_b32   v1, s7, 3, v1
/*000000000128*/ s_waitcnt       lgkmcnt(0)
/*00000000012c*/ v_add3_u32      v2, s8, s1, v0
/*000000000134*/ v_add_co_u32    v0, s[1:2], s10, v1
/*00000000013c*/ v_cmp_eq_u32    vcc, 1, v2
/*000000000140*/ s_and_saveexec_b32 s1, vcc_lo
/*000000000144*/ s_cbranch_execz .L368_0
/*000000000148*/ s_load_dword    s4, s[4:5], 0x10
/*000000000150*/ v_mul_lo_u32    v1, v0, s0
/*000000000158*/ s_waitcnt       lgkmcnt(0)
/*00000000015c*/ v_subrev_nc_u32 v3, s4, v1
/*000000000160*/ v_mov_b32       v1, s2
/*000000000164*/ v_mov_b32       v2, s3
/*000000000168*/ global_store_dword v[1:2], v3, off inst_offset:4
.L368_0:
/*000000000170*/ s_or_b32        exec_lo, exec_lo, s1
/*000000000174*/ v_mov_b32       v1, 0
/*000000000178*/ v_mov_b32       v2, s0
/*00000000017c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000184*/ v_add_co_u32    v0, vcc, s2, v0
/*00000000018c*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*000000000190*/ global_store_dword v[0:1], v2, off
/*000000000198*/ s_endpgm
/*00000000019c*/ s_code_end
/*0000000001a0*/ s_code_end
/*0000000001a4*/ s_code_end
/*0000000001a8*/ s_code_end
/*0000000001ac*/ s_code_end
/*0000000001b0*/ s_code_end
/*0000000001b4*/ s_code_end
/*0000000001b8*/ s_code_end
/*0000000001bc*/ s_code_end
/*0000000001c0*/ s_code_end
/*0000000001c4*/ s_code_end
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
