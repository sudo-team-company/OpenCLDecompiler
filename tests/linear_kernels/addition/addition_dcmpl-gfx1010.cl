__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_x_x(__global int *data, int x)
{
    data[get_global_id(0)] = x * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_x(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)get_global_offset(1) + (ulong)x;
    data[get_global_id(2)] = (ulong)get_global_offset(2) + (ulong)x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)x + (ulong)get_local_id(0);
    data[get_global_id(1)] = (ulong)x + (ulong)get_local_id(1);
    data[get_global_id(2)] = (ulong)x + (ulong)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)get_group_id(1) + (ulong)x;
    data[get_global_id(2)] = (ulong)get_group_id(2) + (ulong)x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)x + (ulong)2;
    data[get_global_id(1)] = (ulong)x + (ulong)2;
    data[get_global_id(2)] = (ulong)x + (ulong)4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_x(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)x + (ulong)get_global_id(1);
    data[get_global_id(2)] = (ulong)x + (ulong)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_x(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)get_global_size(1) + (ulong)x;
    data[get_global_id(2)] = (ulong)get_global_size(2) + (ulong)x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)get_num_groups(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)get_num_groups(1) + (ulong)x;
    data[get_global_id(2)] = (ulong)get_num_groups(2) + (ulong)x;
}

