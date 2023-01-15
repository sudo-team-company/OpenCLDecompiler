__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char_char_short_test(char x1, char x2, short y, __global uint *data0, __global uint *data1)
{
    uint id = get_global_id(0);
    data0[id] = x1 + x2;
    data1[id] = y;
}
