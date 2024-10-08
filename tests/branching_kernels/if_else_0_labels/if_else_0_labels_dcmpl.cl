__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_0_labels(int x, __global int *data, int y)
{
    uint var0;
    var0 = (int)get_global_id(0) != 1 ? y : (get_global_id(1) * x) - (ulong)y;
    data[get_global_id(0)] = var0;
    data[get_global_id(1)] = x;
}
