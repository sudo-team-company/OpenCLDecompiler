__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_1_label(int x, __global int *data, int y)
{
    int var1;
    uint var3;
    uint var5;
    var3 = get_global_id(0);
    if ((uint)2 != (uint)var3) {
        var1 = get_global_id(0) * y;
        var5 = get_global_id(1);
    }
    else {
        var5 = get_global_id(1);
        var3 = 2;
        var1 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var3] = var1;
    data[var5] = x;
}
