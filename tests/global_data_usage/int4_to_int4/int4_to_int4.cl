__constant int4 gdata0[] = {(int4)(1, 2, 3, 4), (int4)(5, 6, 7, 8), (int4)(9, 10, 11, 12)};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int4* out, int i) {
	uint id0 = get_global_id(0);
	out[id0] = gdata0[id0];
}
