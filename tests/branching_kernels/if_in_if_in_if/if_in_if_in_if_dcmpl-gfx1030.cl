__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void if_in_if_in_if(uint nEdges, __global const uint *edges_x, __global const uint *edges_y, uint some_const, __global const double *weights, __global double *d, __global uint *changed)
{
    uint var0;
    double var1;
    uint var2;
    double var3;
    double var4;
    if (nEdges > get_global_id(0)) {
        var0 = edges_x[get_global_id(0)];
        var1 = d[var0];
        if (var1 < some_const) {
            var2 = edges_y[get_global_id(0)];
            var3 = weights[get_global_id(0)];
            var4 = d[var2];
            if (var4 > (var1 + var3)) {
                d[var2] = var1 + var3;
                *changed = 1;
            }
        }
    }
}
