__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_and_if(int x, __global int *data, int y)
{
    uint var3;
    var3 = get_global_id(0);
    if (0 == var3) {
        var3 = get_global_id(1);
    }
    data[var3] = x;
    if (x < y) {
        var3 = get_global_id(2);
    }
    data[var3] = y;
}
