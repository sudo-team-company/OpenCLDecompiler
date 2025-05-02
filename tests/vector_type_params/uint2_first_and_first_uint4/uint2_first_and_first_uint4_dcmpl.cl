__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_first_and_first_uint4(__global uint2 *edges1, __global const uint4 *edges2, __global const uint4 *edges3)
{
    uint var0;
    uint var1;
    var0 = edges2[get_global_id(0)].s0;
    var1 = edges3[get_global_id(0)].s0;
    edges1[get_global_id(0)] = (uint2)(var0, var1);
}
