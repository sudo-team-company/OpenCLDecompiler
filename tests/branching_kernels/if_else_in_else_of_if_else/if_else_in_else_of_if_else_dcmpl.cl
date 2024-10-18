__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    int var3;
    uint var6;
    var6 = get_global_id(0);
    if ((int)1 == (int)var6) {
        var3 = (ulong)(get_global_id(1) * x) - (ulong)y;
    }
    else {
        var6 = get_global_id(2);
        data[get_global_id(0)] = get_global_id(0) * y;
        var0 = ((int)x >= (int)y ? 1 : 0) ? (ulong)y + (ulong)get_global_id(1) : (ulong)((ulong)get_global_offset(2) + (ulong)x) + (ulong)(get_global_id(2) - get_global_offset(2));
        var3 = var0;
    }
    data[var6] = var3;
    data[get_global_id(1)] = x;
}
