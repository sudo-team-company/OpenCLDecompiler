__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void bellmanFordIter_ver1(uint nEdges, __global const uint2 *edges, __global const double *weights, __global double *d, __global uint *changed)
{
    uint2 var0;
    double var1;
    double var2;
    double var3;
    if (nEdges > get_global_id(0)) {
        var0 = edges[get_global_id(0)];
        var1 = d[var0.s0];
        if (var1 < 1e12) {
            var2 = d[var0.s1];
            var3 = weights[get_global_id(0)];
            if (var2 > (var1 + var3)) {
                d[var0.s1] = var1 + var3;
                *changed = 1;
            }
        }
    }
}
