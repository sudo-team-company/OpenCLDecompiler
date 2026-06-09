__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global uint *arg0, uint arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) * get_local_size(0);
    arg0[get_global_id(1)] = get_num_groups(1) * get_local_size(1);
    arg0[get_global_id(2)] = get_num_groups(2) * get_local_size(2);
}
