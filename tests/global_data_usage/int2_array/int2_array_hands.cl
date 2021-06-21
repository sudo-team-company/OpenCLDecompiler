__constant int gdata0[] = {1, 2, 4, 5, 7, 8};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void int_test(__global int *out, int i)
{
    int var0;
    var0 = gdata0[2*get_global_id(0) + get_global_id(1)];
    out[get_global_id(0)] = var0;
}
