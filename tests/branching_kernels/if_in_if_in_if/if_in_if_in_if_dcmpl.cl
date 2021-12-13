__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void if_in_if_in_if(uint nEdges, __global uint *edges_x, __global uint *edges_y, uint some_const, __global double *weights, __global double *d, __global uint *changed)
{
    uint var0;
    double var1;
    uint var3;
    double var4;
    double var6;
    if ((uint)nEdges > (uint)get_global_id(0)) {
        var0 = edges_x[get_global_id(0)];
        var1 = d[var0];
        if ((double)var1 < (double)some_const) {
            var3 = edges_y[get_global_id(0)];
            var4 = weights[get_global_id(0)];
            var6 = d[var3];
            if ((uint)var6 > (uint)((double)var1 + (double)var4)) {
                d[var3] = (double)var1 + (double)var4;
                *changed = 1;
            }
        }
    }
}
