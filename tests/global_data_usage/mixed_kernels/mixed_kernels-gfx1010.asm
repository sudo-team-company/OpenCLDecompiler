// llvm-mc -triple=amdgcn--amdhsa -mcpu=gfx1010 -mattr=+wavefrontsize32,+wavefrontsize64

	.section	.note,#alloc
	.section	.dynsym,#alloc
	.long 0                                                    // 000000000778: 00000000
	.long 0                                                    // 00000000077C: 00000000
	.long 0                                                    // 000000000780: 00000000
	.long 0                                                    // 000000000784: 00000000
	.long 0                                                    // 000000000788: 00000000
	.long 0                                                    // 00000000078C: 00000000
	.long 0x1                                                  // 000000000790: 00000001
	.long 0x70312                                              // 000000000794: 00070312
	.long 0x1900                                               // 000000000798: 00001900
	.long 0                                                    // 00000000079C: 00000000
	.long 0xe4                                                 // 0000000007A0: 000000E4
	.long 0                                                    // 0000000007A4: 00000000
	.long 0x11                                                 // 0000000007A8: 00000011
	.long 0x60311                                              // 0000000007AC: 00060311
	.ascii "@"                                                 // 0000000007B0: 40
	.byte 0x8                                                  // 0000000007B1: 08
	.short 0                                                   // 0000000007B2: 0000
	.long 0                                                    // 0000000007B4: 00000000
	.ascii "@"                                                 // 0000000007B8: 40
	.byte 0                                                    // 0000000007B9: 00
	.short 0                                                   // 0000000007BA: 0000
	.long 0                                                    // 0000000007BC: 00000000

	.section	.gnu.hash,#alloc
	.long 0x1                                                  // 0000000007C0: 00000001
	.long 0x1                                                  // 0000000007C4: 00000001
	.long 0x1                                                  // 0000000007C8: 00000001
	.long 0x1a                                                 // 0000000007CC: 0000001A
	.long 0x400200                                             // 0000000007D0: 00400200
	.long 0x20080000                                           // 0000000007D4: 20080000
	.long 0x1                                                  // 0000000007D8: 00000001
	.ascii "Vi"                                                // 0000000007DC: 6956
	.short 0x24bc                                              // 0000000007DE: 24BC
	.ascii "s"                                                 // 0000000007E0: 73
	.byte 0xc3                                                 // 0000000007E1: C3
	.short 0xf4ff                                              // 0000000007E2: F4FF

	.section	.hash,#alloc
	.long 0x3                                                  // 0000000007E4: 00000003
	.long 0x3                                                  // 0000000007E8: 00000003
	.long 0x1                                                  // 0000000007EC: 00000001
	.long 0                                                    // 0000000007F0: 00000000
	.long 0x2                                                  // 0000000007F4: 00000002
	.long 0                                                    // 0000000007F8: 00000000
	.long 0                                                    // 0000000007FC: 00000000
	.long 0                                                    // 000000000800: 00000000

	.section	.rodata,#alloc
	.type	some_array_test.kd,@object
some_array_test.kd:
	.long 0                                                    // 000000000840: 00000000
	.long 0                                                    // 000000000844: 00000000
	.long 0x118                                                // 000000000848: 00000118
	.long 0                                                    // 00000000084C: 00000000
	.long 0x10c0                                               // 000000000850: 000010C0
	.long 0                                                    // 000000000854: 00000000
	.long 0                                                    // 000000000858: 00000000
	.long 0                                                    // 00000000085C: 00000000
	.long 0                                                    // 000000000860: 00000000
	.long 0                                                    // 000000000864: 00000000
	.long 0                                                    // 000000000868: 00000000
	.long 0                                                    // 00000000086C: 00000000
	.ascii "A"                                                 // 000000000870: 41
	.byte 0                                                    // 000000000871: 00
	.short 0x60af                                              // 000000000872: 60AF
	.long 0x990                                                // 000000000874: 00000990
	.long 0x40b                                                // 000000000878: 0000040B
	.long 0                                                    // 00000000087C: 00000000
	.type	fst_arr,@object
