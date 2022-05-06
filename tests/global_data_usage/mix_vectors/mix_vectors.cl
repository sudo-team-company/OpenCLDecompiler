__constant int4 i4 = (int4)(11, 12, 13, 14);
__constant float8 i8 = (float8)(1,2,3,4,5,6,7,8);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global float *in, __global int *out, int i)
{
  int index = get_global_id(0);
  in[index] = ((__constant float*)&i8)[i];
  out[index] = ((__constant int*)&i4)[i];
}
