/* Disassembling 'linear_kernels\work_item_built_in_functions\copy_get_num_groups\copy_get_num_groups-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel copy_get_num_groups
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
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_dispatch_ptr
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 72
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 12
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "copy_get_num_groups@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 2, 2, 4
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 12
        .max_flat_work_group_size 16
        .arg x, "int", 4, 4, value, struct
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
copy_get_num_groups:
.skip 256
/*000000000100*/ s_load_dwordx4  s[0:3], s[4:5], 0xc
/*000000000108*/ s_load_dwordx4  s[12:15], s[6:7], 0x10
/*000000000110*/ s_waitcnt       lgkmcnt(0)
/*000000000114*/ s_clause        0x1
/*000000000118*/ s_load_dword    s3, s[6:7], 0x20
/*000000000120*/ s_load_dwordx2  s[4:5], s[6:7], 0x8
/*000000000128*/ s_lshl_b32      s7, s9, 1
/*00000000012c*/ s_lshl_b32      s6, s8, 1
/*000000000130*/ s_lshl_b32      s8, s10, 2
/*000000000134*/ v_mov_b32       v4, 0
/*000000000138*/ v_mov_b32       v6, v4
/*00000000013c*/ v_mov_b32       v8, v4
/*000000000140*/ s_and_b32       s9, s0, -2
/*000000000144*/ s_waitcnt       lgkmcnt(0)
/*000000000148*/ v_add3_u32      v7, s3, s8, v2
/*000000000150*/ v_cmp_gt_u32    s[9:10], s0, s9
/*000000000158*/ s_lshr_b32      s0, s0, 1
/*00000000015c*/ v_add3_u32      v3, s12, s6, v0
/*000000000164*/ v_add3_u32      v5, s14, s7, v1
/*00000000016c*/ s_cmpk_lg_u32   s9, 0x0
/*000000000170*/ s_addc_u32      s0, s0, 0
/*000000000174*/ s_and_b32       s3, s1, -2
/*000000000178*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*000000000180*/ v_cmp_gt_u32    s[3:4], s1, s3
/*000000000188*/ s_lshr_b32      s1, s1, 1
/*00000000018c*/ v_lshlrev_b64   v[2:3], 2, v[5:6]
/*000000000194*/ v_mov_b32       v6, s0
/*000000000198*/ v_lshlrev_b64   v[4:5], 2, v[7:8]
/*0000000001a0*/ s_cmpk_lg_u32   s3, 0x0
/*0000000001a4*/ v_add_co_u32    v0, vcc, s4, v0
/*0000000001ac*/ s_addc_u32      s1, s1, 0
/*0000000001b0*/ s_and_b32       s3, s2, -4
/*0000000001b4*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*0000000001b8*/ v_cmp_gt_u32    s[0:1], s2, s3
/*0000000001c0*/ v_add_co_u32    v2, vcc, s4, v2
/*0000000001c8*/ s_lshr_b32      s2, s2, 2
/*0000000001cc*/ v_add_co_ci_u32 v3, vcc, s5, v3, vcc
/*0000000001d0*/ v_add_co_u32    v4, vcc, s4, v4
/*0000000001d8*/ s_cmpk_lg_u32   s0, 0x0
/*0000000001dc*/ v_mov_b32       v9, s1
/*0000000001e0*/ s_addc_u32      s0, s2, 0
/*0000000001e4*/ v_add_co_ci_u32 v5, vcc, s5, v5, vcc
/*0000000001e8*/ v_mov_b32       v11, s0
/*0000000001ec*/ global_store_dword v[0:1], v6, off
/*0000000001f4*/ global_store_dword v[2:3], v9, off
/*0000000001fc*/ global_store_dword v[4:5], v11, off
/*000000000204*/ s_endpgm
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
