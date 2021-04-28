__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int *out, int i)
{
    uint var0;
    var0 = gdata0[(get_global_id(0) * 4) / 4];
    out[(get_global_id(0) * 4) / 4] = var0;
}
__constant uint gdata0[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
