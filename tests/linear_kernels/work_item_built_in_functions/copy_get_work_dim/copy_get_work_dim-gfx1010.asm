.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel copy_get_work_dim
    .config
        .dims x
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 8
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x00000090
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_dispatch_ptr
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 72
        .wavefront_sgpr_count 11
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "copy_get_work_dim@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 2, 2, 4
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 11
        .md_vgprsnum 3
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
copy_get_work_dim:
.skip 256
/*000000000100*/ v_mov_b32       v1, s4
/*000000000104*/ v_mov_b32       v2, s5
/*000000000108*/ s_clause        0x1
/*00000000010c*/ s_load_dword    s2, s[6:7], 0x10
/*000000000114*/ s_load_dwordx2  s[0:1], s[6:7], 0x8
/*00000000011c*/ s_lshl_b32      s3, s8, 1
/*000000000120*/ global_load_ushort v2, v[1:2], off inst_offset:2
/*000000000128*/ v_mov_b32       v1, 0
/*00000000012c*/ s_waitcnt       lgkmcnt(0)
/*000000000130*/ v_add3_u32      v0, s2, s3, v0
/*000000000138*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000140*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000148*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*00000000014c*/ s_waitcnt       vmcnt(0)
/*000000000150*/ global_store_dword v[0:1], v2, off
/*000000000158*/ s_endpgm
/*00000000015c*/ s_code_end
/*000000000160*/ s_code_end
/*000000000164*/ s_code_end
/*000000000168*/ s_code_end
/*00000000016c*/ s_code_end
/*000000000170*/ s_code_end
/*000000000174*/ s_code_end
/*000000000178*/ s_code_end
/*00000000017c*/ s_code_end
/*000000000180*/ s_code_end
/*000000000184*/ s_code_end
/*000000000188*/ s_code_end
/*00000000018c*/ s_code_end
/*000000000190*/ s_code_end
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
