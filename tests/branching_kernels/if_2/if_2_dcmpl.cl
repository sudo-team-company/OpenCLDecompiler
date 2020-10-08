__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_2(int x, __global int *data, int y)
{
    uint var0;
    var0 = get_global_id(0);
    if (0 == var0) {
        var0 = get_global_id(1);
    }
    data[(var0 * 4) / 4] = x;
}
