__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var1;
    int var7;
    uint var8;
    var8 = get_global_id(0);
    if (1 == var8) {
        var7 = (get_global_id(1) * x) - y;
    }
    else {
        var0 = x >= y ? 0 : 1;
        var8 = get_global_id(2);
        data[get_global_id(0)] = get_global_id(0) * y;
        var1 = var0 ? y + get_global_id(1) : x + get_global_id(2);
        var7 = var1;
    }
    data[var8] = var7;
    data[get_global_id(1)] = x;
}
