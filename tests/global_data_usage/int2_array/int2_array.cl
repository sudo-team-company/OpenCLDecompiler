__constant int2 int_arr[] = {(int2)(1, 2), (int2)(4, 5), (int2)(7, 8)};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global int* out, int i) {
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1); 
	out[id0] = ((__constant int*)&int_arr[id0])[id1];
}