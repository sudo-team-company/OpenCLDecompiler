/* Disassembling 'loops_kernels\loop_unrolled\loop_unrolled-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel loop_unrolled
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
        .kernarg_segment_size 72
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
        .md_symname "loop_unrolled@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 9
        .md_vgprsnum 3
        .max_flat_work_group_size 64
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg x, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
loop_unrolled:
.skip 256
/*000000000100*/ s_clause        0x1
/*000000000104*/ s_load_dwordx2  s[0:1], s[4:5], 0x10
/*00000000010c*/ s_load_dwordx2  s[2:3], s[4:5], 0x0
/*000000000114*/ v_lshl_or_b32   v0, s6, 6, v0
/*00000000011c*/ s_waitcnt       lgkmcnt(0)
/*000000000120*/ v_add_co_u32    v0, s[0:1], s0, v0
/*000000000128*/ v_add_co_ci_u32 v1, s[0:1], s1, 0, s[0:1]
/*000000000130*/ s_load_dword    s0, s[4:5], 0x8
/*000000000138*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000140*/ v_add_co_u32    v0, vcc, s2, v0
/*000000000148*/ v_add_co_ci_u32 v1, vcc, s3, v1, vcc
/*00000000014c*/ global_load_dword v2, v[0:1], off
/*000000000154*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000158*/ v_mul_lo_u32    v2, v2, s0
/*000000000160*/ v_mul_lo_u32    v2, v2, s0
/*000000000168*/ v_add_nc_u32    v2, 1, v2
/*00000000016c*/ v_mul_lo_u32    v2, v2, s0
/*000000000174*/ v_add_nc_u32    v2, 2, v2
/*000000000178*/ v_mul_lo_u32    v2, v2, s0
/*000000000180*/ v_add_nc_u32    v2, 3, v2
/*000000000184*/ v_mul_lo_u32    v2, v2, s0
/*00000000018c*/ v_add_nc_u32    v2, 4, v2
/*000000000190*/ v_mul_lo_u32    v2, v2, s0
/*000000000198*/ v_add_nc_u32    v2, 5, v2
/*00000000019c*/ v_mul_lo_u32    v2, v2, s0
/*0000000001a4*/ v_add_nc_u32    v2, 6, v2
/*0000000001a8*/ v_mul_lo_u32    v2, v2, s0
/*0000000001b0*/ v_add_nc_u32    v2, 7, v2
/*0000000001b4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001bc*/ v_add_nc_u32    v2, 8, v2
/*0000000001c0*/ v_mul_lo_u32    v2, v2, s0
/*0000000001c8*/ v_add_nc_u32    v2, 9, v2
/*0000000001cc*/ v_mul_lo_u32    v2, v2, s0
/*0000000001d4*/ v_add_nc_u32    v2, 10, v2
/*0000000001d8*/ v_mul_lo_u32    v2, v2, s0
/*0000000001e0*/ v_add_nc_u32    v2, 11, v2
/*0000000001e4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001ec*/ v_add_nc_u32    v2, 12, v2
/*0000000001f0*/ v_mul_lo_u32    v2, v2, s0
/*0000000001f8*/ v_add_nc_u32    v2, 13, v2
/*0000000001fc*/ v_mul_lo_u32    v2, v2, s0
/*000000000204*/ v_add_nc_u32    v2, 14, v2
/*000000000208*/ v_mul_lo_u32    v2, v2, s0
/*000000000210*/ v_add_nc_u32    v2, 15, v2
/*000000000214*/ v_mul_lo_u32    v2, v2, s0
/*00000000021c*/ v_add_nc_u32    v2, 16, v2
/*000000000220*/ v_mul_lo_u32    v2, v2, s0
/*000000000228*/ v_add_nc_u32    v2, 17, v2
/*00000000022c*/ v_mul_lo_u32    v2, v2, s0
/*000000000234*/ v_add_nc_u32    v2, 18, v2
/*000000000238*/ v_mul_lo_u32    v2, v2, s0
/*000000000240*/ v_add_nc_u32    v2, 19, v2
/*000000000244*/ v_mul_lo_u32    v2, v2, s0
/*00000000024c*/ v_add_nc_u32    v2, 20, v2
/*000000000250*/ v_mul_lo_u32    v2, v2, s0
/*000000000258*/ v_add_nc_u32    v2, 21, v2
/*00000000025c*/ v_mul_lo_u32    v2, v2, s0
/*000000000264*/ v_add_nc_u32    v2, 22, v2
/*000000000268*/ v_mul_lo_u32    v2, v2, s0
/*000000000270*/ v_add_nc_u32    v2, 23, v2
/*000000000274*/ v_mul_lo_u32    v2, v2, s0
/*00000000027c*/ v_add_nc_u32    v2, 24, v2
/*000000000280*/ v_mul_lo_u32    v2, v2, s0
/*000000000288*/ v_add_nc_u32    v2, 25, v2
/*00000000028c*/ v_mul_lo_u32    v2, v2, s0
/*000000000294*/ v_add_nc_u32    v2, 26, v2
/*000000000298*/ v_mul_lo_u32    v2, v2, s0
/*0000000002a0*/ v_add_nc_u32    v2, 27, v2
/*0000000002a4*/ v_mul_lo_u32    v2, v2, s0
/*0000000002ac*/ v_add_nc_u32    v2, 28, v2
/*0000000002b0*/ v_mul_lo_u32    v2, v2, s0
/*0000000002b8*/ v_add_nc_u32    v2, 29, v2
/*0000000002bc*/ v_mul_lo_u32    v2, v2, s0
/*0000000002c4*/ v_add_nc_u32    v2, 30, v2
/*0000000002c8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002d0*/ v_add_nc_u32    v2, 31, v2
/*0000000002d4*/ v_mul_lo_u32    v2, v2, s0
/*0000000002dc*/ v_add_nc_u32    v2, 32, v2
/*0000000002e0*/ v_mul_lo_u32    v2, v2, s0
/*0000000002e8*/ v_add_nc_u32    v2, 33, v2
/*0000000002ec*/ v_mul_lo_u32    v2, v2, s0
/*0000000002f4*/ v_add_nc_u32    v2, 34, v2
/*0000000002f8*/ v_mul_lo_u32    v2, v2, s0
/*000000000300*/ v_add_nc_u32    v2, 35, v2
/*000000000304*/ v_mul_lo_u32    v2, v2, s0
/*00000000030c*/ v_add_nc_u32    v2, 36, v2
/*000000000310*/ v_mul_lo_u32    v2, v2, s0
/*000000000318*/ v_add_nc_u32    v2, 37, v2
/*00000000031c*/ v_mul_lo_u32    v2, v2, s0
/*000000000324*/ v_add_nc_u32    v2, 38, v2
/*000000000328*/ v_mul_lo_u32    v2, v2, s0
/*000000000330*/ v_add_nc_u32    v2, 39, v2
/*000000000334*/ v_mul_lo_u32    v2, v2, s0
/*00000000033c*/ v_add_nc_u32    v2, 40, v2
/*000000000340*/ v_mul_lo_u32    v2, v2, s0
/*000000000348*/ v_add_nc_u32    v2, 41, v2
/*00000000034c*/ v_mul_lo_u32    v2, v2, s0
/*000000000354*/ v_add_nc_u32    v2, 42, v2
/*000000000358*/ v_mul_lo_u32    v2, v2, s0
/*000000000360*/ v_add_nc_u32    v2, 43, v2
/*000000000364*/ v_mul_lo_u32    v2, v2, s0
/*00000000036c*/ v_add_nc_u32    v2, 44, v2
/*000000000370*/ v_mul_lo_u32    v2, v2, s0
/*000000000378*/ v_add_nc_u32    v2, 45, v2
/*00000000037c*/ v_mul_lo_u32    v2, v2, s0
/*000000000384*/ v_add_nc_u32    v2, 46, v2
/*000000000388*/ v_mul_lo_u32    v2, v2, s0
/*000000000390*/ v_add_nc_u32    v2, 47, v2
/*000000000394*/ v_mul_lo_u32    v2, v2, s0
/*00000000039c*/ v_add_nc_u32    v2, 48, v2
/*0000000003a0*/ v_mul_lo_u32    v2, v2, s0
/*0000000003a8*/ v_add_nc_u32    v2, 49, v2
/*0000000003ac*/ v_mul_lo_u32    v2, v2, s0
/*0000000003b4*/ v_add_nc_u32    v2, 50, v2
/*0000000003b8*/ v_mul_lo_u32    v2, v2, s0
/*0000000003c0*/ v_add_nc_u32    v2, 51, v2
/*0000000003c4*/ v_mul_lo_u32    v2, v2, s0
/*0000000003cc*/ v_add_nc_u32    v2, 52, v2
/*0000000003d0*/ v_mul_lo_u32    v2, v2, s0
/*0000000003d8*/ v_add_nc_u32    v2, 53, v2
/*0000000003dc*/ v_mul_lo_u32    v2, v2, s0
/*0000000003e4*/ v_add_nc_u32    v2, 54, v2
/*0000000003e8*/ v_mul_lo_u32    v2, v2, s0
/*0000000003f0*/ v_add_nc_u32    v2, 55, v2
/*0000000003f4*/ v_mul_lo_u32    v2, v2, s0
/*0000000003fc*/ v_add_nc_u32    v2, 56, v2
/*000000000400*/ v_mul_lo_u32    v2, v2, s0
/*000000000408*/ v_add_nc_u32    v2, 57, v2
/*00000000040c*/ v_mul_lo_u32    v2, v2, s0
/*000000000414*/ v_add_nc_u32    v2, 58, v2
/*000000000418*/ v_mul_lo_u32    v2, v2, s0
/*000000000420*/ v_add_nc_u32    v2, 59, v2
/*000000000424*/ v_mul_lo_u32    v2, v2, s0
/*00000000042c*/ v_add_nc_u32    v2, 60, v2
/*000000000430*/ v_mul_lo_u32    v2, v2, s0
/*000000000438*/ v_add_nc_u32    v2, 61, v2
/*00000000043c*/ v_mul_lo_u32    v2, v2, s0
/*000000000444*/ v_add_nc_u32    v2, 62, v2
/*000000000448*/ v_mul_lo_u32    v2, v2, s0
/*000000000450*/ v_add_nc_u32    v2, 63, v2
/*000000000454*/ global_store_dword v[0:1], v2, off
/*00000000045c*/ s_endpgm
/*000000000460*/ s_code_end
/*000000000464*/ s_code_end
/*000000000468*/ s_code_end
/*00000000046c*/ s_code_end
/*000000000470*/ s_code_end
/*000000000474*/ s_code_end
/*000000000478*/ s_code_end
/*00000000047c*/ s_code_end
/*000000000480*/ s_code_end
/*000000000484*/ s_code_end
/*000000000488*/ s_code_end
/*00000000048c*/ s_code_end
/*000000000490*/ s_code_end
/*000000000494*/ s_code_end
/*000000000498*/ s_code_end
/*00000000049c*/ s_code_end
/*0000000004a0*/ s_code_end
/*0000000004a4*/ s_code_end
/*0000000004a8*/ s_code_end
/*0000000004ac*/ s_code_end
/*0000000004b0*/ s_code_end
/*0000000004b4*/ s_code_end
/*0000000004b8*/ s_code_end
/*0000000004bc*/ s_code_end
/*0000000004c0*/ s_code_end
/*0000000004c4*/ s_code_end
/*0000000004c8*/ s_code_end
/*0000000004cc*/ s_code_end
/*0000000004d0*/ s_code_end
/*0000000004d4*/ s_code_end
/*0000000004d8*/ s_code_end
/*0000000004dc*/ s_code_end
/*0000000004e0*/ s_code_end
/*0000000004e4*/ s_code_end
/*0000000004e8*/ s_code_end
/*0000000004ec*/ s_code_end
/*0000000004f0*/ s_code_end
/*0000000004f4*/ s_code_end
/*0000000004f8*/ s_code_end
/*0000000004fc*/ s_code_end
/*000000000500*/ s_code_end
/*000000000504*/ s_code_end
/*000000000508*/ s_code_end
/*00000000050c*/ s_code_end
/*000000000510*/ s_code_end
/*000000000514*/ s_code_end
/*000000000518*/ s_code_end
/*00000000051c*/ s_code_end
/*000000000520*/ s_code_end
/*000000000524*/ s_code_end
/*000000000528*/ s_code_end
/*00000000052c*/ s_code_end
/*000000000530*/ s_code_end
/*000000000534*/ s_code_end
/*000000000538*/ s_code_end
/*00000000053c*/ s_code_end
