__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    uint var1;
    int var4;
    if ((int)1 == (int)get_global_id(0)) {
        data[get_global_id(0)] = (ulong)(get_global_id(1) * x) - (ulong)y;
        var0 = ((int)x >= (int)y ? 1 : 0) ? get_global_id(1) * y : get_global_id(2) * x;
        var4 = var0;
    }
    else {
        data[get_global_id(0)] = get_global_id(0) * y;
        var1 = ((int)x >= (int)y ? 1 : 0) ? (ulong)y + (ulong)get_global_id(1) : (ulong)x + (ulong)get_global_id(2);
        var4 = var1;
    }
    data[get_global_id(2)] = var4;
    data[get_global_id(1)] = x;
}
