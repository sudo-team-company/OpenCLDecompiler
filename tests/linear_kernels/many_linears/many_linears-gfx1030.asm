/* Disassembling 'linear_kernels\many_linears\many_linears-gfx1030.bin' */
.rocm
.gpu GFX1000
.arch_minor 3
.arch_stepping 0
.eflags 54
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1030"
.md_version 1, 0
.kernel copy
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
        .md_symname "copy@kd"
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
.kernel copy2
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
        .md_symname "copy2@kd"
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
        .arg x, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel copy3
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
        .kernarg_segment_size 72
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
        .md_symname "copy3@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 8, 8, 1
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 10
        .md_vgprsnum 8
        .max_flat_work_group_size 64
        .arg x, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel copy4
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
        .md_symname "copy4@kd"
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
        .arg x, "int", 4, 4, value, struct
        .arg data, "int*", 8, 8, globalbuf, struct, global, default
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel copy5
    .config
        .dims xyz
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x0000138c
        .codeversion 1, 2
        .machine 1, 10, 3, 0
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
        .md_symname "copy5@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 2, 2, 4
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 11
        .md_vgprsnum 5
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
.kernel copy6
    .config
        .dims xyz
        .sgprsnum 16
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0040
        .pgmrsrc2 0x0000138c
        .codeversion 1, 2
        .machine 1, 10, 3, 0
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
        .md_symname "copy6@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 2, 2, 4
        .md_kernarg_segment_size 72
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 11
        .md_vgprsnum 5
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
.kernel cpFACE
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
        .md_symname "cpFACE@kd"
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
copy:
.skip 256
/*000000000100*/ s_clause        0x2
/*000000000104*/ s_load_dword    s2, s[4:5], 0x10
/*00000000010c*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000114*/ s_load_dword    s3, s[4:5], 0x8
/*00000000011c*/ s_lshl_b32      s4, s6, 6
/*000000000120*/ v_mov_b32       v1, 0
/*000000000124*/ s_waitcnt       lgkmcnt(0)
/*000000000128*/ v_add3_u32      v0, s2, s4, v0
/*000000000130*/ v_mov_b32       v2, s3
/*000000000134*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000013c*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000144*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000148*/ global_store_dword v[0:1], v2, off
/*000000000150*/ s_endpgm
/*000000000154*/ s_nop           0x0
/*000000000158*/ s_nop           0x0
/*00000000015c*/ s_nop           0x0
/*000000000160*/ s_nop           0x0
/*000000000164*/ s_nop           0x0
/*000000000168*/ s_nop           0x0
/*00000000016c*/ s_nop           0x0
/*000000000170*/ s_nop           0x0
/*000000000174*/ s_nop           0x0
/*000000000178*/ s_nop           0x0
/*00000000017c*/ s_nop           0x0
/*000000000180*/ s_nop           0x0
/*000000000184*/ s_nop           0x0
/*000000000188*/ s_nop           0x0
/*00000000018c*/ s_nop           0x0
/*000000000190*/ s_nop           0x0
/*000000000194*/ s_nop           0x0
/*000000000198*/ s_nop           0x0
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
copy2:
.skip 256
/*000000000300*/ s_clause        0x2
/*000000000304*/ s_load_dword    s2, s[4:5], 0x10
/*00000000030c*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000314*/ s_load_dword    s3, s[4:5], 0x0
/*00000000031c*/ s_lshl_b32      s4, s6, 6
/*000000000320*/ v_mov_b32       v1, 0
/*000000000324*/ s_waitcnt       lgkmcnt(0)
/*000000000328*/ v_add3_u32      v0, s2, s4, v0
/*000000000330*/ v_mov_b32       v2, s3
/*000000000334*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000033c*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000344*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000348*/ global_store_dword v[0:1], v2, off
/*000000000350*/ s_endpgm
/*000000000354*/ s_nop           0x0
/*000000000358*/ s_nop           0x0
/*00000000035c*/ s_nop           0x0
/*000000000360*/ s_nop           0x0
/*000000000364*/ s_nop           0x0
/*000000000368*/ s_nop           0x0
/*00000000036c*/ s_nop           0x0
/*000000000370*/ s_nop           0x0
/*000000000374*/ s_nop           0x0
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
copy3:
.skip 256
/*000000000500*/ s_clause        0x1
/*000000000504*/ s_load_dwordx4  s[0:3], s[4:5], 0x10
/*00000000050c*/ s_load_dwordx2  s[4:5], s[4:5], 0x8
/*000000000514*/ s_waitcnt       lgkmcnt(0)
/*000000000518*/ s_lshl_b32      s1, s6, 3
/*00000000051c*/ v_mov_b32       v3, 0
/*000000000520*/ v_add3_u32      v2, s0, s1, v0
/*000000000528*/ s_lshl_b32      s0, s7, 3
/*00000000052c*/ v_add3_u32      v7, s2, s0, v1
/*000000000534*/ v_lshlrev_b64   v[2:3], 2, v[2:3]
/*00000000053c*/ v_add_co_u32    v0, vcc, s4, v2
/*000000000544*/ v_add_co_ci_u32 v1, vcc, s5, v3, vcc
/*000000000548*/ global_store_dword v[0:1], v7, off
/*000000000550*/ s_endpgm
/*000000000554*/ s_nop           0x0
/*000000000558*/ s_nop           0x0
/*00000000055c*/ s_nop           0x0
/*000000000560*/ s_nop           0x0
/*000000000564*/ s_nop           0x0
/*000000000568*/ s_nop           0x0
/*00000000056c*/ s_nop           0x0
/*000000000570*/ s_nop           0x0
/*000000000574*/ s_nop           0x0
/*000000000578*/ s_nop           0x0
/*00000000057c*/ s_nop           0x0
/*000000000580*/ s_nop           0x0
/*000000000584*/ s_nop           0x0
/*000000000588*/ s_nop           0x0
/*00000000058c*/ s_nop           0x0
/*000000000590*/ s_nop           0x0
/*000000000594*/ s_nop           0x0
/*000000000598*/ s_nop           0x0
/*00000000059c*/ s_nop           0x0
/*0000000005a0*/ s_nop           0x0
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
copy4:
.skip 256
/*000000000700*/ s_clause        0x2
/*000000000704*/ s_load_dword    s2, s[4:5], 0x10
/*00000000070c*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000714*/ s_load_dword    s3, s[4:5], 0x0
/*00000000071c*/ s_lshl_b32      s4, s6, 6
/*000000000720*/ v_mov_b32       v1, 0
/*000000000724*/ s_waitcnt       lgkmcnt(0)
/*000000000728*/ v_add3_u32      v0, s2, s4, v0
/*000000000730*/ v_mov_b32       v2, s3
/*000000000734*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000073c*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000744*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000748*/ global_store_dword v[0:1], v2, off
/*000000000750*/ s_endpgm
/*000000000754*/ s_nop           0x0
/*000000000758*/ s_nop           0x0
/*00000000075c*/ s_nop           0x0
/*000000000760*/ s_nop           0x0
/*000000000764*/ s_nop           0x0
/*000000000768*/ s_nop           0x0
/*00000000076c*/ s_nop           0x0
/*000000000770*/ s_nop           0x0
/*000000000774*/ s_nop           0x0
/*000000000778*/ s_nop           0x0
/*00000000077c*/ s_nop           0x0
/*000000000780*/ s_nop           0x0
/*000000000784*/ s_nop           0x0
/*000000000788*/ s_nop           0x0
/*00000000078c*/ s_nop           0x0
/*000000000790*/ s_nop           0x0
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
copy5:
.skip 256
/*000000000900*/ s_load_dwordx4  s[0:3], s[4:5], 0x10
/*000000000908*/ s_waitcnt       lgkmcnt(0)
/*00000000090c*/ s_clause        0x1
/*000000000910*/ s_load_dword    s1, s[4:5], 0x20
/*000000000918*/ s_load_dwordx2  s[4:5], s[4:5], 0x8
/*000000000920*/ s_lshl_b32      s3, s6, 1
/*000000000924*/ v_mov_b32       v4, 0
/*000000000928*/ v_add_nc_u32    v2, v2, v1
/*00000000092c*/ v_add3_u32      v3, s0, s3, v0
/*000000000934*/ s_waitcnt       lgkmcnt(0)
/*000000000938*/ s_add_i32       s1, s1, s2
/*00000000093c*/ s_lshl_b32      s0, s8, 2
/*000000000940*/ s_lshl_b32      s2, s7, 1
/*000000000944*/ s_add_i32       s1, s1, s0
/*000000000948*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*000000000950*/ v_add3_u32      v2, s1, s2, v2
/*000000000958*/ v_add_co_u32    v0, vcc, s4, v0
/*000000000960*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000964*/ global_store_dword v[0:1], v2, off
/*00000000096c*/ s_endpgm
/*000000000970*/ s_nop           0x0
/*000000000974*/ s_nop           0x0
/*000000000978*/ s_nop           0x0
/*00000000097c*/ s_nop           0x0
/*000000000980*/ s_nop           0x0
/*000000000984*/ s_nop           0x0
/*000000000988*/ s_nop           0x0
/*00000000098c*/ s_nop           0x0
/*000000000990*/ s_nop           0x0
/*000000000994*/ s_nop           0x0
/*000000000998*/ s_nop           0x0
/*00000000099c*/ s_nop           0x0
/*0000000009a0*/ s_nop           0x0
/*0000000009a4*/ s_nop           0x0
/*0000000009a8*/ s_nop           0x0
/*0000000009ac*/ s_nop           0x0
/*0000000009b0*/ s_nop           0x0
/*0000000009b4*/ s_nop           0x0
/*0000000009b8*/ s_nop           0x0
/*0000000009bc*/ s_nop           0x0
/*0000000009c0*/ s_nop           0x0
/*0000000009c4*/ s_nop           0x0
/*0000000009c8*/ s_nop           0x0
/*0000000009cc*/ s_nop           0x0
/*0000000009d0*/ s_nop           0x0
/*0000000009d4*/ s_nop           0x0
/*0000000009d8*/ s_nop           0x0
/*0000000009dc*/ s_nop           0x0
/*0000000009e0*/ s_nop           0x0
/*0000000009e4*/ s_nop           0x0
/*0000000009e8*/ s_nop           0x0
/*0000000009ec*/ s_nop           0x0
/*0000000009f0*/ s_nop           0x0
/*0000000009f4*/ s_nop           0x0
/*0000000009f8*/ s_nop           0x0
/*0000000009fc*/ s_nop           0x0
copy6:
.skip 256
/*000000000b00*/ s_clause        0x1
/*000000000b04*/ s_load_dwordx4  s[0:3], s[4:5], 0x18
/*000000000b0c*/ s_load_dwordx2  s[4:5], s[4:5], 0x8
/*000000000b14*/ v_mov_b32       v4, 0
/*000000000b18*/ v_lshl_or_b32   v3, s6, 1, v0
/*000000000b20*/ v_add_nc_u32    v2, v2, v1
/*000000000b24*/ s_waitcnt       lgkmcnt(0)
/*000000000b28*/ s_lshl_b32      s1, s8, 2
/*000000000b2c*/ v_lshlrev_b64   v[0:1], 2, v[3:4]
/*000000000b34*/ s_add_i32       s0, s2, s0
/*000000000b38*/ v_add_co_u32    v0, vcc, s4, v0
/*000000000b40*/ s_lshl_b32      s2, s7, 1
/*000000000b44*/ s_add_i32       s0, s0, s1
/*000000000b48*/ v_add_co_ci_u32 v1, vcc, s5, v1, vcc
/*000000000b4c*/ v_add3_u32      v2, s0, s2, v2
/*000000000b54*/ global_store_dword v[0:1], v2, off
/*000000000b5c*/ s_endpgm
/*000000000b60*/ s_nop           0x0
/*000000000b64*/ s_nop           0x0
/*000000000b68*/ s_nop           0x0
/*000000000b6c*/ s_nop           0x0
/*000000000b70*/ s_nop           0x0
/*000000000b74*/ s_nop           0x0
/*000000000b78*/ s_nop           0x0
/*000000000b7c*/ s_nop           0x0
/*000000000b80*/ s_nop           0x0
/*000000000b84*/ s_nop           0x0
/*000000000b88*/ s_nop           0x0
/*000000000b8c*/ s_nop           0x0
/*000000000b90*/ s_nop           0x0
/*000000000b94*/ s_nop           0x0
/*000000000b98*/ s_nop           0x0
/*000000000b9c*/ s_nop           0x0
/*000000000ba0*/ s_nop           0x0
/*000000000ba4*/ s_nop           0x0
/*000000000ba8*/ s_nop           0x0
/*000000000bac*/ s_nop           0x0
/*000000000bb0*/ s_nop           0x0
/*000000000bb4*/ s_nop           0x0
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
cpFACE:
.skip 256
/*000000000d00*/ s_clause        0x1
/*000000000d04*/ s_load_dword    s2, s[4:5], 0x10
/*000000000d0c*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000d14*/ s_lshl_b32      s3, s6, 6
/*000000000d18*/ v_mov_b32       v1, 0
/*000000000d1c*/ v_mov_b32       v2, 0xface
/*000000000d24*/ s_waitcnt       lgkmcnt(0)
/*000000000d28*/ v_add3_u32      v0, s2, s3, v0
/*000000000d30*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000d38*/ v_add_co_u32    v0, vcc, s0, v0
/*000000000d40*/ v_add_co_ci_u32 v1, vcc, s1, v1, vcc
/*000000000d44*/ global_store_dword v[0:1], v2, off
/*000000000d4c*/ s_endpgm
/*000000000d50*/ s_code_end
/*000000000d54*/ s_code_end
/*000000000d58*/ s_code_end
/*000000000d5c*/ s_code_end
/*000000000d60*/ s_code_end
/*000000000d64*/ s_code_end
/*000000000d68*/ s_code_end
/*000000000d6c*/ s_code_end
/*000000000d70*/ s_code_end
/*000000000d74*/ s_code_end
/*000000000d78*/ s_code_end
/*000000000d7c*/ s_code_end
/*000000000d80*/ s_code_end
/*000000000d84*/ s_code_end
/*000000000d88*/ s_code_end
/*000000000d8c*/ s_code_end
/*000000000d90*/ s_code_end
/*000000000d94*/ s_code_end
/*000000000d98*/ s_code_end
/*000000000d9c*/ s_code_end
/*000000000da0*/ s_code_end
/*000000000da4*/ s_code_end
/*000000000da8*/ s_code_end
/*000000000dac*/ s_code_end
/*000000000db0*/ s_code_end
/*000000000db4*/ s_code_end
/*000000000db8*/ s_code_end
/*000000000dbc*/ s_code_end
/*000000000dc0*/ s_code_end
/*000000000dc4*/ s_code_end
/*000000000dc8*/ s_code_end
/*000000000dcc*/ s_code_end
/*000000000dd0*/ s_code_end
/*000000000dd4*/ s_code_end
/*000000000dd8*/ s_code_end
/*000000000ddc*/ s_code_end
/*000000000de0*/ s_code_end
/*000000000de4*/ s_code_end
/*000000000de8*/ s_code_end
/*000000000dec*/ s_code_end
/*000000000df0*/ s_code_end
/*000000000df4*/ s_code_end
/*000000000df8*/ s_code_end
/*000000000dfc*/ s_code_end
/*000000000e00*/ s_code_end
/*000000000e04*/ s_code_end
/*000000000e08*/ s_code_end
/*000000000e0c*/ s_code_end
/*000000000e10*/ s_code_end
/*000000000e14*/ s_code_end
/*000000000e18*/ s_code_end
/*000000000e1c*/ s_code_end
/*000000000e20*/ s_code_end
/*000000000e24*/ s_code_end
/*000000000e28*/ s_code_end
/*000000000e2c*/ s_code_end
/*000000000e30*/ s_code_end
/*000000000e34*/ s_code_end
/*000000000e38*/ s_code_end
/*000000000e3c*/ s_code_end
