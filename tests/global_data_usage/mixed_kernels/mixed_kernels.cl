__constant int fst_arr[] = {1, 2, 3, 4, 5, 6, 7};
__constant long snd_arr[] = {8, 9, 10, 11};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void some_array_test(__global long* out, int i) {
	uint id = get_global_id(0);
	uint id1 = get_global_id(1);
	out[id] = fst_arr[i];
	out[id1] = snd_arr[id];
}