Not resolved yet. global_load_ushort v2, v[1:2], off inst_offset:2
v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (1 & 31) // s_lshl_b32
scc = s4!= 0
global_load_ushort v2, v[1:2], off inst_offset:2
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
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
v2 = s3 + v2 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s3 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s1 + (ulong)s3 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = s0 << (1 & 31) // s_lshl_b32
scc = s0!= 0
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v11 = s0 // v_mov_b32
s0 = s1 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v13 = s2 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v6 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s0 + v0 // v_add_nc_u32
v10 = s2 + v1 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v11 = s1 + v2 // v_add_nc_u32
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s6 + (ulong)s0 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s7 + (ulong)s2 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v11 = s0 // v_mov_b32
ulong temp5 = (ulong)s8 + (ulong)s1 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
v6 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)2 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)2 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v11 = s0 // v_mov_b32
ulong temp5 = (ulong)s1 + (ulong)4 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
v6 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
v9 = (s0 << 1) + v3 // v_lshl_add_u32
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v10 = s2 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v11 = s1 + v7 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp2 = (ulong)s4 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v2 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s0 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)s2 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s14 + (ulong)s1 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s6 = s12 & -2 // s_and_b32
scc = s6 != 0
s8 = s13 & -2 // s_and_b32
scc = s8 != 0
v[1:2] = v[3:4] << (2&63) // v_lshlrev_b64
s[6:7] = (uint)s12 > (uint)s6 // v_cmp_gt_u32
s[8:9] = (uint)s13 > (uint)s8 // v_cmp_gt_u32
s3 = s12 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
s7 = s13 >> (1 & 31) // s_lshr_b32
scc = s7!= 0
s9 = s14 >> (2 & 31) // s_lshr_b32
scc = s9!= 0
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v1 = v4 // v_mov_b32
s10 = s14 & -4 // s_and_b32
scc = s10 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc0
vcc = 0
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
s[6:7] = (uint)s14 > (uint)s10 // v_cmp_gt_u32
ulong temp5 = (ulong)s3 + (ulong)s0 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v10 = s0 // v_mov_b32
ulong temp7 = (ulong)s7 + (ulong)s2 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v5 = s0 // v_mov_b32
ulong temp10 = (ulong)s9 + (ulong)s1 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v6 = s0 // v_mov_b32
*(uint*)(v[7:8] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s0 + v9 // v_add_nc_u32
v13 = s2 + v9 // v_add_nc_u32
v11 = s1 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s3 + v0 // v_add_nc_u32
v10 = s3 + v1 // v_add_nc_u32
v11 = s3 + v2 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s0 + v0 // v_add_nc_u32
v10 = s2 + v1 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v11 = s1 + v2 // v_add_nc_u32
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v9 = v0 << (1&31) // v_lshlrev_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = v1 << (1&31) // v_lshlrev_b32
v11 = v2 << (1&31) // v_lshlrev_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v9 = s6 + v0 // v_add_nc_u32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = s7 + v1 // v_add_nc_u32
v11 = s8 + v2 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v9 = 2 | v0 // v_or_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = 2 | v1 // v_or_b32
v11 = 4 | v2 // v_or_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v9 = (s8 << 2) | v2 // v_lshl_or_b32
v12 = v4 // v_mov_b32
v10 = v4 // v_mov_b32
v[7:8] = v[3:4] << (2&63) // v_lshlrev_b64
v11 = s2 + v5 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v9 = s1 + v9 // v_add_nc_u32
uint temp0 = (ulong)v3 + (ulong)v0 + (ulong)s0 // v_add3_u32
v13 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s4 + (ulong)v7 // v_add_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v[3:4] = v[11:12] << (2&63) // v_lshlrev_b64
v5 = v1 + v11 // v_add_nc_u32
v[0:1] = v[9:10] << (2&63) // v_lshlrev_b64
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v8 + cc0
vcc = 0
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v15 = v2 + v9 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc1
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint*)(v[6:7] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v15 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s12 + v0 // v_add_nc_u32
v10 = s13 + v1 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
v7 = s14 + v2 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[8:9] = v[3:4] << (2&63) // v_lshlrev_b64
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s0 + (ulong)v0 + cc0
vcc = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
uint temp4 = (ulong)s4 + (ulong)v8 // v_add_u32
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v8 = v4 // v_mov_b32
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v9 + cc1
vcc = 0
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[3:4] = v[5:6] << (2&63) // v_lshlrev_b64
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s2 + (ulong)v1 + cc2
vcc = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v[0:1] = v[7:8] << (2&63) // v_lshlrev_b64
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v4 + cc3
vcc = 0
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
vcc = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s6 + (ulong)v2 + cc4
vcc = 0
v2 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc5
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint*)(v[10:11] + 0 + 0) = v12 // global_store_dword
*(uint*)(v[3:4] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v15, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v8 + cc2
vcc = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = v0 + v15 // v_add_nc_u32
v11 = v1 + v15 // v_add_nc_u32
v2 = v2 + v15 // v_add_nc_u32
*(uint*)(v[3:4] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s9 = s6 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s7 << (1 & 31) // s_lshl_b32
scc = s10!= 0
s11 = s8 << (1 & 31) // s_lshl_b32
scc = s11!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s11 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s9 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s10 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s6 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s7 + (ulong)s3 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s8 + (ulong)s3 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s6 + (ulong)s0 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s7 + (ulong)s2 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v11 = s0 // v_mov_b32
ulong temp5 = (ulong)s8 + (ulong)s1 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
v6 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v9 = s6 + v0 // v_add_nc_u32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = s7 + v1 // v_add_nc_u32
v11 = s8 + v2 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v15 = s3 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v13 = s7 // v_mov_b32
v11 = s8 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v15 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (2 & 31) // s_lshl_b32
scc = s10!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_i32
s6 = temp0
scc = temp0 >> 32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
ulong temp1 = (ulong)s7 + (ulong)2 // s_add_i32
s7 = temp1
scc = temp1 >> 32
v11 = s6 // v_mov_b32
v13 = s7 // v_mov_b32
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask0 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp4 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask2 = (1ULL<<LANEID)
ulong temp5 = (ulong)s8 + (ulong)4 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v6 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v3 // v_add3_u32
v9 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v10 = s7 + v0 // v_add_nc_u32
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v11 = s8 + v7 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc1
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s8 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)s9 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s14 + (ulong)s10 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v[1:2] = v[3:4] << (2&63) // v_lshlrev_b64
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v1 = v4 // v_mov_b32
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc0
vcc = 0
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp5 = (ulong)s0 + (ulong)s8 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v10 = s0 // v_mov_b32
ulong temp7 = (ulong)s2 + (ulong)s9 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v5 = s0 // v_mov_b32
ulong temp10 = (ulong)s6 + (ulong)s10 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v6 = s0 // v_mov_b32
*(uint*)(v[7:8] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s8 + v9 // v_add_nc_u32
v13 = s9 + v9 // v_add_nc_u32
v11 = s10 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s3 + (ulong)16 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s3 + (ulong)2 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v6 = s1 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp5 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)2 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)16 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v11 = s0 // v_mov_b32
ulong temp5 = (ulong)s1 + (ulong)2 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
v6 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v9 = 8 | v0 // v_or_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = 4 | v1 // v_or_b32
v11 = 2 | v2 // v_or_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_i32
s6 = temp0
scc = temp0 >> 32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
ulong temp1 = (ulong)s7 + (ulong)16 // s_add_i32
s7 = temp1
scc = temp1 >> 32
v11 = s6 // v_mov_b32
v13 = s7 // v_mov_b32
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask0 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp4 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask2 = (1ULL<<LANEID)
ulong temp5 = (ulong)s8 + (ulong)2 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v6 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v9 = 4 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = 8 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[7:8] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v10 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
uint temp0 = (ulong)v3 + (ulong)s0 + (ulong)2 // v_add3_u32
v9 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v10 = 2 + v0 // v_add_nc_u32
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v11 = 4 + v7 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc1
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)16 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)2 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s14 + (ulong)2 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v[1:2] = v[3:4] << (2&63) // v_lshlrev_b64
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v1 = v4 // v_mov_b32
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc0
vcc = 0
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp5 = (ulong)s0 + (ulong)2 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v10 = s0 // v_mov_b32
ulong temp7 = (ulong)s2 + (ulong)2 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v5 = s0 // v_mov_b32
ulong temp10 = (ulong)s6 + (ulong)4 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v6 = s0 // v_mov_b32
*(uint*)(v[7:8] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = 2 + v9 // v_add_nc_u32
v7 = 4 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[11:12] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v0 = (s6 << 4) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v4 = (s7 << 1) | v1 // v_lshl_or_b32
v6 = (s8 << 1) | v2 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v9 = s3 + v2 // v_add_nc_u32
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
v7 = s3 + v0 // v_add_nc_u32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
v11 = s3 + v4 // v_add_nc_u32
v[4:5] = v[4:5] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v4 = (s7 << 4) | v1 // v_lshl_or_b32
v6 = (s8 << 1) | v2 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v9 = s0 + v2 // v_add_nc_u32
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
v7 = s2 + v0 // v_add_nc_u32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
v11 = s1 + v4 // v_add_nc_u32
v[4:5] = v[4:5] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 3) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
v5 = (s7 << 2) | v1 // v_lshl_or_b32
v7 = (s8 << 1) | v2 // v_lshl_or_b32
v12 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v3 = s0 + v3 // v_add_nc_u32
v11 = s2 + v5 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v7 = s1 + v7 // v_add_nc_u32
v9 = v0 + v3 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v10 = v1 + v11 // v_add_nc_u32
v[0:1] = v[11:12] << (2&63) // v_lshlrev_b64
v11 = v2 + v7 // v_add_nc_u32
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v4 = (s7 << 4) | v1 // v_lshl_or_b32
v6 = (s8 << 1) | v2 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v9 = s6 + v2 // v_add_nc_u32
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
v7 = s7 + v0 // v_add_nc_u32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
v11 = s8 + v4 // v_add_nc_u32
v[4:5] = v[4:5] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v4 = (s7 << 1) | v1 // v_lshl_or_b32
v6 = (s8 << 2) | v2 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v9 = 2 + v2 // v_add_nc_u32
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
v7 = 2 + v0 // v_add_nc_u32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
v11 = 4 + v4 // v_add_nc_u32
v[4:5] = v[4:5] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
v9 = (v3 + s0) << 1 // v_add_lshl_u32
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v10 = v0 << (1&31) // v_lshlrev_b32
uint temp0 = (ulong)s4 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v11 = v7 << (1&31) // v_lshlrev_b32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp2 = (ulong)s4 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v2 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v0 = (s8 << 4) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v4 = (s9 << 1) | v1 // v_lshl_or_b32
v6 = (s10 << 1) | v2 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v[6:7] = v[2:3] << (2&63) // v_lshlrev_b64
v11 = s13 + v0 // v_add_nc_u32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
v8 = s12 + v2 // v_add_nc_u32
v[2:3] = v[4:5] << (2&63) // v_lshlrev_b64
v4 = s14 + v4 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v6 // v_add_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v7 + cc0
vcc = 0
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v3 + cc2
vcc = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint*)(v[5:6] + 0 + 0) = v8 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v4 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v5 = (s10 << 2) | v2 // v_lshl_or_b32
v4 = (s9 << 1) | v1 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v1 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v5 // v_add_nc_u32
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
v[5:6] = v[2:3] << (2&63) // v_lshlrev_b64
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
ulong mask0 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask0 ? 1 : 0)
uint temp0 = (ulong)s0 + (ulong)v2 + cc0
vcc = 0
v9 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v5 = v3 // v_mov_b32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v8 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
v[5:6] = v[4:5] << (2&63) // v_lshlrev_b64
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s2 + (ulong)v0 + cc2
vcc = 0
v10 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v2 + cc3
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
vcc = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s6 + (ulong)v4 + cc4
vcc = 0
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v6 + cc5
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[7:8] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v4 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v6 = (s10 << 2) | v2 // v_lshl_or_b32
global_load_ushort v15, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
v4 = (s9 << 1) | v1 // v_lshl_or_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
v2 = s0 + v0 // v_add_nc_u32
v0 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v6 // v_add_nc_u32
v[6:7] = v[2:3] << (2&63) // v_lshlrev_b64
v[8:9] = v[0:1] << (2&63) // v_lshlrev_b64
v[10:11] = v[4:5] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v6 // v_add_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v7 + cc0
vcc = 0
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v8 // v_add_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v9 + cc1
vcc = 0
v8 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v10 // v_add_u32
v9 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v11 + cc2
vcc = 0
v10 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
s_waitcnt       vmcnt(0)
v11 = v15 + v2 // v_add_nc_u32
v2 = v15 + v0 // v_add_nc_u32
v3 = v15 + v4 // v_add_nc_u32
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v2 // global_store_dword
*(uint*)(v[9:10] + 0 + 0) = v3 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v4 = 0 // v_mov_b32
s8 = s8 << (4 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s11 + (ulong)s1 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s12 + (ulong)s1 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s4 + (ulong)s1 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v4 = 0 // v_mov_b32
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s3 + (ulong)s0 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s11 + (ulong)s2 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s4 + (ulong)s1 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s2 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s8 = s8 << (3 & 31) // s_lshl_b32
scc = s8!= 0
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s9 = s9 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s5 = s10 << (1 & 31) // s_lshl_b32
scc = s5!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s5 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v9 = s3 + v0 // v_add_nc_u32
uint temp1 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v10 = s11 + v1 // v_add_nc_u32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[0:1] = v[5:6] << (2&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
v7 = s4 + v2 // v_add_nc_u32
uint temp3 = (ulong)s6 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v4 = 0 // v_mov_b32
s12 = s8 << (1 & 31) // s_lshl_b32
scc = s12!= 0
s13 = s9 << (4 & 31) // s_lshl_b32
scc = s13!= 0
s14 = s10 << (1 & 31) // s_lshl_b32
scc = s14!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s14 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s12 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s13 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s3 + (ulong)s8 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s11 + (ulong)s9 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s4 + (ulong)s10 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)2 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)2 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
ulong temp5 = (ulong)s14 + (ulong)4 // s_add_i32
s0 = temp5
scc = temp5 >> 32
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
v4 = 0 // v_mov_b32
v5 = (s9 << 1) | v1 // v_lshl_or_b32
v3 = (s8 << 1) | v0 // v_lshl_or_b32
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s3 + (ulong)s0 + (ulong)v3 // v_add3_u32
v9 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v10 = s11 + v0 // v_add_nc_u32
uint temp1 = (ulong)s6 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s7 + (ulong)v6 + cc0
vcc = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v[5:6] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s6 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v7 = s4 + v7 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)v2 + cc1
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint*)(v[3:4] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = s12 << (1 & 31) // s_lshl_b32
scc = s0!= 0
s1 = s13 << (1 & 31) // s_lshl_b32
scc = s1!= 0
v11 = s0 // v_mov_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
s0 = s14 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v13 = s1 // v_mov_b32
v7 = s0 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v[1:2] = v[3:4] << (2&63) // v_lshlrev_b64
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
uint temp3 = (ulong)s4 + (ulong)v1 // v_add_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v1 = v4 // v_mov_b32
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v2 + cc0
vcc = 0
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp5 = (ulong)s0 + (ulong)s12 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v10 = s0 // v_mov_b32
ulong temp7 = (ulong)s2 + (ulong)s13 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v5 = s0 // v_mov_b32
ulong temp10 = (ulong)s6 + (ulong)s14 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v6 = s0 // v_mov_b32
*(uint*)(v[7:8] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s10 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s10 + v9 // v_add_nc_u32
v13 = s11 + v9 // v_add_nc_u32
v11 = s4 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s8 = s8 << (4 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
s5 = s11 & -16 // s_and_b32
scc = s5 != 0
uint temp0 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[5:6] = (uint)s11 > (uint)s5 // v_cmp_gt_u32
s0 = s11 >> (4 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v1 = v4 // v_mov_b32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s12 + (ulong)s10 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s1 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s2 = s3 & -2 // s_and_b32
scc = s2 != 0
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
s[2:3] = (uint)s3 > (uint)s2 // v_cmp_gt_u32
s3 = s3 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
v9 = s0 // v_mov_b32
uint temp4 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s2 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
ulong temp6 = (ulong)s3 + (ulong)s1 + scc // s_addc_u32
s2 = temp6
scc = temp6 >> 32
s3 = s4 & -2 // s_and_b32
scc = s3 != 0
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
s[0:1] = (uint)s4 > (uint)s3 // v_cmp_gt_u32
s3 = s4 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v6 + cc1
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v6 = s2 // v_mov_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s7 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s3 + (ulong)s1 + scc // s_addc_u32
s0 = temp11
scc = temp11 >> 32
v11 = s0 // v_mov_b32
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
s5 = s11 & -2 // s_and_b32
scc = s5 != 0
uint temp0 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[5:6] = (uint)s11 > (uint)s5 // v_cmp_gt_u32
s8 = s11 >> (1 & 31) // s_lshr_b32
scc = s8!= 0
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v1 = v4 // v_mov_b32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s10 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s8 + (ulong)s0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s5 = s1 & -16 // s_and_b32
scc = s5 != 0
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
s[5:6] = (uint)s1 > (uint)s5 // v_cmp_gt_u32
s1 = s1 >> (4 & 31) // s_lshr_b32
scc = s1!= 0
v9 = s0 // v_mov_b32
uint temp4 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
ulong temp6 = (ulong)s1 + (ulong)s2 + scc // s_addc_u32
s1 = temp6
scc = temp6 >> 32
s2 = s4 & -2 // s_and_b32
scc = s2 != 0
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
s[0:1] = (uint)s4 > (uint)s2 // v_cmp_gt_u32
s2 = s4 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v6 + cc1
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v6 = s1 // v_mov_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s7 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s2 + (ulong)s3 + scc // s_addc_u32
s0 = temp11
scc = temp11 >> 32
v11 = s0 // v_mov_b32
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s8 = s8 << (3 & 31) // s_lshl_b32
scc = s8!= 0
v4 = 0 // v_mov_b32
s10 = s10 << (1 & 31) // s_lshl_b32
scc = s10!= 0
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s9 = s9 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v6 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s3 & -8 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
vcc = (uint)s3 > (uint)s1 // v_cmp_gt_u32
s0 = s3 >> (3 & 31) // s_lshr_b32
scc = s0!= 0
uint temp2 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s5 = s11 & -4 // s_and_b32
scc = s5 != 0
v[8:9] = v[3:4] << (2&63) // v_lshlrev_b64
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s0 + (ulong)v0 + cc0
vcc = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s2 = s11 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
s0 = s4 & -2 // s_and_b32
scc = s0 != 0
s1 = s4 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
uint temp4 = (ulong)s6 + (ulong)v8 // v_add_u32
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v8 = v4 // v_mov_b32
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v9 + cc1
vcc = 0
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
vcc = (uint)s11 > (uint)s5 // v_cmp_gt_u32
v[3:4] = v[7:8] << (2&63) // v_lshlrev_b64
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s2 + (ulong)v1 + cc2
vcc = 0
v15 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v6 + cc3
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
vcc = (uint)s4 > (uint)s0 // v_cmp_gt_u32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s1 + (ulong)v2 + cc4
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v4 + cc5
vcc = 0
v3 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint*)(v[10:11] + 0 + 0) = v12 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v15 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v5 // global_store_dword

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s12 = s8 << (1 & 31) // s_lshl_b32
scc = s12!= 0
s13 = s9 << (4 & 31) // s_lshl_b32
scc = s13!= 0
s14 = s10 << (1 & 31) // s_lshl_b32
scc = s14!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
s5 = s11 & -2 // s_and_b32
scc = s5 != 0
uint temp0 = (ulong)s0 + (ulong)s12 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[5:6] = (uint)s11 > (uint)s5 // v_cmp_gt_u32
s0 = s11 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s13 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v1 = v4 // v_mov_b32
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s14 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s8 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s2 = s1 & -16 // s_and_b32
scc = s2 != 0
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
s[2:3] = (uint)s1 > (uint)s2 // v_cmp_gt_u32
s1 = s1 >> (4 & 31) // s_lshr_b32
scc = s1!= 0
v9 = s0 // v_mov_b32
uint temp4 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s2 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
ulong temp6 = (ulong)s1 + (ulong)s9 + scc // s_addc_u32
s1 = temp6
scc = temp6 >> 32
s2 = s4 & -2 // s_and_b32
scc = s2 != 0
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
s[0:1] = (uint)s4 > (uint)s2 // v_cmp_gt_u32
s2 = s4 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v6 + cc1
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v6 = s1 // v_mov_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s7 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s2 + (ulong)s10 + scc // s_addc_u32
s0 = temp11
scc = temp11 >> 32
v11 = s0 // v_mov_b32
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s9 = s0 & -2 // s_and_b32
scc = s9 != 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[9:10] = (uint)s0 > (uint)s9 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s9 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)2 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v6 = s0 // v_mov_b32
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s1 + (ulong)2 + scc // s_addc_u32
s1 = temp5
scc = temp5 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask4) | ((temp6 >> 32) ? mask4 : 0)
s[0:1] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
uint temp7 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
v9 = s1 // v_mov_b32
ulong temp10 = (ulong)s2 + (ulong)4 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
v3 = (s8 << 1) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v0 = (s9 << 1) | v1 // v_lshl_or_b32
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
v1 = v4 // v_mov_b32
s5 = s11 & -2 // s_and_b32
scc = s5 != 0
v0 = s2 + v0 // v_add_nc_u32
s[5:6] = (uint)s11 > (uint)s5 // v_cmp_gt_u32
s_waitcnt       lgkmcnt(0)
v2 = s1 + v2 // v_add_nc_u32
s1 = s11 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
uint temp0 = (ulong)s6 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v[7:8] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s7 + (ulong)v6 + cc0
vcc = 0
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong temp2 = (ulong)s0 + (ulong)s1 + scc // s_addc_u32
s0 = temp2
scc = temp2 >> 32
s2 = s3 & -2 // s_and_b32
scc = s2 != 0
s1 = s3 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
vcc = (uint)s3 > (uint)s2 // v_cmp_gt_u32
v11 = s0 + v3 // v_add_nc_u32
v3 = v4 // v_mov_b32
s0 = s4 & -4 // s_and_b32
scc = s0 != 0
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v0 + cc1
vcc = 0
v10 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
uint temp4 = (ulong)s6 + (ulong)v7 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[3:4] = v[2:3] << (2&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v8 + cc2
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
vcc = (uint)s4 > (uint)s0 // v_cmp_gt_u32
s1 = s4 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask5 ? 1 : 0)
uint temp6 = (ulong)s1 + (ulong)v2 + cc3
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
uint temp7 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask7 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v4 + cc4
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask7) | ((temp8 >> 32) ? mask7 : 0)
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[0:1] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s9 = s0 & -16 // s_and_b32
scc = s9 != 0
uint temp0 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[9:10] = (uint)s0 > (uint)s9 // v_cmp_gt_u32
s6 = s0 >> (4 & 31) // s_lshr_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
scc = (uint)s9 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s6 + (ulong)s0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
s6 = s1 >> (1 & 31) // s_lshr_b32
scc = s6!= 0
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v6 = s0 // v_mov_b32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
ulong temp6 = (ulong)s6 + (ulong)s1 + scc // s_addc_u32
s1 = temp6
scc = temp6 >> 32
s3 = s2 & -2 // s_and_b32
scc = s3 != 0
uint temp7 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
s[0:1] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s3 = s2 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v9 = s1 // v_mov_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s3 + (ulong)s2 + scc // s_addc_u32
s0 = temp11
scc = temp11 >> 32
v11 = s0 // v_mov_b32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s12 & -2 // s_and_b32
scc = s0 != 0
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (uint)s12 > (uint)s0 // v_cmp_gt_u32
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s14 & -4 // s_and_b32
scc = s1 != 0
v0 = s[0:1]&(1ULL<<LANEID) ? 1 : 0 // v_cndmask_b32
s0 = s13 & -2 // s_and_b32
scc = s0 != 0
s[0:1] = (uint)s13 > (uint)s0 // v_cmp_gt_u32
v9 = v0 << (1&31) // v_lshlrev_b32
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v2 = s[0:1]&(1ULL<<LANEID) ? 1 : 0 // v_cndmask_b32
s[0:1] = (uint)s14 > (uint)s1 // v_cmp_gt_u32
v9 = s12 + v9 // v_add_nc_u32
s1 = s14 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v4 = v2 << (1&31) // v_lshlrev_b32
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v6 = -2 & v9 // v_and_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v4 = s13 + v4 // v_add_nc_u32
ulong temp5 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
s0 = s0 << (1 & 31) // s_lshl_b32
scc = s0!= 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
v9 = -2 & v4 // v_and_b32
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
v7 = s0 // v_mov_b32
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp8 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask8) | ((temp9 >> 32) ? mask8 : 0)
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v9 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s3 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = s3 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s6 = s11 & -2 // s_and_b32
scc = s6 != 0
s2 = s11 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
s8 = s12 & -4 // s_and_b32
scc = s8 != 0
s7 = s12 >> (2 & 31) // s_lshr_b32
scc = s7!= 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
vcc = (uint)s3 > (uint)s1 // v_cmp_gt_u32
s_waitcnt       vmcnt(0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s0 + (ulong)v9 + cc3
vcc = 0
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
vcc = (uint)s11 > (uint)s6 // v_cmp_gt_u32
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s2 + (ulong)v9 + cc4
vcc = 0
v13 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
vcc = (uint)s12 > (uint)s8 // v_cmp_gt_u32
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v9 + cc5
vcc = 0
v11 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s6 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (4 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s0 + v9 // v_add_nc_u32
v13 = s2 + v9 // v_add_nc_u32
v11 = s1 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (2 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v15, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (2&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (2&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v8 + cc2
vcc = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = v0 + v15 // v_add_nc_u32
v11 = v1 + v15 // v_add_nc_u32
v2 = v2 + v15 // v_add_nc_u32
*(uint*)(v[3:4] + 0 + 0) = v10 // global_store_dword
*(uint*)(v[5:6] + 0 + 0) = v11 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (4 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s8 + v9 // v_add_nc_u32
v13 = s9 + v9 // v_add_nc_u32
v11 = s10 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = 2 + v9 // v_add_nc_u32
v7 = 4 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[11:12] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v5 = (s9 << 1) | v1 // v_lshl_or_b32
v2 = (s10 << 2) | v2 // v_lshl_or_b32
global_load_ushort v10, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
v3 = (s8 << 1) | v0 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (2&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v2 // v_add_nc_u32
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v[8:9] = v[7:8] << (2&63) // v_lshlrev_b64
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v1 // v_add_u32
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v2 + cc1
vcc = 0
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v8 // v_add_u32
v8 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v9 + cc2
vcc = 0
v9 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
s_waitcnt       vmcnt(0)
uint temp6 = (ulong)v10 + (ulong)s0 + (ulong)v3 // v_add3_u32
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
ulong mask6 = (1ULL<<LANEID)
v0 = v10 + v0 // v_add_nc_u32
v6 = v10 + v7 // v_add_nc_u32
*(uint*)(v[4:5] + 0 + 0) = v3 // global_store_dword
*(uint*)(v[1:2] + 0 + 0) = v0 // global_store_dword
*(uint*)(v[8:9] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[12:13] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[4:7][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s12 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s13 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s12 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s13 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s12 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s13 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = s4 + v9 // v_add_nc_u32
v13 = s5 + v9 // v_add_nc_u32
v11 = s6 + v9 // v_add_nc_u32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s_waitcnt       vmcnt(0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s0 + (ulong)v9 + cc3
vcc = 0
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s2 + (ulong)v9 + cc4
vcc = 0
v13 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
vcc = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s6 + (ulong)v9 + cc5
vcc = 0
v11 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[2:3] + 0 + 0) = v13 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v11 // global_store_dword

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (2&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (2&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v6 = v9 << (1&31) // v_lshlrev_b32
*(uint*)(v[0:1] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[7:8] + 0 + 0) = v6 // global_store_dword
*(uint*)(v[4:5] + 0 + 0) = v6 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s6 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v2 = 0 // v_mov_b32
v3 = v0 << (1&31) // v_lshlrev_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v1 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[1:2] = v[1:2] << (2&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v2 + cc0
vcc = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v3 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s6 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
v2 = 0x80 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 6) | v0 // v_lshl_or_b32
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v0 = s2 + v0 // v_add_nc_u32
v[1:2] = v[0:1] << (2&63) // v_lshlrev_b64
v3 = v0 << (1&31) // v_lshlrev_b32
uint temp0 = (ulong)s0 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)v2 + cc0
vcc = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
*(uint*)(v[0:1] + 0 + 0) = v3 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s5 = s2 & 0xffffffc0 // s_and_b32
scc = s5 != 0
uint temp0 = (ulong)s3 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[3:4] = (uint)s2 > (uint)s5 // v_cmp_gt_u32
s2 = s2 >> (6 & 31) // s_lshr_b32
scc = s2!= 0
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong temp1 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp1
scc = temp1 >> 32
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
uint temp2 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
v2 = s2 // v_mov_b32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (6 & 31) // s_lshl_b32
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
v2 = v2 << (1&31) // v_lshlrev_b32
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v3 = 0 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (3 & 31) // s_lshl_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
ulong temp1 = (ulong)s2 + (ulong)s1 // s_add_i32
s1 = temp1
scc = temp1 >> 32
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask1 = (1ULL<<LANEID)
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v2 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s_waitcnt       lgkmcnt(0)
s1 = s6 << (3 & 31) // s_lshl_b32
scc = s1!= 0
v1 = 0 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s2 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v2 = s0 // v_mov_b32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v3 = 0 // v_mov_b32
v7 = v1 + v0 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s7 + (ulong)s6 // s_add_i32
s2 = temp1
scc = temp1 >> 32
v2 = s2 // v_mov_b32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp2 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
v2 = 16 // v_mov_b32
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
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 3) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v2 = s0 + v0 // v_add_nc_u32
s0 = s7 << (3 & 31) // s_lshl_b32
scc = s0!= 0
ulong temp0 = (ulong)s2 + (ulong)s0 // s_add_i32
s0 = temp0
scc = temp0 >> 32
v[3:4] = v[2:3] << (2&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v1 + (ulong)v2 // v_add3_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask0 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (3 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s9 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s1 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v2 = s0 // v_mov_b32
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
uint temp2 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (3 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s9 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s5 = s0 & -8 // s_and_b32
scc = s5 != 0
s4 = s0 >> (3 & 31) // s_lshr_b32
scc = s4!= 0
s[0:1] = (uint)s0 > (uint)s5 // v_cmp_gt_u32
s7 = s1 & -8 // s_and_b32
scc = s7 != 0
v[0:1] = v[0:1] << (2&63) // v_lshlrev_b64
vcc = (uint)s1 > (uint)s7 // v_cmp_gt_u32
s6 = s1 >> (3 & 31) // s_lshr_b32
scc = s6!= 0
v2 = s[0:1]&(1ULL<<LANEID) ? 1 : 0 // v_cndmask_b32
ulong temp1 = (ulong)s6 + (ulong)s4 // s_add_i32
s6 = temp1
scc = temp1 >> 32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp2 = (ulong)s6 + (ulong)v2 + cc0
vcc = 0
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
uint temp3 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp4 = (ulong)s3 + (ulong)v1 + cc1
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
*(uint*)(v[0:1] + 0 + 0) = v2 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v2 = s4 // v_mov_b32
v3 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s_waitcnt       lgkmcnt(0)
s1 = s8 << (3 & 31) // s_lshl_b32
scc = s1!= 0
global_load_ushort v4, v[2:3], off inst_offset:2
v3 = 0 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (3 & 31) // s_lshl_b32
scc = s0!= 0
v[2:3] = v[2:3] << (2&63) // v_lshlrev_b64
s_waitcnt       vmcnt(0)
v0 = s2 + v4 // v_add_nc_u32
uint temp1 = (ulong)v0 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v2 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
*(uint*)(v[0:1] + 0 + 0) = v7 // global_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s4 = s6 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
s3 = (int)s2 >> (31 & 31) // s_ashr_i32
scc = s3!=0
v2 = s2 // v_mov_b32
v[0:1] = v[0:1] << (3&63) // v_lshlrev_b64
v3 = s3 // v_mov_b32
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
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = 0 // v_mov_b32
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s3 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v2 = s0 // v_mov_b32
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s1 + (ulong)s3 // s_add_i32
s1 = temp5
scc = temp5 >> 32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[8:9] << (3&63) // v_lshlrev_b64
v2 = s2 // v_mov_b32
uint temp10 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s1 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v15 = 0 // v_mov_b32
s6 = s6 << (3 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v15 // v_mov_b32
v8 = v15 // v_mov_b32
v10 = v15 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (2 & 31) // s_lshl_b32
scc = s0!= 0
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s6 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v14 = s3 + v0 // v_add_nc_u32
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = s3 + v1 // v_add_nc_u32
v[0:1] = v[9:10] << (3&63) // v_lshlrev_b64
*(ulong*)(v[7:8] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = s3 + v2 // v_add_nc_u32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[14:15] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = 0 // v_mov_b32
s9 = s6 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s7 << (4 & 31) // s_lshl_b32
scc = s10!= 0
s11 = s8 << (1 & 31) // s_lshl_b32
scc = s11!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s11 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s9 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s10 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s6 + (ulong)s3 // s_add_i32
s6 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s7 + (ulong)s3 // s_add_i32
s7 = temp4
scc = temp4 >> 32
v2 = s6 // v_mov_b32
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s8 + (ulong)s3 // s_add_i32
s8 = temp5
scc = temp5 >> 32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[8:9] << (3&63) // v_lshlrev_b64
v2 = s7 // v_mov_b32
uint temp10 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s8 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s9 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s1 = 0 // s_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s9 + (ulong)2 // s_add_i32
s0 = temp3
scc = temp3 >> 32
v10 = s1 // v_mov_b32
ulong temp4 = (ulong)s9 + (ulong)4 // s_add_i32
s9 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
v9 = s0 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp5 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
v3 = s9 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
*(ulong*)(v[11:12] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[7:8] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v5 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v0 = (s8 << 2) | v2 // v_lshl_or_b32
v6 = v4 // v_mov_b32
v10 = v4 // v_mov_b32
v[7:8] = v[3:4] << (3&63) // v_lshlrev_b64
v1 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v9 = s1 + v0 // v_add_nc_u32
v5 = s2 + v5 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v3 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[13:14] = v[9:10] << (3&63) // v_lshlrev_b64
v[11:12] = v[5:6] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s4 + (ulong)v7 // v_add_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v3 = s3 + v5 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v8 + cc0
vcc = 0
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)s4 + (ulong)v11 // v_add_u32
v17 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v12 + cc1
vcc = 0
v18 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
*(ulong*)(v[6:7] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[17:18] + 0 + 0) = v[3:4] // global_store_dwordx2
uint temp5 = (ulong)s4 + (ulong)v13 // v_add_u32
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v3 = s3 + v9 // v_add_nc_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v14 + cc2
vcc = 0
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[1:2] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v3 = 0 // v_mov_b32
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)s3 // s_add_i32
s1 = temp4
scc = temp4 >> 32
v2 = s0 // v_mov_b32
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s14 + (ulong)s3 // s_add_i32
s0 = temp5
scc = temp5 >> 32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[8:9] << (3&63) // v_lshlrev_b64
v2 = s1 // v_mov_b32
uint temp10 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = 0 // v_mov_b32
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s2 = s12 & -2 // s_and_b32
scc = s2 != 0
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s[2:3] = (uint)s12 > (uint)s2 // v_cmp_gt_u32
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
s6 = s13 >> (1 & 31) // s_lshr_b32
scc = s6!= 0
s8 = s13 & -2 // s_and_b32
scc = s8 != 0
s9 = s14 >> (2 & 31) // s_lshr_b32
scc = s9!= 0
s10 = s14 & -4 // s_and_b32
scc = s10 != 0
scc = (uint)s2 != (uint)0x0 // s_cmpk_lg_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong temp4 = (ulong)s0 + (ulong)s3 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
s[1:2] = (uint)s13 > (uint)s8 // v_cmp_gt_u32
v[6:7] = v[6:7] << (3&63) // v_lshlrev_b64
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
s[0:1] = (uint)s14 > (uint)s10 // v_cmp_gt_u32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
v[4:5] = v[4:5] << (3&63) // v_lshlrev_b64
ulong temp6 = (ulong)s6 + (ulong)s3 + scc // s_addc_u32
s1 = temp6
scc = temp6 >> 32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
uint temp7 = (ulong)s4 + (ulong)v6 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v2 = s1 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v7 + cc1
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong temp9 = (ulong)s9 + (ulong)s3 + scc // s_addc_u32
s0 = temp9
scc = temp9 >> 32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v2 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (1 & 31) // s_lshl_b32
scc = s4!= 0
global_load_ushort v4, v[1:2], off inst_offset:2
v1 = 0 // v_mov_b32
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s_waitcnt       vmcnt(0)
v0 = s3 + v4 // v_add_nc_u32
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s12 = (int)s9 >> (31 & 31) // s_ashr_i32
scc = s12!=0
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s10 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s9 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s1 + (ulong)s12 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s9 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s3 + (ulong)s12 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s10 + (ulong)s9 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)s11 + (ulong)s12 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s10 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s0 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)s1 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s2 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)s3 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s10 + (ulong)s10 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)0 + (ulong)s11 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (3 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s10 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s0 + (ulong)v0 // v_add_u32
v9 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s2 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v4 + cc2
vcc = 0
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s10 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = 0
ulong mask10 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v7 // v_add_u32
v5 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask13 ? 1 : 0)
uint temp13 = (ulong)s11 + (ulong)0 + cc4
s[0:1] = 0
v12 = CLAMP ? min(temp13, 0xffffffff) : temp13
s[0:1] = (s[0:1]&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v8 + cc5
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s9 = s6 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s12 = s7 << (4 & 31) // s_lshl_b32
scc = s12!= 0
s13 = s8 << (1 & 31) // s_lshl_b32
scc = s13!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s9 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s12 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s10 + (ulong)s13 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s6 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s7 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s10 + (ulong)s8 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)s11 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (2 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s10 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)2 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)2 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s10 + (ulong)4 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)s11 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v9 = s0 + v3 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s10 + (ulong)s7 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)v9 + (ulong)s0 // v_add_u32
v5 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[8:9] = v[7:8] << (3&63) // v_lshlrev_b64
v[12:13] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v16 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)s1 + cc1
s[0:1] = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)v7 + (ulong)s2 // v_add_u32
v17 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v8 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)0 + (ulong)s3 + cc2
s[0:1] = 0
v18 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v9 + cc3
vcc = 0
v8 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v3 + (ulong)s10 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = 0
ulong mask10 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)s4 + (ulong)v12 // v_add_u32
v12 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)s11 + cc4
s[0:1] = 0
v3 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v13 + cc5
vcc = 0
v13 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[7:8] + 0 + 0) = v[17:18] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[16:17] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s16 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s12 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s13 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s16 + (ulong)s14 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)s17 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (2 & 31) // s_lshl_b32
scc = s10!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s11 = s12 & -2 // s_and_b32
scc = s11 != 0
uint temp0 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[11:12] = (uint)s12 > (uint)s11 // v_cmp_gt_u32
s12 = s12 >> (1 & 31) // s_lshr_b32
scc = s12!= 0
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s11 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s12 + (ulong)0 + scc // s_addc_u32
s8 = temp3
scc = temp3 >> 32
s11 = s13 & -2 // s_and_b32
scc = s11 != 0
s9 = s13 >> (1 & 31) // s_lshr_b32
scc = s9!= 0
s[11:12] = (uint)s13 > (uint)s11 // v_cmp_gt_u32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s11 != (uint)0x0 // s_cmpk_lg_u32
ulong temp6 = (ulong)s9 + (ulong)0 + scc // s_addc_u32
s9 = temp6
scc = temp6 >> 32
s10 = s14 & -4 // s_and_b32
scc = s10 != 0
s11 = s14 >> (2 & 31) // s_lshr_b32
scc = s11!= 0
s[10:11] = (uint)s14 > (uint)s10 // v_cmp_gt_u32
uint temp7 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
scc = (uint)s10 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s11 + (ulong)0 + scc // s_addc_u32
s10 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)s0 + (ulong)s8 // s_add_u32
s0 = temp12
scc = temp12 >> 32
ulong temp13 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp13
scc = temp13 >> 32
ulong temp14 = (ulong)s2 + (ulong)s9 // s_add_u32
s2 = temp14
scc = temp14 >> 32
ulong temp15 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s3 = temp15
scc = temp15 >> 32
v7 = s1 // v_mov_b32
v6 = s0 // v_mov_b32
ulong temp16 = (ulong)s4 + (ulong)s10 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)s5 + (ulong)0 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s9 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s10 << (2 & 31) // s_lshl_b32
scc = s10!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)s8 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = 0xffff & v9 // v_and_b32
uint temp9 = (ulong)s0 + (ulong)v10 // v_add_u32
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = 0
ulong mask9 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((s[0:1]&mask10 ? 1 : 0)
uint temp10 = (ulong)s1 + (ulong)0 + cc3
s[0:1] = 0
v7 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)s2 + (ulong)v10 // v_add_u32
v8 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[0:1] = 0
ulong mask11 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask12 ? 1 : 0)
uint temp12 = (ulong)s3 + (ulong)0 + cc4
s[0:1] = 0
v9 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v10 // v_add_u32
v10 = CLAMP ? min(temp13, 0xffffffff) : temp13
s[0:1] = 0
ulong mask13 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((s[0:1]&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)0 + cc5
s[0:1] = 0
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
s[0:1] = (s[0:1]&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s8 = (int)s9 >> (31 & 31) // s_ashr_i32
scc = s8!=0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s9 + (ulong)v0 // v_add_u32
v9 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[11:12] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s8 + (ulong)0 + cc0
s[0:1] = 0
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s9 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s8 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v11 // v_add_u32
v11 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v12 + cc2
vcc = 0
v12 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v15 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp11 = (ulong)s9 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[0:1] = 0
ulong mask11 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask12 ? 1 : 0)
uint temp12 = (ulong)s8 + (ulong)0 + cc4
s[0:1] = 0
v8 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[11:12] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s0 + (ulong)v0 // v_add_u32
v9 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)0 + (ulong)0 + cc0
s[0:1] = 0
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s2 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v4 + cc2
vcc = 0
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s1 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = 0
ulong mask10 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v7 // v_add_u32
v5 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask13 ? 1 : 0)
uint temp13 = (ulong)0 + (ulong)0 + cc4
s[0:1] = 0
v12 = CLAMP ? min(temp13, 0xffffffff) : temp13
s[0:1] = (s[0:1]&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v8 + cc5
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v15 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v14 = v0 << (1&31) // v_lshlrev_b32
v6 = v15 // v_mov_b32
v8 = v15 // v_mov_b32
v10 = v15 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (2 & 31) // s_lshl_b32
scc = s0!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = v1 << (1&31) // v_lshlrev_b32
v[0:1] = v[9:10] << (3&63) // v_lshlrev_b64
*(ulong*)(v[7:8] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = v2 << (1&31) // v_lshlrev_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[14:15] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
v12 = 0 // v_mov_b32
uint temp0 = (ulong)v0 + (ulong)s6 // v_add_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v8 = v4 // v_mov_b32
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)0 + (ulong)v12 + cc0
vcc = 0
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask3 = (1ULL<<LANEID)
uint temp4 = (ulong)v1 + (ulong)s7 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)v12 + cc1
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[9:10] = v[3:4] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp6 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
ulong mask6 = (1ULL<<LANEID)
uint temp7 = (ulong)s4 + (ulong)v9 // v_add_u32
v15 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v10 + cc2
vcc = 0
v16 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v7 // v_add_u32
v18 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v8 + cc3
vcc = 0
v19 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)v2 + (ulong)s8 // v_add_u32
v11 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v12 + cc4
vcc = 0
v12 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v3 // v_add_u32
v9 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v4 + cc5
vcc = 0
v10 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[18:19] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v15 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v14 = 2 | v0 // v_or_b32
v6 = v15 // v_mov_b32
v8 = v15 // v_mov_b32
v10 = v15 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (1 & 31) // s_lshl_b32
scc = s0!= 0
s3 = s8 << (2 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = 2 | v1 // v_or_b32
v[0:1] = v[9:10] << (3&63) // v_lshlrev_b64
*(ulong*)(v[7:8] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = 4 | v2 // v_or_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[14:15] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
s3 = s7 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s8 << (2 & 31) // s_lshl_b32
scc = s6!= 0
v8 = v4 // v_mov_b32
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v9 = s0 + v3 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s1 + (ulong)s6 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v16 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[11:12] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)v9 + (ulong)v0 // v_add_u32
v9 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)0 + cc1
s[0:1] = 0
v10 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)v7 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v11 // v_add_u32
v6 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)0 + (ulong)0 + cc2
s[0:1] = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v12 + cc3
vcc = 0
v7 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
v[11:12] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp10 = (ulong)v3 + (ulong)v2 // v_add_u32
v13 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = 0
ulong mask10 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)0 + cc4
s[0:1] = 0
v14 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[0:1] = (s[0:1]&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v11 // v_add_u32
v11 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[6:7] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[11:12] + 0 + 0) = v[13:14] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v14 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s12 + (ulong)v0 // v_add_u32
v10 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)0 + (ulong)v14 + cc0
vcc = 0
v11 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[8:9] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask4 = (1ULL<<LANEID)
uint temp5 = (ulong)s4 + (ulong)v8 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v8 = v4 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v9 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s13 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)0 + (ulong)v14 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v18 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v19 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp11 = (ulong)s14 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v14 + cc4
vcc = 0
v8 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[10:11] // global_store_dwordx2
*(ulong*)(v[18:19] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v4 = 0 // v_mov_b32
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v14 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[8:9] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
uint temp4 = (ulong)s0 + (ulong)v0 // v_add_u32
v10 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
s[6:7] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)v14 + cc0
vcc = 0
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
uint temp6 = (ulong)s4 + (ulong)v8 // v_add_u32
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v9 + cc1
vcc = 0
v13 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
ulong temp8 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
v8 = v4 // v_mov_b32
uint temp9 = (ulong)s0 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)0 + (ulong)v14 + cc2
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
uint temp11 = (ulong)s4 + (ulong)v5 // v_add_u32
v14 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp11 >> 32) ? mask9 : 0)
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask10) | ((temp12 >> 32) ? mask10 : 0)
vcc = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s1 = s2 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask11 ? 1 : 0)
uint temp13 = (ulong)s1 + (ulong)v2 + cc4
vcc = 0
v3 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask11) | ((temp13 >> 32) ? mask11 : 0)
uint temp14 = (ulong)s4 + (ulong)v7 // v_add_u32
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp14 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp15 = (ulong)s5 + (ulong)v8 + cc5
vcc = 0
v6 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask13) | ((temp15 >> 32) ? mask13 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[10:11] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v14 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v15 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v8 + cc2
vcc = 0
v6 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v11 = 0xffff & v9 // v_and_b32
uint temp9 = (ulong)v11 + (ulong)v0 // v_add_u32
v9 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = 0
ulong mask9 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((s[0:1]&mask10 ? 1 : 0)
uint temp10 = (ulong)0 + (ulong)0 + cc3
s[0:1] = 0
v10 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)v11 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[0:1] = 0
ulong mask11 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)0 + cc4
s[0:1] = 0
v1 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)v11 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp13, 0xffffffff) : temp13
s[0:1] = 0
ulong mask13 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((s[0:1]&mask14 ? 1 : 0)
uint temp14 = (ulong)0 + (ulong)0 + cc5
s[0:1] = 0
v12 = CLAMP ? min(temp14, 0xffffffff) : temp14
s[0:1] = (s[0:1]&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s10 = s7 << (1 & 31) // s_lshl_b32
scc = s10!= 0
s11 = s8 << (1 & 31) // s_lshl_b32
scc = s11!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s12 = (int)s9 >> (31 & 31) // s_ashr_i32
scc = s12!=0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s10 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s11 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s9 + (ulong)s6 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s12 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s9 + (ulong)s7 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s12 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s9 + (ulong)s8 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)s12 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s9 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s1 = s6 << (1 & 31) // s_lshl_b32
scc = s1!= 0
s3 = s7 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s9 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s6 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s7 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s9 + (ulong)s8 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v12 = 0 // v_mov_b32
uint temp0 = (ulong)s6 + (ulong)v0 // v_add_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v8 = v4 // v_mov_b32
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)0 + (ulong)v12 + cc0
vcc = 0
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask3 = (1ULL<<LANEID)
uint temp4 = (ulong)s7 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)v12 + cc1
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[9:10] = v[3:4] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp6 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
ulong mask6 = (1ULL<<LANEID)
uint temp7 = (ulong)s4 + (ulong)v9 // v_add_u32
v15 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v10 + cc2
vcc = 0
v16 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v7 // v_add_u32
v18 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v8 + cc3
vcc = 0
v19 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)s8 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v12 + cc4
vcc = 0
v12 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v3 // v_add_u32
v9 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v4 + cc5
vcc = 0
v10 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[18:19] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s10 = s7 // s_mov_b32
s13 = s8 << (1 & 31) // s_lshl_b32
scc = s13!= 0
s12 = s10 << (4 & 31) // s_lshl_b32
scc = s12!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s7 = 0 // s_mov_b32
s11 = s7 // s_mov_b32
s9 = s7 // s_mov_b32
s[6:7] = s[6:7] << (1 & 63) // s_lshl_b64
scc = s[6:7]!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s12 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s13 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s[0:1] = s[10:11] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
v9 = s1 // v_mov_b32
v2 = s6 // v_mov_b32
v8 = s0 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s[0:1] = s[8:9] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v3 = s7 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v11 = s1 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s12 = s8 << (2 & 31) // s_lshl_b32
scc = s12!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_u32
s10 = temp0
scc = temp0 >> 32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
ulong temp1 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s11 = temp1
scc = temp1 >> 32
ulong temp2 = (ulong)s7 + (ulong)2 // s_add_u32
s6 = temp2
scc = temp2 >> 32
ulong temp3 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp3
scc = temp3 >> 32
uint temp4 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask0 = (1ULL<<LANEID)
uint temp5 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp6 = (ulong)s1 + (ulong)s12 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
ulong mask2 = (1ULL<<LANEID)
ulong temp7 = (ulong)s8 + (ulong)4 // s_add_u32
s0 = temp7
scc = temp7 >> 32
ulong temp8 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp8
scc = temp8 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
v2 = s10 // v_mov_b32
v9 = s7 // v_mov_b32
v3 = s11 // v_mov_b32
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp9 >> 32) ? mask3 : 0)
v11 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask4) | ((temp10 >> 32) ? mask4 : 0)
uint temp11 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp11 >> 32) ? mask5 : 0)
v8 = s6 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v10 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
v3 = (s6 << 1) | v0 // v_lshl_or_b32
s3 = s7 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v14 = 0 // v_mov_b32
s9 = s8 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v8 = v4 // v_mov_b32
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
v9 = s0 + v3 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v16 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)v9 + (ulong)s6 // v_add_u32
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[8:9] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)v14 + cc1
vcc = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)v7 + (ulong)s7 // v_add_u32
v17 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v[12:13] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v14 + cc2
vcc = 0
v18 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v8 // v_add_u32
v7 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v9 + cc3
vcc = 0
v8 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v3 + (ulong)s8 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v14 + cc4
vcc = 0
v3 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v12 // v_add_u32
v12 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v13 + cc5
vcc = 0
v13 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[7:8] + 0 + 0) = v[17:18] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s8 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)s13 + (ulong)s9 // s_add_u32
s2 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
v2 = s0 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
ulong temp8 = (ulong)s14 + (ulong)s10 // s_add_u32
s0 = temp8
scc = temp8 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask4) | ((temp9 >> 32) ? mask4 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp10 >> 32) ? mask5 : 0)
ulong temp11 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp11
scc = temp11 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s11 = s9 << (1 & 31) // s_lshl_b32
scc = s11!= 0
s13 = s10 << (2 & 31) // s_lshl_b32
scc = s13!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s13 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s11 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
s[6:7] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong temp7 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s3 = temp7
scc = temp7 >> 32
s1 = s2 & -4 // s_and_b32
scc = s1 != 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
s[1:2] = (uint)s2 > (uint)s1 // v_cmp_gt_u32
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
ulong temp11 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s6 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)s0 + (ulong)s8 // s_add_u32
s0 = temp12
scc = temp12 >> 32
ulong temp13 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp13
scc = temp13 >> 32
ulong temp14 = (ulong)s3 + (ulong)s9 // s_add_u32
s2 = temp14
scc = temp14 >> 32
ulong temp15 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp15
scc = temp15 >> 32
v7 = s1 // v_mov_b32
v6 = s0 // v_mov_b32
ulong temp16 = (ulong)s6 + (ulong)s10 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v11 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = 0xffff & v9 // v_and_b32
uint temp9 = (ulong)v10 + (ulong)s8 // v_add_u32
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)0 + (ulong)v11 + cc3
vcc = 0
v7 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)v10 + (ulong)s9 // v_add_u32
v8 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v11 + cc4
vcc = 0
v9 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)v10 + (ulong)s10 // v_add_u32
v10 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)0 + (ulong)v11 + cc5
vcc = 0
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s8 = (int)s9 >> (31 & 31) // s_ashr_i32
scc = s8!=0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s9 + (ulong)16 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s8 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s9 + (ulong)2 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)s8 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v9 = s3 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
v2 = s0 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask6) | ((temp10 >> 32) ? mask6 : 0)
uint temp11 = (ulong)s4 + (ulong)v6 // v_add_u32
v6 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp11 >> 32) ? mask7 : 0)
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v7 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask8) | ((temp12 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[10:11] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[6:7] + 0 + 0) = v[8:9] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s9 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s1 = s6 << (1 & 31) // s_lshl_b32
scc = s1!= 0
s3 = s7 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s9 + (ulong)s6 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)2 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)16 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s9 + (ulong)2 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v15 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v14 = 8 | v0 // v_or_b32
v6 = v15 // v_mov_b32
v8 = v15 // v_mov_b32
v10 = v15 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (2 & 31) // s_lshl_b32
scc = s0!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[4:5] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = 4 | v1 // v_or_b32
v[0:1] = v[9:10] << (3&63) // v_lshlrev_b64
*(ulong*)(v[7:8] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = 2 | v2 // v_or_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[14:15] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s12 = s8 << (1 & 31) // s_lshl_b32
scc = s12!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_u32
s10 = temp0
scc = temp0 >> 32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
ulong temp1 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s11 = temp1
scc = temp1 >> 32
ulong temp2 = (ulong)s7 + (ulong)16 // s_add_u32
s6 = temp2
scc = temp2 >> 32
ulong temp3 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp3
scc = temp3 >> 32
uint temp4 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask0 = (1ULL<<LANEID)
uint temp5 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp6 = (ulong)s1 + (ulong)s12 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
ulong mask2 = (1ULL<<LANEID)
ulong temp7 = (ulong)s8 + (ulong)2 // s_add_u32
s0 = temp7
scc = temp7 >> 32
ulong temp8 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp8
scc = temp8 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
v2 = s10 // v_mov_b32
v9 = s7 // v_mov_b32
v3 = s11 // v_mov_b32
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp9 >> 32) ? mask3 : 0)
v11 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask4) | ((temp10 >> 32) ? mask4 : 0)
uint temp11 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp11 >> 32) ? mask5 : 0)
v8 = s6 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v10 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s1 = 0 // s_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = 4 // s_mov_b32
v10 = s1 // v_mov_b32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
v9 = s0 // v_mov_b32
v3 = 8 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v11 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v12 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v16 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v8 + cc2
vcc = 0
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[11:12] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[15:16] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[1:2] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s3 = 0 // s_mov_b32
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
v8 = v4 // v_mov_b32
v9 = s0 + v3 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)v9 + (ulong)2 // v_add_u32
v5 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[8:9] = v[7:8] << (3&63) // v_lshlrev_b64
v[12:13] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v16 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)v7 + (ulong)2 // v_add_u32
v17 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v8 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s3 + (ulong)0 + cc2
s[0:1] = 0
v18 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v9 + cc3
vcc = 0
v8 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v3 + (ulong)4 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = 0
ulong mask10 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)s4 + (ulong)v12 // v_add_u32
v12 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask12 ? 1 : 0)
uint temp12 = (ulong)s3 + (ulong)0 + cc4
s[0:1] = 0
v3 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v13 + cc5
vcc = 0
v13 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
*(ulong*)(v[15:16] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[7:8] + 0 + 0) = v[17:18] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)16 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)s13 + (ulong)2 // s_add_u32
s2 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
v2 = s0 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
ulong temp8 = (ulong)s14 + (ulong)2 // s_add_u32
s0 = temp8
scc = temp8 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask4) | ((temp9 >> 32) ? mask4 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp10 >> 32) ? mask5 : 0)
ulong temp11 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp11
scc = temp11 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s9 = s0 & -2 // s_and_b32
scc = s9 != 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[9:10] = (uint)s0 > (uint)s9 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s9 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v13 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s3 = temp5
scc = temp5 >> 32
s1 = s2 & -4 // s_and_b32
scc = s1 != 0
s6 = s2 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
s[7:8] = (uint)s2 > (uint)s1 // v_cmp_gt_u32
ulong temp6 = (ulong)s0 + (ulong)2 // s_add_u32
s0 = temp6
scc = temp6 >> 32
ulong temp7 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp7
scc = temp7 >> 32
ulong temp8 = (ulong)s3 + (ulong)2 // s_add_u32
s2 = temp8
scc = temp8 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask4) | ((temp9 >> 32) ? mask4 : 0)
ulong temp10 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp10
scc = temp10 >> 32
uint temp11 = (ulong)s4 + (ulong)v2 // v_add_u32
v9 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp11 >> 32) ? mask5 : 0)
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v10 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
v8 = s1 // v_mov_b32
uint temp13 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v7 = s0 // v_mov_b32
ulong temp14 = (ulong)s6 + (ulong)4 + scc // s_addc_u32
s0 = temp14
scc = temp14 >> 32
v12 = s3 // v_mov_b32
v11 = s2 // v_mov_b32
v3 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp15 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask8) | ((temp15 >> 32) ? mask8 : 0)
*(ulong*)(v[13:14] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = 0 // s_mov_b32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v2 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v8 = 0xffff & v9 // v_and_b32
uint temp9 = (ulong)v8 + (ulong)2 // v_add_u32
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = 0
ulong mask9 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((s[1:2]&mask10 ? 1 : 0)
uint temp10 = (ulong)s0 + (ulong)0 + cc3
s[1:2] = 0
v7 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = (s[1:2]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)v8 + (ulong)4 // v_add_u32
v8 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = 0
ulong mask11 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[1:2]&mask12 ? 1 : 0)
uint temp12 = (ulong)s0 + (ulong)0 + cc4
s[0:1] = 0
v9 = CLAMP ? min(temp12, 0xffffffff) : temp12
s[0:1] = (s[0:1]&~mask12) | ((temp12 >> 32) ? mask12 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v0 = (s6 << 4) | v0 // v_lshl_or_b32
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v3 = (s8 << 1) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
s6 = (int)s9 >> (31 & 31) // s_ashr_i32
scc = s6!=0
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v1 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v1 = 0 // v_mov_b32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v13 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s10 + (ulong)v3 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)v0 + (ulong)s9 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s11 + (ulong)0 + cc2
s[0:1] = 0
v14 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v[5:6] = v[0:1] << (3&63) // v_lshlrev_b64
v3 = v1 // v_mov_b32
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)s6 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v[11:12] = v[2:3] << (3&63) // v_lshlrev_b64
v5 = v1 // v_mov_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v2 + (ulong)s9 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s6 + (ulong)v13 + cc5
vcc = 0
v3 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v11 // v_add_u32
v0 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
v[5:6] = v[4:5] << (3&63) // v_lshlrev_b64
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v12 + cc6
vcc = 0
v1 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
uint temp14 = (ulong)v4 + (ulong)s9 // v_add_u32
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)s6 + (ulong)v14 + cc7
vcc = 0
v12 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v6 + cc8
vcc = 0
v6 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[14:15] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v5 = 0 // v_mov_b32
v1 = (s7 << 4) | v1 // v_lshl_or_b32
v4 = (s8 << 1) | v2 // v_lshl_or_b32
v3 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)v5 + cc0
vcc = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v1 = v3 // v_mov_b32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)v5 + cc1
vcc = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s14 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s15 + (ulong)v5 + cc2
vcc = 0
v13 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[5:6] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp6 = (ulong)s0 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v[1:2] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v5 = v3 // v_mov_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s2 + (ulong)v0 // v_add_u32
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v1 // v_add_u32
v17 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v2 + cc6
vcc = 0
v18 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
v[2:3] = v[4:5] << (3&63) // v_lshlrev_b64
uint temp14 = (ulong)s14 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v13 + cc7
vcc = 0
v5 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v3 + cc8
vcc = 0
v3 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[17:18] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[4:5] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 3) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
v5 = (s7 << 2) | v1 // v_lshl_or_b32
v7 = (s8 << 1) | v2 // v_lshl_or_b32
v20 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v11 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v5 // v_add_u32
v19 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v[8:9] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)v3 + (ulong)v0 // v_add_u32
v10 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v16 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)0 + (ulong)v11 + cc2
vcc = 0
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[14:15] = v[19:20] << (3&63) // v_lshlrev_b64
uint temp6 = (ulong)s10 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v8 // v_add_u32
v12 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v8 = v4 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v9 + cc3
vcc = 0
v13 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)v19 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask10 ? 1 : 0)
uint temp10 = (ulong)s11 + (ulong)0 + cc4
s[0:1] = 0
v17 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = (s[0:1]&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v16 + cc5
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v14 // v_add_u32
v14 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v15 + cc6
vcc = 0
v15 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
uint temp14 = (ulong)v7 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v17 + cc7
vcc = 0
v8 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v6 + cc8
vcc = 0
v6 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[10:11] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[14:15] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v5 = 0 // v_mov_b32
v1 = (s7 << 4) | v1 // v_lshl_or_b32
v4 = (s8 << 1) | v2 // v_lshl_or_b32
v3 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)v5 + cc0
vcc = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v1 = v3 // v_mov_b32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)v5 + cc1
vcc = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s14 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s15 + (ulong)v5 + cc2
vcc = 0
v13 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[5:6] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp6 = (ulong)v2 + (ulong)s6 // v_add_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v[1:2] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v5 = v3 // v_mov_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v0 + (ulong)s7 // v_add_u32
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v1 // v_add_u32
v17 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v2 + cc6
vcc = 0
v18 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
v[2:3] = v[4:5] << (3&63) // v_lshlrev_b64
uint temp14 = (ulong)v4 + (ulong)s8 // v_add_u32
v4 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v13 + cc7
vcc = 0
v5 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v3 + cc8
vcc = 0
v3 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[17:18] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[4:5] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v4 = (s7 << 1) | v1 // v_lshl_or_b32
v5 = (s8 << 2) | v2 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v1 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v4 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s10 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[5:6] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp5 = (ulong)v2 + (ulong)2 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[1:2] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)0 + (ulong)v8 + cc2
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)s11 + (ulong)0 + cc3
s[0:1] = 0
v13 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v5 = v3 // v_mov_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v0 + (ulong)2 // v_add_u32
v11 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v1 // v_add_u32
v17 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v2 + cc6
vcc = 0
v18 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
v[2:3] = v[4:5] << (3&63) // v_lshlrev_b64
uint temp14 = (ulong)v4 + (ulong)4 // v_add_u32
v4 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v13 + cc7
vcc = 0
v5 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v3 + cc8
vcc = 0
v3 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[17:18] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[4:5] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 1) | v0 // v_lshl_or_b32
v0 = (s7 << 1) | v1 // v_lshl_or_b32
v4 = 0 // v_mov_b32
v1 = (s8 << 2) | v2 // v_lshl_or_b32
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v3 // v_add_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v3 = v4 // v_mov_b32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v11 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s10 + (ulong)v1 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v1 = v4 // v_mov_b32
uint temp5 = (ulong)v7 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s11 + (ulong)0 + cc2
s[0:1] = 0
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v[9:10] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
v[3:4] = v[2:3] << (3&63) // v_lshlrev_b64
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v11 + cc5
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v9 // v_add_u32
v14 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v10 + cc6
vcc = 0
v15 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
uint temp14 = (ulong)v2 + (ulong)v2 // v_add_u32
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v12 + cc7
vcc = 0
v12 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s4 + (ulong)v3 // v_add_u32
v9 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s5 + (ulong)v4 + cc8
vcc = 0
v10 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[12:13] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[14:15] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[4:7][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
v0 = (s8 << 4) | v0 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v1 = (s9 << 1) | v1 // v_lshl_or_b32
v4 = (s10 << 1) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v1 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v1 = 0 // v_mov_b32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)v3 + cc1
vcc = 0
v13 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s12 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s13 + (ulong)v3 + cc2
vcc = 0
v14 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[5:6] = v[0:1] << (3&63) // v_lshlrev_b64
v3 = v1 // v_mov_b32
uint temp6 = (ulong)v0 + (ulong)s4 // v_add_u32
v7 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s14 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v[11:12] = v[2:3] << (3&63) // v_lshlrev_b64
v5 = v1 // v_mov_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s15 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v2 + (ulong)s5 // v_add_u32
v2 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v13 + cc5
vcc = 0
v3 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s14 + (ulong)v11 // v_add_u32
v0 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
v[5:6] = v[4:5] << (3&63) // v_lshlrev_b64
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s15 + (ulong)v12 + cc6
vcc = 0
v1 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
uint temp14 = (ulong)v4 + (ulong)s6 // v_add_u32
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v14 + cc7
vcc = 0
v12 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)s14 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)s15 + (ulong)v6 + cc8
vcc = 0
v6 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s[6:7] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v5 = 0 // v_mov_b32
v4 = (s9 << 1) | v1 // v_lshl_or_b32
v6 = (s10 << 2) | v2 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v1 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s3 = s0 & -2 // s_and_b32
scc = s3 != 0
uint temp0 = (ulong)s12 + (ulong)v0 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
s[3:4] = (uint)s0 > (uint)s3 // v_cmp_gt_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s13 + (ulong)v5 + cc0
vcc = 0
v8 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp2 = (ulong)s14 + (ulong)v4 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s15 + (ulong)v5 + cc1
vcc = 0
v12 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong temp4 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
uint temp5 = (ulong)s6 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask5 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)v5 + cc2
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v[5:6] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp7 = (ulong)v2 + (ulong)s0 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp8 = (ulong)0 + (ulong)v8 + cc3
vcc = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask7) | ((temp8 >> 32) ? mask7 : 0)
ulong temp9 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v5 // v_add_u32
v9 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
v[1:2] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v6 + cc4
vcc = 0
v10 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask9) | ((temp11 >> 32) ? mask9 : 0)
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
uint temp12 = (ulong)v0 + (ulong)s1 // v_add_u32
v11 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp12 >> 32) ? mask10 : 0)
v5 = v3 // v_mov_b32
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp13 = (ulong)0 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask11) | ((temp13 >> 32) ? mask11 : 0)
uint temp14 = (ulong)s4 + (ulong)v1 // v_add_u32
v17 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp14 >> 32) ? mask12 : 0)
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp15 = (ulong)s5 + (ulong)v2 + cc6
vcc = 0
v18 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask13) | ((temp15 >> 32) ? mask13 : 0)
v[2:3] = v[4:5] << (3&63) // v_lshlrev_b64
ulong temp16 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s0 = temp16
scc = temp16 >> 32
uint temp17 = (ulong)v4 + (ulong)s0 // v_add_u32
v4 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp17 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp18 = (ulong)0 + (ulong)v13 + cc7
vcc = 0
v5 = CLAMP ? min(temp18, 0xffffffff) : temp18
vcc = (vcc&~mask15) | ((temp18 >> 32) ? mask15 : 0)
uint temp19 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp19, 0xffffffff) : temp19
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp19 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp20 = (ulong)s5 + (ulong)v3 + cc8
vcc = 0
v3 = CLAMP ? min(temp20, 0xffffffff) : temp20
vcc = (vcc&~mask17) | ((temp20 >> 32) ? mask17 : 0)
*(ulong*)(v[9:10] + 0 + 0) = v[7:8] // global_store_dwordx2
*(ulong*)(v[17:18] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[4:5] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v6 = (s10 << 2) | v2 // v_lshl_or_b32
global_load_ushort v12, v[3:4], off inst_offset:2
v4 = (s9 << 1) | v1 // v_lshl_or_b32
v3 = 0 // v_mov_b32
v1 = v3 // v_mov_b32
v5 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v13 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s2 + (ulong)v4 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)0 + cc1
s[0:1] = 0
v14 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[6:7] = v[2:3] << (3&63) // v_lshlrev_b64
v[8:9] = v[0:1] << (3&63) // v_lshlrev_b64
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v15 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v[10:11] = v[4:5] << (3&63) // v_lshlrev_b64
uint temp6 = (ulong)s6 + (ulong)v6 // v_add_u32
v19 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)v7 + cc3
vcc = 0
v20 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s6 + (ulong)v8 // v_add_u32
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)v9 + cc4
vcc = 0
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s6 + (ulong)v10 // v_add_u32
v9 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v11 + cc5
vcc = 0
v10 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
s_waitcnt       vmcnt(0)
v3 = 0xffff & v12 // v_and_b32
uint temp12 = (ulong)v2 + (ulong)v3 // v_add_u32
v1 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc6 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)0 + (ulong)v13 + cc6
vcc = 0
v2 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
uint temp14 = (ulong)v0 + (ulong)v3 // v_add_u32
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask14 = (1ULL<<LANEID)
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
ulong mask15 = (1ULL<<LANEID) // v_addc_u32
uchar cc7 = ((vcc&mask15 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v14 + cc7
vcc = 0
v12 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask15) | ((temp15 >> 32) ? mask15 : 0)
uint temp16 = (ulong)v4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask16 = (1ULL<<LANEID)
vcc = (vcc&~mask16) | ((temp16 >> 32) ? mask16 : 0)
ulong mask17 = (1ULL<<LANEID) // v_addc_u32
uchar cc8 = ((vcc&mask17 ? 1 : 0)
uint temp17 = (ulong)0 + (ulong)v15 + cc8
vcc = 0
v4 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask17) | ((temp17 >> 32) ? mask17 : 0)
*(ulong*)(v[19:20] + 0 + 0) = v[1:2] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s8 = (int)s11 >> (31 & 31) // s_ashr_i32
scc = s8!=0
ulong temp3 = (ulong)s12 + (ulong)s11 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)s8 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s13 + (ulong)s11 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)s8 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s14 + (ulong)s11 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)0 + (ulong)s8 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s11 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s1 = s8 << (1 & 31) // s_lshl_b32
scc = s1!= 0
s3 = s9 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s10 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s11 + (ulong)s6 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s12 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp5 = (ulong)s2 + (ulong)s13 // s_add_u32
s2 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
v2 = s0 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask4) | ((temp8 >> 32) ? mask4 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp9 >> 32) ? mask5 : 0)
ulong temp10 = (ulong)s11 + (ulong)s14 // s_add_u32
s0 = temp10
scc = temp10 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask6) | ((temp11 >> 32) ? mask6 : 0)
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v4 = 0 // v_mov_b32
s6 = s9 << (2 & 31) // s_lshl_b32
scc = s6!= 0
v14 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s12 + (ulong)v0 // v_add_u32
v10 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)0 + (ulong)v14 + cc0
vcc = 0
v11 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[8:9] = v[3:4] << (3&63) // v_lshlrev_b64
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask4 = (1ULL<<LANEID)
uint temp5 = (ulong)s4 + (ulong)v8 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v8 = v4 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v9 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s13 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)0 + (ulong)v14 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v18 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v6 + cc3
vcc = 0
v19 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp11 = (ulong)s14 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v14 + cc4
vcc = 0
v8 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[10:11] // global_store_dwordx2
*(ulong*)(v[18:19] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s8 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)s13 + (ulong)s9 // s_add_u32
s2 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
v2 = s0 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
ulong temp8 = (ulong)s14 + (ulong)s10 // s_add_u32
s0 = temp8
scc = temp8 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask4) | ((temp9 >> 32) ? mask4 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp10 >> 32) ? mask5 : 0)
ulong temp11 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp11
scc = temp11 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)2 // s_add_u32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)s13 + (ulong)2 // s_add_u32
s2 = temp5
scc = temp5 >> 32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
ulong temp6 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
v3 = s1 // v_mov_b32
v2 = s0 // v_mov_b32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp7 >> 32) ? mask3 : 0)
ulong temp8 = (ulong)s14 + (ulong)4 // s_add_u32
s0 = temp8
scc = temp8 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask4) | ((temp9 >> 32) ? mask4 : 0)
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp10 >> 32) ? mask5 : 0)
ulong temp11 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp11
scc = temp11 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp12 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask6) | ((temp12 >> 32) ? mask6 : 0)
uint temp13 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v9 = s3 // v_mov_b32
v11 = s1 // v_mov_b32
v8 = s2 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s8 << 1) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
s3 = s9 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v13 = 0 // v_mov_b32
s6 = s10 << (2 & 31) // s_lshl_b32
scc = s6!= 0
v[7:8] = v[3:4] << (3&63) // v_lshlrev_b64
v6 = v4 // v_mov_b32
v0 = s0 + v3 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s1 + (ulong)s6 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)v0 + (ulong)s12 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v[9:10] = v[5:6] << (3&63) // v_lshlrev_b64
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)0 + (ulong)v13 + cc0
vcc = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v7 // v_add_u32
v14 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v[11:12] = v[3:4] << (3&63) // v_lshlrev_b64
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v15 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)v5 + (ulong)s13 // v_add_u32
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)0 + (ulong)v13 + cc2
vcc = 0
v6 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
uint temp8 = (ulong)s4 + (ulong)v9 // v_add_u32
v7 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v10 + cc3
vcc = 0
v8 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)v3 + (ulong)s14 // v_add_u32
v9 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v13 + cc4
vcc = 0
v10 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
uint temp12 = (ulong)s4 + (ulong)v11 // v_add_u32
v11 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v12 + cc5
vcc = 0
v12 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
*(ulong*)(v[14:15] + 0 + 0) = v[0:1] // global_store_dwordx2
*(ulong*)(v[7:8] + 0 + 0) = v[5:6] // global_store_dwordx2
*(ulong*)(v[11:12] + 0 + 0) = v[9:10] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s11 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
s1 = 0 // s_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s3 = s1 // s_mov_b32
s15 = s1 // s_mov_b32
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s11 + (ulong)s8 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s0 = s12 // s_mov_b32
s2 = s13 // s_mov_b32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
s[0:1] = s[0:1] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
v[6:7] = v[7:8] << (3&63) // v_lshlrev_b64
v3 = s1 // v_mov_b32
v2 = s0 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s[0:1] = s[2:3] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v14 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v9 = s1 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v15 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v8 = s0 // v_mov_b32
s[0:1] = s[14:15] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
uint temp7 = (ulong)s4 + (ulong)v6 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v11 = s1 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[14:15] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
s10 = s0 >> (1 & 31) // s_lshr_b32
scc = s10!= 0
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
ulong temp3 = (ulong)s10 + (ulong)0 + scc // s_addc_u32
s6 = temp3
scc = temp3 >> 32
s7 = s1 & -2 // s_and_b32
scc = s7 != 0
s3 = s1 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
s[7:8] = (uint)s1 > (uint)s7 // v_cmp_gt_u32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
ulong temp6 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s3 = temp6
scc = temp6 >> 32
s7 = s2 & -4 // s_and_b32
scc = s7 != 0
s8 = s2 >> (2 & 31) // s_lshr_b32
scc = s8!= 0
s[7:8] = (uint)s2 > (uint)s7 // v_cmp_gt_u32
uint temp7 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s8 + (ulong)0 + scc // s_addc_u32
s8 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)s6 + (ulong)s0 // s_add_u32
s6 = temp12
scc = temp12 >> 32
ulong temp13 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp13
scc = temp13 >> 32
ulong temp14 = (ulong)s3 + (ulong)s1 // s_add_u32
s0 = temp14
scc = temp14 >> 32
ulong temp15 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp15
scc = temp15 >> 32
ulong temp16 = (ulong)s8 + (ulong)s2 // s_add_u32
s2 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s3 = temp17
scc = temp17 >> 32
v6 = s6 // v_mov_b32
v9 = s1 // v_mov_b32
v7 = s7 // v_mov_b32
v11 = s3 // v_mov_b32
v8 = s0 // v_mov_b32
v10 = s2 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[12:13] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[4:7][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
global_load_ushort v9, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v11 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s12 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s13 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s12 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s13 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s12 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s13 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = 0xffff & v9 // v_and_b32
uint temp9 = (ulong)s4 + (ulong)v10 // v_add_u32
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)0 + (ulong)v11 + cc3
vcc = 0
v7 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
uint temp11 = (ulong)s5 + (ulong)v10 // v_add_u32
v8 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp12 = (ulong)0 + (ulong)v11 + cc4
vcc = 0
v9 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = (vcc&~mask12) | ((temp12 >> 32) ? mask12 : 0)
uint temp13 = (ulong)s6 + (ulong)v10 // v_add_u32
v10 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp13 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp14 = (ulong)0 + (ulong)v11 + cc5
vcc = 0
v11 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask14) | ((temp14 >> 32) ? mask14 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s11 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s7 = s8 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s10 = (int)s3 >> (31 & 31) // s_ashr_i32
scc = s10!=0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s6 = s0 & -16 // s_and_b32
scc = s6 != 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (4 & 31) // s_lshr_b32
scc = s0!= 0
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp2 = (ulong)s11 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s0 + (ulong)s3 // s_add_u32
s6 = temp5
scc = temp5 >> 32
ulong temp6 = (ulong)0 + (ulong)s10 + scc // s_addc_u32
s7 = temp6
scc = temp6 >> 32
s0 = s1 & -2 // s_and_b32
scc = s0 != 0
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
v6 = s6 // v_mov_b32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong temp10 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
uint temp11 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp11 >> 32) ? mask7 : 0)
ulong temp12 = (ulong)s0 + (ulong)s3 // s_add_u32
s0 = temp12
scc = temp12 >> 32
ulong temp13 = (ulong)0 + (ulong)s10 + scc // s_addc_u32
s1 = temp13
scc = temp13 >> 32
s8 = s2 & -2 // s_and_b32
scc = s8 != 0
v9 = s1 // v_mov_b32
s[8:9] = (uint)s2 > (uint)s8 // v_cmp_gt_u32
s2 = s2 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
v8 = s0 // v_mov_b32
v7 = s7 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
ulong temp15 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp15
scc = temp15 >> 32
ulong temp16 = (ulong)s2 + (ulong)s3 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)s10 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v11 = s1 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (4 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
ulong temp4 = (ulong)s12 + (ulong)s0 // s_add_u32
s6 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp5
scc = temp5 >> 32
s0 = s1 & -16 // s_and_b32
scc = s0 != 0
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
s1 = s1 >> (4 & 31) // s_lshr_b32
scc = s1!= 0
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong temp10 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
v6 = s6 // v_mov_b32
ulong temp11 = (ulong)s14 + (ulong)s0 // s_add_u32
s0 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
s8 = s2 & -2 // s_and_b32
scc = s8 != 0
v9 = s1 // v_mov_b32
s[8:9] = (uint)s2 > (uint)s8 // v_cmp_gt_u32
s2 = s2 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
v8 = s0 // v_mov_b32
uint temp13 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v7 = s7 // v_mov_b32
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
ulong temp15 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp15
scc = temp15 >> 32
ulong temp16 = (ulong)s3 + (ulong)s2 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v11 = s1 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v4 = 0 // v_mov_b32
s3 = s8 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s6 = s9 << (2 & 31) // s_lshl_b32
scc = s6!= 0
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v10 = v4 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s1 = s12 & -8 // s_and_b32
scc = s1 != 0
s0 = s12 >> (3 & 31) // s_lshr_b32
scc = s0!= 0
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
s1 = s13 & -4 // s_and_b32
scc = s1 != 0
s2 = s13 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s0 + (ulong)v0 + cc0
vcc = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s0 = s14 & -2 // s_and_b32
scc = s0 != 0
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp4 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
s[0:1] = (uint)s14 > (uint)s0 // v_cmp_gt_u32
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v6 + cc1
vcc = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
vcc = (uint)s13 > (uint)s1 // v_cmp_gt_u32
s1 = s14 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s2 + (ulong)v1 + cc2
vcc = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v13 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v[5:6] = v[9:10] << (3&63) // v_lshlrev_b64
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v8 + cc3
vcc = 0
v14 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v8 = 0 // v_mov_b32
ulong temp9 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s0 + (ulong)v2 // v_add_u32
v7 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp10 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp11 = (ulong)0 + (ulong)v8 + cc4
vcc = 0
v8 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask10) | ((temp11 >> 32) ? mask10 : 0)
uint temp12 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp12 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask12 ? 1 : 0)
uint temp13 = (ulong)s5 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask12) | ((temp13 >> 32) ? mask12 : 0)
*(ulong*)(v[13:14] + 0 + 0) = v[3:4] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[7:8] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s11 = s9 << (4 & 31) // s_lshl_b32
scc = s11!= 0
s13 = s10 << (1 & 31) // s_lshl_b32
scc = s13!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s11 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s13 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
ulong temp4 = (ulong)s0 + (ulong)s8 // s_add_u32
s6 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp5
scc = temp5 >> 32
s0 = s1 & -16 // s_and_b32
scc = s0 != 0
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
s1 = s1 >> (4 & 31) // s_lshr_b32
scc = s1!= 0
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong temp10 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
v6 = s6 // v_mov_b32
ulong temp11 = (ulong)s0 + (ulong)s9 // s_add_u32
s0 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
s3 = s2 & -2 // s_and_b32
scc = s3 != 0
v9 = s1 // v_mov_b32
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s2 = s2 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
v8 = s0 // v_mov_b32
uint temp13 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v7 = s7 // v_mov_b32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
ulong temp15 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp15
scc = temp15 >> 32
ulong temp16 = (ulong)s2 + (ulong)s10 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v11 = s1 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -2 // s_and_b32
scc = s6 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
ulong temp4 = (ulong)s0 + (ulong)2 // s_add_u32
s6 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp5
scc = temp5 >> 32
s0 = s1 & -2 // s_and_b32
scc = s0 != 0
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v15 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v16 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v2 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong temp10 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
v10 = s7 // v_mov_b32
ulong temp11 = (ulong)s0 + (ulong)2 // s_add_u32
s0 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
uint temp13 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
v12 = s1 // v_mov_b32
v9 = s6 // v_mov_b32
v11 = s0 // v_mov_b32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
ulong temp15 = (ulong)s2 + (ulong)4 + scc // s_addc_u32
s2 = temp15
scc = temp15 >> 32
v3 = s2 // v_mov_b32
*(ulong*)(v[15:16] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[1:2] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s8 << 1) | v0 // v_lshl_or_b32
v4 = 0 // v_mov_b32
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
v14 = 0 // v_mov_b32
v[7:8] = v[3:4] << (3&63) // v_lshlrev_b64
v6 = v4 // v_mov_b32
s7 = s0 & -2 // s_and_b32
scc = s7 != 0
uint temp0 = (ulong)s14 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[7:8] = (uint)s0 > (uint)s7 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
v9 = s12 + v3 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v7 // v_add_u32
v18 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v8 + cc0
vcc = 0
v19 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong temp4 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
uint temp5 = (ulong)v9 + (ulong)s0 // v_add_u32
v8 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
s[3:4] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
v[6:7] = v[5:6] << (3&63) // v_lshlrev_b64
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp6 = (ulong)0 + (ulong)v14 + cc1
vcc = 0
v9 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v[12:13] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong temp7 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp7
scc = temp7 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
uint temp8 = (ulong)v5 + (ulong)s1 // v_add_u32
v10 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
s[0:1] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s1 = s2 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask7 ? 1 : 0)
uint temp9 = (ulong)0 + (ulong)v14 + cc2
vcc = 0
v11 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
uint temp10 = (ulong)s4 + (ulong)v6 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask8 = (1ULL<<LANEID)
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v7 + cc3
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask9) | ((temp11 >> 32) ? mask9 : 0)
ulong temp12 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp12
scc = temp12 >> 32
uint temp13 = (ulong)v3 + (ulong)s0 // v_add_u32
v2 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp13 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask11 ? 1 : 0)
uint temp14 = (ulong)0 + (ulong)v14 + cc4
vcc = 0
v3 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask11) | ((temp14 >> 32) ? mask11 : 0)
uint temp15 = (ulong)s4 + (ulong)v12 // v_add_u32
v12 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = 0
ulong mask12 = (1ULL<<LANEID)
vcc = (vcc&~mask12) | ((temp15 >> 32) ? mask12 : 0)
ulong mask13 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask13 ? 1 : 0)
uint temp16 = (ulong)s5 + (ulong)v13 + cc5
vcc = 0
v13 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = (vcc&~mask13) | ((temp16 >> 32) ? mask13 : 0)
*(ulong*)(v[18:19] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[0:1] + 0 + 0) = v[10:11] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s7 = s8 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
v4 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s6 = s0 & -16 // s_and_b32
scc = s6 != 0
s10 = s0 >> (4 & 31) // s_lshr_b32
scc = s10!= 0
s[6:7] = (uint)s0 > (uint)s6 // v_cmp_gt_u32
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
ulong temp3 = (ulong)s10 + (ulong)0 + scc // s_addc_u32
s6 = temp3
scc = temp3 >> 32
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
ulong temp4 = (ulong)s6 + (ulong)s0 // s_add_u32
s6 = temp4
scc = temp4 >> 32
ulong temp5 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s7 = temp5
scc = temp5 >> 32
s0 = s1 & -2 // s_and_b32
scc = s0 != 0
s3 = s1 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
uint temp6 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp6 >> 32) ? mask3 : 0)
v[4:5] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask4) | ((temp7 >> 32) ? mask4 : 0)
uint temp8 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp8 >> 32) ? mask5 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong temp10 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
v6 = s6 // v_mov_b32
ulong temp11 = (ulong)s0 + (ulong)s1 // s_add_u32
s0 = temp11
scc = temp11 >> 32
ulong temp12 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp12
scc = temp12 >> 32
s3 = s2 & -2 // s_and_b32
scc = s3 != 0
s8 = s2 >> (1 & 31) // s_lshr_b32
scc = s8!= 0
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
v9 = s1 // v_mov_b32
v8 = s0 // v_mov_b32
uint temp13 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp13 >> 32) ? mask7 : 0)
v7 = s7 // v_mov_b32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp14 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = (vcc&~mask8) | ((temp14 >> 32) ? mask8 : 0)
ulong temp15 = (ulong)s8 + (ulong)0 + scc // s_addc_u32
s3 = temp15
scc = temp15 >> 32
ulong temp16 = (ulong)s3 + (ulong)s2 // s_add_u32
s0 = temp16
scc = temp16 >> 32
ulong temp17 = (ulong)0 + (ulong)0 + scc // s_addc_u32
s1 = temp17
scc = temp17 >> 32
v11 = s1 // v_mov_b32
v10 = s0 // v_mov_b32
*(ulong*)(v[0:1] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s11 = s9 << (1 & 31) // s_lshl_b32
scc = s11!= 0
s10 = s10 << (2 & 31) // s_lshl_b32
scc = s10!= 0
v4 = 0 // v_mov_b32
s7 = 0 // s_mov_b32
s9 = s7 // s_mov_b32
v6 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
s8 = s0 & -2 // s_and_b32
scc = s8 != 0
uint temp0 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[8:9] = (uint)s0 > (uint)s8 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s11 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s10 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s6 = temp3
scc = temp3 >> 32
s0 = s1 & -2 // s_and_b32
scc = s0 != 0
v[2:3] = v[5:6] << (3&63) // v_lshlrev_b64
s[0:1] = (uint)s1 > (uint)s0 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v15 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[5:6] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v16 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v2 // v_add_u32
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong temp7 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s8 = temp7
scc = temp7 >> 32
s0 = s2 & -4 // s_and_b32
scc = s0 != 0
s1 = s2 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
s[0:1] = (uint)s2 > (uint)s0 // v_cmp_gt_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v3 + cc1
vcc = 0
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v6 + cc2
vcc = 0
v6 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong temp11 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s10 = temp11
scc = temp11 >> 32
s[0:1] = s[6:7] << (1 & 63) // s_lshl_b64
scc = s[0:1]!= 0
s[2:3] = s[8:9] << (1 & 63) // s_lshl_b64
scc = s[2:3]!= 0
v10 = s1 // v_mov_b32
v9 = s0 // v_mov_b32
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v12 = s3 // v_mov_b32
v11 = s2 // v_mov_b32
v3 = s0 // v_mov_b32
*(ulong*)(v[15:16] + 0 + 0) = v[9:10] // global_store_dwordx2
*(ulong*)(v[1:2] + 0 + 0) = v[11:12] // global_store_dwordx2
*(ulong*)(v[5:6] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
global_load_ushort v7, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
v11 = 0 // v_mov_b32
v6 = v4 // v_mov_b32
s7 = s0 & -2 // s_and_b32
scc = s7 != 0
uint temp0 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[7:8] = (uint)s0 > (uint)s7 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[2:3] = v[3:4] << (3&63) // v_lshlrev_b64
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
v1 = v4 // v_mov_b32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
v[4:5] = v[5:6] << (3&63) // v_lshlrev_b64
s[6:7] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
uint temp4 = (ulong)s4 + (ulong)v2 // v_add_u32
v12 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v[0:1] = v[0:1] << (3&63) // v_lshlrev_b64
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v13 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong temp7 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp7
scc = temp7 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask6) | ((temp8 >> 32) ? mask6 : 0)
uint temp9 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp9 >> 32) ? mask7 : 0)
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask8) | ((temp10 >> 32) ? mask8 : 0)
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong temp11 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp11
scc = temp11 >> 32
s_waitcnt       vmcnt(0)
v10 = 0xffff & v7 // v_and_b32
uint temp12 = (ulong)s0 + (ulong)v10 // v_add_u32
v6 = CLAMP ? min(temp12, 0xffffffff) : temp12
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp12 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask10 ? 1 : 0)
uint temp13 = (ulong)0 + (ulong)v11 + cc3
vcc = 0
v7 = CLAMP ? min(temp13, 0xffffffff) : temp13
vcc = (vcc&~mask10) | ((temp13 >> 32) ? mask10 : 0)
uint temp14 = (ulong)s1 + (ulong)v10 // v_add_u32
v8 = CLAMP ? min(temp14, 0xffffffff) : temp14
vcc = 0
ulong mask11 = (1ULL<<LANEID)
vcc = (vcc&~mask11) | ((temp14 >> 32) ? mask11 : 0)
ulong mask12 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask12 ? 1 : 0)
uint temp15 = (ulong)0 + (ulong)v11 + cc4
vcc = 0
v9 = CLAMP ? min(temp15, 0xffffffff) : temp15
vcc = (vcc&~mask12) | ((temp15 >> 32) ? mask12 : 0)
uint temp16 = (ulong)s2 + (ulong)v10 // v_add_u32
v10 = CLAMP ? min(temp16, 0xffffffff) : temp16
vcc = 0
ulong mask13 = (1ULL<<LANEID)
vcc = (vcc&~mask13) | ((temp16 >> 32) ? mask13 : 0)
ulong mask14 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask14 ? 1 : 0)
uint temp17 = (ulong)0 + (ulong)v11 + cc5
vcc = 0
v11 = CLAMP ? min(temp17, 0xffffffff) : temp17
vcc = (vcc&~mask14) | ((temp17 >> 32) ? mask14 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[6:7] // global_store_dwordx2
*(ulong*)(v[2:3] + 0 + 0) = v[8:9] // global_store_dwordx2
*(ulong*)(v[0:1] + 0 + 0) = v[10:11] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v10, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
v[6:7] = v[8:9] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v6 // v_add_u32
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v2 = s6 + v10 // v_add_nc_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[8:9] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v8, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s3 = s9 << (4 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s3 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s3 = s10 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[6:7] = v[6:7] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v6 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v7 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v2 = s0 + v8 // v_add_nc_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v2 = s2 + v8 // v_add_nc_u32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s1 + v8 // v_add_nc_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v15 = 0 // v_mov_b32
s3 = s8 << (3 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v11, v[3:4], off inst_offset:2
v6 = v15 // v_mov_b32
v8 = v15 // v_mov_b32
v10 = v15 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v7 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v[5:6] = v[5:6] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[7:8] = v[7:8] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v8 + cc1
vcc = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v14 = v0 + v11 // v_add_nc_u32
*(ulong*)(v[4:5] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = v1 + v11 // v_add_nc_u32
v[0:1] = v[9:10] << (3&63) // v_lshlrev_b64
*(ulong*)(v[7:8] + 0 + 0) = v[14:15] // global_store_dwordx2
v14 = v2 + v11 // v_add_nc_u32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[14:15] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v8, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (4 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[6:7] = v[6:7] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v6 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v7 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v2 = s8 + v8 // v_add_nc_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v2 = s9 + v8 // v_add_nc_u32
uint temp7 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s10 + v8 // v_add_nc_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v8, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[6:7] = v[6:7] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v[4:5] = v[4:5] << (3&63) // v_lshlrev_b64
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v6 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v7 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v2 = 2 + v8 // v_add_nc_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v2 = 4 + v8 // v_add_nc_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v5 = (s9 << 1) | v1 // v_lshl_or_b32
v7 = (s10 << 2) | v2 // v_lshl_or_b32
global_load_ushort v13, v[3:4], off inst_offset:2
v4 = 0 // v_mov_b32
v3 = (s8 << 1) | v0 // v_lshl_or_b32
v1 = v4 // v_mov_b32
v8 = v4 // v_mov_b32
v2 = v4 // v_mov_b32
v0 = s2 + v5 // v_add_nc_u32
v[5:6] = v[3:4] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
v7 = s1 + v7 // v_add_nc_u32
v[9:10] = v[0:1] << (3&63) // v_lshlrev_b64
uint temp0 = (ulong)s4 + (ulong)v5 // v_add_u32
v15 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v[11:12] = v[7:8] << (3&63) // v_lshlrev_b64
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)v6 + cc0
vcc = 0
v16 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v9 // v_add_u32
v9 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v10 + cc1
vcc = 0
v10 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s_waitcnt       vmcnt(0)
uint temp4 = (ulong)v13 + (ulong)s0 + (ulong)v3 // v_add3_u32
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask4 = (1ULL<<LANEID)
v3 = v13 + v0 // v_add_nc_u32
*(ulong*)(v[15:16] + 0 + 0) = v[1:2] // global_store_dwordx2
*(ulong*)(v[9:10] + 0 + 0) = v[3:4] // global_store_dwordx2
uint temp5 = (ulong)s4 + (ulong)v11 // v_add_u32
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v3 = v13 + v7 // v_add_nc_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v12 + cc2
vcc = 0
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(ulong*)(v[1:2] + 0 + 0) = v[3:4] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[12:13] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[4:7][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v8, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[6:7] = v[6:7] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s12 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s13 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s12 + (ulong)v6 // v_add_u32
v12 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s13 + (ulong)v7 + cc1
vcc = 0
v13 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v2 = s4 + v8 // v_add_nc_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v2 = s5 + v8 // v_add_nc_u32
uint temp7 = (ulong)s12 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
*(ulong*)(v[12:13] + 0 + 0) = v[2:3] // global_store_dwordx2
v2 = s6 + v8 // v_add_nc_u32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s13 + (ulong)v1 + cc2
vcc = 0
v1 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v10, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s1 = s14 & -4 // s_and_b32
scc = s1 != 0
s_waitcnt       vmcnt(0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s0 + (ulong)v10 + cc1
vcc = 0
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = 0
ulong mask6 = (1ULL<<LANEID)
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s0 = s14 >> (2 & 31) // s_lshr_b32
scc = s0!= 0
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)v5 + cc2
vcc = 0
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
v[0:1] = v[8:9] << (3&63) // v_lshlrev_b64
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s2 + (ulong)v10 + cc3
vcc = 0
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
vcc = (uint)s14 > (uint)s1 // v_cmp_gt_u32
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s0 + (ulong)v10 + cc4
vcc = 0
v2 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
uint temp10 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask10 = (1ULL<<LANEID)
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)v1 + cc5
vcc = 0
v1 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v10, v[3:4], off inst_offset:2
v3 = 0 // v_mov_b32
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v5 = v3 // v_mov_b32
v7 = v3 // v_mov_b32
v9 = v3 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v6 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v8 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v[0:1] = v[4:5] << (3&63) // v_lshlrev_b64
v[4:5] = v[6:7] << (3&63) // v_lshlrev_b64
v[6:7] = v[8:9] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask3 = (1ULL<<LANEID)
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v1 + cc0
vcc = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = 0
ulong mask5 = (1ULL<<LANEID)
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)v5 + cc1
vcc = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v6 // v_add_u32
v8 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)v7 + cc2
vcc = 0
v9 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = (vcc&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v2 = 0xffff & v10 // v_and_b32
v[2:3] = v[2:3] << (1&63) // v_lshlrev_b64
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[4:5] + 0 + 0) = v[2:3] // global_store_dwordx2
*(ulong*)(v[8:9] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s6 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
s3 = (int)s2 >> (31 & 31) // s_ashr_i32
scc = s3!=0
v2 = s2 // v_mov_b32
v[0:1] = v[0:1] << (3&63) // v_lshlrev_b64
v3 = s3 // v_mov_b32
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
*(ulong*)(v[0:1] + 0 + 0) = v[2:3] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v0 = s2 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v0 = v0 << (1&31) // v_lshlrev_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s6 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v0 = s2 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[2:3] = v[0:1] << (3&63) // v_lshlrev_b64
v0 = 0x80 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
v0 = (s6 << 6) | v0 // v_lshl_or_b32
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v2 = s2 + v0 // v_add_nc_u32
v[3:4] = v[2:3] << (3&63) // v_lshlrev_b64
v0 = v2 << (1&31) // v_lshlrev_b32
uint temp0 = (ulong)s0 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = 0
ulong mask0 = (1ULL<<LANEID)
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp1 = (ulong)s1 + (ulong)v4 + cc0
vcc = 0
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s4 = s8 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v0 = s2 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s4 = s8 << (6 & 31) // s_lshl_b32
scc = s4!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s5 = s2 & 0xffffffc0 // s_and_b32
scc = s5 != 0
uint temp0 = (ulong)s3 + (ulong)s4 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[5:6] = (uint)s2 > (uint)s5 // v_cmp_gt_u32
s2 = s2 >> (6 & 31) // s_lshr_b32
scc = s2!= 0
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
ulong temp1 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp1
scc = temp1 >> 32
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
uint temp2 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
v0 = s2 // v_mov_b32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (6 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v4, v[1:2], off inst_offset:2
v1 = 0 // v_mov_b32
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s_waitcnt       vmcnt(0)
v0 = 0xffff & v4 // v_and_b32
v[0:1] = v[0:1] << (1&63) // v_lshlrev_b64
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v2 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v4 = v2 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s7 << (3 & 31) // s_lshl_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
ulong temp1 = (ulong)s2 + (ulong)s1 // s_add_i32
s1 = temp1
scc = temp1 >> 32
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v1 // v_add3_u32
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask1 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[1:2] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
s1 = s6 << (3 & 31) // s_lshl_b32
scc = s1!= 0
v3 = v1 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s2 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v0 = s0 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp2 = (ulong)s4 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v2 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v1 = v1 + v0 // v_add_nc_u32
v4 = v2 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[1:2] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
ulong temp0 = (ulong)s7 + (ulong)s6 // s_add_i32
s7 = temp0
scc = temp0 >> 32
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask0 = (1ULL<<LANEID)
v0 = s7 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp2 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v1 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v[2:3] = v[0:1] << (3&63) // v_lshlrev_b64
v0 = 16 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v2 = 0 // v_mov_b32
v0 = (s6 << 3) | v0 // v_lshl_or_b32
v4 = v2 // v_mov_b32
s_waitcnt       lgkmcnt(0)
v3 = s0 + v0 // v_add_nc_u32
s0 = s7 << (3 & 31) // s_lshl_b32
scc = s0!= 0
ulong temp0 = (ulong)s2 + (ulong)s0 // s_add_i32
s0 = temp0
scc = temp0 >> 32
v[4:5] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s0 + (ulong)v1 + (ulong)v3 // v_add3_u32
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask0 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v4 // v_add_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)v5 + cc0
vcc = 0
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(ulong*)(v[3:4] + 0 + 0) = v[1:2] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s4 = s8 << (3 & 31) // s_lshl_b32
scc = s4!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s9 + (ulong)s4 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s1 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v0 = s0 // v_mov_b32
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
uint temp2 = (ulong)s2 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)v3 + cc0
vcc = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = 0 // v_mov_b32
s4 = s8 << (3 & 31) // s_lshl_b32
scc = s4!= 0
v3 = v1 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s9 + (ulong)s4 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s5 = s0 & -8 // s_and_b32
scc = s5 != 0
s4 = s0 >> (3 & 31) // s_lshr_b32
scc = s4!= 0
s[0:1] = (uint)s0 > (uint)s5 // v_cmp_gt_u32
s7 = s1 & -8 // s_and_b32
scc = s7 != 0
v[2:3] = v[2:3] << (3&63) // v_lshlrev_b64
vcc = (uint)s1 > (uint)s7 // v_cmp_gt_u32
s6 = s1 >> (3 & 31) // s_lshr_b32
scc = s6!= 0
v0 = s[0:1]&(1ULL<<LANEID) ? 1 : 0 // v_cndmask_b32
ulong temp1 = (ulong)s6 + (ulong)s4 // s_add_i32
s6 = temp1
scc = temp1 >> 32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask1 ? 1 : 0)
uint temp2 = (ulong)s6 + (ulong)v0 + cc0
vcc = 0
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask1) | ((temp2 >> 32) ? mask1 : 0)
uint temp3 = (ulong)s2 + (ulong)v2 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = 0
ulong mask2 = (1ULL<<LANEID)
vcc = (vcc&~mask2) | ((temp3 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask3 ? 1 : 0)
uint temp4 = (ulong)s3 + (ulong)v3 + cc1
vcc = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = (vcc&~mask3) | ((temp4 >> 32) ? mask3 : 0)
*(ulong*)(v[2:3] + 0 + 0) = v[0:1] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v2 = s4 // v_mov_b32
v3 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s_waitcnt       lgkmcnt(0)
s1 = s8 << (3 & 31) // s_lshl_b32
scc = s1!= 0
global_load_ushort v5, v[2:3], off inst_offset:2
v2 = 0 // v_mov_b32
v4 = v2 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (3 & 31) // s_lshl_b32
scc = s0!= 0
v[3:4] = v[3:4] << (3&63) // v_lshlrev_b64
uint temp1 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
vcc = 0
ulong mask1 = (1ULL<<LANEID)
vcc = (vcc&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)v4 + cc0
vcc = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
vcc = (vcc&~mask2) | ((temp2 >> 32) ? mask2 : 0)
s_waitcnt       vmcnt(0)
v0 = s2 + v5 // v_add_nc_u32
uint temp3 = (ulong)v0 + (ulong)s0 + (ulong)v1 // v_add3_u32
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask3 = (1ULL<<LANEID)
*(ulong*)(v[3:4] + 0 + 0) = v[1:2] // global_store_dwordx2
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s4 = s6 << (6 & 31) // s_lshl_b32
scc = s4!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s3 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s3 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s6 << (3 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v6 = s3 + v0 // v_add_nc_u32
v9 = s3 + v1 // v_add_nc_u32
v11 = s3 + v2 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s9 = s6 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s7 << (4 & 31) // s_lshl_b32
scc = s10!= 0
s11 = s8 << (1 & 31) // s_lshl_b32
scc = s11!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s11 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s9 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s6 + (ulong)s3 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s10 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s7 + (ulong)s3 // s_add_i32
s1 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s8 + (ulong)s3 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s6 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s3 + (ulong)4 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v7 = s0 // v_mov_b32
v6 = s3 + 2 // v_add_nc_u16
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask4) | ((temp5 >> 32) ? mask4 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v11 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v12 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask6) | ((temp7 >> 32) ? mask6 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp8 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask8) | ((temp9 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[11:12] + 0) = v6 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v7 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v6 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v9 = s3 + v3 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v11 = s3 + v4 // v_add_nc_u32
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s10 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s12 + (ulong)s1 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s13 + (ulong)s1 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s14 + (ulong)s1 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s6 = s13 & -2 // s_and_b32
scc = s6 != 0
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s[6:7] = (uint)s13 > (uint)s6 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s7 = s14 >> (2 & 31) // s_lshr_b32
scc = s7!= 0
s8 = s14 & -4 // s_and_b32
scc = s8 != 0
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s8 // v_cmp_gt_u32
ulong temp3 = (ulong)s0 + (ulong)s3 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s2 + (ulong)s3 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[8:9] = 0
ulong mask3 = (1ULL<<LANEID)
s[8:9] = (s[8:9]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask4 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = 0
ulong mask5 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s0 // v_mov_b32
ulong temp8 = (ulong)s7 + (ulong)s3 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[8:9]&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc0
s[8:9] = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[8:9] = (s[8:9]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[2:3] = (s[2:3]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0

v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (1 & 31) // s_lshl_b32
scc = s4!= 0
global_load_ushort v1, v[1:2], off inst_offset:2
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
s_waitcnt       vmcnt(0)
v2 = s3 + v1 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s3 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s3 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s0 << (1 & 31) // s_lshl_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v9 = s2 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s0 = s1 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = (s[1:2]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v6 = s0 + v0 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s2 + v1 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v11 = s1 + v2 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s0 + (ulong)s6 // s_add_i32
s0 = temp2
scc = temp2 >> 32
s_waitcnt       lgkmcnt(0)
uint temp3 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s2 + (ulong)s7 // s_add_i32
s2 = temp5
scc = temp5 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s2 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s8 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s0 + (ulong)2 // s_add_i32
s0 = temp2
scc = temp2 >> 32
s_waitcnt       lgkmcnt(0)
uint temp3 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s2 + (ulong)2 // s_add_i32
s2 = temp5
scc = temp5 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s2 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)4 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v3 = s2 + v1 // v_add_nc_u32
v6 = (s0 << 1) + v0 // v_lshl_add_u32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v4 = s1 + v2 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v9 = s2 + v3 // v_add_nc_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v11 = s1 + v4 // v_add_nc_u32
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s12 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s13 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s14 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s6 = s12 & -2 // s_and_b32
scc = s6 != 0
s8 = s13 & -2 // s_and_b32
scc = s8 != 0
s[6:7] = (uint)s12 > (uint)s6 // v_cmp_gt_u32
s[8:9] = (uint)s13 > (uint)s8 // v_cmp_gt_u32
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s3 = s12 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
s7 = s13 >> (1 & 31) // s_lshr_b32
scc = s7!= 0
s9 = s14 >> (2 & 31) // s_lshr_b32
scc = s9!= 0
s10 = s14 & -4 // s_and_b32
scc = s10 != 0
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
s[6:7] = (uint)s14 > (uint)s10 // v_cmp_gt_u32
ulong temp3 = (ulong)s0 + (ulong)s3 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s2 + (ulong)s7 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[3:4] = 0
ulong mask3 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask4 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
v9 = s0 // v_mov_b32
ulong temp7 = (ulong)s1 + (ulong)s9 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask5 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask5) | ((temp8 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[3:4]&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc0
s[3:4] = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[3:4] = (s[3:4]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[2:3] = (s[2:3]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s3 = s10 << (2 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[3:4] = 0
ulong mask3 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[3:4]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[3:4] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[3:4] = (s[3:4]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[3:4] = 0
ulong mask5 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[3:4]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[3:4] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[3:4] = (s[3:4]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[3:4] = 0
ulong mask7 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[3:4]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[3:4] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[3:4] = (s[3:4]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = s0 + v6 // v_add_nc_u32
v8 = s2 + v6 // v_add_nc_u32
v6 = s1 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v6 = s3 + v0 // v_add_nc_u32
v9 = s3 + v1 // v_add_nc_u32
v11 = s3 + v2 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v6 = s0 + v0 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v9 = s2 + v1 // v_add_nc_u32
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v11 = s1 + v2 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v6 = v0 << (1&15) // v_lshlrev_b16
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v9 = v1 << (1&15) // v_lshlrev_b16
v11 = v2 << (1&15) // v_lshlrev_b16
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v6 = v0 + s6 // v_add_nc_u16
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v9 = v1 + s7 // v_add_nc_u16
v11 = v2 + s8 // v_add_nc_u16
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
v6 = 2 | v0 // v_or_b32
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (2 & 31) // s_lshl_b32
scc = s7!= 0
v9 = 2 | v1 // v_or_b32
v11 = 4 | v2 // v_or_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s7 << 1) | v1 // v_lshl_or_b32
v5 = (s6 << 1) | v0 // v_lshl_or_b32
v4 = (s8 << 2) | v2 // v_lshl_or_b32
v6 = s2 + v3 // v_add_nc_u32
uint temp0 = (ulong)v5 + (ulong)v0 + (ulong)s0 // v_add3_u32
v10 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s4 + (ulong)v5 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v7 = s1 + v4 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)s4 + (ulong)v6 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v15 = v6 + v1 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v7 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v11 = v7 + v2 // v_add_nc_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[0:1] + 0) = v15 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v7 = s12 + v0 // v_add_nc_u16
v10 = s13 + v1 // v_add_nc_u16
v11 = s14 + v2 // v_add_nc_u16
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v6 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s7 = s0 & -2 // s_and_b32
scc = s7 != 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[7:8] = (uint)s0 > (uint)s7 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s12 + (ulong)s6 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s7 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
v10 = s0 + v0 // v_add_nc_u16
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
uint temp4 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[6:7] = 0
ulong mask3 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[6:7]&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc0
s[6:7] = 0
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[6:7] = (s[6:7]&~mask4) | ((temp5 >> 32) ? mask4 : 0)
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[6:7] = 0
ulong mask5 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong temp7 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s0 = temp7
scc = temp7 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
v11 = s0 + v1 // v_add_nc_u16
vcc = (uint)s2 > (uint)s3 // v_cmp_gt_u32
uint temp8 = (ulong)s4 + (ulong)v7 // v_add_u32
v0 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
s1 = s2 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[6:7]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[6:7] = 0
v6 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[6:7] = (s[6:7]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v1 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = (s[0:1]&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp11 = (ulong)s1 + (ulong)v2 + cc3
vcc = 0
v2 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask9) | ((temp11 >> 32) ? mask9 : 0)
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v15, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = v15 + v0 // v_add_nc_u16
v11 = v15 + v1 // v_add_nc_u16
v2 = v15 + v2 // v_add_nc_u16
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
*(uint32*)(v[7:8] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s9 = s6 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s7 << (1 & 31) // s_lshl_b32
scc = s10!= 0
s11 = s8 << (1 & 31) // s_lshl_b32
scc = s11!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s11 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s9 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s3 + (ulong)s6 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s10 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s3 + (ulong)s7 // s_add_i32
s1 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s3 + (ulong)s8 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s0 + (ulong)s6 // s_add_i32
s0 = temp2
scc = temp2 >> 32
s_waitcnt       lgkmcnt(0)
uint temp3 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s2 + (ulong)s7 // s_add_i32
s2 = temp5
scc = temp5 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s2 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s8 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v6 = s6 + v0 // v_add_nc_u16
s9 = s7 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
v9 = s7 + v1 // v_add_nc_u16
v11 = s8 + v2 // v_add_nc_u16
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v6 = s3 // v_mov_b32
v9 = s7 // v_mov_b32
v11 = s8 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (2 & 31) // s_lshl_b32
scc = s10!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_i32
s6 = temp0
scc = temp0 >> 32
ulong temp1 = (ulong)s7 + (ulong)2 // s_add_i32
s7 = temp1
scc = temp1 >> 32
v6 = s6 // v_mov_b32
v9 = s7 // v_mov_b32
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask0 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp4 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask2 = (1ULL<<LANEID)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s8 + (ulong)4 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
v3 = s2 + v1 // v_add_nc_u32
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v6 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v4 = s1 + v2 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v9 = s7 + v3 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v11 = s8 + v4 // v_add_nc_u32
uint temp5 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s12 + (ulong)s8 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s13 + (ulong)s9 // s_add_i32
s1 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s14 + (ulong)s10 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp3 = (ulong)s8 + (ulong)s0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s9 + (ulong)s2 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[7:8] = 0
ulong mask3 = (1ULL<<LANEID)
s[7:8] = (s[7:8]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask4 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = 0
ulong mask5 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s0 // v_mov_b32
ulong temp8 = (ulong)s10 + (ulong)s6 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[7:8]&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc0
s[7:8] = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[7:8] = (s[7:8]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[2:3] = (s[2:3]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = 0xffff & v6 // v_and_b32
v6 = s10 + v6 // v_add_nc_u32
v11 = s8 + v7 // v_add_nc_u32
v9 = s9 + v7 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v11 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s6 = s6 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s7 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s8 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s3 + (ulong)16 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v7 = s0 // v_mov_b32
v6 = s3 + 2 // v_add_nc_u16
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask4) | ((temp5 >> 32) ? mask4 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v11 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v12 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask6) | ((temp7 >> 32) ? mask6 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp8 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask8) | ((temp9 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[11:12] + 0) = v6 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s0 + (ulong)2 // s_add_i32
s0 = temp2
scc = temp2 >> 32
s_waitcnt       lgkmcnt(0)
uint temp3 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s2 + (ulong)16 // s_add_i32
s2 = temp5
scc = temp5 >> 32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s2 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)2 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v6 = 8 | v0 // v_or_b32
s6 = s7 << (2 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
v9 = 4 | v1 // v_or_b32
v11 = 2 | v2 // v_or_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s9 = s7 << (4 & 31) // s_lshl_b32
scc = s9!= 0
s10 = s8 << (1 & 31) // s_lshl_b32
scc = s10!= 0
ulong temp0 = (ulong)s6 + (ulong)2 // s_add_i32
s6 = temp0
scc = temp0 >> 32
ulong temp1 = (ulong)s7 + (ulong)16 // s_add_i32
s7 = temp1
scc = temp1 >> 32
v6 = s6 // v_mov_b32
v9 = s7 // v_mov_b32
uint temp2 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask0 = (1ULL<<LANEID)
uint temp3 = (ulong)s2 + (ulong)s9 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp4 = (ulong)s1 + (ulong)s10 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask2 = (1ULL<<LANEID)
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s8 + (ulong)2 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (1 & 31) // s_lshl_b32
scc = s6!= 0
v6 = 4 // v_mov_b32
v7 = 8 // v_mov_b32
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s8 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v11 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v12 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[11:12] + 0) = v6 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v7 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v3 = s0 + v0 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)v1 // v_add_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
uint temp1 = (ulong)s10 + (ulong)v2 // v_add_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v6 = v3 + 2 // v_add_nc_u16
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v9 = v4 + 2 // v_add_nc_u16
uint temp6 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v11 = v5 + 4 // v_add_nc_u16
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s12 + (ulong)16 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s13 + (ulong)2 // s_add_i32
s1 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s14 + (ulong)2 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp3 = (ulong)s0 + (ulong)2 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s2 + (ulong)2 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[7:8] = 0
ulong mask3 = (1ULL<<LANEID)
s[7:8] = (s[7:8]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask4 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = 0
ulong mask5 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s0 // v_mov_b32
ulong temp8 = (ulong)s6 + (ulong)4 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[7:8]&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc0
s[7:8] = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[7:8] = (s[7:8]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[2:3] = (s[2:3]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ubyte v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v9 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v10 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = v6 + 2 // v_add_nc_u16
v6 = 4 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[9:10] + 0) = v7 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v0 = (s6 << 4) | v0 // v_lshl_or_b32
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v2 = (s8 << 1) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v0 = s0 + v0 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
v11 = s3 + v4 // v_add_nc_u32
v6 = s3 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v9 = s3 + v3 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v1 = (s7 << 4) | v1 // v_lshl_or_b32
v2 = (s8 << 1) | v2 // v_lshl_or_b32
v0 = s0 + v0 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v6 = s0 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v9 = s2 + v3 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v11 = s1 + v4 // v_add_nc_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v3 = (s6 << 3) | v0 // v_lshl_or_b32
v4 = (s7 << 2) | v1 // v_lshl_or_b32
v5 = (s8 << 1) | v2 // v_lshl_or_b32
v3 = s0 + v3 // v_add_nc_u32
v6 = s2 + v4 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v5 = s1 + v5 // v_add_nc_u32
v10 = v3 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v15 = v6 + v1 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v6 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v11 = v5 + v2 // v_add_nc_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v6 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[0:1] + 0) = v15 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v1 = (s7 << 4) | v1 // v_lshl_or_b32
v2 = (s8 << 1) | v2 // v_lshl_or_b32
v0 = s0 + v0 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v6 = s6 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v9 = s7 + v3 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v11 = s8 + v4 // v_add_nc_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
uint temp1 = (ulong)s2 + (ulong)v1 // v_add_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s10 + (ulong)v2 // v_add_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
v6 = v0 + 2 // v_add_nc_u16
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v9 = v3 + 2 // v_add_nc_u16
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v11 = v4 + 4 // v_add_nc_u16
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[10:11] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 1) | v0 // v_lshl_or_b32
v1 = (s7 << 1) | v1 // v_lshl_or_b32
v2 = (s8 << 2) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v3 = s0 + v0 // v_add_nc_u32
uint temp0 = (ulong)s2 + (ulong)v1 // v_add_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
uint temp1 = (ulong)s10 + (ulong)v2 // v_add_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
v6 = v3 << (1&15) // v_lshlrev_b16
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
v9 = v4 << (1&15) // v_lshlrev_b16
uint temp6 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
v11 = v5 << (1&15) // v_lshlrev_b16
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
v0 = (s8 << 4) | v0 // v_lshl_or_b32
v1 = (s9 << 1) | v1 // v_lshl_or_b32
v2 = (s10 << 1) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v0 = s0 + v0 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
v11 = s14 + v4 // v_add_nc_u32
v6 = s12 + v0 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v9 = s13 + v3 // v_add_nc_u32
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v1 = (s9 << 1) | v1 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
v0 = s0 + v0 // v_add_nc_u32
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
v3 = s2 + v1 // v_add_nc_u32
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
ulong mask0 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask0 ? 1 : 0)
uint temp0 = (ulong)s0 + (ulong)v0 + cc0
vcc = 0
v6 = CLAMP ? min(temp0, 0xffffffff) : temp0
vcc = (vcc&~mask0) | ((temp0 >> 32) ? mask0 : 0)
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
uint temp1 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s2 + (ulong)v3 + cc2
vcc = 0
v9 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
vcc = (uint)s14 > (uint)s7 // v_cmp_gt_u32
uint temp4 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc3
s[0:1] = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask6 ? 1 : 0)
uint temp6 = (ulong)s6 + (ulong)v4 + cc4
vcc = 0
v11 = CLAMP ? min(temp6, 0xffffffff) : temp6
vcc = (vcc&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc5
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v1 = (s9 << 1) | v1 // v_lshl_or_b32
global_load_ushort v6, v[3:4], off inst_offset:2
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v7 = s0 + v0 // v_add_nc_u32
v8 = s2 + v1 // v_add_nc_u32
s_waitcnt       lgkmcnt(0)
v9 = s1 + v2 // v_add_nc_u32
uint temp0 = (ulong)s4 + (ulong)v7 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask1 ? 1 : 0)
uint temp1 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s4 + (ulong)v8 // v_add_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s4 + (ulong)v9 // v_add_u32
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = 0
ulong mask4 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask5 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
s_waitcnt       vmcnt(0)
v7 = v7 + v6 // v_add_nc_u32
v8 = v8 + v6 // v_add_nc_u32
v6 = v9 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s5 = s8 << (4 & 31) // s_lshl_b32
scc = s5!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s5 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s11 + (ulong)s1 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s12 + (ulong)s1 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s4 + (ulong)s1 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s5 = s8 << (1 & 31) // s_lshl_b32
scc = s5!= 0
s8 = s9 << (4 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s5 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s0 + (ulong)s3 // s_add_i32
s0 = temp3
scc = temp3 >> 32
ulong temp4 = (ulong)s2 + (ulong)s11 // s_add_i32
s2 = temp4
scc = temp4 >> 32
v6 = s0 // v_mov_b32
uint temp5 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s2 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong temp9 = (ulong)s1 + (ulong)s4 // s_add_i32
s0 = temp9
scc = temp9 >> 32
uint temp10 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
v11 = s0 // v_mov_b32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s5 = s8 << (3 & 31) // s_lshl_b32
scc = s5!= 0
s8 = s9 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
v7 = s3 + v0 // v_add_nc_u16
v10 = s11 + v1 // v_add_nc_u16
uint temp1 = (ulong)s0 + (ulong)s5 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v11 = s4 + v2 // v_add_nc_u16
uint temp3 = (ulong)s6 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v4 // v_add_u32
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)0 + cc2
s[0:1] = 0
v6 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s5 = s8 << (1 & 31) // s_lshl_b32
scc = s5!= 0
s12 = s9 << (4 & 31) // s_lshl_b32
scc = s12!= 0
s13 = s10 << (1 & 31) // s_lshl_b32
scc = s13!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s13 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s11 + (ulong)s9 // s_add_i32
s1 = temp1
scc = temp1 >> 32
uint temp2 = (ulong)s0 + (ulong)s5 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask1 = (1ULL<<LANEID)
ulong temp3 = (ulong)s3 + (ulong)s8 // s_add_i32
s0 = temp3
scc = temp3 >> 32
uint temp4 = (ulong)s2 + (ulong)s12 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
v9 = s1 // v_mov_b32
uint temp5 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
uint temp6 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[1:2] = 0
ulong mask4 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask5 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = 0
ulong mask6 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[1:2]&mask7 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)0 + cc1
s[1:2] = 0
v5 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = (s[1:2]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp10 = (ulong)s7 + (ulong)0 + cc2
s[0:1] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[0:1] = (s[0:1]&~mask8) | ((temp10 >> 32) ? mask8 : 0)
ulong temp11 = (ulong)s4 + (ulong)s10 // s_add_i32
s0 = temp11
scc = temp11 >> 32
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
ulong temp2 = (ulong)s12 + (ulong)2 // s_add_i32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s13 + (ulong)2 // s_add_i32
s1 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[0:1] = (s[0:1]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s14 + (ulong)4 // s_add_i32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v1 = (s9 << 1) | v1 // v_lshl_or_b32
v0 = (s8 << 1) | v0 // v_lshl_or_b32
v2 = (s10 << 2) | v2 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v4 = s1 + v2 // v_add_nc_u32
v3 = s2 + v1 // v_add_nc_u32
uint temp0 = (ulong)s3 + (ulong)s0 + (ulong)v0 // v_add3_u32
v6 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
v11 = s4 + v4 // v_add_nc_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
uint temp3 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v9 = s11 + v3 // v_add_nc_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s10 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s12 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
v6 = s0 // v_mov_b32
s1 = s13 << (1 & 31) // s_lshl_b32
scc = s1!= 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
v9 = s1 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
s0 = s14 << (1 & 31) // s_lshl_b32
scc = s0!= 0
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = (s[1:2]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s[3:4] = (uint)s13 > (uint)s3 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
s[1:2] = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong temp3 = (ulong)s12 + (ulong)s0 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
v6 = s0 // v_mov_b32
ulong temp4 = (ulong)s13 + (ulong)s2 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[7:8] = 0
ulong mask3 = (1ULL<<LANEID)
s[7:8] = (s[7:8]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask4 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = 0
ulong mask5 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s0 // v_mov_b32
ulong temp8 = (ulong)s14 + (ulong)s6 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[7:8]&mask6 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc0
s[7:8] = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[7:8] = (s[7:8]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[2:3] = (s[2:3]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
s9 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s6 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s6 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s6 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = 0xffff & v6 // v_and_b32
v6 = s4 + v6 // v_add_nc_u32
v11 = s9 + v7 // v_add_nc_u32
v9 = s11 + v7 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v11 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s13 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s7 = s8 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s14 = s11 & -16 // s_and_b32
scc = s14 != 0
s10 = s11 >> (4 & 31) // s_lshr_b32
scc = s10!= 0
s[6:7] = (uint)s11 > (uint)s14 // v_cmp_gt_u32
uint temp0 = (ulong)s0 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[2:3] = 0
ulong mask3 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong temp4 = (ulong)s12 + (ulong)s10 + scc // s_addc_u32
s6 = temp4
scc = temp4 >> 32
s10 = s13 & -2 // s_and_b32
scc = s10 != 0
s0 = s13 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s[10:11] = (uint)s13 > (uint)s10 // v_cmp_gt_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[2:3]&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc0
s[2:3] = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[2:3] = (s[2:3]&~mask4) | ((temp5 >> 32) ? mask4 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask5 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
v6 = s6 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[2:3] = (s[2:3]&~mask6) | ((temp7 >> 32) ? mask6 : 0)
scc = (uint)s10 != (uint)0x0 // s_cmpk_lg_u32
ulong temp8 = (ulong)s12 + (ulong)s0 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
s1 = s3 & -2 // s_and_b32
scc = s1 != 0
s2 = s3 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s[1:2] = (uint)s3 > (uint)s1 // v_cmp_gt_u32
v9 = s0 // v_mov_b32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s12 + (ulong)s2 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (4 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s13 = s11 & -2 // s_and_b32
scc = s13 != 0
s10 = s11 >> (1 & 31) // s_lshr_b32
scc = s10!= 0
s[6:7] = (uint)s11 > (uint)s13 // v_cmp_gt_u32
uint temp0 = (ulong)s0 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)s10 + scc // s_addc_u32
s6 = temp3
scc = temp3 >> 32
s10 = s1 & -16 // s_and_b32
scc = s10 != 0
s0 = s1 >> (4 & 31) // s_lshr_b32
scc = s0!= 0
s[10:11] = (uint)s1 > (uint)s10 // v_cmp_gt_u32
v6 = s6 // v_mov_b32
scc = (uint)s10 != (uint)0x0 // s_cmpk_lg_u32
ulong temp4 = (ulong)s2 + (ulong)s0 + scc // s_addc_u32
s0 = temp4
scc = temp4 >> 32
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp5 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[2:3] = 0
ulong mask3 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask3) | ((temp5 >> 32) ? mask3 : 0)
s[1:2] = (uint)s12 > (uint)s1 // v_cmp_gt_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[2:3]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[2:3] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = (s[2:3]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[2:3] = 0
ulong mask5 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s0 // v_mov_b32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask6 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[2:3] = (s[2:3]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
s2 = s12 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s3 + (ulong)s2 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s5 = s8 << (3 & 31) // s_lshl_b32
scc = s5!= 0
s8 = s9 << (2 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
v8 = 0 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s9 + (ulong)v2 // v_add3_u32
v6 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s3 >> (3 & 31) // s_lshr_b32
scc = s1!= 0
uint temp1 = (ulong)s0 + (ulong)s5 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s3 & -8 // s_and_b32
scc = s0 != 0
uint temp2 = (ulong)s2 + (ulong)s8 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
vcc = (uint)s3 > (uint)s0 // v_cmp_gt_u32
s2 = s4 & -4 // s_and_b32
scc = s2 != 0
s0 = s11 & -2 // s_and_b32
scc = s0 != 0
s3 = s11 >> (1 & 31) // s_lshr_b32
scc = s3!= 0
s[0:1] = (uint)s11 > (uint)s0 // v_cmp_gt_u32
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((vcc&mask3 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)v0 + cc0
vcc = 0
v10 = CLAMP ? min(temp3, 0xffffffff) : temp3
vcc = (vcc&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s6 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
vcc = 0
ulong mask4 = (1ULL<<LANEID)
vcc = (vcc&~mask4) | ((temp4 >> 32) ? mask4 : 0)
s1 = s4 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((vcc&mask5 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)v8 + cc1
vcc = 0
v4 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask5) | ((temp5 >> 32) ? mask5 : 0)
vcc = (uint)s4 > (uint)s2 // v_cmp_gt_u32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong temp6 = (ulong)s3 + (ulong)0 + scc // s_addc_u32
s0 = temp6
scc = temp6 >> 32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask6 ? 1 : 0)
uint temp7 = (ulong)s1 + (ulong)v1 + cc2
vcc = 0
v15 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
uint temp8 = (ulong)s6 + (ulong)v5 // v_add_u32
v0 = CLAMP ? min(temp8, 0xffffffff) : temp8
vcc = 0
ulong mask7 = (1ULL<<LANEID)
vcc = (vcc&~mask7) | ((temp8 >> 32) ? mask7 : 0)
v11 = s0 + v2 // v_add_nc_u16
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask8 ? 1 : 0)
uint temp9 = (ulong)s7 + (ulong)v8 + cc3
vcc = 0
v1 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask8) | ((temp9 >> 32) ? mask8 : 0)
uint temp10 = (ulong)s6 + (ulong)v6 // v_add_u32
v5 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = 0
ulong mask9 = (1ULL<<LANEID)
vcc = (vcc&~mask9) | ((temp10 >> 32) ? mask9 : 0)
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v8 + cc4
vcc = 0
v6 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask10) | ((temp11 >> 32) ? mask10 : 0)
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[0:1] + 0) = v15 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s14 = s10 << (1 & 31) // s_lshl_b32
scc = s14!= 0
s13 = s11 & -2 // s_and_b32
scc = s13 != 0
s[6:7] = (uint)s11 > (uint)s13 // v_cmp_gt_u32
s13 = s9 << (4 & 31) // s_lshl_b32
scc = s13!= 0
s11 = s11 >> (1 & 31) // s_lshr_b32
scc = s11!= 0
uint temp0 = (ulong)s0 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s2 + (ulong)s13 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s14 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
ulong temp3 = (ulong)s8 + (ulong)s11 + scc // s_addc_u32
s6 = temp3
scc = temp3 >> 32
s8 = s12 & -16 // s_and_b32
scc = s8 != 0
s0 = s12 >> (4 & 31) // s_lshr_b32
scc = s0!= 0
s[8:9] = (uint)s12 > (uint)s8 // v_cmp_gt_u32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[2:3] = 0
ulong mask3 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
v6 = s6 // v_mov_b32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[2:3]&mask4 ? 1 : 0)
uint temp5 = (ulong)s5 + (ulong)0 + cc0
s[2:3] = 0
v1 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[2:3] = (s[2:3]&~mask4) | ((temp5 >> 32) ? mask4 : 0)
uint temp6 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[2:3] = 0
ulong mask5 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
scc = (uint)s8 != (uint)0x0 // s_cmpk_lg_u32
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[2:3]&mask6 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[2:3] = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[2:3] = (s[2:3]&~mask6) | ((temp7 >> 32) ? mask6 : 0)
ulong temp8 = (ulong)s9 + (ulong)s0 + scc // s_addc_u32
s0 = temp8
scc = temp8 >> 32
s1 = s3 & -2 // s_and_b32
scc = s1 != 0
s2 = s3 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s[1:2] = (uint)s3 > (uint)s1 // v_cmp_gt_u32
v9 = s0 // v_mov_b32
scc = (uint)s1 != (uint)0x0 // s_cmpk_lg_u32
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = 0
ulong mask7 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s10 + (ulong)s2 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s11 = s0 & -2 // s_and_b32
scc = s11 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[6:7] = (uint)s0 > (uint)s11 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)2 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
v6 = s0 // v_mov_b32
s[6:7] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[6:7] = 0
ulong mask3 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s1 + (ulong)2 + scc // s_addc_u32
s1 = temp5
scc = temp5 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
s0 = s2 >> (2 & 31) // s_lshr_b32
scc = s0!= 0
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[6:7]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[6:7] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[6:7] = (s[6:7]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[6:7] = 0
ulong mask5 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s1 // v_mov_b32
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[6:7]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[6:7] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[6:7] = (s[6:7]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s0 + (ulong)4 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s11 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s4 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
v1 = (s9 << 1) | v1 // v_lshl_or_b32
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v3 = (s8 << 1) | v0 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
v5 = s1 + v2 // v_add_nc_u32
s5 = s11 & -2 // s_and_b32
scc = s5 != 0
v4 = s2 + v1 // v_add_nc_u32
s[5:6] = (uint)s11 > (uint)s5 // v_cmp_gt_u32
uint temp0 = (ulong)s6 + (ulong)v3 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[2:3] = 0
ulong mask0 = (1ULL<<LANEID)
s[2:3] = (s[2:3]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
s1 = s11 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask1 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[2:3]&mask1 ? 1 : 0)
uint temp1 = (ulong)s7 + (ulong)0 + cc0
s[2:3] = 0
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[2:3] = (s[2:3]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
ulong temp2 = (ulong)s0 + (ulong)s1 + scc // s_addc_u32
s0 = temp2
scc = temp2 >> 32
s2 = s3 & -2 // s_and_b32
scc = s2 != 0
v6 = s0 + v3 // v_add_nc_u32
vcc = (uint)s3 > (uint)s2 // v_cmp_gt_u32
uint temp3 = (ulong)s6 + (ulong)v4 // v_add_u32
v2 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp3 >> 32) ? mask2 : 0)
s1 = s3 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask3 ? 1 : 0)
uint temp4 = (ulong)s7 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
s0 = s4 & -4 // s_and_b32
scc = s0 != 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((vcc&mask4 ? 1 : 0)
uint temp5 = (ulong)s1 + (ulong)v4 + cc2
vcc = 0
v9 = CLAMP ? min(temp5, 0xffffffff) : temp5
vcc = (vcc&~mask4) | ((temp5 >> 32) ? mask4 : 0)
vcc = (uint)s4 > (uint)s0 // v_cmp_gt_u32
s1 = s4 >> (2 & 31) // s_lshr_b32
scc = s1!= 0
uint temp6 = (ulong)s6 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp6 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask6 ? 1 : 0)
uint temp7 = (ulong)s1 + (ulong)v5 + cc3
vcc = 0
v11 = CLAMP ? min(temp7, 0xffffffff) : temp7
vcc = (vcc&~mask6) | ((temp7 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((s[0:1]&mask7 ? 1 : 0)
uint temp8 = (ulong)s7 + (ulong)0 + cc4
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask7) | ((temp8 >> 32) ? mask7 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s3 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s7 = s8 << (4 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (1 & 31) // s_lshl_b32
scc = s9!= 0
s11 = s0 & -16 // s_and_b32
scc = s11 != 0
s10 = s0 >> (4 & 31) // s_lshr_b32
scc = s10!= 0
s[6:7] = (uint)s0 > (uint)s11 // v_cmp_gt_u32
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp1 = (ulong)s3 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
ulong temp3 = (ulong)s0 + (ulong)s10 + scc // s_addc_u32
s0 = temp3
scc = temp3 >> 32
s6 = s1 & -2 // s_and_b32
scc = s6 != 0
s7 = s1 >> (1 & 31) // s_lshr_b32
scc = s7!= 0
s[6:7] = (uint)s1 > (uint)s6 // v_cmp_gt_u32
v6 = s0 // v_mov_b32
scc = (uint)s6 != (uint)0x0 // s_cmpk_lg_u32
uint temp4 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[6:7] = 0
ulong mask3 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
ulong temp5 = (ulong)s1 + (ulong)s7 + scc // s_addc_u32
s1 = temp5
scc = temp5 >> 32
s3 = s2 & -2 // s_and_b32
scc = s3 != 0
s0 = s2 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[6:7]&mask4 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc0
s[6:7] = 0
v1 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[6:7] = (s[6:7]&~mask4) | ((temp6 >> 32) ? mask4 : 0)
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[6:7] = 0
ulong mask5 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
v9 = s1 // v_mov_b32
uint temp8 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp8 >> 32) ? mask6 : 0)
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[6:7]&mask7 ? 1 : 0)
uint temp9 = (ulong)s5 + (ulong)0 + cc1
s[6:7] = 0
v3 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[6:7] = (s[6:7]&~mask7) | ((temp9 >> 32) ? mask7 : 0)
ulong temp10 = (ulong)s2 + (ulong)s0 + scc // s_addc_u32
s0 = temp10
scc = temp10 >> 32
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s7 = s8 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s8 = s9 << (1 & 31) // s_lshl_b32
scc = s8!= 0
s9 = s10 << (2 & 31) // s_lshl_b32
scc = s9!= 0
s_waitcnt       lgkmcnt(0)
s3 = s0 & -2 // s_and_b32
scc = s3 != 0
uint temp0 = (ulong)s12 + (ulong)s7 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[3:4] = (uint)s0 > (uint)s3 // v_cmp_gt_u32
s0 = s0 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
uint temp1 = (ulong)s14 + (ulong)s8 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s6 + (ulong)s9 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[6:7] = 0
ulong mask3 = (1ULL<<LANEID)
s[6:7] = (s[6:7]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[6:7]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[6:7] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[6:7] = (s[6:7]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong temp5 = (ulong)s0 + (ulong)0 + scc // s_addc_u32
s0 = temp5
scc = temp5 >> 32
s3 = s1 & -2 // s_and_b32
scc = s3 != 0
s[3:4] = (uint)s1 > (uint)s3 // v_cmp_gt_u32
s1 = s1 >> (1 & 31) // s_lshr_b32
scc = s1!= 0
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
ulong temp6 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp6
scc = temp6 >> 32
s3 = s2 & -4 // s_and_b32
scc = s3 != 0
s[3:4] = (uint)s2 > (uint)s3 // v_cmp_gt_u32
s2 = s2 >> (2 & 31) // s_lshr_b32
scc = s2!= 0
scc = (uint)s3 != (uint)0x0 // s_cmpk_lg_u32
uint temp7 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[3:4] = 0
ulong mask5 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask5) | ((temp7 >> 32) ? mask5 : 0)
ulong temp8 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp8
scc = temp8 >> 32
s0 = s0 << (1 & 31) // s_lshl_b32
scc = s0!= 0
s1 = s1 << (1 & 31) // s_lshl_b32
scc = s1!= 0
v6 = s0 // v_mov_b32
v9 = s1 // v_mov_b32
uint temp9 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp9, 0xffffffff) : temp9
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp9 >> 32) ? mask6 : 0)
s0 = s2 << (1 & 31) // s_lshl_b32
scc = s0!= 0
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[3:4]&mask7 ? 1 : 0)
uint temp10 = (ulong)s5 + (ulong)0 + cc1
s[3:4] = 0
v3 = CLAMP ? min(temp10, 0xffffffff) : temp10
s[3:4] = (s[3:4]&~mask7) | ((temp10 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask8 ? 1 : 0)
uint temp11 = (ulong)s5 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp11, 0xffffffff) : temp11
s[1:2] = (s[1:2]&~mask8) | ((temp11 >> 32) ? mask8 : 0)
v11 = s0 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v11 // flat_store_dword
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s11 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s12 = *(uint*)(smem + (0x14 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s8 = s10 << (2 & 31) // s_lshl_b32
scc = s8!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s8 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s3 & -2 // s_and_b32
scc = s1 != 0
vcc = (uint)s3 > (uint)s1 // v_cmp_gt_u32
uint temp1 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s0 = s3 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s6 = s11 & -2 // s_and_b32
scc = s6 != 0
uint temp2 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s2 = s11 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s8 = s12 & -4 // s_and_b32
scc = s8 != 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[9:10] = 0
ulong mask3 = (1ULL<<LANEID)
s[9:10] = (s[9:10]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s7 = s12 >> (2 & 31) // s_lshr_b32
scc = s7!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[9:10]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[9:10] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[9:10] = (s[9:10]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[9:10] = 0
ulong mask5 = (1ULL<<LANEID)
s[9:10] = (s[9:10]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[4:5] = 0
ulong mask6 = (1ULL<<LANEID)
s[4:5] = (s[4:5]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[9:10]&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[9:10] = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[9:10] = (s[9:10]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[4:5]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[4:5] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[4:5] = (s[4:5]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = 0xffff & v6 // v_and_b32
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s0 + (ulong)v7 + cc3
vcc = 0
v11 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
vcc = (uint)s11 > (uint)s6 // v_cmp_gt_u32
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s2 + (ulong)v7 + cc4
vcc = 0
v9 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
vcc = (uint)s12 > (uint)s8 // v_cmp_gt_u32
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s7 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint32*)(v[0:1] + 0) = v11 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
s3 = *(uint*)(smem + (0x8 & ~3)) // s_load_dword
s6 = s8 << (4 & 31) // s_lshl_b32
scc = s6!= 0
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
global_load_ushort v4, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v6 = s3 + v4 // v_add_nc_u32
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[7:8] + 0) = v6 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (4 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s3 = s10 << (1 & 31) // s_lshl_b32
scc = s3!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s3 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[3:4] = 0
ulong mask3 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[3:4]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[3:4] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[3:4] = (s[3:4]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[3:4] = 0
ulong mask5 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[3:4]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[3:4] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[3:4] = (s[3:4]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[3:4] = 0
ulong mask7 = (1ULL<<LANEID)
s[3:4] = (s[3:4]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[3:4]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[3:4] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[3:4] = (s[3:4]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = 0xffff & v6 // v_and_b32
v6 = s1 + v6 // v_add_nc_u32
v11 = s0 + v7 // v_add_nc_u32
v9 = s2 + v7 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v11 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v9 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (2 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v15, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v3 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v5 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v7 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v3 // v_add_u32
v3 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v4 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v5 // v_add_u32
v5 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v6 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v7 // v_add_u32
v7 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v8 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v10 = v0 + v15 // v_add_nc_u32
v11 = v1 + v15 // v_add_nc_u32
v2 = v2 + v15 // v_add_nc_u32
*(uint32*)(v[3:4] + 0) = v10 // flat_store_dword
*(uint32*)(v[5:6] + 0) = v11 // flat_store_dword
*(uint32*)(v[7:8] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (4 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = s8 + v6 // v_add_nc_u32
v8 = s9 + v6 // v_add_nc_u32
v6 = s10 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ubyte v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v9 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v10 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = v6 + 2 // v_add_nc_u16
v6 = 4 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[9:10] + 0) = v7 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x20 & ~3)) // s_load_dwordx2
s[6:7] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v1 = (s9 << 1) | v1 // v_lshl_or_b32
v2 = (s10 << 2) | v2 // v_lshl_or_b32
v7 = (s8 << 1) | v0 // v_lshl_or_b32
global_load_ushort v6, v[3:4], off inst_offset:2
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)v1 // v_add_u32
v8 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[1:2] = 0
ulong mask0 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
uint temp1 = (ulong)s4 + (ulong)v2 // v_add_u32
v9 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[1:2] = 0
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
uint temp2 = (ulong)s6 + (ulong)v7 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[1:2] = 0
ulong mask2 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[1:2]&mask3 ? 1 : 0)
uint temp3 = (ulong)s7 + (ulong)0 + cc0
s[1:2] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[1:2] = (s[1:2]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
uint temp4 = (ulong)s6 + (ulong)v8 // v_add_u32
v2 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[1:2] = 0
ulong mask4 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
ulong mask5 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[1:2]&mask5 ? 1 : 0)
uint temp5 = (ulong)s7 + (ulong)0 + cc1
s[1:2] = 0
v3 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[1:2] = (s[1:2]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s6 + (ulong)v9 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[1:2] = 0
ulong mask6 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[1:2]&mask7 ? 1 : 0)
uint temp7 = (ulong)s7 + (ulong)0 + cc2
s[1:2] = 0
v5 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[1:2] = (s[1:2]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
s_waitcnt       vmcnt(0)
uint temp8 = (ulong)v6 + (ulong)s0 + (ulong)v7 // v_add3_u32
v7 = CLAMP ? min(temp8, 0xffffffff) : temp8
ulong mask8 = (1ULL<<LANEID)
v8 = v6 + v8 // v_add_nc_u16
v6 = v6 + v9 // v_add_nc_u16
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[12:13] = *(ulong*)(smem + (0x0 & ~3)) // s_load_dwordx2
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[4:7][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s3 = s8 << (4 & 31) // s_lshl_b32
scc = s3!= 0
s_waitcnt       lgkmcnt(0)
s7 = s9 << (1 & 31) // s_lshl_b32
scc = s7!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (1 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s7 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s12 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s13 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s12 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s13 + (ulong)0 + cc1
s[0:1] = 0
v3 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
uint temp7 = (ulong)s12 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s13 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
v7 = s4 + v6 // v_add_nc_u32
v8 = s5 + v6 // v_add_nc_u32
v6 = s6 + v6 // v_add_nc_u32
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[12:15][i] = *(uint*)(SMEM + i*4 + (0xc & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s7 = s10 << (2 & 31) // s_lshl_b32
scc = s7!= 0
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ushort v6, v[3:4], off inst_offset:2
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s1 + (ulong)s7 + (ulong)v2 // v_add3_u32
v4 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s1 = s12 & -2 // s_and_b32
scc = s1 != 0
uint temp1 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
vcc = (uint)s12 > (uint)s1 // v_cmp_gt_u32
s0 = s12 >> (1 & 31) // s_lshr_b32
scc = s0!= 0
s3 = s13 & -2 // s_and_b32
scc = s3 != 0
uint temp2 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
s2 = s13 >> (1 & 31) // s_lshr_b32
scc = s2!= 0
s7 = s14 & -4 // s_and_b32
scc = s7 != 0
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[8:9] = 0
ulong mask3 = (1ULL<<LANEID)
s[8:9] = (s[8:9]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
s6 = s14 >> (2 & 31) // s_lshr_b32
scc = s6!= 0
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[8:9]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[8:9] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[8:9] = (s[8:9]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v2 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[8:9] = 0
ulong mask5 = (1ULL<<LANEID)
s[8:9] = (s[8:9]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
uint temp6 = (ulong)s4 + (ulong)v4 // v_add_u32
v4 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[4:5] = 0
ulong mask6 = (1ULL<<LANEID)
s[4:5] = (s[4:5]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
ulong mask7 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[8:9]&mask7 ? 1 : 0)
uint temp7 = (ulong)s5 + (ulong)0 + cc1
s[8:9] = 0
v3 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[8:9] = (s[8:9]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[4:5]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[4:5] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[4:5] = (s[4:5]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
s_waitcnt       vmcnt(0)
ulong mask9 = (1ULL<<LANEID) // v_addc_u32
uchar cc3 = ((vcc&mask9 ? 1 : 0)
uint temp9 = (ulong)s0 + (ulong)v6 + cc3
vcc = 0
v7 = CLAMP ? min(temp9, 0xffffffff) : temp9
vcc = (vcc&~mask9) | ((temp9 >> 32) ? mask9 : 0)
vcc = (uint)s13 > (uint)s3 // v_cmp_gt_u32
ulong mask10 = (1ULL<<LANEID) // v_addc_u32
uchar cc4 = ((vcc&mask10 ? 1 : 0)
uint temp10 = (ulong)s2 + (ulong)v6 + cc4
vcc = 0
v8 = CLAMP ? min(temp10, 0xffffffff) : temp10
vcc = (vcc&~mask10) | ((temp10 >> 32) ? mask10 : 0)
vcc = (uint)s14 > (uint)s7 // v_cmp_gt_u32
ulong mask11 = (1ULL<<LANEID) // v_addc_u32
uchar cc5 = ((vcc&mask11 ? 1 : 0)
uint temp11 = (ulong)s6 + (ulong)v6 + cc5
vcc = 0
v6 = CLAMP ? min(temp11, 0xffffffff) : temp11
vcc = (vcc&~mask11) | ((temp11 >> 32) ? mask11 : 0)
*(uint32*)(v[0:1] + 0) = v7 // flat_store_dword
*(uint32*)(v[2:3] + 0) = v8 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v3 = s4 // v_mov_b32
v4 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x20 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (1 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s9 << (1 & 31) // s_lshl_b32
scc = s6!= 0
global_load_ubyte v4, v[3:4], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s10 << (2 & 31) // s_lshl_b32
scc = s0!= 0
uint temp1 = (ulong)s2 + (ulong)s6 + (ulong)v1 // v_add3_u32
v3 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
uint temp2 = (ulong)s1 + (ulong)s0 + (ulong)v2 // v_add3_u32
v5 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask2 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask3 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
ulong mask4 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask4 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask4) | ((temp4 >> 32) ? mask4 : 0)
uint temp5 = (ulong)s4 + (ulong)v3 // v_add_u32
v7 = CLAMP ? min(temp5, 0xffffffff) : temp5
s[0:1] = 0
ulong mask5 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask5) | ((temp5 >> 32) ? mask5 : 0)
ulong mask6 = (1ULL<<LANEID) // v_addc_u32
uchar cc1 = ((s[0:1]&mask6 ? 1 : 0)
uint temp6 = (ulong)s5 + (ulong)0 + cc1
s[0:1] = 0
v8 = CLAMP ? min(temp6, 0xffffffff) : temp6
s[0:1] = (s[0:1]&~mask6) | ((temp6 >> 32) ? mask6 : 0)
s_waitcnt       vmcnt(0)
v6 = v4 << (1&31) // v_lshlrev_b32
uint temp7 = (ulong)s4 + (ulong)v5 // v_add_u32
v4 = CLAMP ? min(temp7, 0xffffffff) : temp7
s[0:1] = 0
ulong mask7 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask7) | ((temp7 >> 32) ? mask7 : 0)
ulong mask8 = (1ULL<<LANEID) // v_addc_u32
uchar cc2 = ((s[0:1]&mask8 ? 1 : 0)
uint temp8 = (ulong)s5 + (ulong)0 + cc2
s[0:1] = 0
v5 = CLAMP ? min(temp8, 0xffffffff) : temp8
s[0:1] = (s[0:1]&~mask8) | ((temp8 >> 32) ? mask8 : 0)
*(uint32*)(v[0:1] + 0) = v6 // flat_store_dword
*(uint32*)(v[7:8] + 0) = v6 // flat_store_dword
*(uint32*)(v[4:5] + 0) = v6 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s6 << (6 & 31) // s_lshl_b32
scc = s4!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v2 = v0 << (1&15) // v_lshlrev_b16
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v1 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v1 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s6 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (6 & 31) // s_lshl_b32
scc = s3!= 0
v2 = 0x80 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s[0:1] = *(ulong*)(smem + (0x10 & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 6) | v0 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
v2 = v0 << (1&15) // v_lshlrev_b16
uint temp1 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s3 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (6 & 31) // s_lshl_b32
scc = s4!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s2 = s3 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0xc & ~3)) // s_load_dword
s3 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s5 = s8 << (6 & 31) // s_lshl_b32
scc = s5!= 0
s_waitcnt       lgkmcnt(0)
s4 = s2 & 0xffffffc0 // s_and_b32
scc = s4 != 0
uint temp0 = (ulong)s3 + (ulong)s5 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s[4:5] = (uint)s2 > (uint)s4 // v_cmp_gt_u32
s2 = s2 >> (6 & 31) // s_lshr_b32
scc = s2!= 0
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
scc = (uint)s4 != (uint)0x0 // s_cmpk_lg_u32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong temp3 = (ulong)s2 + (ulong)0 + scc // s_addc_u32
s2 = temp3
scc = temp3 >> 32
s2 = s2 << (1 & 31) // s_lshl_b32
scc = s2!= 0
v2 = s2 // v_mov_b32
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v1 = s4 // v_mov_b32
v2 = s5 // v_mov_b32
s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s8 << (6 & 31) // s_lshl_b32
scc = s3!= 0
global_load_ubyte v1, v[1:2], off inst_offset:2
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
s_waitcnt       vmcnt(0)
v2 = v1 << (1&31) // v_lshlrev_b32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s_waitcnt       lgkmcnt(0)
s1 = *(uint*)(smem + (0x0 & ~3)) // s_load_dword
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s6 = s7 << (3 & 31) // s_lshl_b32
scc = s6!= 0
uint temp0 = (ulong)s0 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s_waitcnt       lgkmcnt(0)
ulong temp1 = (ulong)s2 + (ulong)s1 // s_add_i32
s0 = temp1
scc = temp1 >> 32
uint temp2 = (ulong)s0 + (ulong)s6 + (ulong)v1 // v_add3_u32
v2 = CLAMP ? min(temp2, 0xffffffff) : temp2
ulong mask1 = (1ULL<<LANEID)
uint temp3 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp3 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask3 ? 1 : 0)
uint temp4 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[0:1] = (s[0:1]&~mask3) | ((temp4 >> 32) ? mask3 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s_waitcnt       lgkmcnt(0)
s1 = s6 << (3 & 31) // s_lshl_b32
scc = s1!= 0
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s2 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v2 = s0 // v_mov_b32
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[1:2] = 0
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[1:2]&mask2 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc0
s[1:2] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[1:2] = (s[1:2]&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v3 = v1 + v0 // v_add_nc_u16
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v2 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v2 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v3 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s7 + (ulong)s6 // s_add_i32
s2 = temp1
scc = temp1 >> 32
v2 = s2 // v_mov_b32
uint temp2 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp3 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s2 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s3 = s6 << (3 & 31) // s_lshl_b32
scc = s3!= 0
v2 = 16 // v_mov_b32
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s2 + (ulong)s3 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
uint temp1 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp1, 0xffffffff) : temp1
s[0:1] = 0
ulong mask1 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask1) | ((temp1 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask2 ? 1 : 0)
uint temp2 = (ulong)s1 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
v0 = (s6 << 3) | v0 // v_lshl_or_b32
s_waitcnt       lgkmcnt(0)
s1 = s7 << (3 & 31) // s_lshl_b32
scc = s1!= 0
uint temp0 = (ulong)s0 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
s[0:1] = 0
ulong mask0 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask0) | ((temp0 >> 32) ? mask0 : 0)
uint temp1 = (ulong)s2 + (ulong)s1 + (ulong)v1 // v_add3_u32
v1 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
v2 = v1 + v0 // v_add_nc_u16
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s9 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s4 = s8 << (3 & 31) // s_lshl_b32
scc = s4!= 0
s_waitcnt       lgkmcnt(0)
uint temp0 = (ulong)s9 + (ulong)s4 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
ulong temp1 = (ulong)s1 + (ulong)s0 // s_add_i32
s0 = temp1
scc = temp1 >> 32
v2 = s0 // v_mov_b32
uint temp2 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[1:2] = 0
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask1) | ((temp2 >> 32) ? mask1 : 0)
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[1:2]&mask2 ? 1 : 0)
uint temp3 = (ulong)s3 + (ulong)0 + cc0
s[1:2] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[1:2] = (s[1:2]&~mask2) | ((temp3 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

s[0:1] = *(ulong*)(smem + (0xc & ~3)) // s_load_dwordx2
s4 = *(uint*)(smem + (0x10 & ~3)) // s_load_dword
s[2:3] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s6 = s8 << (3 & 31) // s_lshl_b32
scc = s6!= 0
s_waitcnt       lgkmcnt(0)
s5 = s1 & -8 // s_and_b32
scc = s5 != 0
s7 = s0 & -8 // s_and_b32
scc = s7 != 0
s[5:6] = (uint)s1 > (uint)s5 // v_cmp_gt_u32
s8 = s0 >> (3 & 31) // s_lshr_b32
scc = s8!= 0
s[0:1] = (uint)s0 > (uint)s7 // v_cmp_gt_u32
s1 = s1 >> (3 & 31) // s_lshr_b32
scc = s1!= 0
uint temp0 = (ulong)s4 + (ulong)s6 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
scc = (uint)s5 != (uint)0x0 // s_cmpk_lg_u32
ulong temp1 = (ulong)s1 + (ulong)0 + scc // s_addc_u32
s1 = temp1
scc = temp1 >> 32
scc = (uint)s0 != (uint)0x0 // s_cmpk_lg_u32
ulong temp2 = (ulong)s1 + (ulong)s8 + scc // s_addc_u32
s0 = temp2
scc = temp2 >> 32
uint temp3 = (ulong)s2 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[1:2] = 0
ulong mask1 = (1ULL<<LANEID)
s[1:2] = (s[1:2]&~mask1) | ((temp3 >> 32) ? mask1 : 0)
v2 = s0 // v_mov_b32
ulong mask2 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[1:2]&mask2 ? 1 : 0)
uint temp4 = (ulong)s3 + (ulong)0 + cc0
s[1:2] = 0
v1 = CLAMP ? min(temp4, 0xffffffff) : temp4
s[1:2] = (s[1:2]&~mask2) | ((temp4 >> 32) ? mask2 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0
s_nop           0x0

v2 = s4 // v_mov_b32
v3 = s5 // v_mov_b32
for (BYTE i = 0; i < 4; i++) // s_load_dword4
    s[0:3][i] = *(uint*)(SMEM + i*4 + (0x10 & ~3))
s[4:5] = *(ulong*)(smem + (0x8 & ~3)) // s_load_dwordx2
s_waitcnt       lgkmcnt(0)
s1 = s8 << (3 & 31) // s_lshl_b32
scc = s1!= 0
global_load_ushort v2, v[2:3], off inst_offset:2
uint temp0 = (ulong)s0 + (ulong)s1 + (ulong)v0 // v_add3_u32
v0 = CLAMP ? min(temp0, 0xffffffff) : temp0
ulong mask0 = (1ULL<<LANEID)
s0 = s9 << (3 & 31) // s_lshl_b32
scc = s0!= 0
s_waitcnt       vmcnt(0)
v2 = s2 + v2 // v_add_nc_u32
uint temp1 = (ulong)v2 + (ulong)s0 + (ulong)v1 // v_add3_u32
v2 = CLAMP ? min(temp1, 0xffffffff) : temp1
ulong mask1 = (1ULL<<LANEID)
uint temp2 = (ulong)s4 + (ulong)v0 // v_add_u32
v0 = CLAMP ? min(temp2, 0xffffffff) : temp2
s[0:1] = 0
ulong mask2 = (1ULL<<LANEID)
s[0:1] = (s[0:1]&~mask2) | ((temp2 >> 32) ? mask2 : 0)
ulong mask3 = (1ULL<<LANEID) // v_addc_u32
uchar cc0 = ((s[0:1]&mask3 ? 1 : 0)
uint temp3 = (ulong)s5 + (ulong)0 + cc0
s[0:1] = 0
v1 = CLAMP ? min(temp3, 0xffffffff) : temp3
s[0:1] = (s[0:1]&~mask3) | ((temp3 >> 32) ? mask3 : 0)
*(uint32*)(v[0:1] + 0) = v2 // flat_store_dword
