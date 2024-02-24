__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0);
    arg1[get_global_id(1)] = get_num_groups(1);
    arg1[get_global_id(2)] = get_num_groups(2);
}
