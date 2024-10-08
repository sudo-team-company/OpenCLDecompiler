__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else_1(int x, __global int *data, int y)
{
    uint var5;
    uint var7;
    int var8;
    var7 = get_global_id(0);
    if (1 != var7) {
        var8 = get_global_id(0) * y;
        var5 = get_global_id(1);
    }
    else {
        var5 = get_global_id(1);
        data[get_global_id(0)] = (get_global_id(1) * x) - (uint)y;
        if (x >= y) {
            var8 = (ulong)y + get_global_id(1);
            var7 = get_global_id(2);
        }
        else {
            var7 = get_global_id(2);
            var8 = (ulong)x + get_global_id(2);
        }
    }
    data[var7] = var8;
    data[var5] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else_2(int x, __global int *data, int y)
{
    int var12;
    uint var9;
    var9 = get_global_id(0);
    if (1 != var9) {
        var12 = get_global_id(0) * y;
    }
    else {
        var9 = get_global_id(1);
        data[get_global_id(0)] = (get_global_id(1) * x) - (uint)y;
        if (var9 >= get_global_id(2)) {
            var12 = (ulong)y + get_global_id(1);
        }
        else {
            var12 = (ulong)x + get_global_id(2);
            var9 = get_global_id(2);
        }
    }
    data[var9] = var12;
}
