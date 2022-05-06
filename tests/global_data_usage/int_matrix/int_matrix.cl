__constant int int_arr[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global int* out, int i) {
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1); 
	out[id0] = int_arr[id0][id1];
}