__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var1;
    uint var2;
    uint var3;
    int var8;
    if (1 == get_global_id(0)) {
        data[get_global_id(0)] = (get_global_id(1) * x) - y;
        var0 = x >= y ? 0 : 1;
        var1 = var0 ? get_global_id(1) * y : get_global_id(2) * x;
        var8 = var1;
    }
    else {
        data[get_global_id(0)] = get_global_id(0) * y;
        var2 = x >= y ? 0 : 1;
        var3 = var2 ? y + get_global_id(1) : x + get_global_id(2);
        var8 = var3;
    }
    data[get_global_id(2)] = var8;
    data[get_global_id(1)] = x;
}
