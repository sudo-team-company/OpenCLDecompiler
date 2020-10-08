__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else(int x, __global int *data, int y)
{
    uint var13;
    uint var15;
    var15 = get_global_id(0);
    if (1 == var15) {
        data[(var15 * 4) / 4] = (get_global_id(1) * x) - y;
        var15 = get_global_id(2);
        if (x < y) {
            var13 = (get_global_offset(2) + x) + (get_global_id(2) - get_global_offset(2));
        }
        else {
            var13 = y + get_global_id(1);
        }
    }
    else {
        var13 = var15 * y;
    }
    data[(var15 * 4) / 4] = var13;
    data[(get_global_id(1) * 4) / 4] = x;
}
