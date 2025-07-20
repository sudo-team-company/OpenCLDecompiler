__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_1(int x, __global int *data, int y)
{
    if (1 == get_global_id(0)) {
        data[get_global_id(0)] = (get_global_id(1) * x) - y;
    }
    data[get_global_id(1)] = x;
}
