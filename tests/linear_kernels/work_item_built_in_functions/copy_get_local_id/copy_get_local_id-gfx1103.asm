// llvm-mc -triple=amdgcn--amdhsa -mcpu=gfx1103 -mattr=+wavefrontsize32,+wavefrontsize64

	.section	.note,#alloc
	.section	.dynsym,#alloc
	.long 0                                                    // 0000000006F0: 00000000
	.long 0                                                    // 0000000006F4: 00000000
	.long 0                                                    // 0000000006F8: 00000000
	.long 0                                                    // 0000000006FC: 00000000
	.long 0                                                    // 000000000700: 00000000
	.long 0                                                    // 000000000704: 00000000
	.long 0x1                                                  // 000000000708: 00000001
	.long 0x70312                                              // 00000000070C: 00070312
	.long 0x1800                                               // 000000000710: 00001800
	.long 0                                                    // 000000000714: 00000000
	.long 0xd4                                                 // 000000000718: 000000D4
	.long 0                                                    // 00000000071C: 00000000
	.long 0x13                                                 // 000000000720: 00000013
	.long 0x60311                                              // 000000000724: 00060311
	.long 0x7c0                                                // 000000000728: 000007C0
	.long 0                                                    // 00000000072C: 00000000
	.ascii "@"                                                 // 000000000730: 40
	.byte 0                                                    // 000000000731: 00
	.short 0                                                   // 000000000732: 0000
	.long 0                                                    // 000000000734: 00000000

	.section	.gnu.hash,#alloc
	.long 0x1                                                  // 000000000738: 00000001
	.long 0x1                                                  // 00000000073C: 00000001
	.long 0x1                                                  // 000000000740: 00000001
	.long 0x1a                                                 // 000000000744: 0000001A
	.long 0                                                    // 000000000748: 00000000
	.long 0x240004                                             // 00000000074C: 00240004
	.long 0x1                                                  // 000000000750: 00000001
	.long 0xca2bc2b4                                           // 000000000754: CA2BC2B4
	.ascii "s"                                                 // 000000000758: 73
	.byte 0x94                                                 // 000000000759: 94
	.short 0x8910                                              // 00000000075A: 8910

	.section	.hash,#alloc
	.long 0x3                                                  // 00000000075C: 00000003
	.long 0x3                                                  // 000000000760: 00000003
	.long 0x2                                                  // 000000000764: 00000002
	.long 0x1                                                  // 000000000768: 00000001
	.long 0                                                    // 00000000076C: 00000000
	.long 0                                                    // 000000000770: 00000000
	.long 0                                                    // 000000000774: 00000000
	.long 0                                                    // 000000000778: 00000000

	.section	.rodata,#alloc
	.type	copy_get_local_id.kd,@object
copy_get_local_id.kd:
	.long 0                                                    // 0000000007C0: 00000000
	.long 0                                                    // 0000000007C4: 00000000
	.long 0x110                                                // 0000000007C8: 00000110
	.long 0                                                    // 0000000007CC: 00000000
	.ascii "@"                                                 // 0000000007D0: 40
	.byte 0x10                                                 // 0000000007D1: 10
	.short 0                                                   // 0000000007D2: 0000
	.long 0                                                    // 0000000007D4: 00000000
	.long 0                                                    // 0000000007D8: 00000000
	.long 0                                                    // 0000000007DC: 00000000
	.long 0                                                    // 0000000007E0: 00000000
	.long 0                                                    // 0000000007E4: 00000000
	.long 0                                                    // 0000000007E8: 00000000
	.long 0                                                    // 0000000007EC: 00000000
	.long 0x60af0101                                           // 0000000007F0: 60AF0101
	.long 0x1384                                               // 0000000007F4: 00001384
	.long 0x408                                                // 0000000007F8: 00000408
	.long 0                                                    // 0000000007FC: 00000000

	.text

	.p2align	8
	.type	copy_get_local_id,@function
	.size	copy_get_local_id, copy_get_local_id_symend-copy_get_local_id