fst_arr:
	.long 0x1                                                  // 000000000880: 00000001
	.long 0x2                                                  // 000000000884: 00000002
	.long 0x3                                                  // 000000000888: 00000003
	.long 0x4                                                  // 00000000088C: 00000004
	.long 0x5                                                  // 000000000890: 00000005
	.long 0x6                                                  // 000000000894: 00000006
	.long 0x7                                                  // 000000000898: 00000007
	.long 0                                                    // 00000000089C: 00000000
	.type	snd_arr,@object
snd_arr:
	.long 0x8                                                  // 0000000008A0: 00000008
	.long 0                                                    // 0000000008A4: 00000000
	.ascii "	"                                                 // 0000000008A8: 09
	.byte 0                                                    // 0000000008A9: 00
	.short 0                                                   // 0000000008AA: 0000
	.long 0                                                    // 0000000008AC: 00000000
	.ascii "\n"                                                // 0000000008B0: 0A
	.byte 0                                                    // 0000000008B1: 00
	.short 0                                                   // 0000000008B2: 0000
	.long 0                                                    // 0000000008B4: 00000000
	.long 0xb                                                  // 0000000008B8: 0000000B
	.long 0                                                    // 0000000008BC: 00000000

	.text

	.p2align	8
	.type	some_array_test,@function
	.size	some_array_test, some_array_test_symend-some_array_test
some_array_test:
	s_load_dword s10, s[4:5], 0x4                              // 000000001900: F4000282 FA000004
	s_load_dwordx4 s[0:3], s[6:7], 0x18                        // 000000001908: F4080003 FA000018
	v_mov_b32_e32 v3, 0                                        // 000000001910: 7E060280
	s_waitcnt lgkmcnt(0)                                       // 000000001914: BF8CC07F
	s_and_b32 s1, s10, 0xffff                                  // 000000001918: 8701FF0A 0000FFFF
	s_mul_i32 s8, s8, s1                                       // 000000001920: 93080108
	v_add3_u32 v2, s0, s8, v0                                  // 000000001924: D76D0002 04001000
	s_getpc_b64 s[0:1]                                         // 00000000192C: BE801F00
	s_add_u32 s0, s0, 0xffffef50                               // 000000001930: 8000FF00 FFFFEF50
	s_addc_u32 s1, s1, -1                                      // 000000001938: 8201FF01 FFFFFFFF
	s_getpc_b64 s[4:5]                                         // 000000001940: BE841F00
	s_add_u32 s4, s4, 0xffffef5c                               // 000000001944: 8004FF04 FFFFEF5C
	s_addc_u32 s5, s5, -1                                      // 00000000194C: 8205FF05 FFFFFFFF
	v_lshlrev_b64 v[4:5], 2, v[2:3]                            // 000000001954: D6FF0004 00020482
	v_lshlrev_b64 v[6:7], 3, v[2:3]                            // 00000000195C: D6FF0006 00020483
	v_add_co_u32 v8, vcc_lo, v4, s0                            // 000000001964: D70F6A08 00000104
	v_add_co_ci_u32_e32 v9, vcc_lo, s1, v5, vcc_lo             // 00000000196C: 50120A01
	v_add_co_u32 v6, vcc_lo, v6, s4                            // 000000001970: D70F6A06 00000906
	v_add_co_ci_u32_e32 v7, vcc_lo, s5, v7, vcc_lo             // 000000001978: 500E0E05
	s_load_dwordx4 s[4:7], s[6:7], null                        // 00000000197C: F4080103 FA000000
	global_load_dword v12, v[8:9], off                         // 000000001984: DC308000 0C7D0008
	global_load_dwordx2 v[10:11], v[6:7], off                  // 00000000198C: DC348000 0A7D0006
	s_lshr_b32 s0, s10, 16                                     // 000000001994: 9000900A
	s_mul_i32 s9, s9, s0                                       // 000000001998: 93090009
	v_add3_u32 v2, s2, s9, v1                                  // 00000000199C: D76D0002 04041202
	v_lshlrev_b64 v[0:1], 3, v[2:3]                            // 0000000019A4: D6FF0000 00020483
	s_waitcnt lgkmcnt(0)                                       // 0000000019AC: BF8CC07F
	v_add_co_u32 v2, vcc_lo, s6, v4                            // 0000000019B0: D70F6A02 00020806
	v_add_co_ci_u32_e32 v3, vcc_lo, s7, v5, vcc_lo             // 0000000019B8: 50060A07
	v_add_co_u32 v0, vcc_lo, s4, v0                            // 0000000019BC: D70F6A00 00020004
	v_add_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo             // 0000000019C4: 50020205
	s_waitcnt vmcnt(1)                                         // 0000000019C8: BF8C3F71
	global_store_dword v[2:3], v12, off                        // 0000000019CC: DC708000 007D0C02
	s_waitcnt vmcnt(0)                                         // 0000000019D4: BF8C3F70
	global_store_dwordx2 v[0:1], v[10:11], off                 // 0000000019D8: DC748000 007D0A00
	s_endpgm                                                   // 0000000019E0: BF810000
