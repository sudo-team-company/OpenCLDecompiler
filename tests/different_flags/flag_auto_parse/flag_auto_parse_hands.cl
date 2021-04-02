__kernel void sum(__global short *A, __global ulong *C, uint size, __local ulong *L)
Not resolved yet. v_cmp_gt_u32    vcc, s1, v0
m0 = 0x10000 // s_mov_b32
s0 = *(uint*)(smem + (0x4 & ~3)) // s_load_dword
s1 = *(uint*)(smem + (0x40 & ~3)) // s_load_dword
s_waitcnt       lgkmcnt(0)
s0 = s0 & 0xffff // s_and_b32
scc = s0 != 0
v_cmp_gt_u32    vcc, s1, v0
s[2:3] = exec // s_and_saveexec_b64
exec = vcc & exec
scc = exec != 0
pc = exec==0 ?.L168_0 : pc+4 // s_cbranch_execz
s[4:5] = *(ulong*)(smem + (0x30 & ~3)) // s_load_dwordx2
s[8:9] = exec // s_mov_b64
v1 = 0 // v_mov_b32
v2 = 0 // v_mov_b32
v3 = v0 // v_mov_b32
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
.L96_0:v4 = (int)v3 >> (31&31) // v_ashrrev_i32
v[4:5] = v[3:4] << (1&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v6 = s5 // v_mov_b32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)v6 + (ulong)v5 + cc0
vcc = 0
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
flat_load_sshort v4, v[4:5]
uint temp2 = (ulong)s0 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s_waitcnt       vmcnt(0) & lgkmcnt(0)
v5 = (int)v4 >> (31&31) // v_ashrrev_i32
uint temp3 = (ulong)v4 + (ulong)v1 // v_add_u32
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)v5 + (ulong)v2 + cc1
vcc = 0
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v_cmp_gt_u32    vcc, s1, v3
exec = exec & vcc // s_and_b64
scc = exec != 0
s_cbranch_execnz .L96_0
exec = s[8:9] // s_mov_b64
.L168_0:exec = s[2:3] & ~exec // s_andn2_b64
scc = exec != 0
v1 = 0 // v_mov_b32
v2 = 0 // v_mov_b32
exec = s[2:3] // s_mov_b64
s1 = *(uint*)(smem + (0x48 & ~3)) // s_load_dword
v3 = v0 << (3&31) // v_lshlrev_b32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
uint temp5 = (ulong)s1 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong* V0 // ds_write_b64
V0 = (ulong*)(ds + ((v3 + 0) & ~7))
*V0 = v[1:2]
scc = s0==0 // s_cmp_eq_i32
pc = scc==1 ?.L348_0 : pc+4 // s_cbranch_scc1
v1 = 0 // v_mov_b32
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
.L256_0:s_waitcnt       lgkmcnt(0)
s_barrier
v4 = s0 // v_mov_b32
v5 = 0 // v_mov_b32
vcc = (ulong)v[4:5] > (uint)v[0:1] // v_cmp_gt_u64
s[2:3] = exec // s_and_saveexec_b64
exec = vcc & exec
scc = exec != 0
uint temp6 = (ulong)s0 + (ulong)v0 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
pc = exec==0 ?.L332_0 : pc+4 // s_cbranch_execz
v4 = v4 << (3&31) // v_lshlrev_b32
uint temp7 = (ulong)s1 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v[4:5] = *(ulong*)(DS + ((v4 + 0)&~7)) // ds_read_b64
v[6:7] = *(ulong*)(DS + ((v3 + 0)&~7)) // ds_read_b64
s_waitcnt       lgkmcnt(0)
uint temp8 = (ulong)v6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)v7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong* V1 // ds_write_b64
V1 = (ulong*)(ds + ((v3 + 0) & ~7))
*V1 = v[4:5]
.L332_0:exec = s[2:3] // s_mov_b64
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
scc = s0==0 // s_cmp_eq_i32
pc = scc==0 ?.L256_0 : pc+4 // s_cbranch_scc0
.L348_0:vcc(LANEID) = (int)0 == (int)v0 // v_cmp_eq_i32
s[2:3] = exec // s_and_saveexec_b64
exec = vcc & exec
scc = exec != 0
v0 = s1 // v_mov_b32
pc = exec==0 ?.L400_0 : pc+4 // s_cbranch_execz
s[0:1] = *(ulong*)(smem + (0x38 & ~3)) // s_load_dwordx2
v[0:1] = *(ulong*)(DS + ((v0 + 0)&~7)) // ds_read_b64
s_waitcnt       lgkmcnt(0)
v2 = s0 // v_mov_b32
v3 = s1 // v_mov_b32
*(ulong*)(v[2:3] + 0 = v[0:1] // flat_store_dwordx2
.L400_0:s_waitcnt       lgkmcnt(0)
s_barrier
