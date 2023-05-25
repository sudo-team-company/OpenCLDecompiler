__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_and_if(int x, __global int *data, int y)
{
    uint var4;
    var4 = get_global_id(0);
    if ((int)0 == (int)var4) {
        var4 = get_global_id(1);
    }
    data[var4] = x;
    if ((int)x < (int)y) {
        var4 = get_global_id(2);
    }
    data[var4] = y;
}
