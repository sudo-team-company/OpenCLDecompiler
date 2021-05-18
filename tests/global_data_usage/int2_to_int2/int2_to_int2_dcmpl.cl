__constant int2 gdata0[] = {(int2)(1, 2), (int2)(4, 5), (int2)(7, 8)};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int2 *out, int i)
{
    int2 var0;
    var0 = gdata0[(get_global_id(0) * 8) / 8];
    out[(get_global_id(0) * 8) / 8] = var0;
}
