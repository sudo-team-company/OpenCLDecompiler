__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
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