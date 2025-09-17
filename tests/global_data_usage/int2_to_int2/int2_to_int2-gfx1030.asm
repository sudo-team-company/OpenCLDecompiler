// llvm-mc -triple=amdgcn--amdhsa -mcpu=gfx1030 -mattr=+wavefrontsize32,+wavefrontsize64

	.section	.note,#alloc
	.section	.dynsym,#alloc
	.long 0                                                    // 000000000708: 00000000
	.long 0                                                    // 00000000070C: 00000000
	.long 0                                                    // 000000000710: 00000000
	.long 0                                                    // 000000000714: 00000000
	.long 0                                                    // 000000000718: 00000000
	.long 0                                                    // 00000000071C: 00000000
	.long 0x1                                                  // 000000000720: 00000001
	.long 0x70312                                              // 000000000724: 00070312
	.long 0x1900                                               // 000000000728: 00001900
	.long 0                                                    // 00000000072C: 00000000
	.long 0x84                                                 // 000000000730: 00000084
	.long 0                                                    // 000000000734: 00000000
	.ascii "\n"                                                // 000000000738: 0A
	.byte 0                                                    // 000000000739: 00
	.short 0                                                   // 00000000073A: 0000
	.long 0x60311                                              // 00000000073C: 00060311
	.long 0x7c0                                                // 000000000740: 000007C0
	.long 0                                                    // 000000000744: 00000000
	.ascii "@"                                                 // 000000000748: 40
	.byte 0                                                    // 000000000749: 00
	.short 0                                                   // 00000000074A: 0000
	.long 0                                                    // 00000000074C: 00000000

	.section	.gnu.hash,#alloc
	.long 0x1                                                  // 000000000750: 00000001
	.long 0x1                                                  // 000000000754: 00000001
	.long 0x1                                                  // 000000000758: 00000001
	.long 0x1a                                                 // 00000000075C: 0000001A
	.long 0                                                    // 000000000760: 00000000
	.long 0x9204                                               // 000000000764: 00009204
	.long 0x1                                                  // 000000000768: 00000001
	.long 0x8bc88eee                                           // 00000000076C: 8BC88EEE
	.ascii "m"                                                 // 000000000770: 6D
	.byte 0xae                                                 // 000000000771: AE
	.ascii ")"                                                 // 000000000772: 29
	.byte 0xa5                                                 // 000000000773: A5

	.section	.hash,#alloc
	.long 0x3                                                  // 000000000774: 00000003
	.long 0x3                                                  // 000000000778: 00000003
	.long 0                                                    // 00000000077C: 00000000
	.long 0x2                                                  // 000000000780: 00000002
	.long 0x1                                                  // 000000000784: 00000001
	.long 0                                                    // 000000000788: 00000000
	.long 0                                                    // 00000000078C: 00000000
	.long 0                                                    // 000000000790: 00000000

	.section	.rodata,#alloc
	.type	int_test.kd,@object
int_test.kd:
	.long 0                                                    // 0000000007C0: 00000000
	.long 0                                                    // 0000000007C4: 00000000
	.long 0x110                                                // 0000000007C8: 00000110
	.long 0                                                    // 0000000007CC: 00000000
	.ascii "@"                                                 // 0000000007D0: 40
	.byte 0x11                                                 // 0000000007D1: 11
	.short 0                                                   // 0000000007D2: 0000
	.long 0                                                    // 0000000007D4: 00000000
	.long 0                                                    // 0000000007D8: 00000000
	.long 0                                                    // 0000000007DC: 00000000
	.long 0                                                    // 0000000007E0: 00000000
	.long 0                                                    // 0000000007E4: 00000000
	.long 0                                                    // 0000000007E8: 00000000
	.long 0                                                    // 0000000007EC: 00000000
	.ascii "@"                                                 // 0000000007F0: 40
	.byte 0                                                    // 0000000007F1: 00
	.short 0x60af                                              // 0000000007F2: 60AF
	.long 0x90                                                 // 0000000007F4: 00000090
	.long 0x40b                                                // 0000000007F8: 0000040B
	.long 0                                                    // 0000000007FC: 00000000
	.type	int_arr,@object
int_arr:
	.long 0x1                                                  // 000000000800: 00000001
	.long 0x2                                                  // 000000000804: 00000002
	.long 0x4                                                  // 000000000808: 00000004
	.long 0x5                                                  // 00000000080C: 00000005
	.long 0x7                                                  // 000000000810: 00000007
	.long 0x8                                                  // 000000000814: 00000008

	.text

	.p2align	8
	.type	int_test,@function
	.size	int_test, int_test_symend-int_test
