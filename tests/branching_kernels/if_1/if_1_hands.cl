__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_1(int x, __global int *data, int y)
{
    if ((int)1 == (int)get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = (ulong)(get_global_id(1) * x) - (ulong)y;
    }
    data[(get_global_id(1) * 4) / 4] = x;
}
