__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 2;
    data[get_global_id(1)] = 2;
    data[get_global_id(2)] = 4;
}
