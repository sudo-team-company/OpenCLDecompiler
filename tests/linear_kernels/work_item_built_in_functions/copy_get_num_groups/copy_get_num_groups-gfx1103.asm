// llvm-mc -triple=amdgcn--amdhsa -mcpu=gfx1103 -mattr=+wavefrontsize32,+wavefrontsize64

	.section	.note,#alloc
	.section	.dynsym,#alloc
	.long 0                                                    // 0000000006F8: 00000000
	.long 0                                                    // 0000000006FC: 00000000
	.long 0                                                    // 000000000700: 00000000
	.long 0                                                    // 000000000704: 00000000
	.long 0                                                    // 000000000708: 00000000
	.long 0                                                    // 00000000070C: 00000000
	.long 0x1                                                  // 000000000710: 00000001
	.long 0x70312                                              // 000000000714: 00070312
	.long 0x1800                                               // 000000000718: 00001800
	.long 0                                                    // 00000000071C: 00000000
	.ascii "8"                                                 // 000000000720: 38
	.byte 0x1                                                  // 000000000721: 01
	.short 0                                                   // 000000000722: 0000
	.long 0                                                    // 000000000724: 00000000
	.long 0x15                                                 // 000000000728: 00000015
	.long 0x60311                                              // 00000000072C: 00060311
	.long 0x7c0                                                // 000000000730: 000007C0
	.long 0                                                    // 000000000734: 00000000
	.ascii "@"                                                 // 000000000738: 40
	.byte 0                                                    // 000000000739: 00
	.short 0                                                   // 00000000073A: 0000
	.long 0                                                    // 00000000073C: 00000000

	.section	.gnu.hash,#alloc
	.long 0x1                                                  // 000000000740: 00000001
	.long 0x1                                                  // 000000000744: 00000001
	.long 0x1                                                  // 000000000748: 00000001
	.long 0x1a                                                 // 00000000074C: 0000001A
	.long 0x808000                                             // 000000000750: 00808000
	.long 0x2400                                               // 000000000754: 00002400
	.long 0x1                                                  // 000000000758: 00000001
	.ascii "l"                                                 // 00000000075C: 6C
	.byte 0x8b                                                 // 00000000075D: 8B
	.ascii "v]+B+>"                                            // 00000000075E: 422B5D76 3E2B

	.section	.hash,#alloc
	.long 0x3                                                  // 000000000764: 00000003
	.long 0x3                                                  // 000000000768: 00000003
	.long 0                                                    // 00000000076C: 00000000
	.long 0x2                                                  // 000000000770: 00000002
	.long 0x1                                                  // 000000000774: 00000001
	.long 0                                                    // 000000000778: 00000000
	.long 0                                                    // 00000000077C: 00000000
	.long 0                                                    // 000000000780: 00000000

	.section	.rodata,#alloc
	.type	copy_get_num_groups.kd,@object
copy_get_num_groups.kd:
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
	.type	copy_get_num_groups,@function
	.size	copy_get_num_groups, copy_get_num_groups_symend-copy_get_num_groups
copy_get_num_groups:
	v_dual_mov_b32 v2, 0 :: v_dual_and_b32 v1, 0x3ff, v0       // 000000001800: CA240080 020000FF 000003FF
	s_load_b64 s[6:7], s[0:1], 0x8                             // 00000000180C: F4040180 F8000008
	s_lshl_b32 s2, s2, 1                                       // 000000001814: 84028102
	v_bfe_u32 v5, v0, 10, 10                                   // 000000001818: D6100005 02291500
	s_clause 0x1                                               // 000000001820: BF850001
	global_load_b32 v7, v2, s[0:1] offset:34                   // 000000001824: DC520022 07000002
	global_load_u16 v8, v2, s[0:1] offset:38                   // 00000000182C: DC4A0026 08000002
	s_clause 0x2                                               // 000000001834: BF850002
	s_load_b128 s[8:11], s[0:1], 0x38                          // 000000001838: F4080200 F8000038
	s_load_b32 s5, s[0:1], 0x48                                // 000000001840: F4000140 F8000048
	s_load_b128 s[12:15], s[0:1], 0x10                         // 000000001848: F4080300 F8000010
	s_lshl_b32 s0, s3, 1                                       // 000000001850: 84008103
	v_bfe_u32 v0, v0, 20, 10                                   // 000000001854: D6100000 02292900
	s_mov_b32 s33, 0                                           // 00000000185C: BEA10080
	s_waitcnt lgkmcnt(0)                                       // 000000001860: BF89FC07
	v_add3_u32 v1, s8, s2, v1                                  // 000000001864: D6550001 04040408
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000186C: BF8700B1
	v_lshlrev_b64 v[3:4], 2, v[1:2]                            // 000000001870: D73C0003 00020282
	v_add3_u32 v1, s10, s0, v5                                 // 000000001878: D6550001 0414000A
	s_lshl_b32 s0, s4, 2                                       // 000000001880: 84008204
	v_lshlrev_b64 v[5:6], 2, v[1:2]                            // 000000001884: D73C0005 00020282
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000188C: BF870213
	v_add_co_u32 v3, vcc_lo, s6, v3                            // 000000001890: D7006A03 00020606
	v_add_co_ci_u32_e32 v4, vcc_lo, s7, v4, vcc_lo             // 000000001898: 40080807
	v_add3_u32 v1, s5, s0, v0                                  // 00000000189C: D6550001 04000005
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000018A4: BF870094
	v_add_co_u32 v5, s1, s6, v5                                // 0000000018A8: D7000105 00020A06
	v_add_co_ci_u32_e64 v6, s1, s7, v6, s1                     // 0000000018B0: D5200106 00060C07
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 0000000018B8: BF870143
	v_lshlrev_b64 v[0:1], 2, v[1:2]                            // 0000000018BC: D73C0000 00020282
	s_waitcnt vmcnt(1)                                         // 0000000018C4: BF8907F7
	v_lshrrev_b32_e32 v9, 16, v7                               // 0000000018C8: 32120E90
	v_cmp_ne_u16_e32 vcc_lo, 0, v7.l                           // 0000000018CC: 7C7A0E80
	v_cmp_ne_u16_e64 s0, 0, v9.l                               // 0000000018D0: D43D0000 00021280
	s_cmp_lg_u32 vcc_lo, 0                                     // 0000000018D8: BF07806A
	s_waitcnt vmcnt(0)                                         // 0000000018DC: BF8903F7
	v_cmp_ne_u16_e32 vcc_lo, 0, v8.l                           // 0000000018E0: 7C7A1080
	s_addc_u32 s1, s12, 0                                      // 0000000018E4: 8201800C
	s_cmp_lg_u32 s0, 0                                         // 0000000018E8: BF078000
	s_addc_u32 s0, s13, 0                                      // 0000000018EC: 8200800D
	s_cmp_lg_u32 vcc_lo, 0                                     // 0000000018F0: BF07806A
	v_dual_mov_b32 v2, s1 :: v_dual_mov_b32 v7, s0             // 0000000018F4: CA100001 02060000
	s_addc_u32 s0, s14, 0                                      // 0000000018FC: 8200800E
	v_add_co_u32 v0, vcc_lo, s6, v0                            // 000000001900: D7006A00 00020006
	v_add_co_ci_u32_e32 v1, vcc_lo, s7, v1, vcc_lo             // 000000001908: 40020207
	v_mov_b32_e32 v8, s0                                       // 00000000190C: 7E100200
	s_clause 0x2                                               // 000000001910: BF850002
	global_store_b32 v[3:4], v2, off                           // 000000001914: DC6A0000 007C0203
	global_store_b32 v[5:6], v7, off                           // 00000000191C: DC6A0000 007C0705
	global_store_b32 v[0:1], v8, off                           // 000000001924: DC6A0000 007C0800
	s_nop 0                                                    // 00000000192C: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 000000001930: BFB60003
	s_endpgm                                                   // 000000001934: BFB00000
