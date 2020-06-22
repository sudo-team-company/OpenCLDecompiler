__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy2(int x, __global int *data)
{
	uint id = get_global_id(0);
	data[id] = x;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void copy3(int x, __global int *data)
{
	uint g0 = get_global_id(0);
  uint g1 = get_global_id(1);
	data[g0] = g1;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void copy4(int x, __global int *data)
{
	uint id = get_global_id(0);
	data[id] = x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy5(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  uint g1 = get_global_id(1);
  uint g2 = get_global_id(2);
	data[g0] = g1 + g2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy6(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  uint o0 = get_global_offset(0);
  uint g1 = get_global_id(1);
  uint g2 = get_global_id(2);
	data[g0 - o0] = g1 + g2;
}




__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void cpFACE(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = 0xFACE;
}

