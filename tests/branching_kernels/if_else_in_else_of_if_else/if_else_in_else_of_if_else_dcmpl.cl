__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    uint var2;
    uint var7;
    uint var8;
    var8 = get_global_id(0);
    if (1 == get_global_id(0)) {
        var7 = (get_global_id(1) * x) - y;
    }
    else {
        data[(get_global_id(0) * 4) / 4] = get_global_id(0) * y;
        var2 = (x >= y ? 1 : 0) ? y + get_global_id(1) : (get_global_offset(2) + x) + (get_global_id(2) - get_global_offset(2));
        var7 = var2;
        var8 = get_global_id(2);
    }
    data[(var8 * 4) / 4] = var7;
    data[(get_global_id(1) * 4) / 4] = x;
}
