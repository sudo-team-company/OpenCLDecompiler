__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_else(uint arg0, __global uint *arg1, uint arg2)
{
    if (get_global_id(0) != 1) {
        arg1[get_global_id(0)] = get_global_id(0) * arg2;
    }
    else {
        arg1[get_global_id(0)] = (get_global_id(1) * arg0) - arg2;
        if (arg0 >= arg2) {
            arg1[get_global_id(2)] = get_global_id(1) + arg2;
        }
        else {
            arg1[get_global_id(2)] = get_global_id(2) + arg0;
        }
    }
    arg1[get_global_id(1)] = arg0;
}
