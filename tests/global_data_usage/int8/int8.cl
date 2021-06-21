__constant int8 i8 = (int8)(1,2,3,4,5,6,7,8);

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
  int index = get_global_id(0);
  in[index] = ((__constant int*)&i8)[i];
}
