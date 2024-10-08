__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    int var5;
    uint var6;
    var6 = get_global_id(0);
    if (1 == (int)var6) {
        var5 = (get_global_id(1) * x) - (ulong)y;
    }
    else {
        var6 = get_global_id(2);
        data[get_global_id(0)] = get_global_id(0) * y;
        var0 = (x >= y ? 1 : 0) ? (ulong)y + get_global_id(1) : ((ulong)get_global_offset(2) + (ulong)x) + (get_global_id(2) - get_global_offset(2));
        var5 = var0;
    }
    data[var6] = var5;
    data[get_global_id(1)] = x;
}
