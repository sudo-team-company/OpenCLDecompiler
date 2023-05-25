__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void if_and_if(int x, __global int *data, int y)
{
    uint var5;
    var5 = get_global_id(0);
    if ((uint)0 == (uint)var5) {
        var5 = get_global_id(1);
    }
    data[var5] = x;
    if ((int)x >= (int)y) {
        var5 = get_global_id(2);
    }
    data[var5] = y;
}
