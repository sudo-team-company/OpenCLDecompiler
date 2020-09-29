__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_else(int x, __global int *data, int y)
{
    uint var13;
    uint var15;
    if (1 == get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = (get_global_id(1) * x) - y;
        if (x < y) {
            var13 = y + get_global_id(1);
            var15 = get_global_id(2);
        }
        else {
            var13 = (get_global_offset(2) + x) + (get_global_id(2) - get_global_offset(2));
            var15 = get_global_id(2);
        }
    }
    else {
        var15 = get_global_id(0);
        var13 = get_global_id(0) * y;
    }
    data[(var15 * 4) / 4] = var13;
    data[(get_global_id(1) * 4) / 4] = x;
}
