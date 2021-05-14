__constant long gdata0[] = {2, 3, 5, 8, 9, 10, 11};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global double *out, int i)
{
    long var0;
    var0 = gdata0[(get_global_id(0) * 8) / 8];
    out[(get_global_id(0) * 8) / 8] = (double)var0;
}
