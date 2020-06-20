/* Disassembling 'mask_kernel.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.compile_options "-fno-bin-source -fno-bin-llvmir -fno-bin-amdil -fbin-exe -D__AMD__=1 -D__Ellesmere__=1 -D__Ellesmere=1 -D__IMAGE_SUPPORT__=1 -DFP_FAST_FMA=1 -cl-denorms-are-zero -m64 -Dcl_khr_fp64=1 -Dcl_amd_fp64=1 -Dcl_khr_global_int32_base_atomics=1 -Dcl_khr_global_int32_extended_atomics=1 -Dcl_khr_local_int32_base_atomics=1 -Dcl_khr_local_int32_extended_atomics=1 -Dcl_khr_int64_base_atomics=1 -Dcl_khr_int64_extended_atomics=1 -Dcl_khr_3d_image_writes=1 -Dcl_khr_byte_addressable_store=1 -Dcl_khr_fp16=1 -Dcl_khr_gl_sharing=1 -Dcl_khr_gl_depth_images=1 -Dcl_amd_device_attribute_query=1 -Dcl_amd_vec3=1 -Dcl_amd_printf=1 -Dcl_amd_media_ops=1 -Dcl_amd_media_ops2=1 -Dcl_amd_popcnt=1 -Dcl_khr_d3d10_sharing=1 -Dcl_khr_d3d11_sharing=1 -Dcl_khr_dx9_media_sharing=1 -Dcl_khr_image2d_from_buffer=1 -Dcl_khr_spir=1 -Dcl_khr_subgroups=1 -Dcl_khr_gl_event=1 -Dcl_khr_depth_images=1 -Dcl_khr_mipmap_image=1 -Dcl_khr_mipmap_image_writes=1 -Dcl_amd_liquid_flash=1 -Dcl_amd_planar_yuv=1 "
.acl_version "AMD-COMP-LIB-v0.8 (0.0.SC_BUILD_NUMBER)"
.kernel mask_kernel
    .config
        .dims xyz
        .sgprsnum 21
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x00001390
        .dx10clamp
        .ieeemode
        .useargs
        .usesetup
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg n, "int", int
        .arg x, "float*", float*, global, 
        .arg mask_num, "float", float
        .arg mask, "float*", float*, global, , rdonly
        .arg scale, "float", float
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x4
/*000000000008*/ s_load_dwordx2  s[4:5], s[6:7], 0x10
/*000000000010*/ s_load_dwordx4  s[12:15], s[6:7], 0x0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_load_dword    s5, s[6:7], 0x30
/*000000000024*/ s_and_b32       s11, s0, 0xffff
/*00000000002c*/ s_bfe_u32       s0, s0, 0x100010
/*000000000034*/ s_and_b32       s1, s1, 0xffff
/*00000000003c*/ s_mul_i32       s8, s11, s8
/*000000000040*/ s_mul_i32       s0, s0, s9
/*000000000044*/ v_add_u32       v1, vcc, s0, v1
/*000000000048*/ s_mul_i32       s0, s1, s10
/*00000000004c*/ s_add_u32       s1, s8, s12
/*000000000050*/ v_add_u32       v0, vcc, s1, v0
/*000000000054*/ s_add_u32       s0, s0, s4
/*000000000058*/ v_add_u32       v2, vcc, s0, v2
/*00000000005c*/ v_mul_lo_u32    v2, s3, v2
/*000000000064*/ v_add_u32       v2, vcc, s14, v2
/*000000000068*/ v_add_u32       v1, vcc, v2, v1
/*00000000006c*/ v_mul_lo_u32    v1, v1, s2
/*000000000074*/ v_add_u32       v0, vcc, v1, v0
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ v_cmp_gt_i32    vcc, s5, v0
/*000000000080*/ s_and_saveexec_b64 s[0:1], vcc
/*000000000084*/ s_cbranch_execz .L260_0
/*000000000088*/ s_load_dwordx2  s[2:3], s[6:7], 0x48
/*000000000090*/ v_ashrrev_i32   v1, 31, v0
/*000000000094*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000009c*/ s_waitcnt       lgkmcnt(0)
/*0000000000a0*/ v_add_u32       v2, vcc, s2, v0
/*0000000000a4*/ v_mov_b32       v3, s3
/*0000000000a8*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*0000000000ac*/ flat_load_dword v2, v[2:3]
/*0000000000b4*/ s_load_dword    s2, s[6:7], 0x40
/*0000000000bc*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000000c0*/ v_cmp_eq_f32    vcc, s2, v2
/*0000000000c4*/ s_and_saveexec_b64 s[2:3], vcc
/*0000000000c8*/ s_cbranch_execz .L260_0
/*0000000000cc*/ s_load_dwordx2  s[4:5], s[6:7], 0x38
/*0000000000d4*/ s_load_dword    s6, s[6:7], 0x50
/*0000000000dc*/ s_waitcnt       lgkmcnt(0)
/*0000000000e0*/ v_add_u32       v0, vcc, s4, v0
/*0000000000e4*/ v_mov_b32       v2, s5
/*0000000000e8*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*0000000000ec*/ flat_load_dword v2, v[0:1]
/*0000000000f4*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*0000000000f8*/ v_mul_f32       v2, s6, v2
/*0000000000fc*/ flat_store_dword v[0:1], v2
.L260_0:
/*000000000104*/ s_endpgm
