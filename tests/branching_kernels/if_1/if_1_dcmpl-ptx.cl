__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_1(uint arg0, __global uint *arg1, uint arg2)
{
    if (get_global_id(0) == 1) {
        arg1[1] = (get_global_id(1) * arg0) - arg2;
    }
    arg1[get_global_id(1)] = arg0;
}
