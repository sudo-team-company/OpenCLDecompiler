__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_in_if(int x, __global int *data, int y)
{
    uint var0;
    if ((int)0 == (int)get_global_id(0)) {
        var0 = data[(get_global_id(1) * 4) / 4];
        if ((int)y > (int)var0) {
            data[(get_global_id(2) * 4) / 4] = x;
        }
    }
    data[(get_global_id(0) * 4) / 4] = y;
}
