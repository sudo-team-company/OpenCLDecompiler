__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_1(int x, __global int *data, int y)
{
    uint var2;
    uint var3;
    int var5;
    var3 = get_global_id(0);
    if (1 != var3) {
        var5 = get_global_id(0) * y;
        var2 = get_global_id(1);
    }
    else {
        var2 = get_global_id(1);
        var3 = 1;
        var5 = (get_global_id(1) * x) - (uint)y;
    }
    data[var3] = var5;
    data[get_global_id(2)] = min(x, y);
    data[var2] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_2(int x, __global int *data, int y)
{
    int var8;
    uint var9;
    var9 = get_global_id(0);
    if (0 != var9) {
        data[get_global_id(0)] = get_global_id(0) * y;
    }
    else {
        *data = 0 - y;
    }
    if (1 != get_global_id(1)) {
        var8 = get_global_id(1) * y;
    }
    else {
        var9 = 1;
        var8 = x - y;
    }
    data[var9] = var8;
}
