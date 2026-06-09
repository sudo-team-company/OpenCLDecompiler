__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char_short_test(char arg0, short arg1, __global uint *arg2, __global uint *arg3)
{
    arg2[get_global_id(0)] = arg0;
    arg3[get_global_id(0)] = arg1;
}
