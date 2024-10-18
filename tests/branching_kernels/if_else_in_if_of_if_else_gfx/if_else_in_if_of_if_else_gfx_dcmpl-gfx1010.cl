__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else_1(int x, __global int *data, int y)
{
    uint var4;
    uint var6;
    int var8;
    var6 = get_global_id(0);
    if ((uint)1 != (uint)var6) {
        var8 = get_global_id(0) * y;
        var4 = get_global_id(1);
    }
    else {
        var4 = get_global_id(1);
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((int)x >= (int)y) {
            var8 = (ulong)y + (ulong)get_global_id(1);
            var6 = get_global_id(2);
        }
        else {
            var6 = get_global_id(2);
            var8 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    data[var6] = var8;
    data[var4] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else_2(int x, __global int *data, int y)
{
    int var12;
    uint var5;
    var5 = get_global_id(0);
    if ((uint)1 != (uint)var5) {
        var12 = get_global_id(0) * y;
    }
    else {
        var5 = get_global_id(1);
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((uint)var5 >= (uint)get_global_id(2)) {
            var12 = (ulong)y + (ulong)get_global_id(1);
        }
        else {
            var12 = (ulong)x + (ulong)get_global_id(2);
            var5 = get_global_id(2);
        }
    }
    data[var5] = var12;
}
