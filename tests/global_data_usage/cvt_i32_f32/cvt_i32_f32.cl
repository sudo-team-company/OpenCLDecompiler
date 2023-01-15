__constant float float_arr2[] = {-1.0, 1.0, 2.0, -2.0, 3.0, -3.0, 1.1, 1.2, 1.3, 1.4, 1.5};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global int* out, int i) {
	uint id = get_global_id(0);
	out[id] = float_arr2[id];
}
