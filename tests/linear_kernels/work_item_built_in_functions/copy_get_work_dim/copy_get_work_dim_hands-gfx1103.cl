__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim();
}
