__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void if_and_if(int x, __global int *data, int y)
{
    uint var2;
    var2 = get_global_id(0);
    if ((uint)0 == (uint)var2) {
        var2 = get_global_id(1);
    }
    data[var2] = x;
    if ((int)x >= (int)y) {
    }
    data[var5] = y;
}
