__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_of_if_else(int x, __global int *data, int y)
{
    int var12;
    uint var14;
    var14 = get_global_id(0);
    if ((int)1 == (int)var14) {
        data[var14] = (ulong)(get_global_id(1) * x) - (ulong)y;
        var14 = get_global_id(2);
        if ((int)x < (int)y) {
            var12 = (ulong)((ulong)get_global_offset(2) + (ulong)x) + (ulong)(get_global_id(2) - get_global_offset(2));
        }
        else {
            var12 = (ulong)y + (ulong)get_global_id(1);
        }
    }
    else {
        var12 = var14 * y;
    }
    data[var14] = var12;
    data[get_global_id(1)] = x;
}
