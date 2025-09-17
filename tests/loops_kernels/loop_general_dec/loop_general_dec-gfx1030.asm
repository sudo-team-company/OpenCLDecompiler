.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel loop_general
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
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 12
        .workitem_vgpr_count 4
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_general@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 12
        .md_vgprsnum 4
        .max_flat_work_group_size 64
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg from, "int", 4, 4, value, struct
        .arg to, "int", 4, 4, value, struct
        .arg x, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
loop_general:
.skip 256
/*000000000100*/ s_clause        0x1
/*000000000104*/ s_load_dwordx2  s[0:1], s[4:5], 0x18
/*00000000010c*/ s_load_dwordx2  s[8:9], s[4:5], 0x0
/*000000000114*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000011c*/ s_waitcnt       lgkmcnt(0)
/*000000000120*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000128*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000130*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000138*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000140*/ v_add_co_u32    v0, vcc, s8, v0
/*000000000148*/ v_add_co_ci_u32 v1, vcc, s9, v1, vcc
/*00000000014c*/ global_load_dword v2, v[0:1], off
/*000000000154*/ s_waitcnt       lgkmcnt(0)
/*000000000158*/ s_cmp_le_i32    s0, s1
/*00000000015c*/ s_cbranch_scc1  .L388_0
.L352_0:
/*000000000160*/ s_waitcnt       vmcnt(0)
/*000000000164*/ v_mul_lo_u32    v3, s2, v2
/*00000000016c*/ v_add_nc_u32    v2, s0, v3
/*000000000170*/ s_add_i32       s0, s0, -1
/*000000000174*/ s_cmp_le_i32    s0, s1
/*000000000178*/ s_cbranch_scc0  .L352_0
/*00000000017c*/ v_add3_u32      v2, v3, s0, 1
.L388_0:
/*000000000184*/ s_waitcnt       vmcnt(0)
/*000000000188*/ global_store_dword v[0:1], v2, off
/*000000000190*/ s_endpgm
/*000000000194*/ s_code_end
/*000000000198*/ s_code_end
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
