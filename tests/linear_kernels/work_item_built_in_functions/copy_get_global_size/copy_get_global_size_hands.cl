__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0);
    data[get_global_id(1)] = get_global_size(1);
    data[get_global_id(2)] = get_global_size(2);
}
