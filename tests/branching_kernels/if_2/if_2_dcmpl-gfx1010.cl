__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_2(int x, __global int *data, int y)
{
    uint var2;
    var2 = get_global_id(0);
    if (0 == var2) {
        var2 = get_global_id(1);
    }
    data[var2] = x;
}
