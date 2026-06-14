__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void bellmanFordIter_ver1(uint arg0, __global uint2 *arg1, __global double *arg2, __global double *arg3, __global uint *arg4)
{
    uint2 var0;
    double var1;
    double var2;
    double var3;
    if (get_global_id(0) < arg0) {
        var0 = arg1[get_global_id(0)];
        var1 = arg3[var0.s0];
        if (var1 < 1e12) {
            var2 = arg2[get_global_id(0)];
            var3 = arg3[var0.s1];
            if (var3 > (var1 + var2)) {
                arg3[var0.s1] = var1 + var2;
                *arg4 = 1;
            }
        }
    }
}
