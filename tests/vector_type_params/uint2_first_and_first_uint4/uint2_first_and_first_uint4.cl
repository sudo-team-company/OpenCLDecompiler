__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_first_and_first_uint4(
    __global uint2* restrict edges1,
    __global const uint4* restrict edges2,
    __global const uint4* restrict edges3
)
{
      uint edgeId = get_global_id(0);
      edges1[edgeId] = (uint2)(edges2[edgeId].x, edges3[edgeId].x);
}
