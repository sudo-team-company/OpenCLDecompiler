__kernel __attribute__((reqd_work_group_size(16, 16, 16)))
void localVarExample(int x, __global int *data, int y)
{
    if (0 == get_global_id(0)) {
        if (y > data[get_global_id(1)]) {
            data[get_global_id(2)] = x;
        }
    }
    data[get_global_id(0)] = y;
}
