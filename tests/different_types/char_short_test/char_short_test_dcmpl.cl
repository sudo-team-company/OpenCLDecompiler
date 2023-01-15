__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char_short_test(char x, short y, __global uint *data0, __global uint *data1)
{
    data0[get_global_id(0)] = x;
    data1[get_global_id(0)] = y;
}
