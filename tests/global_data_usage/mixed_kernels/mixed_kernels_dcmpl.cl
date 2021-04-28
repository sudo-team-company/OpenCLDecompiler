__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void some_array_test(__global long *out, int i)
{
    int var0;
    long var1;
    var0 = gdata0[(get_global_id(0) * 4) / 4];
    var1 = gdata32[(get_global_id(0) * 8) / 8];
    out[(get_global_id(0) * 8) / 8] = var0;
    out[(get_global_id(1) * 8) / 8] = var1;
}
__constant int gdata0[] = {1, 2, 3, 4, 5, 6, 7, 0};
__constant long gdata32[] = {8, 9, 10, 11};
