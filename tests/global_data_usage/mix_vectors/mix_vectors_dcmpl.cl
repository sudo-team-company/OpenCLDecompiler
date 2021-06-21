__constant int gdata0[] = {11, 12, 13, 14, 0, 0, 0, 0};

__constant float gdata32[] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global float *in, __global int *out, int i)
{
    in[get_global_id(0)] = gdata32[i];
    out[get_global_id(0)] = gdata0[i];
}
