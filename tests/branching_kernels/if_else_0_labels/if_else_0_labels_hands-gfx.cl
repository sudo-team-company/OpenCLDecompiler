__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_0_labels(int x, __global int *data, int y)
{
    int var1;
    uint var2;
    uint var4;
    var2 = get_global_id(0);
    if (1 != var2) {
        var4 = get_global_id(1);
        var1 = y;
    }
    else {
        var4 = get_global_id(1);
        var2 = 1;
        var1 = (get_global_id(1) * x) - (uint)y;
    }
    data[var2] = var1;
    data[var4] = x;
}
