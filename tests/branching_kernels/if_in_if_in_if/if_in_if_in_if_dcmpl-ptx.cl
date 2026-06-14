__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void if_in_if_in_if(uint arg0, __global uint *arg1, __global uint *arg2, uint arg3, __global double *arg4, __global double *arg5, __global uint *arg6)
{
    uint var0;
    double var1;
    double var2;
    uint var3;
    double var4;
    if (get_global_id(0) < arg0) {
        var0 = arg1[get_global_id(0)];
        var1 = arg5[var0];
        if (var1 < arg3) {
            var2 = arg4[get_global_id(0)];
            var3 = arg2[get_global_id(0)];
            var4 = arg5[var3];
            if (var4 > (var1 + var2)) {
                arg5[var3] = var1 + var2;
                *arg6 = 1;
            }
        }
    }
}
