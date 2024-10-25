__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0);
    arg0[get_global_id(1)] = get_global_size(1);
    arg0[get_global_id(2)] = get_global_size(2);
}
