Not resolved yet. global_load_ushort v2, v[1:2], off inst_offset:2
v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v2, v[1:2], off inst_offset:2
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s_waitcnt       vmcnt(0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
