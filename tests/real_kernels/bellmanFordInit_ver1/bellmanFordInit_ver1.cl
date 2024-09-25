#define WORKGROUP 64
#define INF 1e12

__kernel __attribute__((reqd_work_group_size(WORKGROUP, 1, 1)))
void bellmanFordIter_ver1(
    uint nEdges,
    __global const uint2* restrict edges,
    __global const double* restrict weights,
    __global double* restrict d,
    __global uint* restrict changed
)
{
    uint edgeId = get_global_id(0);

    if (edgeId >= nEdges) {
        return;
    }

    if (d[edges[edgeId].x] < INF) {
        double relaxWeight = d[edges[edgeId].x] + weights[edgeId];

        if (d[edges[edgeId].y] > relaxWeight) {
            d[edges[edgeId].y] = relaxWeight;
            *changed = 1;
        }
    }
}
