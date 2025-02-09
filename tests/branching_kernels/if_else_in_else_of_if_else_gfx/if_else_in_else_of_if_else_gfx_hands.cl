__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else_1(int x, __global int *data, int y)
{
    uint var7;
    int var9;
    if (1 != get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        var7 = get_global_id(2);
        if (x >= y) {
            var9 = (ulong)y + get_global_id(1);
        }
        else {
            var9 = (ulong)x + get_global_id(2);
        }
    }
    else {
        var7 = 1;
        var9 = (get_global_id(1) * x) - (uint)y;
    }
    data[var7] = var9;
    data[get_global_id(1)] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else_2(int x, __global int *data, int y)
{
    uint var10;
    int var7;
    if (1 != get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if (get_global_id(1) >= get_global_id(2)) {
            var7 = (ulong)y + get_global_id(1);
            var10 = get_global_id(1);
        }
        else {
            var7 = (ulong)x + get_global_id(2);
            var10 = get_global_id(2);
        }
    }
    else {
        var10 = 1;
        var7 = (get_global_id(1) * x) - (uint)y;
    }
    data[var10] = var7;
}
