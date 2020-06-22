__kernel __attribute__((reqd_work_group_size(16, 16, 16)))
void localVarExample(int x, __global int *data, int y)
{
    uint var5;
    uint var0;
    var0 = get_global_id(0);
    if (0 == get_global_id(0)) {
        var0 = get_global_id(1);
    }
    data[var0] = x;
    if (x < y) {
        var5 = get_global_id(2);
    }
    else {
        var5 = var0;
    }
    data[var5] = y;
}
