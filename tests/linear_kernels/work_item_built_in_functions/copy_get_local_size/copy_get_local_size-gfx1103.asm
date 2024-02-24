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
	.ascii "D"                                                 // 000000000720: 44
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
	.long 0x102                                                // 000000000750: 00000102
	.ascii "	"                                                 // 000000000754: 09
	.byte 0                                                    // 000000000755: 00
	.short 0                                                   // 000000000756: 0000
	.long 0x1                                                  // 000000000758: 00000001
	.ascii "\""                                                // 00000000075C: 22
	.byte 0xe5                                                 // 00000000075D: E5
	.ascii ","                                                 // 00000000075E: 2C
	.byte 0x4                                                  // 00000000075F: 04
	.ascii "!"                                                 // 000000000760: 21
	.byte 0xc8                                                 // 000000000761: C8
	.ascii "R\""                                               // 000000000762: 2252

	.section	.hash,#alloc
	.long 0x3                                                  // 000000000764: 00000003
	.long 0x3                                                  // 000000000768: 00000003
	.long 0x2                                                  // 00000000076C: 00000002
	.long 0                                                    // 000000000770: 00000000
	.long 0                                                    // 000000000774: 00000000
	.long 0                                                    // 000000000778: 00000000
	.long 0                                                    // 00000000077C: 00000000
	.long 0x1                                                  // 000000000780: 00000001

	.section	.rodata,#alloc
	.type	copy_get_local_size.kd,@object
copy_get_local_size.kd:
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
	.type	copy_get_local_size,@function
	.size	copy_get_local_size, copy_get_local_size_symend-copy_get_local_size
copy_get_local_size:
	s_load_b128 s[8:11], s[0:1], 0x10                          // 000000001800: F4080200 F8000010
	s_add_u32 s5, s0, 16                                       // 000000001808: 80059000
	s_waitcnt lgkmcnt(0)                                       // 00000000180C: BF89FC07
	s_addc_u32 s11, s1, 0                                      // 000000001810: 820B8001
	s_lshl_b32 s12, s2, 1                                      // 000000001814: 840C8102
	s_lshl_b32 s13, s3, 1                                      // 000000001818: 840D8103
	s_lshl_b32 s14, s4, 2                                      // 00000000181C: 840E8204
	v_dual_mov_b32 v2, 0 :: v_dual_and_b32 v1, 0x3ff, v0       // 000000001820: CA240080 020000FF 000003FF
	v_bfe_u32 v5, v0, 10, 10                                   // 00000000182C: D6100005 02291500
	v_bfe_u32 v0, v0, 20, 10                                   // 000000001834: D6100000 02292900
	s_mov_b32 s33, 0                                           // 00000000183C: BEA10080
	s_cmp_lt_u32 s2, s8                                        // 000000001840: BF0A0802
	s_cselect_b32 s2, 12, 18                                   // 000000001844: 9802928C
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)// 000000001848: BF8704C9
	s_add_u32 s6, s5, s2                                       // 00000000184C: 80060205
	s_addc_u32 s7, s11, 0                                      // 000000001850: 8207800B
	s_cmp_lt_u32 s3, s9                                        // 000000001854: BF0A0903
	s_cselect_b32 s2, 14, 20                                   // 000000001858: 9802948E
	s_add_u32 s2, s5, s2                                       // 00000000185C: 80020205
	s_addc_u32 s3, s11, 0                                      // 000000001860: 8203800B
	s_cmp_lt_u32 s4, s10                                       // 000000001864: BF0A0A04
	s_cselect_b32 s4, 16, 22                                   // 000000001868: 98049690
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000186C: BF870009
	s_add_u32 s4, s5, s4                                       // 000000001870: 80040405
	s_addc_u32 s5, s11, 0                                      // 000000001874: 8205800B
	s_clause 0x2                                               // 000000001878: BF850002
	global_load_u16 v7, v2, s[6:7]                             // 00000000187C: DC4A0000 07060002
	global_load_u16 v8, v2, s[2:3]                             // 000000001884: DC4A0000 08020002
	global_load_u16 v9, v2, s[4:5]                             // 00000000188C: DC4A0000 09040002
	s_clause 0x2                                               // 000000001894: BF850002
	s_load_b128 s[4:7], s[0:1], 0x38                           // 000000001898: F4080100 F8000038
	s_load_b32 s2, s[0:1], 0x48                                // 0000000018A0: F4000080 F8000048
	s_load_b64 s[0:1], s[0:1], 0x8                             // 0000000018A8: F4040000 F8000008
	s_waitcnt lgkmcnt(0)                                       // 0000000018B0: BF89FC07
	v_add3_u32 v1, s4, s12, v1                                 // 0000000018B4: D6550001 04041804
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000018BC: BF8700A1
	v_lshlrev_b64 v[3:4], 2, v[1:2]                            // 0000000018C0: D73C0003 00020282
	v_add3_u32 v1, s6, s13, v5                                 // 0000000018C8: D6550001 04141A06
	v_lshlrev_b64 v[5:6], 2, v[1:2]                            // 0000000018D0: D73C0005 00020282
	v_add3_u32 v1, s2, s14, v0                                 // 0000000018D8: D6550001 04001C02
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 0000000018E0: BF8701A4
	v_add_co_u32 v3, vcc_lo, s0, v3                            // 0000000018E4: D7006A03 00020600
	v_add_co_ci_u32_e32 v4, vcc_lo, s1, v4, vcc_lo             // 0000000018EC: 40080801
	v_lshlrev_b64 v[0:1], 2, v[1:2]                            // 0000000018F0: D73C0000 00020282
	v_add_co_u32 v5, vcc_lo, s0, v5                            // 0000000018F8: D7006A05 00020A00
	v_add_co_ci_u32_e32 v6, vcc_lo, s1, v6, vcc_lo             // 000000001900: 400C0C01
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000001904: BF870213
	v_add_co_u32 v0, vcc_lo, s0, v0                            // 000000001908: D7006A00 00020000
	v_add_co_ci_u32_e32 v1, vcc_lo, s1, v1, vcc_lo             // 000000001910: 40020201
	s_waitcnt vmcnt(2)                                         // 000000001914: BF890BF7
	global_store_b32 v[3:4], v7, off                           // 000000001918: DC6A0000 007C0703
	s_waitcnt vmcnt(1)                                         // 000000001920: BF8907F7
	global_store_b32 v[5:6], v8, off                           // 000000001924: DC6A0000 007C0805
	s_waitcnt vmcnt(0)                                         // 00000000192C: BF8903F7
	global_store_b32 v[0:1], v9, off                           // 000000001930: DC6A0000 007C0900
	s_nop 0                                                    // 000000001938: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 00000000193C: BFB60003
	s_endpgm                                                   // 000000001940: BFB00000
copy_get_local_size_symend:
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
    .name:           copy_get_local_size
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 0x2
      - 0x2
      - 0x4
    .sgpr_count:     0x24
    .sgpr_spill_count: 0
    .symbol:         copy_get_local_size.kd
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
