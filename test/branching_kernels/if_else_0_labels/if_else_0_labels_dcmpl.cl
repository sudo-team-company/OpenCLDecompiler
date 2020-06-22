__kernel __attribute__((reqd_work_group_size(16, 16, 1)))
void localVarExample(int x, __global int *data, int y)
{
    uint var0;
    var0 = get_global_id(0) != 1 ? y : get_global_id(1) * x - y;
    data[get_global_id(0)] = var0;
    data[get_global_id(1)] = x;
}
