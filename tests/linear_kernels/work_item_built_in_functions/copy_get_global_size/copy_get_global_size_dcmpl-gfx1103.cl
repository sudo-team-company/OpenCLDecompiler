__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)(get_num_groups(0) * 16) + (ulong)unknown yet;
    arg0[get_global_id(1)] = (ulong)(get_num_groups(1) * 2) + (ulong)(unknown yet // 65536);
    arg0[get_global_id(2)] = (ulong)(get_num_groups(2) * 2) + (ulong)unknown yet;
}
