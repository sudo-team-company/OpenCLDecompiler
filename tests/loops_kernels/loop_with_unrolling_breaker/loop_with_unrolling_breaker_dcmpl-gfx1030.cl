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
    if (unrollingBreaker < 0) {
        var0 = (uint)unrollingBreaker < 63 ? (uint)unrollingBreaker < 63 : 63;
        var1 = var10[get_global_id(0)];
        var7 = var1;
        do {
            var6 = var7 * x;
            var7 = var8 + (var6);
            var8 = var8 + 1;
            var9 = var9;
            var10 = var10 + (-1) / 4;
            var11 = var11 + (-1) / 4;
            var12 = 1 != (0 - var0);
            var12 = 1 != (0 - var0);
        } while (1 != (0 - var0));
        data[get_global_id(0)] = (var6) - (0 - var0);
    }
}
