// llvm-mc -triple=amdgcn--amdhsa -mcpu=gfx1010 -mattr=+wavefrontsize32,+wavefrontsize64

	.section	.note,#alloc
	.section	.dynsym,#alloc
	.long 0                                                    // 000000000760: 00000000
	.long 0                                                    // 000000000764: 00000000
	.long 0                                                    // 000000000768: 00000000
	.long 0                                                    // 00000000076C: 00000000
	.long 0                                                    // 000000000770: 00000000
	.long 0                                                    // 000000000774: 00000000
	.long 0x1                                                  // 000000000778: 00000001
	.long 0x70312                                              // 00000000077C: 00070312
	.long 0x1900                                               // 000000000780: 00001900
	.long 0                                                    // 000000000784: 00000000
	.long 0x90                                                 // 000000000788: 00000090
	.long 0                                                    // 00000000078C: 00000000
	.long 0x6                                                  // 000000000790: 00000006
	.long 0x60311                                              // 000000000794: 00060311
	.long 0x800                                                // 000000000798: 00000800
	.long 0                                                    // 00000000079C: 00000000
	.ascii "@"                                                 // 0000000007A0: 40
	.byte 0                                                    // 0000000007A1: 00
	.short 0                                                   // 0000000007A2: 0000
	.long 0                                                    // 0000000007A4: 00000000

	.section	.gnu.hash,#alloc
	.long 0x1                                                  // 0000000007A8: 00000001
	.long 0x1                                                  // 0000000007AC: 00000001
	.long 0x1                                                  // 0000000007B0: 00000001
	.long 0x1a                                                 // 0000000007B4: 0000001A
	.long 0x80000000                                           // 0000000007B8: 80000000
	.ascii "$"                                                 // 0000000007BC: 24
	.byte 0                                                    // 0000000007BD: 00
	.ascii "@"                                                 // 0000000007BE: 40
	.byte 0                                                    // 0000000007BF: 00
	.long 0x1                                                  // 0000000007C0: 00000001
	.ascii "dh"                                                // 0000000007C4: 6864
	.short 0x7c9e                                              // 0000000007C6: 7C9E
	.ascii "#"                                                 // 0000000007C8: 23
	.byte 0x9c                                                 // 0000000007C9: 9C
	.short 0xd91d                                              // 0000000007CA: D91D

	.section	.hash,#alloc
	.long 0x3                                                  // 0000000007CC: 00000003
	.long 0x3                                                  // 0000000007D0: 00000003
	.long 0x2                                                  // 0000000007D4: 00000002
	.long 0x1                                                  // 0000000007D8: 00000001
	.long 0                                                    // 0000000007DC: 00000000
	.long 0                                                    // 0000000007E0: 00000000
	.long 0                                                    // 0000000007E4: 00000000
	.long 0                                                    // 0000000007E8: 00000000

	.section	.rodata,#alloc
	.type	test.kd,@object
test.kd:
	.long 0                                                    // 000000000800: 00000000
	.long 0                                                    // 000000000804: 00000000
	.long 0x118                                                // 000000000808: 00000118
	.long 0                                                    // 00000000080C: 00000000
	.long 0x1100                                               // 000000000810: 00001100
	.long 0                                                    // 000000000814: 00000000
	.long 0                                                    // 000000000818: 00000000
	.long 0                                                    // 00000000081C: 00000000
	.long 0                                                    // 000000000820: 00000000
	.long 0                                                    // 000000000824: 00000000
	.long 0                                                    // 000000000828: 00000000
	.long 0                                                    // 00000000082C: 00000000
	.ascii "@"                                                 // 000000000830: 40
	.byte 0                                                    // 000000000831: 00
	.short 0x60af                                              // 000000000832: 60AF
	.long 0x90                                                 // 000000000834: 00000090
	.long 0x40b                                                // 000000000838: 0000040B
	.long 0                                                    // 00000000083C: 00000000
	.type	i8,@object
i8:
	.long 0x1                                                  // 000000000840: 00000001
	.long 0x2                                                  // 000000000844: 00000002
	.long 0x3                                                  // 000000000848: 00000003
	.long 0x4                                                  // 00000000084C: 00000004
	.long 0x5                                                  // 000000000850: 00000005
	.long 0x6                                                  // 000000000854: 00000006
	.long 0x7                                                  // 000000000858: 00000007
	.long 0x8                                                  // 00000000085C: 00000008

	.text

	.p2align	8
	.type	test,@function
	.size	test, test_symend-test
