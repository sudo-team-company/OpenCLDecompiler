__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_1_label(int x, __global int *data, int y)
{
    uint var0;
    uint var3;
    uint var4;
    var3 = get_global_id(0);
    if (2 != var3) {
        var0 = get_global_id(0) * y;
        var4 = get_global_id(1);
    }
    else {
        var4 = get_global_id(1);
        var3 = 2;
        var0 = (get_global_id(1) * x) - y;
    }
    data[var3] = var0;
    data[var4] = x;
}
