__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void copy_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0);
    arg1[get_global_id(1)] = get_local_id(1);
    arg1[get_global_id(2)] = get_local_id(2);
}
