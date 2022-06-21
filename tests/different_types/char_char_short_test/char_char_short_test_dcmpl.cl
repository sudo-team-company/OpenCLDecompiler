__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char_char_short_test(char x1, char x2, short y, __global uint *data0, __global uint *data1)
{
    data0[get_global_id(0)] = (ulong)x2 + (ulong)x1;
    data1[get_global_id(0)] = y;
}
