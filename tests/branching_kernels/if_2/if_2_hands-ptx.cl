__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_2(uint arg0, __global uint *arg1, uint arg2)
{
    uint var0;
    var0 = get_global_id(0);
    if (var0 == 0) {
        var0 = get_global_id(1);
    }
    arg1[var0] = arg0;
}
