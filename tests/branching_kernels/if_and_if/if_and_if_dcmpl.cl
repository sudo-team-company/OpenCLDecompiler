__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_and_if(int x, __global int *data, int y)
{
    uint var0;
    uint var5;
    var0 = get_global_id(0);
    if (0 == var0) {
        var0 = get_global_id(1);
    }
    data[(var0 * 4) / 4] = x;
    var5 = var0;
    if (x < y) {
        var5 = get_global_id(2);
    }
    data[(var5 * 4) / 4] = y;
}
