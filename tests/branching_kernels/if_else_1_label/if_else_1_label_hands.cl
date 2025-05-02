__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_1_label(int x, __global int *data, int y)
{
    __global int *var0;
    uint var2;
    if (2 == get_global_id(0)) {
        var0 = data + get_global_id(0);
        var2 = (get_global_id(1) * x) - y;
    }
    else {
        var2 = get_global_id(0) * y;
        var0 = data + get_global_id(0);
    }
    *var0 = var2;
    data[get_global_id(1)] = x;
}
