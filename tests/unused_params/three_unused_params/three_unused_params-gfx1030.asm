/* Disassembling 'unused_params\three_unused_params\three_unused_params-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel three_unused_params
    .config
        .dims xy
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 8
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x00000990
        .codeversion 1, 2
        .machine 1, 10, 3, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_dispatch_ptr
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 104
        .wavefront_sgpr_count 15
        .workitem_vgpr_count 8
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "three_unused_params@kd"
        .md_language "OpenCL C", 1, 2
        .md_kernarg_segment_size 104
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 15
        .md_vgprsnum 8
        .max_flat_work_group_size 256
        .arg n, "int", 4, 4, value, struct
        .arg w, "int", 4, 4, value, struct
        .arg z, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg ww, "int", 4, 4, value, struct
        .arg data1, "int*", 8, 8, globalbuf, struct, global, default
        .arg x, "int", 4, 4, value, struct
        .arg y, "int", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
three_unused_params:
.skip 256
/*000000000100*/ s_load_dword    s12, s[4:5], 0x4
/*000000000108*/ s_load_dwordx2  s[10:11], s[6:7], 0x30
/*000000000110*/ s_waitcnt       lgkmcnt(0)
/*000000000114*/ s_clause        0x2
/*000000000118*/ s_load_dword    s11, s[6:7], 0x0
/*000000000120*/ s_load_dwordx2  s[0:1], s[6:7], 0x10
/*000000000128*/ s_load_dwordx2  s[2:3], s[6:7], 0x28
/*000000000130*/ s_and_b32       s12, s12, 0xffff
/*000000000138*/ s_mul_i32       s8, s8, s12
/*00000000013c*/ v_add_nc_u32    v0, s8, v0
/*000000000140*/ v_add_co_u32    v0, s[8:9], s10, v0
/*000000000148*/ s_add_u32       s10, s6, 48
/*00000000014c*/ s_waitcnt       lgkmcnt(0)
/*000000000150*/ v_cmp_le_i32    vcc, s11, v0
/*000000000154*/ s_addc_u32      s11, s7, 0
/*000000000158*/ s_and_saveexec_b32 s8, vcc_lo
/*00000000015c*/ s_xor_b32       s8, exec_lo, s8
/*000000000160*/ s_cbranch_execz .L464_0
/*000000000164*/ v_mov_b32       v2, s4
/*000000000168*/ v_mov_b32       v3, s5
/*00000000016c*/ s_load_dwordx2  s[4:5], s[10:11], 0x8
/*000000000174*/ s_load_dwordx2  s[6:7], s[6:7], 0x20
/*00000000017c*/ global_load_ushort v2, v[2:3], off inst_offset:6
/*000000000184*/ v_mov_b32       v3, 0
/*000000000188*/ s_waitcnt       vmcnt(0)
/*00000000018c*/ v_mul_lo_u32    v2, s9, v2
/*000000000194*/ v_add_nc_u32    v1, v2, v1
/*000000000198*/ s_waitcnt       lgkmcnt(0)
/*00000000019c*/ v_add_co_u32    v2, s[4:5], s4, v1
/*0000000001a4*/ v_mov_b32       v4, v2
/*0000000001a8*/ v_ashrrev_i64   v[3:4], 30, v[3:4]
/*0000000001b0*/ v_add_co_u32    v3, vcc, s6, v3
/*0000000001b8*/ v_add_co_ci_u32 v4, vcc, s7, v4, vcc
/*0000000001bc*/ global_load_dword v1, v[3:4], off
/*0000000001c4*/ v_ashrrev_i32   v3, 31, v2
/*0000000001c8*/ s_waitcnt       vmcnt(0)
/*0000000001cc*/ v_add_nc_u32    v7, s3, v1
.L464_0:
/*0000000001d0*/ s_or_saveexec_b32 s3, s8
/*0000000001d4*/ s_xor_b32       exec_lo, exec_lo, s3
/*0000000001d8*/ v_ashrrev_i32   v1, 31, v0
/*0000000001dc*/ v_mov_b32       v7, s2
/*0000000001e0*/ v_mov_b32       v3, v1
/*0000000001e4*/ v_mov_b32       v2, v0
/*0000000001e8*/ s_or_b32        exec_lo, exec_lo, s3
/*0000000001ec*/ v_lshlrev_b64   v[0:1], 2, v[2:3]
/*0000000001f4*/ v_add_co_u32    v0, vcc, s0, v0
/*0000000001fc*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000200*/ global_store_dword v[0:1], v7, off
/*000000000208*/ s_endpgm
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
