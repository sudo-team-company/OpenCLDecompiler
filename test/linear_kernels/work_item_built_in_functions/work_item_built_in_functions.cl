__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy_x(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void copy_get_global_offset(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void copy_get_local_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void copy_get_group_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_local_size(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_global_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0;
	data[g1] = g1;
	data[g2] = g2;
}




__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}


__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_num_groups(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0;
	data[id1] = g1;
	data[id2] = g2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_work_dim(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_work_dim();
	data[g0] = o0;
}
