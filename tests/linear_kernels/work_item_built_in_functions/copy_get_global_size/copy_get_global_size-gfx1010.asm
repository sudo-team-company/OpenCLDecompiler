/* Disassembling 'linear_kernels\work_item_built_in_functions\copy_get_global_size\copy_get_global_size-gfx1010.bin' */
.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel copy_get_global_size
    .config
        .dims xyz
        .sgprsnum 24
        .vgprsnum 8
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 8
        .pgmrsrc1 0x60af0081
        .pgmrsrc2 0x00001390
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_dispatch_ptr
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 72
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 14
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "copy_get_global_size@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 16, 2, 2
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 14
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
copy_get_global_size:
.skip 256
/*000000000100*/ s_load_dwordx4  s[0:3], s[6:7], 0x10
/*000000000108*/ s_waitcnt       lgkmcnt(0)
/*00000000010c*/ s_load_dword    s1, s[6:7], 0x20
/*000000000114*/ s_load_dwordx4  s[12:15], s[4:5], 0xc
/*00000000011c*/ s_load_dwordx2  s[4:5], s[6:7], 0x0
/*000000000124*/ v_mov_b32       v4, 0
/*000000000128*/ s_lshl_b32      s3, s8, 4
/*00000000012c*/ s_lshl_b32      s6, s9, 1
/*000000000130*/ s_lshl_b32      s7, s10, 1
/*000000000134*/ v_mov_b32       v6, v4
/*000000000138*/ v_mov_b32       v8, v4
/*00000000013c*/ s_waitcnt       lgkmcnt(0)
/*000000000140*/ v_add3_u32      v7, s1, s7, v2
/*000000000148*/ v_add3_u32      v3, s0, s3, v0
/*000000000150*/ v_add3_u32      v5, s2, s6, v1
/*000000000158*/ v_mov_b32       v11, s12
/*00000000015c*/ v_mov_b32       v13, s13
/*000000000160*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*000000000168*/ v_lshlrev_b64   v[2:3], 2, v[5:6]
/*000000000170*/ v_lshlrev_b64   v[4:5], 2, v[7:8]
/*000000000178*/ v_mov_b32       v6, s14
/*00000000017c*/ v_add_co_u32    v0, vcc, s4, v0
/*000000000184*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000188*/ v_add_co_u32    v2, vcc, s4, v2
/*000000000190*/ v_add_co_ci_u32 v3, vcc, s5, v3, vcc
/*000000000194*/ v_add_co_u32    v4, vcc, s4, v4
/*00000000019c*/ v_add_co_ci_u32 v5, vcc, s5, v5, vcc
/*0000000001a0*/ global_store_dword v[0:1], v11, off
/*0000000001a8*/ global_store_dword v[2:3], v13, off
/*0000000001b0*/ global_store_dword v[4:5], v6, off
/*0000000001b8*/ s_endpgm
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
