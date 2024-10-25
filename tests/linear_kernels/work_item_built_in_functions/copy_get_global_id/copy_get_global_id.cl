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
