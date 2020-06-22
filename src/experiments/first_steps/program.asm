s_lshl_b32      s0, s6, 6
v_mov_b32       v2, 0xface
s_load_dwordx2  s[2:3], s[4:5], 0x0
s_load_dwordx2  s[4:5], s[4:5], 0x30
s_waitcnt       lgkmcnt(0)
s_add_u32       s0, s0, s2
v_add_u32       v0, vcc, s0, v0
v_mov_b32       v1, 0
v_lshlrev_b64   v[0:1], 2, v[0:1]
v_add_u32       v0, vcc, s4, v0
v_mov_b32       v3, s5
v_addc_u32      v1, vcc, v3, v1, vcc
flat_store_dword v[0:1], v2
s_endpgm