__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_work_dim(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_work_dim();
	data[g0] = o0;
}