copy_get_num_groups_symend:
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
	.long 0xbf9f0000                                           // 000000001AC0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AC4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AC8: BF9F0000
	.long 0xbf9f0000                                           // 000000001ACC: BF9F0000
	.long 0xbf9f0000                                           // 000000001AD0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AD4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AD8: BF9F0000
	.long 0xbf9f0000                                           // 000000001ADC: BF9F0000
	.long 0xbf9f0000                                           // 000000001AE0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AE4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AE8: BF9F0000
	.long 0xbf9f0000                                           // 000000001AEC: BF9F0000
	.long 0xbf9f0000                                           // 000000001AF0: BF9F0000
	.long 0xbf9f0000                                           // 000000001AF4: BF9F0000
	.long 0xbf9f0000                                           // 000000001AF8: BF9F0000
	.long 0xbf9f0000                                           // 000000001AFC: BF9F0000

	.section	.dynamic,#alloc,#write
_DYNAMIC:
	.long 0x6                                                  // 000000002B00: 00000006
	.long 0                                                    // 000000002B04: 00000000
	.long 0x6f8                                                // 000000002B08: 000006F8
	.long 0                                                    // 000000002B0C: 00000000
	.long 0xb                                                  // 000000002B10: 0000000B
	.long 0                                                    // 000000002B14: 00000000
	.long 0x18                                                 // 000000002B18: 00000018
	.long 0                                                    // 000000002B1C: 00000000
	.long 0x5                                                  // 000000002B20: 00000005
	.long 0                                                    // 000000002B24: 00000000
	.long 0x784                                                // 000000002B28: 00000784
	.long 0                                                    // 000000002B2C: 00000000
	.ascii "\n"                                                // 000000002B30: 0A
	.byte 0                                                    // 000000002B31: 00
	.short 0                                                   // 000000002B32: 0000
	.long 0                                                    // 000000002B34: 00000000
	.ascii ","                                                 // 000000002B38: 2C
	.byte 0                                                    // 000000002B39: 00
	.short 0                                                   // 000000002B3A: 0000
	.long 0                                                    // 000000002B3C: 00000000
	.long 0x6ffffef5                                           // 000000002B40: 6FFFFEF5
	.long 0                                                    // 000000002B44: 00000000
	.ascii "@"                                                 // 000000002B48: 40
	.byte 0x7                                                  // 000000002B49: 07
	.short 0                                                   // 000000002B4A: 0000
	.long 0                                                    // 000000002B4C: 00000000
	.long 0x4                                                  // 000000002B50: 00000004
	.long 0                                                    // 000000002B54: 00000000
	.ascii "d"                                                 // 000000002B58: 64
	.byte 0x7                                                  // 000000002B59: 07
	.short 0                                                   // 000000002B5A: 0000
	.long 0                                                    // 000000002B5C: 00000000
	.long 0                                                    // 000000002B60: 00000000
	.long 0                                                    // 000000002B64: 00000000
	.long 0                                                    // 000000002B68: 00000000
	.long 0                                                    // 000000002B6C: 00000000

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
        .type_name:      'uint*'
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
    .max_flat_workgroup_size: 0x10
    .name:           copy_get_num_groups
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x2
      - 0x2
      - 0x4
    .sgpr_count:     0x24
    .sgpr_spill_count: 0
    .symbol:         copy_get_num_groups.kd
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
