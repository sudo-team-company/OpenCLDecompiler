__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void bellmanFordIter_ver1(uint nEdges, __global uint2 *edges, __global double *weights, __global double *d, __global uint *changed)
{
    uint2 var0;
    double var1;
    double var2;
    double var3;
    if ((uint)nEdges > (uint)get_global_id(0)) {
        var0 = edges[get_global_id(0)];
        var1 = d[var0.s0];
        if ((double)var1 < (double)1e12) {
            var2 = d[var0.s1];
            var3 = weights[get_global_id(0)];
            if ((double)var2 > (double)((double)var1 + (double)var3)) {
                d[var0.s1] = (double)var1 + (double)var3;
                *changed = 1;
            }
        }
    }
}
