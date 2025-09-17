.rocm
.gpu GFX1010
.arch_minor 1
.arch_stepping 0
.eflags 51
.newbinfmt
.target "amdgcn-amd-amdhsa--gfx1010"
.md_version 1, 0
.kernel loop_kernel_0
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
        .kernarg_segment_size 80
        .wavefront_sgpr_count 12
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_kernel_0@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 12
        .md_vgprsnum 3
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg unrollingBreaker, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel loop_kernel_1
    .config
        .dims x
        .sgprsnum 8
        .vgprsnum 4
        .dx10clamp
        .ieeemode
        .floatmode 0xf0
        .priority 0
        .exceptions 0x60
        .userdatanum 6
        .pgmrsrc1 0x60af0000
        .pgmrsrc2 0x0000008c
        .codeversion 1, 2
        .machine 1, 10, 1, 0
        .kernel_code_entry_offset 0x100
        .use_private_segment_buffer
        .use_kernarg_segment_ptr
        .private_elem_size 4
        .use_ptr64
        .kernarg_segment_size 80
        .wavefront_sgpr_count 8
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_kernel_1@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 8
        .md_vgprsnum 3
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg unrollingBreaker, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.kernel loop_kernel_2
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
        .kernarg_segment_size 80
        .wavefront_sgpr_count 10
        .workitem_vgpr_count 3
        .kernarg_segment_align 16
        .group_segment_align 16
        .private_segment_align 16
        .wavefront_size 32
        .call_convention 0xffffffff
    .control_directive
        .fill 128, 1, 0x00
    .config
        .md_symname "loop_kernel_2@kd"
        .md_language "OpenCL C", 1, 2
        .reqd_work_group_size 64, 1, 1
        .md_kernarg_segment_size 80
        .md_kernarg_segment_align 8
        .md_group_segment_fixed_size 0
        .md_private_segment_fixed_size 0
        .md_wavefront_size 32
        .md_sgprsnum 10
        .md_vgprsnum 3
        .max_flat_work_group_size 64
        .arg data, "uint*", 8, 8, globalbuf, struct, global, default
        .arg x, "uint", 4, 4, value, struct
        .arg y, "uint", 4, 4, value, struct
        .arg unrollingBreaker, "uint", 4, 4, value, struct
        .arg , "", 8, 8, gox, struct
        .arg , "", 8, 8, goy, struct
        .arg , "", 8, 8, goz, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, none, struct
        .arg , "", 8, 8, multigridsyncarg, struct