some_array_test_symend:
	.long 0xbf9f0000                                           // 0000000019E4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019E8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019EC: BF9F0000
	.long 0xbf9f0000                                           // 0000000019F0: BF9F0000
	.long 0xbf9f0000                                           // 0000000019F4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019F8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019FC: BF9F0000
	.long 0xbf9f0000                                           // 000000001A00: BF9F0000
	.long 0xbf9f0000                                           // 000000001A04: BF9F0000
	.long 0xbf9f0000                                           // 000000001A08: BF9F0000
	.long 0xbf9f0000                                           // 000000001A0C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A10: BF9F0000
	.long 0xbf9f0000                                           // 000000001A14: BF9F0000
	.long 0xbf9f0000                                           // 000000001A18: BF9F0000
	.long 0xbf9f0000                                           // 000000001A1C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A20: BF9F0000
	.long 0xbf9f0000                                           // 000000001A24: BF9F0000
	.long 0xbf9f0000                                           // 000000001A28: BF9F0000
	.long 0xbf9f0000                                           // 000000001A2C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A30: BF9F0000
	.long 0xbf9f0000                                           // 000000001A34: BF9F0000
	.long 0xbf9f0000                                           // 000000001A38: BF9F0000
	.long 0xbf9f0000                                           // 000000001A3C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A40: BF9F0000
	.long 0xbf9f0000                                           // 000000001A44: BF9F0000
	.long 0xbf9f0000                                           // 000000001A48: BF9F0000
	.long 0xbf9f0000                                           // 000000001A4C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A50: BF9F0000
	.long 0xbf9f0000                                           // 000000001A54: BF9F0000
	.long 0xbf9f0000                                           // 000000001A58: BF9F0000
	.long 0xbf9f0000                                           // 000000001A5C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A60: BF9F0000
	.long 0xbf9f0000                                           // 000000001A64: BF9F0000
	.long 0xbf9f0000                                           // 000000001A68: BF9F0000
	.long 0xbf9f0000                                           // 000000001A6C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A70: BF9F0000
	.long 0xbf9f0000                                           // 000000001A74: BF9F0000
	.long 0xbf9f0000                                           // 000000001A78: BF9F0000
	.long 0xbf9f0000                                           // 000000001A7C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A80: BF9F0000
	.long 0xbf9f0000                                           // 000000001A84: BF9F0000
	.long 0xbf9f0000                                           // 000000001A88: BF9F0000
	.long 0xbf9f0000                                           // 000000001A8C: BF9F0000
	.long 0xbf9f0000                                           // 000000001A90: BF9F0000
	.long 0xbf9f0000                                           // 000000001A94: BF9F0000
	.long 0xbf9f0000                                           // 000000001A98: BF9F0000
	.long 0xbf9f0000                                           // 000000001A9C: BF9F0000
	.long 0xbf9f0000                                           // 000000001AA0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AA4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AA8: BF9F0000
	.long 0xbf9f0000                                           // 000000001AAC: BF9F0000
	.long 0xbf9f0000                                           // 000000001AB0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AB4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AB8: BF9F0000
	.long 0xbf9f0000                                           // 000000001ABC: BF9F0000

	.section	.dynamic,#alloc,#write
