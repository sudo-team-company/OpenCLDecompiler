__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else(int x, __global int *data, int y)
{
    uint var0;
    int var1;
    if ((uint)1 != (uint)get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if ((int)x >= (int)y) {
            var0 = (ulong)y + (ulong)get_global_id(1);
        }
        else {
            var0 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    else {
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((int)x >= (int)y) {
            var1 = get_global_id(1) * y;
        }
        else {
            var1 = get_global_id(2) * x;
        }
    }
    data[get_global_id(2)] = var1;
    data[get_global_id(1)] = x;
}
