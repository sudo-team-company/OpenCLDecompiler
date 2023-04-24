__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_2_labels(int x, __global int *data, int y)
{
    __global int *var1;
    int var4;
    if ((int)1 == (int)get_global_id(0)) {
        var1 = data + (get_global_id(0) * 4) / 4;
        var4 = (ulong)(get_global_id(1) * x) - (ulong)y;
    }
    else {
        var1 = data + (get_global_id(0) * 4) / 4;
        var4 = y * x;
    }
    *(__global int*)(var1) = var4;
    data[get_global_id(1)] = x;
}