int_test:
	s_load_dword s0, s[4:5], 0x4                               // 000000001900: F4000002 FA000004
	s_load_dword s1, s[6:7], 0x10                              // 000000001908: F4000043 FA000010
	v_mov_b32_e32 v1, 0                                        // 000000001910: 7E020280
	s_waitcnt lgkmcnt(0)                                       // 000000001914: BF8CC07F
	s_and_b32 s0, s0, 0xffff                                   // 000000001918: 8700FF00 0000FFFF
	s_mul_i32 s8, s8, s0                                       // 000000001920: 93080008
	v_add3_u32 v0, v0, s1, s8                                  // 000000001924: D76D0000 00200300
	s_getpc_b64 s[0:1]                                         // 00000000192C: BE801F00
	s_add_u32 s0, s0, 0xffffeed0                               // 000000001930: 8000FF00 FFFFEED0
	s_addc_u32 s1, s1, -1                                      // 000000001938: 8201FF01 FFFFFFFF
	v_lshlrev_b64 v[0:1], 3, v[0:1]                            // 000000001940: D6FF0000 00020083
	v_add_co_u32 v2, vcc_lo, v0, s0                            // 000000001948: D70F6A02 00000100
	v_add_co_ci_u32_e32 v3, vcc_lo, s1, v1, vcc_lo             // 000000001950: 50060201
	s_load_dwordx2 s[0:1], s[6:7], null                        // 000000001954: F4040003 FA000000
	global_load_dwordx2 v[2:3], v[2:3], off                    // 00000000195C: DC348000 027D0002
	s_waitcnt lgkmcnt(0)                                       // 000000001964: BF8CC07F
	v_add_co_u32 v0, vcc_lo, s0, v0                            // 000000001968: D70F6A00 00020000
	v_add_co_ci_u32_e32 v1, vcc_lo, s1, v1, vcc_lo             // 000000001970: 50020201
	s_waitcnt vmcnt(0)                                         // 000000001974: BF8C3F70
	global_store_dwordx2 v[0:1], v[2:3], off                   // 000000001978: DC748000 007D0200
	s_endpgm                                                   // 000000001980: BF810000
int_test_symend:
	.long 0xbf9f0000                                           // 000000001984: BF9F0000
	.long 0xbf9f0000                                           // 000000001988: BF9F0000
	.long 0xbf9f0000                                           // 00000000198C: BF9F0000
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
	.long 0x708                                                // 000000002A88: 00000708
	.long 0                                                    // 000000002A8C: 00000000
	.long 0xb                                                  // 000000002A90: 0000000B
	.long 0                                                    // 000000002A94: 00000000
	.long 0x18                                                 // 000000002A98: 00000018
	.long 0                                                    // 000000002A9C: 00000000
	.long 0x5                                                  // 000000002AA0: 00000005
	.long 0                                                    // 000000002AA4: 00000000
	.long 0x794                                                // 000000002AA8: 00000794
	.long 0                                                    // 000000002AAC: 00000000
	.ascii "\n"                                                // 000000002AB0: 0A
	.byte 0                                                    // 000000002AB1: 00
	.short 0                                                   // 000000002AB2: 0000
	.long 0                                                    // 000000002AB4: 00000000
	.long 0x16                                                 // 000000002AB8: 00000016
	.long 0                                                    // 000000002ABC: 00000000
	.long 0x6ffffef5                                           // 000000002AC0: 6FFFFEF5
	.long 0                                                    // 000000002AC4: 00000000
	.ascii "P"                                                 // 000000002AC8: 50
	.byte 0x7                                                  // 000000002AC9: 07
	.short 0                                                   // 000000002ACA: 0000
	.long 0                                                    // 000000002ACC: 00000000
	.long 0x4                                                  // 000000002AD0: 00000004
	.long 0                                                    // 000000002AD4: 00000000
	.ascii "t"                                                 // 000000002AD8: 74
	.byte 0x7                                                  // 000000002AD9: 07
	.short 0                                                   // 000000002ADA: 0000
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
        .name:           out
        .offset:         0
        .size:           0x8
        .type_name:      'int2*'
        .value_kind:     global_buffer
      - .name:           i
        .offset:         0x8
        .size:           0x4
        .type_name:      int
        .value_kind:     by_value
      - .offset:         0x10
        .size:           0x4
        .value_kind:     hidden_block_count_x
      - .offset:         0x14
        .size:           0x4
        .value_kind:     hidden_block_count_y
      - .offset:         0x18
        .size:           0x4
        .value_kind:     hidden_block_count_z
      - .offset:         0x1c
        .size:           0x2
        .value_kind:     hidden_group_size_x
      - .offset:         0x1e
        .size:           0x2
        .value_kind:     hidden_group_size_y
      - .offset:         0x20
        .size:           0x2
        .value_kind:     hidden_group_size_z
      - .offset:         0x22
        .size:           0x2
        .value_kind:     hidden_remainder_x
      - .offset:         0x24
        .size:           0x2
        .value_kind:     hidden_remainder_y
      - .offset:         0x26
        .size:           0x2
        .value_kind:     hidden_remainder_z
      - .offset:         0x38
        .size:           0x8
        .value_kind:     hidden_global_offset_x
      - .offset:         0x40
        .size:           0x8
        .value_kind:     hidden_global_offset_y
      - .offset:         0x48
        .size:           0x8
        .value_kind:     hidden_global_offset_z
      - .offset:         0x50
        .size:           0x2
        .value_kind:     hidden_grid_dims
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 0x8
    .kernarg_segment_size: 0x110
    .language:       OpenCL C
    .language_version:
      - 0x1
      - 0x2
    .max_flat_workgroup_size: 0x40
    .name:           int_test
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x40
      - 0x1
      - 0x1
    .sgpr_count:     0xb
    .sgpr_spill_count: 0
    .symbol:         int_test.kd
    .uniform_work_group_size: 0x1
    .uses_dynamic_stack: false
    .vgpr_count:     0x4
    .vgpr_spill_count: 0
    .wavefront_size: 0x20
    .workgroup_processor_mode: 0x1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1030
amdhsa.version:
  - 0x1
  - 0x2
amdpal.pipelines:
  - .registers:      {}
...
	.end_amdgpu_pal_metadata
