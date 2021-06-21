__constant int gdata0[] = {1, 2, 3, 4, 5, 6, 7};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global float *out, int i)
{
    int var0;
    var0 = gdata0[get_global_id(0)];
    out[get_global_id(0)] = (float)var0;
}
