__constant long snd_arr[] = {2, 3, 5, 8, 9, 10, 11};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global double* out, int i) {
	uint id = get_global_id(0);
	out[id] = snd_arr[id];
}
