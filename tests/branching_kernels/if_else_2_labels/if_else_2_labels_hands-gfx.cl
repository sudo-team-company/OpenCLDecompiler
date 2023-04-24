__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_2_labels(int x, __global int *data, int y)
{
    int var2;
    uint var3;
    uint var5;
    var3 = get_global_id(0);
    if ((uint)1 != (uint)var3) {
        var5 = get_global_id(1);
        var2 = y * x;
    }
    else {
        var5 = get_global_id(1);
        var3 = 1;
        var2 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var3] = var2;
    data[var5] = x;
}
