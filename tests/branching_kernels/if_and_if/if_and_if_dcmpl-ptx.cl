__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void if_and_if(uint arg0, __global uint *arg1, uint arg2)
{
    uint var0;
    __global uint *var2;
    var0 = get_global_id(0);
    if (var0 == 0) {
        var0 = get_global_id(1);
    }
    var2 = arg1 + var0;
    *var2 = arg0;
    if (arg0 < arg2) {
        var2 = arg1 + get_global_id(2);
    }
    *var2 = arg2;
}
