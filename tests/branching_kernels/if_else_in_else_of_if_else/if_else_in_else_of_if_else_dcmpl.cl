__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var2;
    uint var7;
    uint var8;
    var8 = get_global_id(0);
    if ((int)1 == (int)var8) {
        var7 = (ulong)(get_global_id(1) * x) - (ulong)y;
    }
    else {
        data[(var8 * 4) / 4] = var8 * y;
        var2 = ((int)x >= (int)y ? 1 : 0) ? (ulong)y + (ulong)get_global_id(1) : (ulong)((ulong)get_global_offset(2) + (ulong)x) + (ulong)(get_global_id(2) - get_global_offset(2));
        var7 = var2;
        var8 = get_global_id(2);
    }
    data[(var8 * 4) / 4] = var7;
    data[(get_global_id(1) * 4) / 4] = x;
}
