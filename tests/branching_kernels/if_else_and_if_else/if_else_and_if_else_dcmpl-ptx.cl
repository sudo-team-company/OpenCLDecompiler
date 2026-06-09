__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else(uint arg0, __global uint *arg1, uint arg2)
{
    uint var0;
    var0 = get_global_id(0) == 1 ? (get_global_id(1) * arg0) - arg2 : get_global_id(0) * arg2;
    arg1[get_global_id(0)] = var0;
    arg1[get_global_id(2)] = min(arg0, arg2);
    arg1[get_global_id(1)] = arg0;
}
