__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void copy_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0);
    data[get_global_id(1)] = get_group_id(1);
    data[get_global_id(2)] = get_group_id(2);
}
