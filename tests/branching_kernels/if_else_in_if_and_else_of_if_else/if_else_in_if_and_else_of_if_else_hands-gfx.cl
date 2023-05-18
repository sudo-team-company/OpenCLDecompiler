__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_1(int x, __global int *data, int y)
{
    int var5;
    if ((uint)1 != (uint)get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if ((int)x >= (int)y) {
            var5 = (ulong)y + (ulong)get_global_id(1);
        }
        else {
            var5 = (ulong)x + (ulong)get_global_id(2);
        }
    }
    else {
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((int)x >= (int)y) {
            var5 = get_global_id(1) * y;
        }
        else {
            var5 = get_global_id(2) * x;
        }
    }
    data[get_global_id(2)] = var5;
    data[get_global_id(1)] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_2(int x, __global int *data, int y)
{
    int var8;
    if ((uint)1 != (uint)get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if ((uint)get_global_id(1) != (uint)get_global_id(2)) {
            var8 = (ulong)y + (ulong)get_global_id(1);
        }
        else {
            var8 = (ulong)x + (ulong)get_global_id(1);
        }
    }
    else {
        data[get_global_id(0)] = (uint)(get_global_id(1) * x) - (uint)y;
        if ((uint)get_global_id(1) >= (uint)get_global_id(2)) {
            var8 = get_global_id(1) * y;
        }
        else {
            var8 = get_global_id(2) * x;
        }
    }
    data[get_global_id(2)] = var8;
}
