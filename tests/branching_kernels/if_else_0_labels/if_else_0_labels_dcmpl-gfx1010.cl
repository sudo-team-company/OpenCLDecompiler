__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_0_labels(int x, __global int *data, int y)
{
    uint var0;
    int var1;
    uint var2;
    uint var4;
    var2 = get_global_id(0);
    if (var2 != 1) {
        var1 = y;
        var4 = get_global_id(1);
    }
    else {
        var2 = 1;
        var4 = get_global_id(1);
        var1 = (uint)(var4 * x) - (uint)y;
    }
    data[var2] = var1;
    data[var4] = x;
}
