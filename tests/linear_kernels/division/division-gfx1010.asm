/* Disassembling 'division_x_y-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel div_x_y_char
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
        .wavefront_sgpr_count 11
        .workitem_vgpr_count 4
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_char@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 11
        .md_vgprsnum 4
        .max_flat_work_group_size 64
        .arg data, "char*", 8, 8, globalbuf, struct, global, default
        .arg x, "char", 1, 1, value, struct
        .arg y, "char", 1, 1, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_double
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
        .kernarg_segment_size 80
        .wavefront_sgpr_count 14
        .workitem_vgpr_count 9
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_double@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 14
        .md_vgprsnum 9
        .max_flat_work_group_size 64
        .arg data, "double*", 8, 8, globalbuf, struct, global, default
        .arg x, "double", 8, 8, value, struct
        .arg y, "double", 8, 8, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_float
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
        .wavefront_sgpr_count 12
        .workitem_vgpr_count 6
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_float@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 12
        .md_vgprsnum 6
        .max_flat_work_group_size 64
        .arg data, "float*", 8, 8, globalbuf, struct, global, default
        .arg x, "float", 4, 4, value, struct
        .arg y, "float", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_int
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
        .wavefront_sgpr_count 12
        .workitem_vgpr_count 5
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_int@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 12
        .md_vgprsnum 5
        .max_flat_work_group_size 64
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg x, "int", 4, 4, value, struct
        .arg y, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_long
    .config
        .dims x
        .sgprsnum 24
        .vgprsnum 8
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0081
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 24
        .workitem_vgpr_count 13
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_long@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 24
        .md_vgprsnum 13
        .max_flat_work_group_size 64
        .arg data, "long*", 8, 8, globalbuf, struct, global, default
        .arg x, "long", 8, 8, value, struct
        .arg y, "long", 8, 8, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_short
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
        .wavefront_sgpr_count 11
        .workitem_vgpr_count 5
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_short@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 11
        .md_vgprsnum 5
        .max_flat_work_group_size 64
        .arg data, "short*", 8, 8, globalbuf, struct, global, default
        .arg x, "short", 2, 2, value, struct
        .arg y, "short", 2, 2, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_uchar
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
        .wavefront_sgpr_count 10
        .workitem_vgpr_count 4
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_uchar@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 10
        .md_vgprsnum 4
        .max_flat_work_group_size 64
        .arg data, "uchar*", 8, 8, globalbuf, struct, global, default
        .arg x, "uchar", 1, 1, value, struct
        .arg y, "uchar", 1, 1, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_uint
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
        .wavefront_sgpr_count 10
        .workitem_vgpr_count 5
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_uint@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 10
        .md_vgprsnum 5
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_ulong
    .config
        .dims x
        .sgprsnum 40
        .vgprsnum 8
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0101
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 34
        .workitem_vgpr_count 13
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_ulong@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 34
        .md_vgprsnum 13
        .max_flat_work_group_size 64
        .arg data, "ulong*", 8, 8, globalbuf, struct, global, default
        .arg x, "ulong", 8, 8, value, struct
        .arg y, "ulong", 8, 8, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel div_x_y_ushort
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
        .workitem_vgpr_count 5
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "div_x_y_ushort@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 5
        .max_flat_work_group_size 64
        .arg data, "ushort*", 8, 8, globalbuf, struct, global, default
        .arg x, "ushort", 2, 2, value, struct
        .arg y, "ushort", 2, 2, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
div_x_y_char:
.skip 256
/*000000000100*/ s_clause        0x1
/*000000000104*/ s_load_dword    s2, s[4:5], 0x8
/*00000000010c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000114*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000011c*/ s_waitcnt       lgkmcnt(0)
/*000000000120*/ s_bfe_i32       s7, s2, 0x80008
/*000000000128*/ s_sext_i32_i8   s8, s2
/*00000000012c*/ v_cvt_f32_i32   v1, s7
/*000000000130*/ v_cvt_f32_i32   v3, s8
/*000000000134*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*00000000013c*/ s_xor_b32       s4, s8, s7
/*000000000140*/ v_rcp_iflag_f32 v2, v1
/*000000000144*/ s_ashr_i32      s4, s4, 30
/*000000000148*/ s_or_b32        s4, s4, 1
/*00000000014c*/ v_mul_f32       v2, v3, v2
/*000000000150*/ v_trunc_f32     v2, v2
/*000000000154*/ v_mad_f32       v3, -v2, v1, v3
/*00000000015c*/ v_cmp_ge_f32    s[5:6], abs(v3), abs(v1)
/*000000000164*/ v_cvt_i32_f32   v1, v2
/*000000000168*/ s_cmp_lg_u32    s5, 0
/*00000000016c*/ s_cselect_b32   s4, s4, 0
/*000000000170*/ s_waitcnt       lgkmcnt(0)
/*000000000174*/ s_add_u32       s0, s2, s0
/*000000000178*/ s_addc_u32      s1, s3, s1
/*00000000017c*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000184*/ v_add_nc_u32    v2, s4, v1
/*000000000188*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000190*/ global_store_byte v[0:1], v2, off
/*000000000198*/ s_endpgm
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
div_x_y_uchar:
.skip 256
/*000000000300*/ s_clause        0x2
/*000000000304*/ s_load_dword    s7, s[4:5], 0x8
/*00000000030c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000314*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*00000000031c*/ v_lshl_or_b32   v0, s6, 6, v0
/*000000000324*/ s_waitcnt       lgkmcnt(0)
/*000000000328*/ v_cvt_f32_ubyte1 v1, s7
/*00000000032c*/ v_cvt_f32_ubyte0 v3, s7
/*000000000330*/ s_add_u32       s0, s2, s0
/*000000000334*/ s_addc_u32      s1, s3, s1
/*000000000338*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000340*/ v_rcp_iflag_f32 v2, v1
/*000000000344*/ v_mul_f32       v2, v3, v2
/*000000000348*/ v_trunc_f32     v2, v2
/*00000000034c*/ v_mad_f32       v3, -v2, v1, v3
/*000000000354*/ v_cvt_u32_f32   v2, v2
/*000000000358*/ v_cmp_ge_f32    vcc, abs(v3), v1
/*000000000360*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000368*/ v_add_co_ci_u32 v2, vcc, 0, v2, vcc
/*00000000036c*/ global_store_byte v[0:1], v2, off
/*000000000374*/ s_endpgm
/*000000000378*/ s_nop           0x0
/*00000000037c*/ s_nop           0x0
/*000000000380*/ s_nop           0x0
/*000000000384*/ s_nop           0x0
/*000000000388*/ s_nop           0x0
/*00000000038c*/ s_nop           0x0
/*000000000390*/ s_nop           0x0
/*000000000394*/ s_nop           0x0
/*000000000398*/ s_nop           0x0
/*00000000039c*/ s_nop           0x0
/*0000000003a0*/ s_nop           0x0
/*0000000003a4*/ s_nop           0x0
/*0000000003a8*/ s_nop           0x0
/*0000000003ac*/ s_nop           0x0
/*0000000003b0*/ s_nop           0x0
/*0000000003b4*/ s_nop           0x0
/*0000000003b8*/ s_nop           0x0
/*0000000003bc*/ s_nop           0x0
/*0000000003c0*/ s_nop           0x0
/*0000000003c4*/ s_nop           0x0
/*0000000003c8*/ s_nop           0x0
/*0000000003cc*/ s_nop           0x0
/*0000000003d0*/ s_nop           0x0
/*0000000003d4*/ s_nop           0x0
/*0000000003d8*/ s_nop           0x0
/*0000000003dc*/ s_nop           0x0
/*0000000003e0*/ s_nop           0x0
/*0000000003e4*/ s_nop           0x0
/*0000000003e8*/ s_nop           0x0
/*0000000003ec*/ s_nop           0x0
/*0000000003f0*/ s_nop           0x0
/*0000000003f4*/ s_nop           0x0
/*0000000003f8*/ s_nop           0x0
/*0000000003fc*/ s_nop           0x0
div_x_y_short:
.skip 256
/*000000000500*/ s_clause        0x1
/*000000000504*/ s_load_dword    s2, s[4:5], 0x8
/*00000000050c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000514*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000051c*/ s_waitcnt       lgkmcnt(0)
/*000000000520*/ s_ashr_i32      s7, s2, 16
/*000000000524*/ s_sext_i32_i16  s8, s2
/*000000000528*/ v_cvt_f32_i32   v2, s7
/*00000000052c*/ v_cvt_f32_i32   v3, s8
/*000000000530*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000538*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000540*/ v_rcp_iflag_f32 v1, v2
/*000000000544*/ v_mul_f32       v1, v3, v1
/*000000000548*/ v_trunc_f32     v4, v1
/*00000000054c*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000554*/ s_xor_b32       s0, s8, s7
/*000000000558*/ s_ashr_i32      s0, s0, 30
/*00000000055c*/ v_mad_f32       v3, -v4, v2, v3
/*000000000564*/ v_lshlrev_b64   v[0:1], 1, v[0:1]
/*00000000056c*/ s_or_b32        s0, s0, 1
/*000000000570*/ v_cmp_ge_f32    s[1:2], abs(v3), abs(v2)
/*000000000578*/ v_cvt_i32_f32   v2, v4
/*00000000057c*/ s_waitcnt       lgkmcnt(0)
/*000000000580*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000588*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*00000000058c*/ s_cmp_lg_u32    s1, 0
/*000000000590*/ s_cselect_b32   s0, s0, 0
/*000000000594*/ v_add_nc_u32    v2, s0, v2
/*000000000598*/ global_store_short v[0:1], v2, off
/*0000000005a0*/ s_endpgm
/*0000000005a4*/ s_nop           0x0
/*0000000005a8*/ s_nop           0x0
/*0000000005ac*/ s_nop           0x0
/*0000000005b0*/ s_nop           0x0
/*0000000005b4*/ s_nop           0x0
/*0000000005b8*/ s_nop           0x0
/*0000000005bc*/ s_nop           0x0
/*0000000005c0*/ s_nop           0x0
/*0000000005c4*/ s_nop           0x0
/*0000000005c8*/ s_nop           0x0
/*0000000005cc*/ s_nop           0x0
/*0000000005d0*/ s_nop           0x0
/*0000000005d4*/ s_nop           0x0
/*0000000005d8*/ s_nop           0x0
/*0000000005dc*/ s_nop           0x0
/*0000000005e0*/ s_nop           0x0
/*0000000005e4*/ s_nop           0x0
/*0000000005e8*/ s_nop           0x0
/*0000000005ec*/ s_nop           0x0
/*0000000005f0*/ s_nop           0x0
/*0000000005f4*/ s_nop           0x0
/*0000000005f8*/ s_nop           0x0
/*0000000005fc*/ s_nop           0x0
div_x_y_ushort:
.skip 256
/*000000000700*/ s_clause        0x1
/*000000000704*/ s_load_dword    s2, s[4:5], 0x8
/*00000000070c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000000714*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000071c*/ s_waitcnt       lgkmcnt(0)
/*000000000720*/ s_lshr_b32      s3, s2, 16
/*000000000724*/ s_and_b32       s2, s2, 0xffff
/*00000000072c*/ v_cvt_f32_u32   v2, s3
/*000000000730*/ v_cvt_f32_u32   v3, s2
/*000000000734*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*00000000073c*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000744*/ v_rcp_iflag_f32 v1, v2
/*000000000748*/ v_mul_f32       v1, v3, v1
/*00000000074c*/ v_trunc_f32     v4, v1
/*000000000750*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000758*/ v_mad_f32       v3, -v4, v2, v3
/*000000000760*/ v_cvt_u32_f32   v4, v4
/*000000000764*/ v_lshlrev_b64   v[0:1], 1, v[0:1]
/*00000000076c*/ v_cmp_ge_f32    vcc, abs(v3), v2
/*000000000774*/ v_add_co_ci_u32 v2, vcc, 0, v4, vcc
/*000000000778*/ s_waitcnt       lgkmcnt(0)
/*00000000077c*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000784*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*000000000788*/ global_store_short v[0:1], v2, off
/*000000000790*/ s_endpgm
/*000000000794*/ s_nop           0x0
/*000000000798*/ s_nop           0x0
/*00000000079c*/ s_nop           0x0
/*0000000007a0*/ s_nop           0x0
/*0000000007a4*/ s_nop           0x0
/*0000000007a8*/ s_nop           0x0
/*0000000007ac*/ s_nop           0x0
/*0000000007b0*/ s_nop           0x0
/*0000000007b4*/ s_nop           0x0
/*0000000007b8*/ s_nop           0x0
/*0000000007bc*/ s_nop           0x0
/*0000000007c0*/ s_nop           0x0
/*0000000007c4*/ s_nop           0x0
/*0000000007c8*/ s_nop           0x0
/*0000000007cc*/ s_nop           0x0
/*0000000007d0*/ s_nop           0x0
/*0000000007d4*/ s_nop           0x0
/*0000000007d8*/ s_nop           0x0
/*0000000007dc*/ s_nop           0x0
/*0000000007e0*/ s_nop           0x0
/*0000000007e4*/ s_nop           0x0
/*0000000007e8*/ s_nop           0x0
/*0000000007ec*/ s_nop           0x0
/*0000000007f0*/ s_nop           0x0
/*0000000007f4*/ s_nop           0x0
/*0000000007f8*/ s_nop           0x0
/*0000000007fc*/ s_nop           0x0
div_x_y_int:
.skip 256
/*000000000900*/ s_clause        0x1
/*000000000904*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*00000000090c*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000914*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000091c*/ s_waitcnt       lgkmcnt(0)
/*000000000920*/ s_ashr_i32      s7, s1, 31
/*000000000924*/ s_ashr_i32      s9, s0, 31
/*000000000928*/ s_add_i32       s1, s1, s7
/*00000000092c*/ s_add_i32       s0, s0, s9
/*000000000930*/ s_xor_b32       s8, s1, s7
/*000000000934*/ s_xor_b32       s0, s0, s9
/*000000000938*/ v_cvt_f32_u32   v1, s8
/*00000000093c*/ s_sub_i32       s1, 0, s8
/*000000000940*/ v_add_co_u32    v0, s[2:3], s2, v0
/*000000000948*/ v_rcp_iflag_f32 v1, v1
/*00000000094c*/ v_mul_f32       v1, 0x4f7ffffe /* 4.29496678e+9f */, v1
/*000000000954*/ v_cvt_u32_f32   v1, v1
/*000000000958*/ v_mul_lo_u32    v2, s1, v1
/*000000000960*/ v_mul_hi_u32    v2, v1, v2
/*000000000968*/ v_add_nc_u32    v1, v1, v2
/*00000000096c*/ v_mul_hi_u32    v1, s0, v1
/*000000000974*/ v_mul_lo_u32    v2, v1, s8
/*00000000097c*/ v_add_nc_u32    v3, 1, v1
/*000000000980*/ v_sub_nc_u32    v2, s0, v2
/*000000000984*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*00000000098c*/ v_cmp_le_u32    vcc, s8, v2
/*000000000990*/ v_subrev_nc_u32 v4, s8, v2
/*000000000994*/ v_cndmask_b32   v1, v1, v3, vcc
/*000000000998*/ v_cndmask_b32   v2, v2, v4, vcc
/*00000000099c*/ v_add_nc_u32    v3, 1, v1
/*0000000009a0*/ v_cmp_le_u32    vcc, s8, v2
/*0000000009a4*/ v_cndmask_b32   v2, v1, v3, vcc
/*0000000009a8*/ v_add_co_ci_u32 v1, s[2:3], s3, 0, s[2:3]
/*0000000009b0*/ s_xor_b32       s2, s9, s7
/*0000000009b4*/ v_xor_b32       v2, s2, v2
/*0000000009b8*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*0000000009c0*/ v_subrev_nc_u32 v2, s2, v2
/*0000000009c4*/ s_waitcnt       lgkmcnt(0)
/*0000000009c8*/ v_add_co_u32    v0, vcc, s0, v0
/*0000000009d0*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*0000000009d4*/ global_store_dword v[0:1], v2, off
/*0000000009dc*/ s_endpgm
/*0000000009e0*/ s_nop           0x0
/*0000000009e4*/ s_nop           0x0
/*0000000009e8*/ s_nop           0x0
/*0000000009ec*/ s_nop           0x0
/*0000000009f0*/ s_nop           0x0
/*0000000009f4*/ s_nop           0x0
/*0000000009f8*/ s_nop           0x0
/*0000000009fc*/ s_nop           0x0
div_x_y_uint:
.skip 256
/*000000000b00*/ s_clause        0x2
/*000000000b04*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000b0c*/ s_load_dwordx2  s[2:3], s[4:5], 0x10
/*000000000b14*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000b1c*/ v_lshl_or_b32   v0, s6, 6, v0
/*000000000b24*/ s_waitcnt       lgkmcnt(0)
/*000000000b28*/ v_cvt_f32_u32   v1, s1
/*000000000b2c*/ s_sub_i32       s7, 0, s1
/*000000000b30*/ v_rcp_iflag_f32 v1, v1
/*000000000b34*/ v_mul_f32       v1, 0x4f7ffffe /* 4.29496678e+9f */, v1
/*000000000b3c*/ v_cvt_u32_f32   v1, v1
/*000000000b40*/ v_mul_lo_u32    v2, s7, v1
/*000000000b48*/ v_mul_hi_u32    v2, v1, v2
/*000000000b50*/ v_add_nc_u32    v1, v1, v2
/*000000000b54*/ v_mul_hi_u32    v1, s0, v1
/*000000000b5c*/ v_mul_lo_u32    v2, v1, s1
/*000000000b64*/ v_add_nc_u32    v3, 1, v1
/*000000000b68*/ v_sub_nc_u32    v2, s0, v2
/*000000000b6c*/ v_add_co_u32    v0, s[0:1], s2, v0
/*000000000b74*/ v_cmp_le_u32    vcc, s1, v2
/*000000000b78*/ v_subrev_nc_u32 v4, s1, v2
/*000000000b7c*/ v_cndmask_b32   v3, v1, v3, vcc
/*000000000b80*/ v_add_co_ci_u32 v1, s[0:1], s3, 0, s[0:1]
/*000000000b88*/ v_cndmask_b32   v2, v2, v4, vcc
/*000000000b8c*/ v_add_nc_u32    v4, 1, v3
/*000000000b90*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000b98*/ v_cmp_le_u32    vcc, s1, v2
/*000000000b9c*/ v_cndmask_b32   v2, v3, v4, vcc
/*000000000ba0*/ v_add_co_u32    v0, vcc, s4, v0
/*000000000ba8*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000bac*/ global_store_dword v[0:1], v2, off
/*000000000bb4*/ s_endpgm
/*000000000bb8*/ s_nop           0x0
/*000000000bbc*/ s_nop           0x0
/*000000000bc0*/ s_nop           0x0
/*000000000bc4*/ s_nop           0x0
/*000000000bc8*/ s_nop           0x0
/*000000000bcc*/ s_nop           0x0
/*000000000bd0*/ s_nop           0x0
/*000000000bd4*/ s_nop           0x0
/*000000000bd8*/ s_nop           0x0
/*000000000bdc*/ s_nop           0x0
/*000000000be0*/ s_nop           0x0
/*000000000be4*/ s_nop           0x0
/*000000000be8*/ s_nop           0x0
/*000000000bec*/ s_nop           0x0
/*000000000bf0*/ s_nop           0x0
/*000000000bf4*/ s_nop           0x0
/*000000000bf8*/ s_nop           0x0
/*000000000bfc*/ s_nop           0x0
div_x_y_long:
.skip 256
/*000000000d00*/ s_clause        0x1
/*000000000d04*/ s_load_dwordx4  s[8:11], s[4:5], 0x0
/*000000000d0c*/ s_load_dwordx4  s[12:15], s[4:5], 0x10
/*000000000d14*/ s_waitcnt       lgkmcnt(0)
/*000000000d18*/ s_or_b64        s[2:3], s[10:11], s[12:13]
/*000000000d1c*/ s_mov_b32       s2, 0
/*000000000d20*/ s_cmp_lg_u64    s[2:3], 0
/*000000000d24*/ s_cbranch_scc0  .L4132_0
/*000000000d28*/ s_ashr_i32      s14, s13, 31
/*000000000d2c*/ s_add_u32       s0, s12, s14
/*000000000d30*/ s_mov_b32       s15, s14
/*000000000d34*/ s_addc_u32      s1, s13, s14
/*000000000d38*/ s_xor_b64       s[16:17], s[0:1], s[14:15]
/*000000000d3c*/ v_cvt_f32_u32   v1, s16
/*000000000d40*/ v_cvt_f32_u32   v2, s17
/*000000000d44*/ s_sub_u32       s1, 0, s16
/*000000000d48*/ s_subb_u32      s3, 0, s17
/*000000000d4c*/ s_ashr_i32      s18, s11, 31
/*000000000d50*/ v_mac_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000000d58*/ s_add_u32       s20, s10, s18
/*000000000d5c*/ s_mov_b32       s19, s18
/*000000000d60*/ s_addc_u32      s21, s11, s18
/*000000000d64*/ v_rcp_f32       v1, v1
/*000000000d68*/ v_mul_f32       v1, 0x5f7ffffc /* 1.844674e+19f */, v1
/*000000000d70*/ v_mul_f32       v2, 0x2f800000 /* 2.32830644e-10f */, v1
/*000000000d78*/ v_trunc_f32     v2, v2
/*000000000d7c*/ v_mac_f32       v1, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000000d84*/ v_cvt_u32_f32   v2, v2
/*000000000d88*/ v_cvt_u32_f32   v1, v1
/*000000000d8c*/ v_mul_lo_u32    v3, s1, v2
/*000000000d94*/ v_mul_hi_u32    v4, s1, v1
/*000000000d9c*/ v_mul_lo_u32    v5, s3, v1
/*000000000da4*/ v_add_nc_u32    v3, v4, v3
/*000000000da8*/ v_mul_lo_u32    v4, s1, v1
/*000000000db0*/ v_add_nc_u32    v3, v3, v5
/*000000000db4*/ v_mul_hi_u32    v5, v1, v4
/*000000000dbc*/ v_mul_lo_u32    v6, v1, v3
/*000000000dc4*/ v_mul_hi_u32    v7, v1, v3
/*000000000dcc*/ v_mul_hi_u32    v8, v2, v4
/*000000000dd4*/ v_mul_lo_u32    v4, v2, v4
/*000000000ddc*/ v_mul_hi_u32    v9, v2, v3
/*000000000de4*/ v_mul_lo_u32    v3, v2, v3
/*000000000dec*/ v_add_co_u32    v5, vcc, v5, v6
/*000000000df4*/ v_add_co_ci_u32 v6, vcc, 0, v7, vcc
/*000000000df8*/ v_add_co_u32    v4, vcc, v4, v5
/*000000000e00*/ v_add_co_ci_u32 v4, vcc, v6, v8, vcc
/*000000000e04*/ v_add_co_ci_u32 v5, vcc, 0, v9, vcc
/*000000000e08*/ v_add_co_u32    v3, vcc, v4, v3
/*000000000e10*/ v_add_co_ci_u32 v4, vcc, 0, v5, vcc
/*000000000e14*/ v_add_co_u32    v12, s[0:1], v1, v3
/*000000000e1c*/ v_add_co_ci_u32 v3, vcc, v2, v4, s[0:1]
/*000000000e24*/ v_add_nc_u32    v2, v2, v4
/*000000000e28*/ v_mul_hi_u32    v5, s1, v12
/*000000000e30*/ v_mul_lo_u32    v7, s3, v12
/*000000000e38*/ v_mul_lo_u32    v6, s1, v3
/*000000000e40*/ v_add_nc_u32    v5, v5, v6
/*000000000e44*/ v_mul_lo_u32    v6, s1, v12
/*000000000e4c*/ v_add_nc_u32    v5, v5, v7
/*000000000e50*/ v_mul_hi_u32    v7, v12, v6
/*000000000e58*/ v_mul_lo_u32    v8, v12, v5
/*000000000e60*/ v_mul_hi_u32    v9, v12, v5
/*000000000e68*/ v_mul_hi_u32    v10, v3, v6
/*000000000e70*/ v_mul_lo_u32    v6, v3, v6
/*000000000e78*/ v_mul_hi_u32    v11, v3, v5
/*000000000e80*/ v_mul_lo_u32    v3, v3, v5
/*000000000e88*/ v_add_co_u32    v7, vcc, v7, v8
/*000000000e90*/ v_add_co_ci_u32 v8, vcc, 0, v9, vcc
/*000000000e94*/ v_add_co_u32    v5, vcc, v7, v6
/*000000000e9c*/ v_add_co_ci_u32 v5, vcc, v8, v10, vcc
/*000000000ea0*/ v_add_co_ci_u32 v6, vcc, 0, v11, vcc
/*000000000ea4*/ v_add_co_u32    v3, vcc, v5, v3
/*000000000eac*/ v_add_co_ci_u32 v4, vcc, 0, v6, vcc
/*000000000eb0*/ v_add_co_ci_u32 v2, vcc, v2, v4, s[0:1]
/*000000000eb8*/ v_add_co_u32    v1, vcc, v12, v3
/*000000000ec0*/ s_xor_b64       s[0:1], s[20:21], s[18:19]
/*000000000ec4*/ v_add_co_ci_u32 v2, vcc, 0, v2, vcc
/*000000000ec8*/ v_mul_hi_u32    v3, s0, v1
/*000000000ed0*/ v_mul_hi_u32    v6, s1, v1
/*000000000ed8*/ v_mul_lo_u32    v1, s1, v1
/*000000000ee0*/ v_mul_lo_u32    v4, s0, v2
/*000000000ee8*/ v_mul_hi_u32    v5, s0, v2
/*000000000ef0*/ v_mul_hi_u32    v7, s1, v2
/*000000000ef8*/ v_mul_lo_u32    v2, s1, v2
/*000000000f00*/ v_add_co_u32    v3, vcc, v3, v4
/*000000000f08*/ v_add_co_ci_u32 v4, vcc, 0, v5, vcc
/*000000000f0c*/ v_add_co_u32    v1, vcc, v1, v3
/*000000000f14*/ v_add_co_ci_u32 v1, vcc, v4, v6, vcc
/*000000000f18*/ v_add_co_ci_u32 v3, vcc, 0, v7, vcc
/*000000000f1c*/ v_add_co_u32    v11, vcc, v1, v2
/*000000000f24*/ v_add_co_ci_u32 v2, vcc, 0, v3, vcc
/*000000000f28*/ v_mul_hi_u32    v3, s16, v11
/*000000000f30*/ v_mul_lo_u32    v5, s17, v11
/*000000000f38*/ v_mul_lo_u32    v4, s16, v2
/*000000000f40*/ v_add_nc_u32    v3, v3, v4
/*000000000f44*/ v_mul_lo_u32    v4, s16, v11
/*000000000f4c*/ v_add_nc_u32    v3, v3, v5
/*000000000f50*/ v_sub_co_u32    v4, vcc, s0, v4
/*000000000f58*/ v_sub_nc_u32    v5, s1, v3
/*000000000f5c*/ v_subrev_co_ci_u32 v5, s[0:1], s17, v5, vcc
/*000000000f64*/ v_sub_co_u32    v6, s[0:1], v4, s16
/*000000000f6c*/ v_sub_co_ci_u32 v3, vcc, s1, v3, vcc
/*000000000f70*/ v_subrev_co_ci_u32 v5, s[0:1], 0, v5, s[0:1]
/*000000000f78*/ v_add_co_u32    v7, s[0:1], v11, 2
/*000000000f80*/ v_add_co_ci_u32 v8, s[0:1], 0, v2, s[0:1]
/*000000000f88*/ v_cmp_le_u32    vcc, s17, v5
/*000000000f8c*/ v_cndmask_b32   v9, 0, -1, vcc
/*000000000f94*/ v_cmp_le_u32    vcc, s16, v6
/*000000000f98*/ v_cndmask_b32   v6, 0, -1, vcc
/*000000000fa0*/ v_cmp_eq_u32    vcc, s17, v5
/*000000000fa4*/ s_mov_b32       s0, vcc_lo
/*000000000fa8*/ v_cmp_le_u32    vcc, s17, v3
/*000000000fac*/ v_cndmask_b32   v5, 0, -1, vcc
/*000000000fb4*/ v_cmp_le_u32    vcc, s16, v4
/*000000000fb8*/ v_cndmask_b32   v6, v9, v6, s[0:1]
/*000000000fc0*/ v_cndmask_b32   v4, 0, -1, vcc
/*000000000fc8*/ v_add_co_u32    v9, vcc, v11, 1
/*000000000fd0*/ v_add_co_ci_u32 v10, vcc, 0, v2, vcc
/*000000000fd4*/ v_cmp_eq_u32    vcc, s17, v3
/*000000000fd8*/ v_cndmask_b32   v3, v5, v4, vcc
/*000000000fdc*/ v_cmp_lg_u32    s[0:1], 0, v6
/*000000000fe4*/ v_cmp_lg_u32    vcc, 0, v3
/*000000000fe8*/ v_cndmask_b32   v5, v9, v7, s[0:1]
/*000000000ff0*/ v_cndmask_b32   v4, v10, v8, s[0:1]
/*000000000ff8*/ s_xor_b64       s[0:1], s[18:19], s[14:15]
/*000000000ffc*/ v_cndmask_b32   v1, v11, v5, vcc
/*000000001000*/ v_cndmask_b32   v2, v2, v4, vcc
/*000000001004*/ v_xor_b32       v1, s0, v1
/*000000001008*/ v_xor_b32       v2, s1, v2
/*00000000100c*/ v_sub_co_u32    v1, vcc, v1, s0
/*000000001014*/ v_subrev_co_ci_u32 v2, vcc, s1, v2, vcc
/*000000001018*/ s_andn2_b32     vcc_lo, exec_lo, s2
/*00000000101c*/ s_cbranch_vccz  .L4132_0
/*000000001020*/ s_branch        .L4232_0
.L4132_0:
/*000000001024*/ v_cvt_f32_u32   v1, s12
/*000000001028*/ s_sub_i32       s0, 0, s12
/*00000000102c*/ v_rcp_iflag_f32 v1, v1
/*000000001030*/ v_mul_f32       v1, 0x4f7ffffe /* 4.29496678e+9f */, v1
/*000000001038*/ v_cvt_u32_f32   v1, v1
/*00000000103c*/ v_mul_lo_u32    v2, s0, v1
/*000000001044*/ v_mul_hi_u32    v2, v1, v2
/*00000000104c*/ v_add_nc_u32    v1, v1, v2
/*000000001050*/ v_mul_hi_u32    v1, s10, v1
/*000000001058*/ v_mul_lo_u32    v2, v1, s12
/*000000001060*/ v_add_nc_u32    v3, 1, v1
/*000000001064*/ v_sub_nc_u32    v2, s10, v2
/*000000001068*/ v_cmp_le_u32    vcc, s12, v2
/*00000000106c*/ v_subrev_nc_u32 v4, s12, v2
/*000000001070*/ v_cndmask_b32   v1, v1, v3, vcc
/*000000001074*/ v_cndmask_b32   v2, v2, v4, vcc
/*000000001078*/ v_add_nc_u32    v3, 1, v1
/*00000000107c*/ v_cmp_le_u32    vcc, s12, v2
/*000000001080*/ v_mov_b32       v2, 0
/*000000001084*/ v_cndmask_b32   v1, v1, v3, vcc
.L4232_0:
/*000000001088*/ s_load_dwordx2  s[0:1], s[4:5], 0x18
/*000000001090*/ v_lshl_or_b32   v0, s6, 6, v0
/*000000001098*/ s_waitcnt       lgkmcnt(0)
/*00000000109c*/ v_add_co_u32    v3, s[0:1], s0, v0
/*0000000010a4*/ v_add_co_ci_u32 v4, s[0:1], s1, 0, s[0:1]
/*0000000010ac*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*0000000010b4*/ v_add_co_u32    v3, vcc, s8, v3
/*0000000010bc*/ v_add_co_ci_u32 v4, vcc, s9, v4, vcc
/*0000000010c0*/ global_store_dwordx2 v[3:4], v[1:2], off
/*0000000010c8*/ s_endpgm
/*0000000010cc*/ s_nop           0x0
/*0000000010d0*/ s_nop           0x0
/*0000000010d4*/ s_nop           0x0
/*0000000010d8*/ s_nop           0x0
/*0000000010dc*/ s_nop           0x0
/*0000000010e0*/ s_nop           0x0
/*0000000010e4*/ s_nop           0x0
/*0000000010e8*/ s_nop           0x0
/*0000000010ec*/ s_nop           0x0
/*0000000010f0*/ s_nop           0x0
/*0000000010f4*/ s_nop           0x0
/*0000000010f8*/ s_nop           0x0
/*0000000010fc*/ s_nop           0x0
div_x_y_ulong:
.skip 256
/*000000001200*/ s_clause        0x1
/*000000001204*/ s_load_dwordx4  s[28:31], s[4:5], 0x0
/*00000000120c*/ s_load_dwordx4  s[12:15], s[4:5], 0x10
/*000000001214*/ s_waitcnt       lgkmcnt(0)
/*000000001218*/ s_or_b64        s[2:3], s[30:31], s[12:13]
/*00000000121c*/ s_mov_b32       s2, 0
/*000000001220*/ s_cmp_lg_u64    s[2:3], 0
/*000000001224*/ s_cbranch_scc0  .L5348_0
/*000000001228*/ v_cvt_f32_u32   v1, s12
/*00000000122c*/ v_cvt_f32_u32   v2, s13
/*000000001230*/ s_sub_u32       s1, 0, s12
/*000000001234*/ s_subb_u32      s3, 0, s13
/*000000001238*/ v_mac_f32       v1, 0x4f800000 /* 4.2949673e+9f */, v2
/*000000001240*/ v_rcp_f32       v1, v1
/*000000001244*/ v_mul_f32       v1, 0x5f7ffffc /* 1.844674e+19f */, v1
/*00000000124c*/ v_mul_f32       v2, 0x2f800000 /* 2.32830644e-10f */, v1
/*000000001254*/ v_trunc_f32     v2, v2
/*000000001258*/ v_mac_f32       v1, 0xcf800000 /* -4.2949673e+9f */, v2
/*000000001260*/ v_cvt_u32_f32   v2, v2
/*000000001264*/ v_cvt_u32_f32   v1, v1
/*000000001268*/ v_mul_lo_u32    v3, s1, v2
/*000000001270*/ v_mul_hi_u32    v4, s1, v1
/*000000001278*/ v_mul_lo_u32    v5, s3, v1
/*000000001280*/ v_add_nc_u32    v3, v4, v3
/*000000001284*/ v_mul_lo_u32    v4, s1, v1
/*00000000128c*/ v_add_nc_u32    v3, v3, v5
/*000000001290*/ v_mul_hi_u32    v5, v1, v4
/*000000001298*/ v_mul_lo_u32    v6, v1, v3
/*0000000012a0*/ v_mul_hi_u32    v7, v1, v3
/*0000000012a8*/ v_mul_hi_u32    v8, v2, v4
/*0000000012b0*/ v_mul_lo_u32    v4, v2, v4
/*0000000012b8*/ v_mul_hi_u32    v9, v2, v3
/*0000000012c0*/ v_mul_lo_u32    v3, v2, v3
/*0000000012c8*/ v_add_co_u32    v5, vcc, v5, v6
/*0000000012d0*/ v_add_co_ci_u32 v6, vcc, 0, v7, vcc
/*0000000012d4*/ v_add_co_u32    v4, vcc, v4, v5
/*0000000012dc*/ v_add_co_ci_u32 v4, vcc, v6, v8, vcc
/*0000000012e0*/ v_add_co_ci_u32 v5, vcc, 0, v9, vcc
/*0000000012e4*/ v_add_co_u32    v3, vcc, v4, v3
/*0000000012ec*/ v_add_co_ci_u32 v4, vcc, 0, v5, vcc
/*0000000012f0*/ v_add_co_u32    v12, s[0:1], v1, v3
/*0000000012f8*/ v_add_co_ci_u32 v3, vcc, v2, v4, s[0:1]
/*000000001300*/ v_add_nc_u32    v2, v2, v4
/*000000001304*/ v_mul_hi_u32    v5, s1, v12
/*00000000130c*/ v_mul_lo_u32    v7, s3, v12
/*000000001314*/ v_mul_lo_u32    v6, s1, v3
/*00000000131c*/ v_add_nc_u32    v5, v5, v6
/*000000001320*/ v_mul_lo_u32    v6, s1, v12
/*000000001328*/ v_add_nc_u32    v5, v5, v7
/*00000000132c*/ v_mul_hi_u32    v7, v12, v6
/*000000001334*/ v_mul_lo_u32    v8, v12, v5
/*00000000133c*/ v_mul_hi_u32    v9, v12, v5
/*000000001344*/ v_mul_hi_u32    v10, v3, v6
/*00000000134c*/ v_mul_lo_u32    v6, v3, v6
/*000000001354*/ v_mul_hi_u32    v11, v3, v5
/*00000000135c*/ v_mul_lo_u32    v3, v3, v5
/*000000001364*/ v_add_co_u32    v7, vcc, v7, v8
/*00000000136c*/ v_add_co_ci_u32 v8, vcc, 0, v9, vcc
/*000000001370*/ v_add_co_u32    v5, vcc, v7, v6
/*000000001378*/ v_add_co_ci_u32 v5, vcc, v8, v10, vcc
/*00000000137c*/ v_add_co_ci_u32 v6, vcc, 0, v11, vcc
/*000000001380*/ v_add_co_u32    v3, vcc, v5, v3
/*000000001388*/ v_add_co_ci_u32 v4, vcc, 0, v6, vcc
/*00000000138c*/ v_add_co_ci_u32 v2, vcc, v2, v4, s[0:1]
/*000000001394*/ v_add_co_u32    v1, vcc, v12, v3
/*00000000139c*/ v_add_co_ci_u32 v2, vcc, 0, v2, vcc
/*0000000013a0*/ v_mul_hi_u32    v3, s30, v1
/*0000000013a8*/ v_mul_hi_u32    v6, s31, v1
/*0000000013b0*/ v_mul_lo_u32    v1, s31, v1
/*0000000013b8*/ v_mul_lo_u32    v4, s30, v2
/*0000000013c0*/ v_mul_hi_u32    v5, s30, v2
/*0000000013c8*/ v_mul_hi_u32    v7, s31, v2
/*0000000013d0*/ v_mul_lo_u32    v2, s31, v2
/*0000000013d8*/ v_add_co_u32    v3, vcc, v3, v4
/*0000000013e0*/ v_add_co_ci_u32 v4, vcc, 0, v5, vcc
/*0000000013e4*/ v_add_co_u32    v1, vcc, v1, v3
/*0000000013ec*/ v_add_co_ci_u32 v1, vcc, v4, v6, vcc
/*0000000013f0*/ v_add_co_ci_u32 v3, vcc, 0, v7, vcc
/*0000000013f4*/ v_add_co_u32    v11, vcc, v1, v2
/*0000000013fc*/ v_add_co_ci_u32 v2, vcc, 0, v3, vcc
/*000000001400*/ v_mul_hi_u32    v3, s12, v11
/*000000001408*/ v_mul_lo_u32    v5, s13, v11
/*000000001410*/ v_mul_lo_u32    v4, s12, v2
/*000000001418*/ v_add_nc_u32    v3, v3, v4
/*00000000141c*/ v_mul_lo_u32    v4, s12, v11
/*000000001424*/ v_add_nc_u32    v3, v3, v5
/*000000001428*/ v_sub_co_u32    v4, vcc, s30, v4
/*000000001430*/ v_sub_nc_u32    v5, s31, v3
/*000000001434*/ v_subrev_co_ci_u32 v5, s[0:1], s13, v5, vcc
/*00000000143c*/ v_sub_co_u32    v6, s[0:1], v4, s12
/*000000001444*/ v_sub_co_ci_u32 v3, vcc, s31, v3, vcc
/*000000001448*/ v_subrev_co_ci_u32 v5, s[0:1], 0, v5, s[0:1]
/*000000001450*/ v_add_co_u32    v7, s[0:1], v11, 2
/*000000001458*/ v_add_co_ci_u32 v8, s[0:1], 0, v2, s[0:1]
/*000000001460*/ v_cmp_le_u32    vcc, s13, v5
/*000000001464*/ v_cndmask_b32   v9, 0, -1, vcc
/*00000000146c*/ v_cmp_le_u32    vcc, s12, v6
/*000000001470*/ v_cndmask_b32   v6, 0, -1, vcc
/*000000001478*/ v_cmp_eq_u32    vcc, s13, v5
/*00000000147c*/ s_mov_b32       s0, vcc_lo
/*000000001480*/ v_cmp_le_u32    vcc, s13, v3
/*000000001484*/ v_cndmask_b32   v5, 0, -1, vcc
/*00000000148c*/ v_cmp_le_u32    vcc, s12, v4
/*000000001490*/ v_cndmask_b32   v6, v9, v6, s[0:1]
/*000000001498*/ v_cndmask_b32   v4, 0, -1, vcc
/*0000000014a0*/ v_add_co_u32    v9, vcc, v11, 1
/*0000000014a8*/ v_add_co_ci_u32 v10, vcc, 0, v2, vcc
/*0000000014ac*/ v_cmp_eq_u32    vcc, s13, v3
/*0000000014b0*/ v_cndmask_b32   v3, v5, v4, vcc
/*0000000014b4*/ v_cmp_lg_u32    s[0:1], 0, v6
/*0000000014bc*/ v_cmp_lg_u32    vcc, 0, v3
/*0000000014c0*/ v_cndmask_b32   v4, v10, v8, s[0:1]
/*0000000014c8*/ v_cndmask_b32   v5, v9, v7, s[0:1]
/*0000000014d0*/ v_cndmask_b32   v2, v2, v4, vcc
/*0000000014d4*/ v_cndmask_b32   v1, v11, v5, vcc
/*0000000014d8*/ s_andn2_b32     vcc_lo, exec_lo, s2
/*0000000014dc*/ s_cbranch_vccz  .L5348_0
/*0000000014e0*/ s_branch        .L5448_0
.L5348_0:
/*0000000014e4*/ v_cvt_f32_u32   v1, s12
/*0000000014e8*/ s_sub_i32       s0, 0, s12
/*0000000014ec*/ v_rcp_iflag_f32 v1, v1
/*0000000014f0*/ v_mul_f32       v1, 0x4f7ffffe /* 4.29496678e+9f */, v1
/*0000000014f8*/ v_cvt_u32_f32   v1, v1
/*0000000014fc*/ v_mul_lo_u32    v2, s0, v1
/*000000001504*/ v_mul_hi_u32    v2, v1, v2
/*00000000150c*/ v_add_nc_u32    v1, v1, v2
/*000000001510*/ v_mul_hi_u32    v1, s30, v1
/*000000001518*/ v_mul_lo_u32    v2, v1, s12
/*000000001520*/ v_add_nc_u32    v3, 1, v1
/*000000001524*/ v_sub_nc_u32    v2, s30, v2
/*000000001528*/ v_cmp_le_u32    vcc, s12, v2
/*00000000152c*/ v_subrev_nc_u32 v4, s12, v2
/*000000001530*/ v_cndmask_b32   v1, v1, v3, vcc
/*000000001534*/ v_cndmask_b32   v2, v2, v4, vcc
/*000000001538*/ v_add_nc_u32    v3, 1, v1
/*00000000153c*/ v_cmp_le_u32    vcc, s12, v2
/*000000001540*/ v_mov_b32       v2, 0
/*000000001544*/ v_cndmask_b32   v1, v1, v3, vcc
.L5448_0:
/*000000001548*/ s_load_dwordx2  s[0:1], s[4:5], 0x18
/*000000001550*/ v_lshl_or_b32   v0, s6, 6, v0
/*000000001558*/ s_waitcnt       lgkmcnt(0)
/*00000000155c*/ v_add_co_u32    v3, s[0:1], s0, v0
/*000000001564*/ v_add_co_ci_u32 v4, s[0:1], s1, 0, s[0:1]
/*00000000156c*/ v_lshlrev_b64   v[3:4], 3, v[3:4]
/*000000001574*/ v_add_co_u32    v3, vcc, s28, v3
/*00000000157c*/ v_add_co_ci_u32 v4, vcc, s29, v4, vcc
/*000000001580*/ global_store_dwordx2 v[3:4], v[1:2], off
/*000000001588*/ s_endpgm
/*00000000158c*/ s_nop           0x0
/*000000001590*/ s_nop           0x0
/*000000001594*/ s_nop           0x0
/*000000001598*/ s_nop           0x0
/*00000000159c*/ s_nop           0x0
/*0000000015a0*/ s_nop           0x0
/*0000000015a4*/ s_nop           0x0
/*0000000015a8*/ s_nop           0x0
/*0000000015ac*/ s_nop           0x0
/*0000000015b0*/ s_nop           0x0
/*0000000015b4*/ s_nop           0x0
/*0000000015b8*/ s_nop           0x0
/*0000000015bc*/ s_nop           0x0
/*0000000015c0*/ s_nop           0x0
/*0000000015c4*/ s_nop           0x0
/*0000000015c8*/ s_nop           0x0
/*0000000015cc*/ s_nop           0x0
/*0000000015d0*/ s_nop           0x0
/*0000000015d4*/ s_nop           0x0
/*0000000015d8*/ s_nop           0x0
/*0000000015dc*/ s_nop           0x0
/*0000000015e0*/ s_nop           0x0
/*0000000015e4*/ s_nop           0x0
/*0000000015e8*/ s_nop           0x0
/*0000000015ec*/ s_nop           0x0
/*0000000015f0*/ s_nop           0x0
/*0000000015f4*/ s_nop           0x0
/*0000000015f8*/ s_nop           0x0
/*0000000015fc*/ s_nop           0x0
div_x_y_float:
.skip 256
/*000000001700*/ s_clause        0x1
/*000000001704*/ s_load_dwordx2  s[8:9], s[4:5], 0x8
/*00000000170c*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*000000001714*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000171c*/ s_waitcnt       lgkmcnt(0)
/*000000001720*/ v_div_scale_f32 v1, s[2:3], s9, s9, s8
/*000000001728*/ v_div_scale_f32 v4, vcc, s8, s9, s8
/*000000001730*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000001738*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000001740*/ v_rcp_f32       v2, v1
/*000000001744*/ v_fma_f32       v3, -v1, v2, 1.0
/*00000000174c*/ v_fmac_f32      v2, v3, v2
/*000000001750*/ v_mul_f32       v3, v4, v2
/*000000001754*/ v_fma_f32       v5, v3, -v1, v4
/*00000000175c*/ v_fmac_f32      v3, v5, v2
/*000000001760*/ v_fmac_f32      v4, -v1, v3
/*000000001768*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000001770*/ v_div_fmas_f32  v2, v4, v2, v3
/*000000001778*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000001780*/ v_div_fixup_f32 v2, v2, s9, s8
/*000000001788*/ s_waitcnt       lgkmcnt(0)
/*00000000178c*/ v_add_co_u32    v0, vcc, s2, v0
/*000000001794*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*000000001798*/ global_store_dword v[0:1], v2, off
/*0000000017a0*/ s_endpgm
/*0000000017a4*/ s_nop           0x0
/*0000000017a8*/ s_nop           0x0
/*0000000017ac*/ s_nop           0x0
/*0000000017b0*/ s_nop           0x0
/*0000000017b4*/ s_nop           0x0
/*0000000017b8*/ s_nop           0x0
/*0000000017bc*/ s_nop           0x0
/*0000000017c0*/ s_nop           0x0
/*0000000017c4*/ s_nop           0x0
/*0000000017c8*/ s_nop           0x0
/*0000000017cc*/ s_nop           0x0
/*0000000017d0*/ s_nop           0x0
/*0000000017d4*/ s_nop           0x0
/*0000000017d8*/ s_nop           0x0
/*0000000017dc*/ s_nop           0x0
/*0000000017e0*/ s_nop           0x0
/*0000000017e4*/ s_nop           0x0
/*0000000017e8*/ s_nop           0x0
/*0000000017ec*/ s_nop           0x0
/*0000000017f0*/ s_nop           0x0
/*0000000017f4*/ s_nop           0x0
/*0000000017f8*/ s_nop           0x0
/*0000000017fc*/ s_nop           0x0
div_x_y_double:
.skip 256
/*000000001900*/ s_clause        0x2
/*000000001904*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*00000000190c*/ s_load_dwordx4  s[8:11], s[4:5], 0x10
/*000000001914*/ s_load_dwordx2  s[4:5], s[4:5], 0x18
/*00000000191c*/ s_waitcnt       lgkmcnt(0)
/*000000001920*/ v_div_scale_f64 v[1:2], s[7:8], s[8:9], s[8:9], s[2:3]
/*000000001928*/ v_rcp_f64       v[3:4], v[1:2]
/*00000000192c*/ v_fma_f64       v[5:6], -v[1:2], v[3:4], 1.0
/*000000001934*/ v_fma_f64       v[3:4], v[3:4], v[5:6], v[3:4]
/*00000000193c*/ v_fma_f64       v[5:6], -v[1:2], v[3:4], 1.0
/*000000001944*/ v_fma_f64       v[3:4], v[3:4], v[5:6], v[3:4]
/*00000000194c*/ v_div_scale_f64 v[5:6], vcc, s[2:3], s[8:9], s[2:3]
/*000000001954*/ v_mul_f64       v[7:8], v[5:6], v[3:4]
/*00000000195c*/ v_fma_f64       v[1:2], -v[1:2], v[7:8], v[5:6]
/*000000001964*/ v_div_fmas_f64  v[1:2], v[1:2], v[3:4], v[7:8]
/*00000000196c*/ v_lshl_or_b32   v3, s6, 6, v0
/*000000001974*/ v_div_fixup_f64 v[0:1], v[1:2], s[8:9], s[2:3]
/*00000000197c*/ v_add_co_u32    v2, s[2:3], s4, v3
/*000000001984*/ v_add_co_ci_u32 v3, s[2:3], s5, 0, s[2:3]
/*00000000198c*/ v_lshlrev_b64   v[2:3], 3, v[2:3]
/*000000001994*/ v_add_co_u32    v2, vcc, s0, v2
/*00000000199c*/ v_add_co_ci_u32 v3, vcc, s1, v3, vcc
/*0000000019a0*/ global_store_dwordx2 v[2:3], v[0:1], off
/*0000000019a8*/ s_endpgm
/*0000000019ac*/ s_code_end
/*0000000019b0*/ s_code_end
/*0000000019b4*/ s_code_end
/*0000000019b8*/ s_code_end
/*0000000019bc*/ s_code_end
/*0000000019c0*/ s_code_end
/*0000000019c4*/ s_code_end
/*0000000019c8*/ s_code_end
/*0000000019cc*/ s_code_end
/*0000000019d0*/ s_code_end
/*0000000019d4*/ s_code_end
/*0000000019d8*/ s_code_end
/*0000000019dc*/ s_code_end
/*0000000019e0*/ s_code_end
/*0000000019e4*/ s_code_end
/*0000000019e8*/ s_code_end
/*0000000019ec*/ s_code_end
/*0000000019f0*/ s_code_end
/*0000000019f4*/ s_code_end
/*0000000019f8*/ s_code_end
/*0000000019fc*/ s_code_end
/*000000001a00*/ s_code_end
/*000000001a04*/ s_code_end
/*000000001a08*/ s_code_end
/*000000001a0c*/ s_code_end
/*000000001a10*/ s_code_end
/*000000001a14*/ s_code_end
/*000000001a18*/ s_code_end
/*000000001a1c*/ s_code_end
/*000000001a20*/ s_code_end
/*000000001a24*/ s_code_end
/*000000001a28*/ s_code_end
/*000000001a2c*/ s_code_end
/*000000001a30*/ s_code_end
/*000000001a34*/ s_code_end
/*000000001a38*/ s_code_end
/*000000001a3c*/ s_code_end
/*000000001a40*/ s_code_end
/*000000001a44*/ s_code_end
/*000000001a48*/ s_code_end
/*000000001a4c*/ s_code_end
/*000000001a50*/ s_code_end
/*000000001a54*/ s_code_end
/*000000001a58*/ s_code_end
/*000000001a5c*/ s_code_end
/*000000001a60*/ s_code_end
/*000000001a64*/ s_code_end
/*000000001a68*/ s_code_end
/*000000001a6c*/ s_code_end
/*000000001a70*/ s_code_end
/*000000001a74*/ s_code_end
/*000000001a78*/ s_code_end
/*000000001a7c*/ s_code_end
