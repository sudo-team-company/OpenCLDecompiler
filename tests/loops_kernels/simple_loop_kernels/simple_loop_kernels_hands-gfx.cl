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
            var12 = ;
            var7 = (ulong)var8 + (ulong)1;
            var14 = var10;
            var8 = var7;
            var9 = (ulong) + (ulong)var9;
            var10 = var10 + 4 / 4;
            var13 = var9;
            var11 = var11 + 0 / 4;
            var12 = (uint)var8 < (uint)63 && (uint)!(unrollingBreaker) != (uint)var8;
            var9 = (var9) * x;
            *(__global uint*)(var14) = var13;
        } while ((uint)var8 < (uint)63 && (uint)!(unrollingBreaker) != (uint)var8);
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    int var10;
    __global uint *var11;
    int var6;
    int var7;
    __global uint *var8;
    __global uint *var9;
    if (var6 == 0) {
        do {
            var11 = var8;
            var6 = (ulong)var6 + (ulong)(-1);
            var7 = (ulong) + (ulong)var7;
            var8 = var8 + 4 / 4;
            var10 = var7;
            var9 = var9 + 0 / 4;
            var7 = (var7) * x;
            *(__global uint*)(var11) = var10;
        } while (!(((ulong)var6 + (ulong)(-1)) == 0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    __global uint *var11;
    int var12;
    __global uint *var13;
    int var8;
    int var9;
    if (var8 == 0) {
        var10 = data + (var8 * 4) / 4;
        var11 = data + (0 * 4) / 4;
        do {
            var13 = var10;
            var8 = (ulong)var8 + (ulong)(-1);
            var9 = (ulong) + (ulong)var9;
            var10 = var10 + (-4) / 4;
            var12 = var9;
            var11 = var11 + (-1) / 4;
            var9 = (var9) * x;
            *(__global uint*)(var13) = var12;
        } while (!(((ulong)var8 + (ulong)(-1)) == 0));
    }
}
