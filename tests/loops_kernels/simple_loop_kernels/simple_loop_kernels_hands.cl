__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    __global uint *var11;
    uint var12;
    __global uint *var13;
    uint var9;
    __global uint *var10;
    if (unrollingBreaker == 0) {
        var9 = 0x1;
        var10 = data;
        var11 = data;
        var12 = y;
        do {
            var13 = var10;
            var0 = *(__global uint*)(var13);
            var9 = (ulong)var9 + (ulong)1;
            var10 = var10 + 4 / 4;
            var11 = var11 + 0 / 4;
            var12 = (ulong)var0 + (ulong)var12;
            *(__global uint*)(var13) = var12;
            var12 = (var12) * x;
        } while ((((ulong)0 - (ulong)unrollingBreaker) == var9 ? 1 : 0) | var9 > 63 ? 1 : 0);
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var11;
    uint var12;
    __global uint *var13;
    __global uint *var9;
    __global uint *var10;
    var11 = unrollingBreaker;
    if (var11 == 0) {
        var9 = data;
        var10 = data;
        var11 = unrollingBreaker;
        var12 = y;
        do {
            var13 = var9;
            var0 = *(__global uint*)(var13);
            var9 = var9 + 4 / 4;
            var10 = var10 + 0 / 4;
            var11 = (ulong)var11 + (ulong)(-1);
            var12 = (ulong)var0 + (ulong)var12;
            *(__global uint*)(var13) = var12;
            var12 = (var12) * x;
        } while (!(((ulong)var11 + (ulong)(-1)) == 0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    __global uint *var10;
    uint var11;
    uint var12;
    __global uint *var13;
    __global uint *var9;
    var11 = unrollingBreaker;
    if (var11 == 0) {
        var9 = data + (var11 * 4) / 4;
        var10 = data + (0x0 * 4) / 4;
        var11 = unrollingBreaker;
        var12 = y;
        do {
            var13 = var9;
            var0 = *(__global uint*)(var13);
            var9 = var9 + (-4) / 4;
            var10 = var10 + (-1) / 4;
            var11 = (ulong)var11 + (ulong)(-1);
            var12 = (ulong)var0 + (ulong)var12;
            *(__global uint*)(var13) = var12;
            var12 = (var12) * x;
        } while (!(((ulong)var11 + (ulong)(-1)) == 0));
    }
}
