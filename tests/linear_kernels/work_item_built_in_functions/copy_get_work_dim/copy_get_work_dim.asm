/* Disassembling 'linear_kernels\work_item_built_in_functions\copy_get_work_dim\copy_get_work_dim.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel copy_get_work_dim
    .config
        .dims x
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x00000090
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
        .arg x, "int", int
        .arg data, "uint*", uint*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[6:7], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_load_dword    s1, s[4:5], 0x0
/*000000000014*/ s_load_dwordx2  s[2:3], s[6:7], 0x38
/*00000000001c*/ s_lshl_b32      s4, s8, 1
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ s_waitcnt       lgkmcnt(0)
/*00000000002c*/ s_bfe_u32       s0, s1, 0x20010
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ v_add_u32       v0, vcc, s2, v0
/*000000000044*/ v_mov_b32       v2, s3
/*000000000048*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*00000000004c*/ v_mov_b32       v2, s0
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
