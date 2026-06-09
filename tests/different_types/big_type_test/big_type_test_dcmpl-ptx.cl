__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void big_type_test(uint8 arg0, __global uint *arg1, uint arg2, uint8 arg3, uint8 arg4, uint8 arg5, ulong arg6, ulong arg7)
{
    arg1[get_global_id(0)] = arg0.s1 + arg0.s2 + arg5.s1 + arg7;
}
