__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_reverse_uint2(__global uint2 *edges1, __global const uint2 *edges2)
{
    uint2 var0;
    var0 = edges2[get_global_id(0)];
    edges1[get_global_id(0)] = var0.s10;
}
