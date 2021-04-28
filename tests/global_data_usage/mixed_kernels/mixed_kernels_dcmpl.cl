__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void some_array_test(__global long *out, int i)
{
    long var0;
    var0 = gdata32[(get_global_id(0) * 8) / 4];
    out[(get_global_id(0) * 8) / 8] = gdata0[(i * 4) / 8];
    out[(((ulong)((ulong)get_group_id(1) + (ulong)get_global_offset(1)) + (ulong)get_local_id(1)) * 8) / 8] = var0;
}
__constant int gdata0[] = {1, 2, 3, 4, 5, 6, 7, 0};
__constant long gdata32[] = {8, 9, 10, 11};
