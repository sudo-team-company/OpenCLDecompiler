__constant long gdata0[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global long *out, int i)
{
    long var0;
    var0 = gdata0[((ulong)(get_global_id(0) * 24) + (ulong)(get_global_id(1) * 8)) / 8];
    out[(get_global_id(0) * 8) / 8] = var0;
}
