__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    __global uint *var10;
    uint var11;
    __global uint *var12;
    uint var8;
    __global uint *var9;
    if ((int)unrollingBreaker == (int)0) {
        var8 = 0x1;
        var11 = y;
        var9 = data;
        var10 = data;
        do {
            var12 = var9;
            var0 = *(__global uint*)(var12);
            var8 = (ulong)var8 + (ulong)1;
            var9 = var9 + 4 / 4;
            var10 = var10 + 0 / 4;
            var11 = (ulong)var0 + (ulong)var11;
            *(__global uint*)(var12) = var11;
            var11 = (var11) * x;
        } while (((int)((ulong)0 - (ulong)unrollingBreaker) == (int)var8 ? 1 : 0) || (uint)var8 > (uint)63 ? 1 : 0);
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var10;
    uint var11;
    __global uint *var12;
    __global uint *var8;
    __global uint *var9;
    var10 = unrollingBreaker;
    if ((int)var10 == (int)0) {
        var8 = data;
        var9 = data;
        var11 = y;
        do {
            var12 = var8;
            var0 = *(__global uint*)(var12);
            var8 = var8 + 4 / 4;
            var9 = var9 + 0 / 4;
            var10 = (ulong)var10 + (ulong)(-1);
            var11 = (ulong)var0 + (ulong)var11;
            *(__global uint*)(var12) = var11;
            var11 = (var11) * x;
        } while (!((int)((ulong)var10 + (ulong)(-1)) == (int)0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var10;
    uint var11;
    __global uint *var12;
    __global uint *var8;
    __global uint *var9;
    var10 = unrollingBreaker;
    if ((int)var10 == (int)0) {
        var8 = data + (var10 * 4) / 4;
        var9 = data + (0x0 * 4) / 4;
        var11 = y;
        do {
            var12 = var8;
            var0 = *(__global uint*)(var12);
            var8 = var8 + (-4) / 4;
            var9 = var9 + (-1) / 4;
            var10 = (ulong)var10 + (ulong)(-1);
            var11 = (ulong)var0 + (ulong)var11;
            *(__global uint*)(var12) = var11;
            var11 = (var11) * x;
        } while (!((int)((ulong)var10 + (ulong)(-1)) == (int)0));
    }
}
