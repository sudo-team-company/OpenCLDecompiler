__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy_x(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1;
}
