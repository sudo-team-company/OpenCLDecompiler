__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_1_label(int x, __global int *data, int y)
{
    uint *var2;
    uint var4;
    if (2 == get_global_id(0)) {
        var2 = &data[(get_global_id(0) * 4) / 4];
        var4 = (get_global_id(1) * x) - y;
    }
    else {
        var2 = &data[(get_global_id(0) * 4) / 4];
        var4 = get_global_id(0) * y;
    }
    *var2 = var4;
    data[(get_global_id(1) * 4) / 4] = x;
}
