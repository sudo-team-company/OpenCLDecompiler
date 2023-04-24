__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_else(int x, __global int *data, int y)
{
    uint var1;
    int var2;
    uint var5;
    var1 = get_global_id(0);
    if ((uint)1 != (uint)var1) {
        var2 = get_global_id(0) * y;
        var5 = get_global_id(1);
    }
    else {
        var5 = get_global_id(1);
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((int)x >= (int)y) {
            var2 = (ulong)y + (ulong)get_global_id(1);
            var1 = get_global_id(2);
        }
        else {
            var1 = get_global_id(2);
            var2 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    data[var1] = var2;
    data[var5] = x;
}
