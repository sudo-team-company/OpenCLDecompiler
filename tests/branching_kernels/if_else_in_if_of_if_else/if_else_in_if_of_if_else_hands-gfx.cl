__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_else(int x, __global int *data, int y)
{
    uint var5;
    uint var7;
    int var8;
    var7 = get_global_id(0);
    if ((uint)1 != (uint)var7) {
        var8 = get_global_id(0) * y;
        var5 = get_global_id(1);
    }
    else {
        var5 = get_global_id(1);
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((int)x >= (int)y) {
            var8 = (ulong)y + (ulong)get_global_id(1);
            var7 = get_global_id(2);
        }
        else {
            var7 = get_global_id(2);
            var8 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    data[var7] = var8;
    data[var5] = x;
}
