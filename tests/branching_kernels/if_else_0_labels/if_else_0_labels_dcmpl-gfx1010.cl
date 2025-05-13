__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_0_labels(int x, __global int *data, int y)
{
    int var0;
    uint var2;
    uint var3;
    var2 = get_global_id(0);
    if (1 != var2) {
        var3 = get_global_id(1);
        var0 = y;
    }
    else {
        var3 = get_global_id(1);
        var2 = 1;
        var0 = (get_global_id(1) * x) - y;
    }
    data[var2] = var0;
    data[var3] = x;
}
