__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_else_of_if_else(int x, __global int *data, int y)
{
    int var7;
    uint var8;
    if ((uint)1 != (uint)get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        var8 = get_global_id(2);
        if ((int)x >= (int)y) {
            var7 = (ulong)y + (ulong)get_global_id(1);
        }
        else {
            var7 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    else {
        var8 = 1;
        var7 = (uint)(get_global_id(1) * x) - (uint)y;
    }
    data[var8] = var7;
    data[get_global_id(1)] = x;
}
