__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy_x(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x;
}
