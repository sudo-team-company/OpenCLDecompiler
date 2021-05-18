__constant int gdata0[] = {1, 2, 4, 5, 7, 8};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global int *out, int i)
{
    int var0;
    var0 = gdata0[((ulong)(get_global_id(0) * 8) + (ulong)(get_global_id(1) * 4)) / 4];
    out[(get_global_id(0) * 4) / 4] = var0;
}
