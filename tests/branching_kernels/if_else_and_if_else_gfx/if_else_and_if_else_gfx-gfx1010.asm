.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel if_else_and_if_else_1
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
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 18
        .workitem_vgpr_count 11
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_else_and_if_else_1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 18
        .md_vgprsnum 11
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
.kernel if_else_and_if_else_2
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
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 14
        .workitem_vgpr_count 7
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "if_else_and_if_else_2@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 4, 4, 4
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 14
        .md_vgprsnum 7
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
if_else_and_if_else_1:
.skip 256
/*000000000100*/ s_clause        0x4
/*000000000104*/ s_load_dwordx4  s[12:15], s[4:5], 0x18
/*00000000010c*/ s_load_dword    s0, s[4:5], 0x0
/*000000000114*/ s_load_dwordx2  s[2:3], s[4:5], 0x8
/*00000000011c*/ s_load_dword    s1, s[4:5], 0x10
/*000000000124*/ s_load_dwordx2  s[4:5], s[4:5], 0x28
/*00000000012c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000134*/ s_waitcnt       lgkmcnt(0)
/*000000000138*/ v_add_co_u32    v3, s[5:6], s12, v0
/*000000000140*/ v_cmp_lg_u32    vcc, 1, v3
/*000000000144*/ s_and_saveexec_b32 s5, vcc_lo
/*000000000148*/ s_xor_b32       s5, exec_lo, s5
/*00000000014c*/ v_mul_lo_u32    v10, v3, s1
/*000000000154*/ v_mov_b32       v4, 0
/*000000000158*/ s_or_saveexec_b32 s5, s5
/*00000000015c*/ v_lshl_or_b32   v1, s7, 2, v1
/*000000000164*/ v_add_co_u32    v1, s[6:7], s14, v1
/*00000000016c*/ s_xor_b32       exec_lo, exec_lo, s5
/*000000000170*/ v_mul_lo_u32    v0, v1, s0
/*000000000178*/ v_mov_b32       v3, 1
/*00000000017c*/ v_mov_b32       v4, 0
/*000000000180*/ v_subrev_nc_u32 v10, s1, v0
/*000000000184*/ s_or_b32        exec_lo, exec_lo, s5
/*000000000188*/ s_lshl_b32      s5, s8, 2
/*00000000018c*/ v_mov_b32       v6, 0
/*000000000190*/ v_add3_u32      v5, s4, s5, v2
/*000000000198*/ v_lshlrev_b64   v[3:4], 2, v[3:4]
/*0000000001a0*/ s_min_i32       s1, s0, s1
/*0000000001a4*/ v_mov_b32       v8, s0
/*0000000001a8*/ v_mov_b32       v2, v6
/*0000000001ac*/ v_lshlrev_b64   v[5:6], 2, v[5:6]
/*0000000001b4*/ v_mov_b32       v7, s1
/*0000000001b8*/ v_add_co_u32    v3, vcc, s2, v3
/*0000000001c0*/ v_lshlrev_b64   v[1:2], 2, v[1:2]
/*0000000001c8*/ v_add_co_ci_u32 v4, vcc, s3, v4, vcc
/*0000000001cc*/ v_add_co_u32    v5, vcc, s2, v5
/*0000000001d4*/ v_add_co_ci_u32 v6, vcc, s3, v6, vcc
/*0000000001d8*/ v_add_co_u32    v1, vcc, s2, v1
/*0000000001e0*/ v_add_co_ci_u32 v2, vcc, s3, v2, vcc
/*0000000001e4*/ global_store_dword v[3:4], v10, off
/*0000000001ec*/ global_store_dword v[5:6], v7, off
/*0000000001f4*/ global_store_dword v[1:2], v8, off
/*0000000001fc*/ s_endpgm
if_else_and_if_else_2:
.skip 256
/*000000000300*/ s_clause        0x2
/*000000000304*/ s_load_dwordx4  s[8:11], s[4:5], 0x18
/*00000000030c*/ s_load_dwordx2  s[0:1], s[4:5], 0x8
/*000000000314*/ s_load_dword    s2, s[4:5], 0x10
/*00000000031c*/ v_lshl_or_b32   v0, s6, 2, v0
/*000000000324*/ s_waitcnt       lgkmcnt(0)
/*000000000328*/ v_add_co_u32    v2, s[3:4], s8, v0
/*000000000330*/ v_cmp_lg_u32    vcc, 0, v2
/*000000000334*/ s_and_saveexec_b32 s3, vcc_lo
/*000000000338*/ s_xor_b32       s3, exec_lo, s3
/*00000000033c*/ s_cbranch_execz .L872_0
/*000000000340*/ v_mov_b32       v3, 0
/*000000000344*/ v_mul_lo_u32    v6, v2, s2
/*00000000034c*/ v_lshlrev_b64   v[3:4], 2, v[2:3]
/*000000000354*/ v_add_co_u32    v3, vcc, s0, v3
/*00000000035c*/ v_add_co_ci_u32 v4, vcc, s1, v4, vcc
/*000000000360*/ global_store_dword v[3:4], v6, off
.L872_0:
/*000000000368*/ s_or_saveexec_b32 s3, s3
/*00000000036c*/ s_waitcnt_decptr 0xffe3
/*000000000370*/ s_xor_b32       exec_lo, exec_lo, s3
/*000000000374*/ s_cbranch_execz .L912_0
/*000000000378*/ s_sub_i32       s6, 0, s2
/*00000000037c*/ v_mov_b32       v4, s1
/*000000000380*/ v_mov_b32       v3, s0
/*000000000384*/ v_mov_b32       v6, s6
/*000000000388*/ global_store_dword v[3:4], v6, off
.L912_0:
/*000000000390*/ s_waitcnt_decptr 0xffe3
/*000000000394*/ s_or_b32        exec_lo, exec_lo, s3
/*000000000398*/ s_lshl_b32      s3, s7, 2
/*00000000039c*/ v_add3_u32      v1, s10, s3, v1
/*0000000003a4*/ v_cmp_lg_u32    vcc, 1, v1
/*0000000003a8*/ s_and_saveexec_b32 s3, vcc_lo
/*0000000003ac*/ s_xor_b32       s3, exec_lo, s3
/*0000000003b0*/ v_mul_lo_u32    v0, v1, s2
/*0000000003b8*/ v_mov_b32       v3, 0
/*0000000003bc*/ s_or_saveexec_b32 s3, s3
/*0000000003c0*/ s_xor_b32       exec_lo, exec_lo, s3
/*0000000003c4*/ s_cbranch_execz .L996_0
/*0000000003c8*/ s_load_dword    s4, s[4:5], 0x0
/*0000000003d0*/ v_mov_b32       v2, 1
/*0000000003d4*/ v_mov_b32       v3, 0
/*0000000003d8*/ s_waitcnt       lgkmcnt(0)
/*0000000003dc*/ s_sub_i32       s2, s4, s2
/*0000000003e0*/ v_mov_b32       v0, s2
.L996_0:
/*0000000003e4*/ s_or_b32        exec_lo, exec_lo, s3
/*0000000003e8*/ v_lshlrev_b64   v[1:2], 2, v[2:3]
/*0000000003f0*/ v_add_co_u32    v1, vcc, s0, v1
/*0000000003f8*/ v_add_co_ci_u32 v2, vcc, s1, v2, vcc
/*0000000003fc*/ global_store_dword v[1:2], v0, off
/*000000000404*/ s_endpgm
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
