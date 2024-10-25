#define WORKGROUP 64


__kernel __attribute__((reqd_work_group_size(WORKGROUP, 1, 1)))
void if_in_if_in_if(
    uint nEdges,
    __global const uint* restrict edges_x,
    __global const uint* restrict edges_y,
    uint some_const,
    __global const double* restrict weights,
    __global double* restrict d,
    __global uint* restrict changed
)
{
    uint edgeId = get_global_id(0);

    if (edgeId >= nEdges) {
        return;
    }

    if (d[edges_x[edgeId]] < some_const) {
        double relaxWeight = d[edges_x[edgeId]] + weights[edgeId];

        if (d[edges_y[edgeId]] > relaxWeight) {
            d[edges_y[edgeId]] = relaxWeight;
            *changed = 1;
        }
    }
}
