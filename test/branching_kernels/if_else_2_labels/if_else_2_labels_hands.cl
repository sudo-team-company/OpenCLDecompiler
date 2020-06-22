__kernel __attribute__((reqd_work_group_size(16, 16, 1)))
void localVarExample(int x, __global int *data, int y)
{
    uint var6;
    uint *var3;
    if (1 == get_global_id(0)) {
        var3 = &data[get_global_id(0)];
        var6 = get_global_id(1) * x - y;
    }
    else {
        var3 = &data[get_global_id(0)];
        var6 = y * x;
    }
    *var3 = var6;
    data[get_global_id(1)] = x;
}
