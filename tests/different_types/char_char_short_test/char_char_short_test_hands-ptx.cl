__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char_char_short_test(char arg0, char arg1, short arg2, __global uint *arg3, __global uint *arg4)
{
    arg3[get_global_id(0)] = arg1 + arg0;
    arg4[get_global_id(0)] = arg2;
}
