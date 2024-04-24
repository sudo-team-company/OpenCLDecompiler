/* Disassembling 'loops_kernels\loop_unrolled_2\loop_unrolled_2-gfx1030.bin' */
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
/*000000000160*/ v_add_nc_u32    v2, 7, v2
/*000000000164*/ v_mul_lo_u32    v2, v2, s0
/*00000000016c*/ v_add_nc_u32    v2, 10, v2
/*000000000170*/ v_mul_lo_u32    v2, v2, s0
/*000000000178*/ v_add_nc_u32    v2, 13, v2
/*00000000017c*/ v_mul_lo_u32    v2, v2, s0
/*000000000184*/ v_add_nc_u32    v2, 16, v2
/*000000000188*/ v_mul_lo_u32    v2, v2, s0
/*000000000190*/ v_add_nc_u32    v2, 19, v2
/*000000000194*/ v_mul_lo_u32    v2, v2, s0
/*00000000019c*/ v_add_nc_u32    v2, 22, v2
/*0000000001a0*/ v_mul_lo_u32    v2, v2, s0
/*0000000001a8*/ v_add_nc_u32    v2, 25, v2
/*0000000001ac*/ v_mul_lo_u32    v2, v2, s0
/*0000000001b4*/ v_add_nc_u32    v2, 28, v2
/*0000000001b8*/ v_mul_lo_u32    v2, v2, s0
/*0000000001c0*/ v_add_nc_u32    v2, 31, v2
/*0000000001c4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001cc*/ v_add_nc_u32    v2, 34, v2
/*0000000001d0*/ v_mul_lo_u32    v2, v2, s0
/*0000000001d8*/ v_add_nc_u32    v2, 37, v2
/*0000000001dc*/ v_mul_lo_u32    v2, v2, s0
/*0000000001e4*/ v_add_nc_u32    v2, 40, v2
/*0000000001e8*/ v_mul_lo_u32    v2, v2, s0
/*0000000001f0*/ v_add_nc_u32    v2, 43, v2
/*0000000001f4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001fc*/ v_add_nc_u32    v2, 46, v2
/*000000000200*/ v_mul_lo_u32    v2, v2, s0
/*000000000208*/ v_add_nc_u32    v2, 49, v2
/*00000000020c*/ v_mul_lo_u32    v2, v2, s0
/*000000000214*/ v_add_nc_u32    v2, 52, v2
/*000000000218*/ v_mul_lo_u32    v2, v2, s0
/*000000000220*/ v_add_nc_u32    v2, 55, v2
/*000000000224*/ v_mul_lo_u32    v2, v2, s0
/*00000000022c*/ v_add_nc_u32    v2, 58, v2
/*000000000230*/ v_mul_lo_u32    v2, v2, s0
/*000000000238*/ v_add_nc_u32    v2, 61, v2
/*00000000023c*/ v_mul_lo_u32    v2, v2, s0
/*000000000244*/ v_add_nc_u32    v2, 64, v2
/*000000000248*/ v_mul_lo_u32    v2, v2, s0
/*000000000250*/ v_add_nc_u32    v2, 0x43, v2
/*000000000258*/ v_mul_lo_u32    v2, v2, s0
/*000000000260*/ v_add_nc_u32    v2, 0x46, v2
/*000000000268*/ v_mul_lo_u32    v2, v2, s0
/*000000000270*/ v_add_nc_u32    v2, 0x49, v2
/*000000000278*/ v_mul_lo_u32    v2, v2, s0
/*000000000280*/ v_add_nc_u32    v2, 0x4c, v2
/*000000000288*/ v_mul_lo_u32    v2, v2, s0
/*000000000290*/ v_add_nc_u32    v2, 0x4f, v2
/*000000000298*/ v_mul_lo_u32    v2, v2, s0
/*0000000002a0*/ v_add_nc_u32    v2, 0x52, v2
/*0000000002a8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002b0*/ v_add_nc_u32    v2, 0x55, v2
/*0000000002b8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002c0*/ v_add_nc_u32    v2, 0x58, v2
/*0000000002c8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002d0*/ v_add_nc_u32    v2, 0x5b, v2
/*0000000002d8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002e0*/ v_add_nc_u32    v2, 0x5e, v2
/*0000000002e8*/ v_mul_lo_u32    v2, v2, s0
/*0000000002f0*/ v_add_nc_u32    v2, 0x61, v2
/*0000000002f8*/ v_mul_lo_u32    v2, v2, s0
/*000000000300*/ v_add_nc_u32    v2, 0x64, v2
/*000000000308*/ v_mul_lo_u32    v2, v2, s0
/*000000000310*/ v_add_nc_u32    v2, 0x67, v2
/*000000000318*/ v_mul_lo_u32    v2, v2, s0
/*000000000320*/ v_add_nc_u32    v2, 0x6a, v2
/*000000000328*/ v_mul_lo_u32    v2, v2, s0
/*000000000330*/ v_add_nc_u32    v2, 0x6d, v2
/*000000000338*/ v_mul_lo_u32    v2, v2, s0
/*000000000340*/ v_add_nc_u32    v2, 0x70, v2
/*000000000348*/ v_mul_lo_u32    v2, v2, s0
/*000000000350*/ v_add_nc_u32    v2, 0x73, v2
/*000000000358*/ v_mul_lo_u32    v2, v2, s0
/*000000000360*/ v_add_nc_u32    v2, 0x76, v2
/*000000000368*/ v_mul_lo_u32    v2, v2, s0
/*000000000370*/ v_add_nc_u32    v2, 0x79, v2
/*000000000378*/ global_store_dword v[0:1], v2, off
/*000000000380*/ s_endpgm
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
/*000000000440*/ s_code_end
/*000000000444*/ s_code_end
/*000000000448*/ s_code_end
/*00000000044c*/ s_code_end
/*000000000450*/ s_code_end
/*000000000454*/ s_code_end
/*000000000458*/ s_code_end
/*00000000045c*/ s_code_end
/*000000000460*/ s_code_end
/*000000000464*/ s_code_end
/*000000000468*/ s_code_end
/*00000000046c*/ s_code_end
/*000000000470*/ s_code_end
/*000000000474*/ s_code_end
/*000000000478*/ s_code_end
/*00000000047c*/ s_code_end