test:
	s_load_dword s0, s[6:7], 0x10                              // 000000001900: F4000003 FA000010
	s_load_dword s9, s[4:5], 0x4                               // 000000001908: F4000242 FA000004
	s_load_dword s10, s[6:7], 0x18                             // 000000001910: F4000283 FA000018
	s_getpc_b64 s[2:3]                                         // 000000001918: BE821F00
	s_add_u32 s2, s2, 0xffffef24                               // 00000000191C: 8002FF02 FFFFEF24
	s_addc_u32 s3, s3, -1                                      // 000000001924: 8203FF03 FFFFFFFF
	s_load_dwordx2 s[4:5], s[6:7], null                        // 00000000192C: F4040103 FA000000
	s_waitcnt lgkmcnt(0)                                       // 000000001934: BF8CC07F
	s_ashr_i32 s1, s0, 31                                      // 000000001938: 91019F00
	s_and_b32 s6, s9, 0xffff                                   // 00000000193C: 8706FF09 0000FFFF
	s_lshl_b64 s[0:1], s[0:1], 2                               // 000000001944: 8F808200
	s_mul_i32 s8, s8, s6                                       // 000000001948: 93080608
	s_add_u32 s0, s0, s2                                       // 00000000194C: 80000200
	s_addc_u32 s1, s1, s3                                      // 000000001950: 82010301
	v_add3_u32 v1, s10, s8, v0                                 // 000000001954: D76D0001 0400100A
	s_load_dword s0, s[0:1], null                              // 00000000195C: F4000000 FA000000
	v_mov_b32_e32 v0, 0                                        // 000000001964: 7E000280
	v_ashrrev_i64 v[0:1], 30, v[0:1]                           // 000000001968: D7010000 0002009E
	v_add_co_u32 v0, vcc_lo, s4, v0                            // 000000001970: D70F6A00 00020004
	v_add_co_ci_u32_e32 v1, vcc_lo, s5, v1, vcc_lo             // 000000001978: 50020205
	s_waitcnt lgkmcnt(0)                                       // 00000000197C: BF8CC07F
	v_mov_b32_e32 v2, s0                                       // 000000001980: 7E040200
	global_store_dword v[0:1], v2, off                         // 000000001984: DC708000 007D0200
	s_endpgm                                                   // 00000000198C: BF810000
test_symend:
	.long 0xbf9f0000                                           // 000000001990: BF9F0000
	.long 0xbf9f0000                                           // 000000001994: BF9F0000
	.long 0xbf9f0000                                           // 000000001998: BF9F0000
	.long 0xbf9f0000                                           // 00000000199C: BF9F0000
	.long 0xbf9f0000                                           // 0000000019A0: BF9F0000
	.long 0xbf9f0000                                           // 0000000019A4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019A8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019AC: BF9F0000
	.long 0xbf9f0000                                           // 0000000019B0: BF9F0000
	.long 0xbf9f0000                                           // 0000000019B4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019B8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019BC: BF9F0000
	.long 0xbf9f0000                                           // 0000000019C0: BF9F0000
	.long 0xbf9f0000                                           // 0000000019C4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019C8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019CC: BF9F0000
	.long 0xbf9f0000                                           // 0000000019D0: BF9F0000
	.long 0xbf9f0000                                           // 0000000019D4: BF9F0000
	.long 0xbf9f0000                                           // 0000000019D8: BF9F0000
	.long 0xbf9f0000                                           // 0000000019DC: BF9F0000
	.long 0xbf9f0000                                           // 0000000019E0: BF9F0000
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

	.section	.dynamic,#alloc,#write
_DYNAMIC:
	.long 0x6                                                  // 000000002A80: 00000006
	.long 0                                                    // 000000002A84: 00000000
	.ascii "`"                                                 // 000000002A88: 60
	.byte 0x7                                                  // 000000002A89: 07
	.short 0                                                   // 000000002A8A: 0000
	.long 0                                                    // 000000002A8C: 00000000
	.long 0xb                                                  // 000000002A90: 0000000B
	.long 0                                                    // 000000002A94: 00000000
	.long 0x18                                                 // 000000002A98: 00000018
	.long 0                                                    // 000000002A9C: 00000000
	.long 0x5                                                  // 000000002AA0: 00000005
	.long 0                                                    // 000000002AA4: 00000000
	.long 0x7ec                                                // 000000002AA8: 000007EC
	.long 0                                                    // 000000002AAC: 00000000
	.ascii "\n"                                                // 000000002AB0: 0A
	.byte 0                                                    // 000000002AB1: 00
	.short 0                                                   // 000000002AB2: 0000
	.long 0                                                    // 000000002AB4: 00000000
	.long 0xe                                                  // 000000002AB8: 0000000E
	.long 0                                                    // 000000002ABC: 00000000
	.long 0x6ffffef5                                           // 000000002AC0: 6FFFFEF5
	.long 0                                                    // 000000002AC4: 00000000
	.long 0x7a8                                                // 000000002AC8: 000007A8
	.long 0                                                    // 000000002ACC: 00000000
	.long 0x4                                                  // 000000002AD0: 00000004
	.long 0                                                    // 000000002AD4: 00000000
	.long 0x7cc                                                // 000000002AD8: 000007CC
	.long 0                                                    // 000000002ADC: 00000000
	.long 0                                                    // 000000002AE0: 00000000
	.long 0                                                    // 000000002AE4: 00000000
	.long 0                                                    // 000000002AE8: 00000000
	.long 0                                                    // 000000002AEC: 00000000

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
        .name:           in
        .offset:         0
        .size:           0x8
        .type_name:      'int*'
        .value_kind:     global_buffer
      - .address_space:  global
        .name:           out
        .offset:         0x8
        .size:           0x8
        .type_name:      'uint*'
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
    .name:           test
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x40
      - 0x1
      - 0x1
    .sgpr_count:     0xd
    .sgpr_spill_count: 0
    .symbol:         test.kd
    .uniform_work_group_size: 0x1
    .uses_dynamic_stack: false
    .vgpr_count:     0x3
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
