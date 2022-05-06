__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_2_labels(int x, __global int *data, int y)
{
    __global int *var3;
    int var6;
    if ((int)1 == (int)get_global_id(0)) {
        var3 = data + (get_global_id(0) * 4) / 4;
        var6 = (ulong)(get_global_id(1) * x) - (ulong)y;
    }
    else {
        var3 = data + (get_global_id(0) * 4) / 4;
        var6 = y * x;
    }
    *(__global int*)(var3) = var6;
    data[get_global_id(1)] = x;
}
