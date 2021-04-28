__constant long long_arr[] = {1, 2, 3, 4, 5, 6, 7};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void long_test(__global long* out, int i) {
	uint id = get_global_id(0);
	out[id] = long_arr[i];
}