__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_first_fourth_element_uint4(__global uint2 *arg0, __global uint4 *arg1)
{
    uint4 var0;
    var0 = arg1[get_global_id(0)];
    arg0[get_global_id(0)] = var0.s03;
}