copy_get_local_id:
	s_clause 0x2                                               // 000000001800: BF850002
	s_load_b128 s[8:11], s[0:1], 0x38                          // 000000001804: F4080200 F8000038
	s_load_b32 s5, s[0:1], 0x48                                // 00000000180C: F4000140 F8000048
	s_load_b64 s[0:1], s[0:1], 0x8                             // 000000001814: F4040000 F8000008
	v_dual_mov_b32 v2, 0 :: v_dual_and_b32 v7, 0x3ff, v0       // 00000000181C: CA240080 020600FF 000003FF
	s_lshl_b32 s2, s2, 2                                       // 000000001828: 84028202
	v_bfe_u32 v8, v0, 10, 10                                   // 00000000182C: D6100008 02291500
	v_bfe_u32 v9, v0, 20, 10                                   // 000000001834: D6100009 02292900
	s_mov_b32 s33, 0                                           // 00000000183C: BEA10080
	s_waitcnt lgkmcnt(0)                                       // 000000001840: BF89FC07
	v_add3_u32 v1, s8, s2, v7                                  // 000000001844: D6550001 041C0408
	s_lshl_b32 s2, s3, 2                                       // 00000000184C: 84028203
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 000000001850: BF8700B1
	v_lshlrev_b64 v[3:4], 2, v[1:2]                            // 000000001854: D73C0003 00020282
	v_add3_u32 v1, s10, s2, v8                                 // 00000000185C: D6550001 0420040A
	s_lshl_b32 s2, s4, 2                                       // 000000001864: 84028204
	v_lshlrev_b64 v[5:6], 2, v[1:2]                            // 000000001868: D73C0005 00020282
	v_add3_u32 v1, s5, s2, v9                                  // 000000001870: D6550001 04240405
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 000000001878: BF8701A4
	v_add_co_u32 v3, vcc_lo, s0, v3                            // 00000000187C: D7006A03 00020600
	v_add_co_ci_u32_e32 v4, vcc_lo, s1, v4, vcc_lo             // 000000001884: 40080801
	v_lshlrev_b64 v[0:1], 2, v[1:2]                            // 000000001888: D73C0000 00020282
	v_add_co_u32 v5, vcc_lo, s0, v5                            // 000000001890: D7006A05 00020A00
	v_add_co_ci_u32_e32 v6, vcc_lo, s1, v6, vcc_lo             // 000000001898: 400C0C01
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000189C: BF870213
	v_add_co_u32 v0, vcc_lo, s0, v0                            // 0000000018A0: D7006A00 00020000
	v_add_co_ci_u32_e32 v1, vcc_lo, s1, v1, vcc_lo             // 0000000018A8: 40020201
	s_clause 0x2                                               // 0000000018AC: BF850002
	global_store_b32 v[3:4], v7, off                           // 0000000018B0: DC6A0000 007C0703
	global_store_b32 v[5:6], v8, off                           // 0000000018B8: DC6A0000 007C0805
	global_store_b32 v[0:1], v9, off                           // 0000000018C0: DC6A0000 007C0900
	s_nop 0                                                    // 0000000018C8: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 0000000018CC: BFB60003
	s_endpgm                                                   // 0000000018D0: BFB00000
