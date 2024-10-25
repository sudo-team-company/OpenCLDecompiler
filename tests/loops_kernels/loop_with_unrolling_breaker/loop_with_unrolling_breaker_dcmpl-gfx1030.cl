__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_with_unrolling_breaker(__global int *data, int x, int unrollingBreaker)
{
    uint var0;
    int var1;
    __global int *var10;
    __global int *var11;
    unknown type var12;
    int var6;
    uint var7;
    uint var8;
    uint var9;
    if ((int)unrollingBreaker < (int)0) {
        var0 = (uint)unrollingBreaker < (uint)63 ? (uint)unrollingBreaker < (uint)63 : 63;
        var1 = var10[get_global_id(0)];
        var7 = var1;
        do {
            var6 = var7 * x;
            var7 = (ulong)var8 + (ulong)(var6);
            var8 = (ulong)var8 + (ulong)1;
            var9 = var9;
            var10 = var10 + (-1) / 4;
            var11 = var11 + (-1) / 4;
            var12 = (ulong)1 != (ulong)((ulong)0 - var0);
            var12 = (ulong)1 != (ulong)((ulong)0 - var0);
        } while ((ulong)1 != (ulong)((ulong)0 - var0));
        data[get_global_id(0)] = (uint)(var6) - (uint)((ulong)0 - var0);
    }
}
