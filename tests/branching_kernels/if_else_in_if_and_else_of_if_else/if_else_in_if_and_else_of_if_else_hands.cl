__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var5;
    uint var8;
    if ((int)1 == (int)get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = (ulong)(get_global_id(1) * x) - (ulong)y;
        var0 = ((int)x >= (int)y ? 1 : 0) ? get_global_id(1) * y : get_global_id(2) * x;
        var8 = var0;
    }
    else {
        data[(get_global_id(0) * 4) / 4] = get_global_id(0) * y;
        var5 = ((int)x >= (int)y ? 1 : 0) ? (ulong)y + (ulong)get_global_id(1) : (ulong)x + (ulong)get_global_id(2);
        var8 = var5;
    }
    data[(get_global_id(2) * 4) / 4] = var8;
    data[(get_global_id(1) * 4) / 4] = x;
}
