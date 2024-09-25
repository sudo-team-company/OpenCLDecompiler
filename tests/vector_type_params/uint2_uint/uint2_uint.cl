__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_uint(
    __global const uint2* restrict edges,
    __global double* restrict d
)
{
      uint edgeId = get_global_id(0);

        if (edges[edgeId].y > edges[edgeId].x) {
            d[edges[edgeId].y] = d[edges[edgeId].x];
        }
}
