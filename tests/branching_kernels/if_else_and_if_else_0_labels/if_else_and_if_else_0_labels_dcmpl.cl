__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_0_labels(int x, __global int *data, int y)
{
    uint var0;
    uint var1;
    var0 = get_global_id(0) != 1 ? get_global_id(0) * y : (get_global_id(1) * x) - y;
    data[(get_global_id(0) * 4) / 4] = var0;
    var1 = (x >= y ? 1 : 0) ? y + get_global_id(1) : (get_global_offset(2) + x) + (get_global_id(2) - get_global_offset(2));
    data[(get_global_id(2) * 4) / 4] = var1;
    data[(get_global_id(1) * 4) / 4] = x;
}
