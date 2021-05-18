__constant int gdata0[] = {1, 2, 3, 4, 5, 6, 7, 8};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
    in[(get_global_id(0) / (long)1073741824) * 1073741824] = gdata0[(i * 4) / 4];
}
