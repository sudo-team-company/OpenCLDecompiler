__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_with_long_expr(int x, __global int *data, int y)
{
    uint var1;
    uint var2;
    int var5;
    var2 = get_global_id(0);
    if (x >= y || 1 != get_global_id(0) || 2 != get_global_id(2)) {
        var5 = get_global_id(0) * y;
        var1 = get_global_id(1);
    }
    else {
        var1 = get_global_id(1);
        var2 = 1;
        var5 = (get_global_id(1) * x) - (uint)y;
    }
    data[var2] = var5;
    data[var1] = x;
}
