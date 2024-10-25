__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_1(int x, __global int *data, int y)
{
    uint var1;
    uint var3;
    int var5;
    var3 = get_global_id(0);
    if ((uint)1 != (uint)var3) {
        var5 = get_global_id(0) * y;
        var1 = get_global_id(1);
    }
    else {
        var1 = get_global_id(1);
        var3 = 1;
        var5 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var3] = var5;
    data[get_global_id(2)] = min((int)x, (int)y);
    data[var1] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_2(int x, __global int *data, int y)
{
    int var5;
    uint var8;
    var8 = get_global_id(0);
    if ((uint)0 != (uint)var8) {
        data[get_global_id(0)] = get_global_id(0) * y;
    }
    else {
        *data = (long)0 - (long)y;
    }
    if ((uint)1 != (uint)get_global_id(1)) {
        var5 = get_global_id(1) * y;
    }
    else {
        var8 = 1;
        var5 = (long)x - (long)y;
    }
    data[var8] = var5;
}
