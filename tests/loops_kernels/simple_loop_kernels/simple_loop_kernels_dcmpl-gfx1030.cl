__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    __global uint *var11;
    uint var12;
    int var13;
    __global uint *var14;
    uint var7;
    int var8;
    int var9;
    var8 = 0;
    if (unrollingBreaker == 0) {
        do {
            var7 = (ulong)var8 + 1;
            var14 = var10;
            var8 = var7;
            var9 = (ulong) + (ulong)var9;
            var10 = var10 + 4 / 4;
            var13 = var9;
            var11 = var11 + 0 / 4;
            var12 = (uint)var8 < 63 && (uint)!(unrollingBreaker) != (uint)var8;
            var9 = (var9) * x;
            var14 = var13;
        } while ((uint)var8 < 63 && (uint)!(unrollingBreaker) != (uint)var8);
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    int var5;
    int var6;
    __global uint *var7;
    __global uint *var8;
    int var9;
    var5 = unrollingBreaker;
    if (var5 == 0) {
        do {
            var10 = var7;
            var5 = (ulong)var5 + (-1);
            var6 = (ulong) + (ulong)var6;
            var7 = var7 + 4 / 4;
            var9 = var6;
            var8 = var8 + 0 / 4;
            var6 = (var6) * x;
            var10 = var9;
        } while (!((uint)((ulong)var5 + (-1)) == 0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    int var11;
    __global uint *var12;
    int var7;
    int var8;
    __global uint *var9;
    var7 = unrollingBreaker;
    if (var7 == 0) {
        var9 = data + (var7 * 4) / 4;
        var10 = data + (0 * 4) / 4;
        do {
            var12 = var9;
            var7 = (ulong)var7 + (-1);
            var8 = (ulong) + (ulong)var8;
            var9 = var9 + (-4) / 4;
            var11 = var8;
            var10 = var10 + (-1) / 4;
            var8 = (var8) * x;
            var12 = var11;
        } while (!((uint)((ulong)var7 + (-1)) == 0));
    }
}
