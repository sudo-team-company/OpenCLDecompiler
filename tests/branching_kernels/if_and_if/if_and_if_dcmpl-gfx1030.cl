__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void if_and_if(int x, __global int *data, int y)
{
    uint var5;
    var5 = get_global_id(0);
    if (0 == var5) {
        var5 = get_global_id(1);
    }
    data[var5] = x;
    if (x >= y) {
        var5 = get_global_id(2);
    }
    data[var5] = y;
}
