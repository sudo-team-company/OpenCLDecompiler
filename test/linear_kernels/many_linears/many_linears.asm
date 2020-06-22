/* Disassembling 'arith-Ellesmere.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel copy
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000008c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x38
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel copy2
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000008c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s4, s6, 6
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel copy3
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x0000098c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 3
/*000000000018*/ s_lshl_b32      s3, s7, 3
/*00000000001c*/ s_add_u32       s2, s3, s2
/*000000000020*/ v_add_u32       v2, vcc, s2, v1
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ v_add_u32       v0, vcc, s0, v0
/*00000000002c*/ v_mov_b32       v1, 0
/*000000000030*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000038*/ v_add_u32       v0, vcc, s4, v0
/*00000000003c*/ v_mov_b32       v3, s5
/*000000000040*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000044*/ flat_store_dword v[0:1], v2
/*00000000004c*/ s_endpgm
.kernel copy4
    .config
        .dims x
        .cws 4, 16, 2
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000008c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global, 
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_load_dword    s1, s[4:5], 0x30
/*00000000001c*/ s_lshl_b32      s4, s6, 2
/*000000000020*/ s_add_u32       s0, s4, s0
/*000000000024*/ v_add_u32       v0, vcc, s0, v0
/*000000000028*/ v_mov_b32       v1, 0
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s2, v0
/*000000000038*/ v_mov_b32       v2, s3
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ s_waitcnt       lgkmcnt(0)
/*000000000044*/ v_mov_b32       v2, s1
/*000000000048*/ flat_store_dword v[0:1], v2
/*000000000050*/ s_endpgm
.kernel copy5
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 17
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x0000138c
        .dx10clamp
        .ieeemode
        .useargs
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[10:11], s[4:5], 0x10
/*000000000010*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ s_lshl_b32      s1, s6, 1
/*000000000020*/ s_lshl_b32      s3, s7, 1
/*000000000024*/ s_lshl_b32      s6, s8, 2
/*000000000028*/ s_add_u32       s2, s3, s2
/*00000000002c*/ v_add_u32       v1, vcc, s2, v1
/*000000000030*/ s_add_u32       s2, s6, s10
/*000000000034*/ v_add_u32       v2, vcc, s2, v2
/*000000000038*/ v_add_u32       v2, vcc, v2, v1
/*00000000003c*/ s_add_u32       s0, s1, s0
/*000000000040*/ v_add_u32       v0, vcc, s0, v0
/*000000000044*/ v_mov_b32       v1, 0
/*000000000048*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000050*/ v_add_u32       v0, vcc, s4, v0
/*000000000054*/ v_mov_b32       v3, s5
/*000000000058*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*00000000005c*/ flat_store_dword v[0:1], v2
/*000000000064*/ s_endpgm
.kernel copy6
    .config
        .dims xyz
        .cws 2, 2, 4
        .sgprsnum 16
        .vgprsnum 4
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0080
        .pgmrsrc2 0x0000138c
        .dx10clamp
        .ieeemode
        .useargs
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
/*000000000000*/ s_load_dwordx4  s[0:3], s[4:5], 0x8
/*000000000008*/ s_load_dwordx2  s[4:5], s[4:5], 0x38
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 1
/*000000000018*/ v_add_u32       v0, vcc, s1, v0
/*00000000001c*/ s_lshl_b32      s1, s7, 1
/*000000000020*/ s_lshl_b32      s3, s8, 2
/*000000000024*/ s_add_u32       s0, s1, s0
/*000000000028*/ s_add_u32       s1, s3, s2
/*00000000002c*/ v_add_u32       v3, vcc, s0, v1
/*000000000030*/ v_add_u32       v2, vcc, s1, v2
/*000000000034*/ v_mov_b32       v1, 0
/*000000000038*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000040*/ v_add_u32       v2, vcc, v2, v3
/*000000000044*/ v_add_u32       v0, vcc, s4, v0
/*000000000048*/ v_mov_b32       v3, s5
/*00000000004c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000050*/ flat_store_dword v[0:1], v2
/*000000000058*/ s_endpgm
.kernel cpFACE
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0040
        .pgmrsrc2 0x0000008c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg data, "int*", int*, global, 
        .arg x, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_load_dwordx2  s[2:3], s[4:5], 0x30
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 6
/*000000000018*/ s_add_u32       s0, s1, s0
/*00000000001c*/ v_add_u32       v0, vcc, s0, v0
/*000000000020*/ v_mov_b32       v1, 0
/*000000000024*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*00000000002c*/ v_add_u32       v0, vcc, s2, v0
/*000000000030*/ v_mov_b32       v2, s3
/*000000000034*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000038*/ v_mov_b32       v2, 0xface
/*000000000040*/ flat_store_dword v[0:1], v2
/*000000000048*/ s_endpgm
