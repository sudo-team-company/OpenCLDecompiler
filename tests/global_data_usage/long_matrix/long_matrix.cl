/*
__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_local_size(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 + get_local_size(0);
	data[id1] = g1 + get_local_size(1);
	data[id2] = g2 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int* out, int i) {
	uint id = get_global_id(0);
	out[id] = id;
}


__constant int int_arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int* out, int i) {
	uint id = get_global_id(0);
	out[id] = int_arr[id];
}


__constant long long_arr[] = {1, 2, 3, 4, 5, 6, 7};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void long_test(__global long* out, int i) {
	uint id = get_global_id(0);	
	out[id] = long_arr[i];
}


__constant int fst_arr[] = {1, 2, 3, 4, 5, 6, 7};
__constant long snd_arr[] = {8, 9, 10, 11};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void some_array_test(__global long* out, __global int* res, int i) {
	uint id = get_global_id(0);
	uint id1 = get_global_id(1);
	res[id] = fst_arr[id];
	out[id1] = snd_arr[id];
}

__constant int fix_arr[3] = {1, 2, 3};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void fix_test(__global int* out, int i) {
	out[0] = fix_arr[i];
}


//__constant double float_arr[] = {-1.0, 1.0, -2.2, 3.9, -4.20, 5.12345};
__constant int int_arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global double* out, int i) {
	uint id = get_global_id(0);
	out[id] = int_arr[id];
}


//__constant int int_arr[] = {1, 2, 3, 4, 5, 6, 7};
//__constant long snd_arr[] = {2, 3, 5, 8, 9, 10, 11};

__constant double float_arr[] = {-1.0, 1.0, -2.2, 3.9, -4.20, 5.12345};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global long* out, int i) {
	uint id = get_global_id(0);
	out[id] = float_arr[id];
}
__constant int4 i4 = (int4)(11, 12, 13, 14);
__constant int8 i8 = (int8)(1,2,3,4,5,6,7,8);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
  int index = get_global_id(0);
  in[index] = ((__constant int*)&i8)[i];
  in[0] = ((__constant int*)&i4)[i];
}

__constant int4 i4 = (int4)(11, 12, 13, 14);
__constant float8 i8 = (float8)(1,2,3,4,5,6,7,8);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global float *in, __global int *out, int i)
{
  int index = get_global_id(0);
  in[index] = ((__constant float*)&i8)[i];
  out[index] = ((__constant int*)&i4)[i];
}

__constant long4 i4 = (long4)(11, 12, 13, 14);
__constant int8 i8 = (int8)(1,2,3,4,5,6,7,8);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global long *out, int i)
{
  long index = get_global_id(0);
  in[index] = ((__constant int*)&i8)[i];
  out[index] = ((__constant long*)&i4)[i];
}



__constant long int_arr[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global long* out, int i) {
	int id0 = get_global_id(0);
	int id1 = get_global_id(1); 
	out[id0] = int_arr[id0][id1];
}
*/
__constant long int_arr[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global long* out, int i) {
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1); 
	out[id0] = int_arr[id0][id1];
}