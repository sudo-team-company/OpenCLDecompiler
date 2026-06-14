__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_first_and_first_uint4(__global uint2 *arg0, __global uint4 *arg1, __global uint4 *arg2)
{
    uint4 var0;
    uint4 var1;
    var0 = arg1[get_global_id(0)];
    var1 = arg2[get_global_id(0)];
    arg0[get_global_id(0)] = (uint2)(var0.s0, var1.s0);
}
