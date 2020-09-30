__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else(int x, __global int *data, int y)
{
    uint *var2;
    uint var4;
    if (1 == get_global_id(0)) {
        var2 = &data[(get_global_id(0) * 4) / 4];
        var4 = (get_global_id(1) * x) - y;
    }
    else {
        var2 = &data[(get_global_id(0) * 4) / 4];
        var4 = get_global_id(0) * y;
    }
    *var2 = var4;
    data[(get_global_id(2) * 4) / 4] = min(x, y);
    data[(get_global_id(1) * 4) / 4] = x;
}
