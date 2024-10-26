__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_break_kernel(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var5;
    uint var6;
    __global uint *var7;
    __global uint *var8;
    uint var9;
    if ((int)unrollingBreaker == 0) {
        var7 = data;
        var8 = data;
        var6 = y;
        var9 = 0x0;
        do {
            var0 = *var7;
            var6 = var0 + var6;
            *var7 = var6;
            if (!(0 != (int)(var6))) {
                break;
            }
            var6 = (var6) * x;
            var7 = var7 + 4 / 4;
            var8 = var8 + 0 / 4;
            var9 = (ulong)var9 + 1;
        } while (!(((ulong)var9 + 1) >= unrollingBreaker));
    }
    var5 = data[get_global_id(0)];
    data[get_global_id(0)] = x + var5;
}
