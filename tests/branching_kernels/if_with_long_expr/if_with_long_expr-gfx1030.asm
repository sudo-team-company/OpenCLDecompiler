.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel if_with_long_expr
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
        .workitem_vgpr_count 8
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 64
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_with_long_expr@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 64
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
if_with_long_expr:
.skip 256
/*000000000100*/ s_clause        0x4
/*000000000104*/ s_load_dwordx4  s[12:15], s[4:5], 0x18
/*00000000010c*/ s_load_dwordx2  s[0:1], s[4:5], 0x28
/*000000000114*/ s_load_dword    s3, s[4:5], 0x10
/*00000000011c*/ s_load_dword    s2, s[4:5], 0x0
/*000000000124*/ s_load_dwordx2  s[4:5], s[4:5], 0x8
/*00000000012c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000134*/ s_waitcnt       lgkmcnt(0)
/*000000000138*/ s_lshl_b32      s1, s8, 2
/*00000000013c*/ v_add_co_u32    v3, s[8:9], s12, v0
/*000000000144*/ v_add3_u32      v0, s0, s1, v2
/*00000000014c*/ v_cmp_ge_i32    s[8:9], s2, s3
/*000000000154*/ v_cmp_lg_u32    vcc, 1, v3
/*000000000158*/ v_cmp_lg_u32    s[0:1], 2, v0
/*000000000160*/ s_or_b64        s[0:1], vcc, s[0:1]
/*000000000164*/ s_or_b64        s[0:1], s[8:9], s[0:1]
/*000000000168*/ s_and_saveexec_b64 s[8:9], s[0:1]
/*00000000016c*/ s_xor_b64       s[0:1], exec, s[8:9]
/*000000000170*/ v_mul_lo_u32    v6, v3, s3
/*000000000178*/ v_mov_b32       v4, 0
/*00000000017c*/ s_or_saveexec_b64 s[0:1], s[0:1]
/*000000000180*/ v_lshl_or_b32   v1, s7, 2, v1
/*000000000188*/ v_add_co_u32    v1, s[6:7], s14, v1
/*000000000190*/ s_xor_b64       exec, exec, s[0:1]
/*000000000194*/ v_mul_lo_u32    v0, v1, s2
/*00000000019c*/ v_mov_b32       v3, 1
/*0000000001a0*/ v_mov_b32       v4, 0
/*0000000001a4*/ v_subrev_nc_u32 v6, s3, v0
/*0000000001a8*/ s_or_b64        exec, exec, s[0:1]
/*0000000001ac*/ v_mov_b32       v2, 0
/*0000000001b0*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000001b8*/ v_mov_b32       v7, s2
/*0000000001bc*/ v_lshlrev_b64   v[1:2], 2, v[1:2]
/*0000000001c4*/ v_add_co_u32    v3, vcc, s4, v3
/*0000000001cc*/ v_add_co_ci_u32 v4, vcc, s5, v4, vcc
/*0000000001d0*/ v_add_co_u32    v1, vcc, s4, v1
/*0000000001d8*/ v_add_co_ci_u32 v2, vcc, s5, v2, vcc
/*0000000001dc*/ global_store_dword v[3:4], v6, off
/*0000000001e4*/ global_store_dword v[1:2], v7, off
/*0000000001ec*/ s_endpgm
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
