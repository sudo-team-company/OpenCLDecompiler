/* Disassembling 'barrier_1.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel localVarExample
    .config
        .dims xy
        .cws 16, 16, 16
        .sgprsnum 16
        .vgprsnum 7
        .localsize 512
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
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
        .arg res, "int*", int*, global, 
    .text
/*000000000000*/ s_mov_b32       m0, 0x10000
/*000000000008*/ s_load_dwordx4  s[0:3], s[4:5], 0x0
/*000000000010*/ s_waitcnt       lgkmcnt(0)
/*000000000014*/ s_lshl_b32      s1, s6, 4
/*000000000018*/ v_add_u32       v0, vcc, s1, v0
/*00000000001c*/ s_lshl_b32      s1, s7, 4
/*000000000020*/ v_add_u32       v1, vcc, s1, v1
/*000000000024*/ v_add_u32       v5, vcc, s0, v0
/*000000000028*/ v_lshlrev_b32   v2, 2, v5
/*00000000002c*/ v_mov_b32       v3, 0
/*000000000030*/ ds_write_b32    v2, v3
/*000000000038*/ v_add_u32       v1, vcc, s2, v1
/*00000000003c*/ v_lshlrev_b32   v3, 2, v1
/*000000000040*/ v_mov_b32       v4, 1
/*000000000044*/ ds_write_b32    v3, v4 offset:256
/*00000000004c*/ v_mov_b32       v4, 0
/*000000000050*/ v_ashrrev_i64   v[4:5], 30, v[4:5]
/*000000000058*/ v_mov_b32       v0, 0
/*00000000005c*/ v_ashrrev_i64   v[0:1], 30, v[0:1]
/*000000000064*/ s_waitcnt       lgkmcnt(0)
/*000000000068*/ s_barrier
/*00000000006c*/ v_mov_b32       v6, 1
/*000000000070*/ ds_add_u32      v2, v6
/*000000000078*/ s_waitcnt       lgkmcnt(0)
/*00000000007c*/ s_barrier
/*000000000080*/ s_load_dwordx2  s[0:1], s[4:5], 0x30
/*000000000088*/ s_waitcnt       lgkmcnt(0)
/*00000000008c*/ v_add_u32       v0, vcc, s0, v0
/*000000000090*/ v_mov_b32       v6, s1
/*000000000094*/ v_addc_u32      v1, vcc, v6, v1, vcc
/*000000000098*/ v_add_u32       v4, vcc, s0, v4
/*00000000009c*/ v_addc_u32      v5, vcc, v6, v5, vcc
/*0000000000a0*/ s_barrier
/*0000000000a4*/ ds_read_b32     v6, v2
/*0000000000ac*/ s_waitcnt       lgkmcnt(0)
/*0000000000b0*/ ds_write_b32    v2, v6 offset:256
/*0000000000b8*/ v_mov_b32       v6, 1
/*0000000000bc*/ ds_add_u32      v3, v6 offset:256
/*0000000000c4*/ s_waitcnt       lgkmcnt(0)
/*0000000000c8*/ s_barrier
/*0000000000cc*/ ds_read_b32     v6, v3 offset:256
/*0000000000d4*/ s_waitcnt       lgkmcnt(0)
/*0000000000d8*/ ds_write_b32    v2, v6
/*0000000000e0*/ s_waitcnt       lgkmcnt(0)
/*0000000000e4*/ s_barrier
/*0000000000e8*/ ds_read_b32     v2, v2
/*0000000000f0*/ ds_read_b32     v3, v3 offset:256
/*0000000000f8*/ s_waitcnt       lgkmcnt(1)
/*0000000000fc*/ flat_store_dword v[4:5], v2
/*000000000104*/ s_waitcnt       lgkmcnt(1)
/*000000000108*/ flat_store_dword v[0:1], v3
/*000000000110*/ s_endpgm
