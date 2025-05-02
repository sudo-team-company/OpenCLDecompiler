__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_2_labels(int x, __global int *data, int y)
{
    __global int *var0;
    uint var4;
    if (1 == get_global_id(0)) {
        var0 = data + get_global_id(0);
        var4 = (get_global_id(1) * x) - y;
    }
    else {
        var0 = data + get_global_id(0);
        var4 = y * x;
    }
    *var0 = var4;
    data[get_global_id(1)] = x;
}
