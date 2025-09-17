.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.globaldata
.gdata:
    .byte 0x00, 0x00, 0x80, 0xbf, 0x00, 0x00, 0x80, 0x3f
    .byte 0xcd, 0xcc, 0x0c, 0xc0, 0x9a, 0x99, 0x79, 0x40
    .byte 0x66, 0x66, 0x86, 0xc0, 0x4d, 0xf3, 0xa3, 0x40
.kernel float_test
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 4
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
        .arg out, "float*", float*, global, 
        .arg i, "int", int
    .text
/*000000000000*/ s_load_dwordx2  s[0:1], s[4:5], 0x0
/*000000000008*/ s_waitcnt       lgkmcnt(0)
/*00000000000c*/ s_lshl_b32      s1, s6, 6
/*000000000010*/ s_add_u32       s0, s1, s0
/*000000000014*/ v_add_u32       v0, vcc, s0, v0
/*000000000018*/ v_mov_b32       v1, 0
/*00000000001c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000024*/ s_mov_b32       s1, .gdata>>32
/*00000000002c*/ s_mov_b32       s0, .gdata&0xffffffff
/*000000000034*/ v_add_u32       v2, vcc, s0, v0
/*000000000038*/ v_mov_b32       v3, s1
/*00000000003c*/ v_addc_u32      v3, vcc, v3, v1, vcc
/*000000000040*/ flat_load_dword v2, v[2:3]
/*000000000048*/ s_load_dwordx2  s[0:1], s[4:5], 0x30
/*000000000050*/ s_waitcnt       lgkmcnt(0)
/*000000000054*/ v_add_u32       v0, vcc, s0, v0
/*000000000058*/ v_mov_b32       v3, s1
/*00000000005c*/ v_addc_u32      v1, vcc, v3, v1, vcc
/*000000000060*/ s_waitcnt       vmcnt(0)
/*000000000064*/ flat_store_dword v[0:1], v2
/*00000000006c*/ s_endpgm
