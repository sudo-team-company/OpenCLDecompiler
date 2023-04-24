__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else(int x, __global int *data, int y)
{
    uint var2;
    uint var3;
    int var5;
    var3 = get_global_id(0);
    if ((uint)1 != (uint)var3) {
        var5 = get_global_id(0) * y;
        var2 = get_global_id(1);
    }
    else {
        var2 = get_global_id(1);
        var3 = 1;
        var5 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var3] = var5;
    data[get_global_id(2)] = min((int)x, (int)y);
    data[var2] = x;
}
