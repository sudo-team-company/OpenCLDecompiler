__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_with_long_expr(int x, __global int *data, int y)
{
    uint var1;
    uint var2;
    int var4;
    var2 = get_global_id(0);
    if ((uint)x >= (uint)y || (uint)1 != (uint)get_global_id(0) || (uint)2 != (uint)get_global_id(2)) {
        var4 = get_global_id(0) * y;
        var1 = get_global_id(1);
    }
    else {
        var1 = get_global_id(1);
        var2 = 1;
        var4 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var2] = var4;
    data[var1] = x;
}
