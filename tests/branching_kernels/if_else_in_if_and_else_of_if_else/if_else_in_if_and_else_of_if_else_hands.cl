__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var1;
    uint var5;
    int var8;
    var1 = get_global_id(0);
    if (1 == get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = (get_global_id(1) * x) - y;
        var0 = (x >= y ? 1 : 0) ? get_global_id(1) * y : get_global_id(2) * x;
        var8 = var0;
    }
    else {
        data[(get_global_id(0) * 4) / 4] = var1 * y;
        var5 = (x >= y ? 1 : 0) ? y + get_global_id(1) : x + get_global_id(2);
        var8 = var5;
    }
    data[(get_global_id(2) * 4) / 4] = var8;
    data[(get_global_id(1) * 4) / 4] = x;
}