_DYNAMIC:
	.long 0x6                                                  // 000000002AC0: 00000006
	.long 0                                                    // 000000002AC4: 00000000
	.ascii "x"                                                 // 000000002AC8: 78
	.byte 0x7                                                  // 000000002AC9: 07
	.short 0                                                   // 000000002ACA: 0000
	.long 0                                                    // 000000002ACC: 00000000
	.long 0xb                                                  // 000000002AD0: 0000000B
	.long 0                                                    // 000000002AD4: 00000000
	.long 0x18                                                 // 000000002AD8: 00000018
	.long 0                                                    // 000000002ADC: 00000000
	.long 0x5                                                  // 000000002AE0: 00000005
	.long 0                                                    // 000000002AE4: 00000000
	.long 0x804                                                // 000000002AE8: 00000804
	.long 0                                                    // 000000002AEC: 00000000
	.ascii "\n"                                                // 000000002AF0: 0A
	.byte 0                                                    // 000000002AF1: 00
	.short 0                                                   // 000000002AF2: 0000
	.long 0                                                    // 000000002AF4: 00000000
	.ascii "$"                                                 // 000000002AF8: 24
	.byte 0                                                    // 000000002AF9: 00
	.short 0                                                   // 000000002AFA: 0000
	.long 0                                                    // 000000002AFC: 00000000
	.long 0x6ffffef5                                           // 000000002B00: 6FFFFEF5
	.long 0                                                    // 000000002B04: 00000000
	.long 0x7c0                                                // 000000002B08: 000007C0
	.long 0                                                    // 000000002B0C: 00000000
	.long 0x4                                                  // 000000002B10: 00000004
	.long 0                                                    // 000000002B14: 00000000
	.long 0x7e4                                                // 000000002B18: 000007E4
	.long 0                                                    // 000000002B1C: 00000000
	.long 0                                                    // 000000002B20: 00000000
	.long 0                                                    // 000000002B24: 00000000
	.long 0                                                    // 000000002B28: 00000000
	.long 0                                                    // 000000002B2C: 00000000

	.section	.comment,"MS",@progbits
	.long 0x616c6300                                           // 000000000000: 616C6300
	.ascii "ng version 17.0.0"                                 // 000000000004: 7620676E 69737265 31206E6F 2E302E37 30
	.byte 0                                                    // 000000000015: 00
	.ascii "Linker: LLD 17.0.0"                                // 000000000016: 6B6E694C 203A7265 20444C4C 302E3731 302E
	.byte 0                                                    // 000000000028: 00

	.amdgpu_pal_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .name:           out
        .offset:         0
        .size:           0x8
        .type_name:      'long*'
        .value_kind:     global_buffer
      - .address_space:  global
        .name:           res
        .offset:         0x8
        .size:           0x8
        .type_name:      'int*'
        .value_kind:     global_buffer
      - .name:           i
        .offset:         0x10
        .size:           0x4
        .type_name:      int
        .value_kind:     by_value
      - .offset:         0x18
        .size:           0x4
        .value_kind:     hidden_block_count_x
      - .offset:         0x1c
        .size:           0x4
        .value_kind:     hidden_block_count_y
      - .offset:         0x20
        .size:           0x4
        .value_kind:     hidden_block_count_z
      - .offset:         0x24
        .size:           0x2
        .value_kind:     hidden_group_size_x
      - .offset:         0x26
        .size:           0x2
        .value_kind:     hidden_group_size_y
      - .offset:         0x28
        .size:           0x2
        .value_kind:     hidden_group_size_z
      - .offset:         0x2a
        .size:           0x2
        .value_kind:     hidden_remainder_x
      - .offset:         0x2c
        .size:           0x2
        .value_kind:     hidden_remainder_y
      - .offset:         0x2e
        .size:           0x2
        .value_kind:     hidden_remainder_z
      - .offset:         0x40
        .size:           0x8
        .value_kind:     hidden_global_offset_x
      - .offset:         0x48
        .size:           0x8
        .value_kind:     hidden_global_offset_y
      - .offset:         0x50
        .size:           0x8
        .value_kind:     hidden_global_offset_z
      - .offset:         0x58
        .size:           0x2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 0x8
    .kernarg_segment_size: 0x118
    .language:       OpenCL C
    .language_version:
      - 0x1
      - 0x2
    .max_flat_workgroup_size: 0x40
    .name:           some_array_test
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x8
      - 0x8
      - 0x1
    .sgpr_count:     0xd
    .sgpr_spill_count: 0
    .symbol:         some_array_test.kd
    .uniform_work_group_size: 0x1
    .uses_dynamic_stack: false
    .vgpr_count:     0xd
    .vgpr_spill_count: 0
    .wavefront_size: 0x20
    .workgroup_processor_mode: 0x1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1010
amdhsa.version:
  - 0x1
  - 0x2
amdpal.pipelines:
  - .registers:      {}
...
	.end_amdgpu_pal_metadata
