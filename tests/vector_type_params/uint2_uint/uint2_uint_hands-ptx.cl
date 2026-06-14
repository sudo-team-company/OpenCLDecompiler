__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint2_uint(__global uint2 *arg0, __global double *arg1)
{
    uint2 var0;
    double var1;
    var0 = arg0[get_global_id(0)];
    if (var0.s1 > var0.s0) {
        var1 = arg1[var0.s0];
        arg1[var0.s1] = var1;
    }
}
