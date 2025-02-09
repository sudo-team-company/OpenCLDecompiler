__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else(int x, __global int *data, int y)
{
    __global int *var0;
    int var2;
    if (1 == (int)get_global_id(0)) {
        var0 = data + (get_global_id(0) * 4) / 4;
        var2 = (get_global_id(1) * x) - (ulong)y;
    }
    else {
        var2 = get_global_id(0) * y;
        var0 = data + (get_global_id(0) * 4) / 4;
    }
    *var0 = var2;
    data[get_global_id(2)] = min(x, y);
    data[get_global_id(1)] = x;
}
