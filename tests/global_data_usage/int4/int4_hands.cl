__constant int gdata0[] = {11, 12, 13, 14};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
    in[get_global_id(0)] = gdata0[i];
}
