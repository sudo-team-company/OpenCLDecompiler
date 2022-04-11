__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_uint2(
    __global uint2* restrict edges1,
    __global const uint2* restrict edges2
)
{
      uint edgeId = get_global_id(0);
      edges1[edgeId] = edges2[edgeId];
}