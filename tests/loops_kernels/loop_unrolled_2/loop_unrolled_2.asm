.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 0
.driver_version 203603
.kernel loop_unrolled
    .config
        .dims x
        .cws 64, 1, 1
        .sgprsnum 13
        .vgprsnum 3
        .floatmode 0xc0
        .pgmrsrc1 0x00ac02c0
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
/*000000000008*/ s_lshl_b32      s2, s6, 6
/*00000000000c*/ s_load_dwordx2  s[6:7], s[4:5], 0x30
/*000000000014*/ v_add_u32       v0, vcc, s2, v0
/*000000000018*/ s_waitcnt       lgkmcnt(0)
/*00000000001c*/ v_add_u32       v0, vcc, v0, s0
/*000000000024*/ v_mov_b32       v1, s1
/*000000000028*/ v_addc_u32      v1, vcc, 0, v1, vcc
/*00000000002c*/ v_lshlrev_b64   v[0:1], 2, v[0:1]
/*000000000034*/ v_add_u32       v0, vcc, s6, v0
/*000000000038*/ v_mov_b32       v2, s7
/*00000000003c*/ v_addc_u32      v1, vcc, v2, v1, vcc
/*000000000040*/ flat_load_dword v2, v[0:1]
/*000000000048*/ s_load_dword    s0, s[4:5], 0x38
/*000000000050*/ s_waitcnt       vmcnt(0) & lgkmcnt(0)
/*000000000054*/ v_mul_lo_u32    v2, v2, s0
/*00000000005c*/ v_add_u32       v2, vcc, 7, v2
/*000000000060*/ v_mul_lo_u32    v2, v2, s0
/*000000000068*/ v_add_u32       v2, vcc, 10, v2
/*00000000006c*/ v_mul_lo_u32    v2, v2, s0
/*000000000074*/ v_add_u32       v2, vcc, 13, v2
/*000000000078*/ v_mul_lo_u32    v2, v2, s0
/*000000000080*/ v_add_u32       v2, vcc, 16, v2
/*000000000084*/ v_mul_lo_u32    v2, v2, s0
/*00000000008c*/ v_add_u32       v2, vcc, 19, v2
/*000000000090*/ v_mul_lo_u32    v2, v2, s0
/*000000000098*/ v_add_u32       v2, vcc, 22, v2
/*00000000009c*/ v_mul_lo_u32    v2, v2, s0
/*0000000000a4*/ v_add_u32       v2, vcc, 25, v2
/*0000000000a8*/ v_mul_lo_u32    v2, v2, s0
/*0000000000b0*/ v_add_u32       v2, vcc, 28, v2
/*0000000000b4*/ v_mul_lo_u32    v2, v2, s0
/*0000000000bc*/ v_add_u32       v2, vcc, 31, v2
/*0000000000c0*/ v_mul_lo_u32    v2, v2, s0
/*0000000000c8*/ v_add_u32       v2, vcc, 34, v2
/*0000000000cc*/ v_mul_lo_u32    v2, v2, s0
/*0000000000d4*/ v_add_u32       v2, vcc, 37, v2
/*0000000000d8*/ v_mul_lo_u32    v2, v2, s0
/*0000000000e0*/ v_add_u32       v2, vcc, 40, v2
/*0000000000e4*/ v_mul_lo_u32    v2, v2, s0
/*0000000000ec*/ v_add_u32       v2, vcc, 43, v2
/*0000000000f0*/ v_mul_lo_u32    v2, v2, s0
/*0000000000f8*/ v_add_u32       v2, vcc, 46, v2
/*0000000000fc*/ v_mul_lo_u32    v2, v2, s0
/*000000000104*/ v_add_u32       v2, vcc, 49, v2
/*000000000108*/ v_mul_lo_u32    v2, v2, s0
/*000000000110*/ v_add_u32       v2, vcc, 52, v2
/*000000000114*/ v_mul_lo_u32    v2, v2, s0
/*00000000011c*/ v_add_u32       v2, vcc, 55, v2
/*000000000120*/ v_mul_lo_u32    v2, v2, s0
/*000000000128*/ v_add_u32       v2, vcc, 58, v2
/*00000000012c*/ v_mul_lo_u32    v2, v2, s0
/*000000000134*/ v_add_u32       v2, vcc, 61, v2
/*000000000138*/ v_mul_lo_u32    v2, v2, s0
/*000000000140*/ v_add_u32       v2, vcc, 64, v2
/*000000000144*/ v_mul_lo_u32    v2, v2, s0
/*00000000014c*/ v_add_u32       v2, vcc, 0x43, v2
/*000000000154*/ v_mul_lo_u32    v2, v2, s0
/*00000000015c*/ v_add_u32       v2, vcc, 0x46, v2
/*000000000164*/ v_mul_lo_u32    v2, v2, s0
/*00000000016c*/ v_add_u32       v2, vcc, 0x49, v2
/*000000000174*/ v_mul_lo_u32    v2, v2, s0
/*00000000017c*/ v_add_u32       v2, vcc, 0x4c, v2
/*000000000184*/ v_mul_lo_u32    v2, v2, s0
/*00000000018c*/ v_add_u32       v2, vcc, 0x4f, v2
/*000000000194*/ v_mul_lo_u32    v2, v2, s0
/*00000000019c*/ v_add_u32       v2, vcc, 0x52, v2
/*0000000001a4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001ac*/ v_add_u32       v2, vcc, 0x55, v2
/*0000000001b4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001bc*/ v_add_u32       v2, vcc, 0x58, v2
/*0000000001c4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001cc*/ v_add_u32       v2, vcc, 0x5b, v2
/*0000000001d4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001dc*/ v_add_u32       v2, vcc, 0x5e, v2
/*0000000001e4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001ec*/ v_add_u32       v2, vcc, 0x61, v2
/*0000000001f4*/ v_mul_lo_u32    v2, v2, s0
/*0000000001fc*/ v_add_u32       v2, vcc, 0x64, v2
/*000000000204*/ v_mul_lo_u32    v2, v2, s0
/*00000000020c*/ v_add_u32       v2, vcc, 0x67, v2
/*000000000214*/ v_mul_lo_u32    v2, v2, s0
/*00000000021c*/ v_add_u32       v2, vcc, 0x6a, v2
/*000000000224*/ v_mul_lo_u32    v2, v2, s0
/*00000000022c*/ v_add_u32       v2, vcc, 0x6d, v2
/*000000000234*/ v_mul_lo_u32    v2, v2, s0
/*00000000023c*/ v_add_u32       v2, vcc, 0x70, v2
/*000000000244*/ v_mul_lo_u32    v2, v2, s0
/*00000000024c*/ v_add_u32       v2, vcc, 0x73, v2
/*000000000254*/ v_mul_lo_u32    v2, v2, s0
/*00000000025c*/ v_add_u32       v2, vcc, 0x76, v2
/*000000000264*/ v_mul_lo_u32    v2, v2, s0
/*00000000026c*/ v_add_u32       v2, vcc, 0x79, v2
/*000000000274*/ flat_store_dword v[0:1], v2
/*00000000027c*/ s_endpgm
