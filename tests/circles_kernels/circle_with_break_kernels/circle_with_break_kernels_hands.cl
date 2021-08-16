__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void circleBreakKernel(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var10;
    uint var6;
    uint var7;
    uint var8;
    uint var9;
    if (unrollingBreaker == 0) {
        var7 = y;
        var8 = data;
        var9 = data;
        var10 = 0x0;
        do {
            var0 = var8;
            var7 = (ulong)var0 + (ulong)var7;
            *var8 = var7;
            if (!((int)0 != (int)(var7))) {
                break;
            }
            var7 = (var7) * x;
            var8 = (ulong)var8 + (ulong)(4 / 4);
            var9 = (ulong)var9 + (ulong)(0 / 4);
            var10 = (ulong)var10 + (ulong)1;
        } while (!(((ulong)var10 + (ulong)1) >= unrollingBreaker));
    }
    var6 = data[get_global_id(0)];
    data[get_global_id(0)] = (ulong)x + (ulong)var6;
}
