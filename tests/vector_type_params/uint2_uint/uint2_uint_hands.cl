__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_uint(__global const uint2 *edges, __global double *d)
{
    uint2 var0;
    double var1;
    var0 = edges[get_global_id(0)];
    if (var0.s1 > var0.s0) {
        var1 = d[var0.s0];
        d[var0.s1] = var1;
    }
}
