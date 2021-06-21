__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else(int x, __global int *data, int y)
{
    int var13;
    uint var15;
    var15 = get_global_id(0);
    if ((int)1 == (int)var15) {
        data[var15] = (ulong)(get_global_id(1) * x) - (ulong)y;
        var15 = get_global_id(2);
        if ((int)x < (int)y) {
            var13 = (ulong)((ulong)get_global_offset(2) + (ulong)x) + (ulong)(get_global_id(2) - get_global_offset(2));
        }
        else {
            var13 = (ulong)y + (ulong)get_global_id(1);
        }
    }
    else {
        var13 = var15 * y;
    }
    data[var15] = var13;
    data[get_global_id(1)] = x;
}
