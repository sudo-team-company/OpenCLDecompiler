/* Disassembling 'local_memory_kernels\barrier_1\barrier_1-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel barrier_1
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
        .workgroup_group_segment_size 512
        .kernarg_segment_size 64
        .wavefront_sgpr_count 10
        .workitem_vgpr_count 8
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "barrier_1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 64
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 512
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 10
        .md_vgprsnum 8
        .max_flat_work_group_size 64
        .arg res, "int*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
barrier_1:
.skip 256
/*000000000100*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000108*/ v_lshl_or_b32   v1, s7, 2, v1
/*000000000110*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000118*/ v_mov_b32       v2, 0
/*00000000011c*/ s_waitcnt       lgkmcnt(0)
/*000000000120*/ v_add_nc_u32    v3, s0, v0
/*000000000124*/ v_add_nc_u32    v1, s2, v1
/*000000000128*/ v_mov_b32       v0, 1
/*00000000012c*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000134*/ v_lshlrev_b32   v7, 2, v3
/*000000000138*/ v_lshlrev_b32   v5, 2, v1
/*00000000013c*/ v_ashrrev_i64   v[3:4], 30, v[2:3]
/*000000000144*/ ds_write_b32    v5, v0
/*00000000014c*/ ds_write_b32    v7, v2 offset:256
/*000000000154*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000158*/ s_waitcnt_vscnt null, 0x0
/*00000000015c*/ s_barrier
/*000000000160*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000164*/ s_waitcnt_vscnt null, 0x0
/*000000000168*/ buffer_gl0_inv 
/*000000000170*/ ds_add_u32      v7, v0 offset:256
/*000000000178*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*00000000017c*/ s_waitcnt_vscnt null, 0x0
/*000000000180*/ s_barrier
/*000000000184*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000188*/ s_waitcnt_vscnt null, 0x0
/*00000000018c*/ buffer_gl0_inv 
/*000000000194*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000198*/ s_waitcnt_vscnt null, 0x0
/*00000000019c*/ s_barrier
/*0000000001a0*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000001a4*/ s_waitcnt_vscnt null, 0x0
/*0000000001a8*/ buffer_gl0_inv 
/*0000000001b0*/ ds_read_b32     v6, v7 offset:256
/*0000000001b8*/ v_add_co_u32    v3, vcc, s0, v3
/*0000000001c0*/ v_add_co_ci_u32 v4, vcc, s1, v4, vcc
/*0000000001c4*/ s_waitcnt       lgkmcnt(0)
/*0000000001c8*/ ds_write_b32    v7, v6
/*0000000001d0*/ ds_add_u32      v5, v0
/*0000000001d8*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000001dc*/ s_waitcnt_vscnt null, 0x0
/*0000000001e0*/ s_barrier
/*0000000001e4*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000001e8*/ s_waitcnt_vscnt null, 0x0
/*0000000001ec*/ buffer_gl0_inv 
/*0000000001f4*/ ds_read_b32     v0, v5
/*0000000001fc*/ s_waitcnt       lgkmcnt(0)
/*000000000200*/ ds_write_b32    v7, v0 offset:256
/*000000000208*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*00000000020c*/ s_waitcnt_vscnt null, 0x0
/*000000000210*/ s_barrier
/*000000000214*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000218*/ s_waitcnt_vscnt null, 0x0
/*00000000021c*/ buffer_gl0_inv 
/*000000000224*/ ds_read_b32     v6, v7 offset:256
/*00000000022c*/ v_mov_b32       v0, v2
/*000000000230*/ v_ashrrev_i64   v[0:1], 30, v[0:1]
/*000000000238*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000240*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000244*/ s_waitcnt       lgkmcnt(0)
/*000000000248*/ global_store_dword v[3:4], v6, off
/*000000000250*/ ds_read_b32     v3, v5
/*000000000258*/ s_waitcnt       lgkmcnt(0)
/*00000000025c*/ global_store_dword v[0:1], v3, off
/*000000000264*/ s_endpgm
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
/*000000000300*/ s_code_end
/*000000000304*/ s_code_end
/*000000000308*/ s_code_end
/*00000000030c*/ s_code_end
/*000000000310*/ s_code_end
/*000000000314*/ s_code_end
/*000000000318*/ s_code_end
/*00000000031c*/ s_code_end
/*000000000320*/ s_code_end
/*000000000324*/ s_code_end
/*000000000328*/ s_code_end
/*00000000032c*/ s_code_end
/*000000000330*/ s_code_end
/*000000000334*/ s_code_end
/*000000000338*/ s_code_end
/*00000000033c*/ s_code_end
