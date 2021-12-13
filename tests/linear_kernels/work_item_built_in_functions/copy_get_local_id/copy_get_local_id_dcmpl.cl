__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void copy_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0);
    data[get_global_id(1)] = get_local_id(1);
    data[get_global_id(2)] = get_local_id(2);
}
