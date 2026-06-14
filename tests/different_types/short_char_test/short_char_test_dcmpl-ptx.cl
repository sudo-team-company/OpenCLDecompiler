__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void short_char_test(short arg0, char arg1, __global uint *arg2, __global uint *arg3)
{
    arg2[get_global_id(0)] = arg1;
    arg3[get_global_id(0)] = arg0;
}