copy_get_local_id_symend:
	.long 0xbf9f0000                                           // 0000000018D4: BF9F0000
	.long 0xbf9f0000                                           // 0000000018D8: BF9F0000
	.long 0xbf9f0000                                           // 0000000018DC: BF9F0000
	.long 0xbf9f0000                                           // 0000000018E0: BF9F0000
	.long 0xbf9f0000                                           // 0000000018E4: BF9F0000
	.long 0xbf9f0000                                           // 0000000018E8: BF9F0000
	.long 0xbf9f0000                                           // 0000000018EC: BF9F0000
	.long 0xbf9f0000                                           // 0000000018F0: BF9F0000
	.long 0xbf9f0000                                           // 0000000018F4: BF9F0000
	.long 0xbf9f0000                                           // 0000000018F8: BF9F0000
	.long 0xbf9f0000                                           // 0000000018FC: BF9F0000
	.long 0xbf9f0000                                           // 000000001900: BF9F0000
	.long 0xbf9f0000                                           // 000000001904: BF9F0000
	.long 0xbf9f0000                                           // 000000001908: BF9F0000
	.long 0xbf9f0000                                           // 00000000190C: BF9F0000
	.long 0xbf9f0000                                           // 000000001910: BF9F0000
	.long 0xbf9f0000                                           // 000000001914: BF9F0000
	.long 0xbf9f0000                                           // 000000001918: BF9F0000
	.long 0xbf9f0000                                           // 00000000191C: BF9F0000
	.long 0xbf9f0000                                           // 000000001920: BF9F0000
	.long 0xbf9f0000                                           // 000000001924: BF9F0000
	.long 0xbf9f0000                                           // 000000001928: BF9F0000
	.long 0xbf9f0000                                           // 00000000192C: BF9F0000
	.long 0xbf9f0000                                           // 000000001930: BF9F0000
	.long 0xbf9f0000                                           // 000000001934: BF9F0000
	.long 0xbf9f0000                                           // 000000001938: BF9F0000
	.long 0xbf9f0000                                           // 00000000193C: BF9F0000
	.long 0xbf9f0000                                           // 000000001940: BF9F0000
	.long 0xbf9f0000                                           // 000000001944: BF9F0000
	.long 0xbf9f0000                                           // 000000001948: BF9F0000
	.long 0xbf9f0000                                           // 00000000194C: BF9F0000
	.long 0xbf9f0000                                           // 000000001950: BF9F0000
	.long 0xbf9f0000                                           // 000000001954: BF9F0000
	.long 0xbf9f0000                                           // 000000001958: BF9F0000
	.long 0xbf9f0000                                           // 00000000195C: BF9F0000
	.long 0xbf9f0000                                           // 000000001960: BF9F0000
	.long 0xbf9f0000                                           // 000000001964: BF9F0000
	.long 0xbf9f0000                                           // 000000001968: BF9F0000
	.long 0xbf9f0000                                           // 00000000196C: BF9F0000
	.long 0xbf9f0000                                           // 000000001970: BF9F0000
	.long 0xbf9f0000                                           // 000000001974: BF9F0000
	.long 0xbf9f0000                                           // 000000001978: BF9F0000
	.long 0xbf9f0000                                           // 00000000197C: BF9F0000
	.long 0xbf9f0000                                           // 000000001980: BF9F0000
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
	.long 0x6f0                                                // 000000002A88: 000006F0
	.long 0                                                    // 000000002A8C: 00000000
	.long 0xb                                                  // 000000002A90: 0000000B
	.long 0                                                    // 000000002A94: 00000000
	.long 0x18                                                 // 000000002A98: 00000018
	.long 0                                                    // 000000002A9C: 00000000
	.long 0x5                                                  // 000000002AA0: 00000005
	.long 0                                                    // 000000002AA4: 00000000
	.ascii "|"                                                 // 000000002AA8: 7C
	.byte 0x7                                                  // 000000002AA9: 07
	.short 0                                                   // 000000002AAA: 0000
	.long 0                                                    // 000000002AAC: 00000000
	.ascii "\n"                                                // 000000002AB0: 0A
	.byte 0                                                    // 000000002AB1: 00
	.short 0                                                   // 000000002AB2: 0000
	.long 0                                                    // 000000002AB4: 00000000
	.ascii "("                                                 // 000000002AB8: 28
	.byte 0                                                    // 000000002AB9: 00
	.short 0                                                   // 000000002ABA: 0000
	.long 0                                                    // 000000002ABC: 00000000
	.long 0x6ffffef5                                           // 000000002AC0: 6FFFFEF5
	.long 0                                                    // 000000002AC4: 00000000
	.ascii "8"                                                 // 000000002AC8: 38
	.byte 0x7                                                  // 000000002AC9: 07
	.short 0                                                   // 000000002ACA: 0000
	.long 0                                                    // 000000002ACC: 00000000
	.long 0x4                                                  // 000000002AD0: 00000004
	.long 0                                                    // 000000002AD4: 00000000
	.ascii "\\"                                                // 000000002AD8: 5C
	.byte 0x7                                                  // 000000002AD9: 07
	.short 0                                                   // 000000002ADA: 0000
	.long 0                                                    // 000000002ADC: 00000000
	.long 0                                                    // 000000002AE0: 00000000
	.long 0                                                    // 000000002AE4: 00000000
	.long 0                                                    // 000000002AE8: 00000000
	.long 0                                                    // 000000002AEC: 00000000

	.section	.comment,"MS",@progbits
	.long 0x616c6300                                           // 000000000000: 616C6300
	.ascii "ng version 18.0.0 (ssh://gerritgit/lightning/ec/llvm-project 12ba2f50c2cd6ac494748370b29a8838deb2fb39)"// 000000000004: 7620676E 69737265 31206E6F 2E302E38 73282030 2F3A6873 7265672F 67746972 6C2F7469 74686769 676E696E 2F63652F 6D766C6C 6F72702D 7463656A 62323120 35663261 63326330 63613664 37343934 37333834 39326230 33383861 62656438 33626632 2939
	.short 0x4c00                                              // 00000000006A: 4C00
	.ascii "inker: LLD 18.0.0"                                 // 00000000006C: 656B6E69 4C203A72 3120444C 2E302E38 30
	.byte 0                                                    // 00000000007D: 00

	.amdgpu_pal_metadata
---
amdhsa.kernels:
  - .args:
      - .offset:         0
        .size:           0x4
        .type_name:      int
        .value_kind:     by_value
      - .address_space:  global
        .offset:         0x8
        .size:           0x8
        .type_name:      'int*'
        .value_kind:     global_buffer
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
      - 0x2
      - 0
    .max_flat_workgroup_size: 0x40
    .name:           copy_get_local_id
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x4
      - 0x4
      - 0x4
    .sgpr_count:     0x24
    .sgpr_spill_count: 0
    .symbol:         copy_get_local_id.kd
    .uses_dynamic_stack: false
    .vgpr_count:     0xa
    .vgpr_spill_count: 0
    .wavefront_size: 0x20
    .workgroup_processor_mode: 0x1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1103
amdhsa.version:
  - 0x1
  - 0x2
amdpal.pipelines:
  - .registers:      {}
...
	.end_amdgpu_pal_metadata
