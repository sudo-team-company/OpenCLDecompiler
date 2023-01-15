__constant int4 i4 = (int4)(11, 12, 13, 14);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
  int index = get_global_id(0);
  in[index] = ((__constant int*)&i4)[i];
}
