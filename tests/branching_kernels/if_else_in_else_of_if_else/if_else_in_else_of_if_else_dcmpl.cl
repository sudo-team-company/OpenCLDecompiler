__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var3;
    uint var6;
    var6 = get_global_id(0);
    if (1 == var6) {
        var3 = (get_global_id(1) * x) - y;
    }
    else {
        var6 = get_global_id(2);
        data[get_global_id(0)] = get_global_id(0) * y;
        var0 = ((x >= y) ? (1) : (0)) ? y + get_global_id(1) : x + get_global_id(2);
        var3 = var0;
    }
    data[var6] = var3;
    data[get_global_id(1)] = x;
}