.text
loop_kernel_0:
.skip 256
/*000000000100*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000108*/ s_waitcnt       lgkmcnt(0)
/*00000000010c*/ s_mov_b32       s3, 0
/*000000000110*/ s_cmp_eq_u32    s2, 0
/*000000000114*/ s_cbranch_scc1  .L380_0
/*000000000118*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000120*/ s_not_b32       s2, s2
.L292_0:
/*000000000124*/ s_waitcnt       lgkmcnt(0)
/*000000000128*/ s_load_dword    s6, s[4:5], 0x0
/*000000000130*/ v_cmp_lt_u32    s[8:9], s3, 63
/*000000000138*/ v_cmp_lg_u32    s[9:10], s2, s3
/*000000000140*/ s_add_i32       s7, s3, 1
/*000000000144*/ v_mov_b32       v0, s4
/*000000000148*/ v_mov_b32       v1, s5
/*00000000014c*/ s_mov_b32       s3, s7
/*000000000150*/ s_waitcnt       lgkmcnt(0)
/*000000000154*/ s_add_i32       s1, s6, s1
/*000000000158*/ s_add_u32       s4, s4, 4
/*00000000015c*/ v_mov_b32       v2, s1
/*000000000160*/ s_addc_u32      s5, s5, 0
/*000000000164*/ s_and_b32       s6, s8, s9
/*000000000168*/ s_mul_i32       s1, s1, s0
/*00000000016c*/ s_and_b32       vcc_lo, exec_lo, s6
/*000000000170*/ global_store_dword v[0:1], v2, off
/*000000000178*/ s_cbranch_vccnz .L292_0
.L380_0:
/*00000000017c*/ s_endpgm
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
loop_kernel_1:
.skip 256
/*000000000300*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000308*/ s_waitcnt       lgkmcnt(0)
/*00000000030c*/ s_cmp_eq_u32    s2, 0
/*000000000310*/ s_cbranch_scc1  .L860_0
/*000000000314*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
.L796_0:
/*00000000031c*/ s_waitcnt       lgkmcnt(0)
/*000000000320*/ s_load_dword    s3, s[4:5], 0x0
/*000000000328*/ v_mov_b32       v0, s4
/*00000000032c*/ v_mov_b32       v1, s5
/*000000000330*/ s_add_i32       s2, s2, -1
/*000000000334*/ s_waitcnt       lgkmcnt(0)
/*000000000338*/ s_add_i32       s1, s3, s1
/*00000000033c*/ s_add_u32       s4, s4, 4
/*000000000340*/ v_mov_b32       v2, s1
/*000000000344*/ s_addc_u32      s5, s5, 0
/*000000000348*/ s_cmp_eq_u32    s2, 0
/*00000000034c*/ s_mul_i32       s1, s1, s0
/*000000000350*/ global_store_dword v[0:1], v2, off
/*000000000358*/ s_cbranch_scc0  .L796_0
.L860_0:
/*00000000035c*/ s_endpgm
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
loop_kernel_2:
.skip 256
/*000000000500*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000508*/ s_mov_b32       s7, 0
/*00000000050c*/ s_waitcnt       lgkmcnt(0)
/*000000000510*/ s_cmp_eq_u32    s2, 0
/*000000000514*/ s_cbranch_scc1  .L1392_0
/*000000000518*/ s_load_dwordx2  s[4:5], s[4:5], 0x0
/*000000000520*/ s_mov_b32       s6, s2
/*000000000524*/ s_lshl_b64      s[6:7], s[6:7], 2
/*000000000528*/ s_waitcnt       lgkmcnt(0)
/*00000000052c*/ s_add_u32       s4, s4, s6
/*000000000530*/ s_addc_u32      s5, s5, s7
.L1332_0:
/*000000000534*/ s_load_dword    s3, s[4:5], 0x0
/*00000000053c*/ v_mov_b32       v0, s4
/*000000000540*/ v_mov_b32       v1, s5
/*000000000544*/ s_add_i32       s2, s2, -1
/*000000000548*/ s_waitcnt       lgkmcnt(0)
/*00000000054c*/ s_add_i32       s1, s3, s1
/*000000000550*/ s_add_u32       s4, s4, -4
/*000000000554*/ v_mov_b32       v2, s1
/*000000000558*/ s_addc_u32      s5, s5, -1
/*00000000055c*/ s_cmp_eq_u32    s2, 0
/*000000000560*/ s_mul_i32       s1, s1, s0
/*000000000564*/ global_store_dword v[0:1], v2, off
/*00000000056c*/ s_cbranch_scc0  .L1332_0
.L1392_0:
/*000000000570*/ s_endpgm
/*000000000574*/ s_code_end
/*000000000578*/ s_code_end
/*00000000057c*/ s_code_end
/*000000000580*/ s_code_end
/*000000000584*/ s_code_end
/*000000000588*/ s_code_end
/*00000000058c*/ s_code_end
/*000000000590*/ s_code_end
/*000000000594*/ s_code_end
/*000000000598*/ s_code_end
/*00000000059c*/ s_code_end
/*0000000005a0*/ s_code_end
/*0000000005a4*/ s_code_end
/*0000000005a8*/ s_code_end
/*0000000005ac*/ s_code_end
/*0000000005b0*/ s_code_end
/*0000000005b4*/ s_code_end
/*0000000005b8*/ s_code_end
/*0000000005bc*/ s_code_end
/*0000000005c0*/ s_code_end
/*0000000005c4*/ s_code_end
/*0000000005c8*/ s_code_end
/*0000000005cc*/ s_code_end
/*0000000005d0*/ s_code_end
/*0000000005d4*/ s_code_end
/*0000000005d8*/ s_code_end
/*0000000005dc*/ s_code_end
/*0000000005e0*/ s_code_end
/*0000000005e4*/ s_code_end
/*0000000005e8*/ s_code_end
/*0000000005ec*/ s_code_end
/*0000000005f0*/ s_code_end
/*0000000005f4*/ s_code_end
/*0000000005f8*/ s_code_end
/*0000000005fc*/ s_code_end
/*000000000600*/ s_code_end
/*000000000604*/ s_code_end
/*000000000608*/ s_code_end
/*00000000060c*/ s_code_end
/*000000000610*/ s_code_end
/*000000000614*/ s_code_end
/*000000000618*/ s_code_end
/*00000000061c*/ s_code_end
/*000000000620*/ s_code_end
/*000000000624*/ s_code_end
/*000000000628*/ s_code_end
/*00000000062c*/ s_code_end
/*000000000630*/ s_code_end
/*000000000634*/ s_code_end
/*000000000638*/ s_code_end
/*00000000063c*/ s_code_end
