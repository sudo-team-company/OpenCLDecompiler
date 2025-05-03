__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    __global uint *var10;
    uint var11;
    __global uint *var12;
    uchar var8;
    __global uint *var9;
    if (unrollingBreaker == 0) {
        var8 = 0x1;
        var11 = y;
        var9 = data;
        var10 = data;
        do {
            var12 = var9;
            var0 = *var12;
            var8 = var8 + 1;
            var9 = var9 + 1;
            var10 = var10;
            var11 = var0 + var11;
            *var12 = var11;
            var11 = var11 * x;
        } while ((((0 - unrollingBreaker) == var8) ? (1) : (0)) || ((0x1 > 63) ? (1) : (var8 > 63)));
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
    if (var10 == 0) {
        var8 = data;
        var9 = data;
        var11 = y;
        do {
            var12 = var8;
            var0 = *var12;
            var8 = var8 + 1;
            var9 = var9;
            var10 = var10 - 1;
            var11 = var0 + var11;
            *var12 = var11;
            var11 = var11 * x;
        } while (!((var10 - 1) == 0));
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
    if (var10 == 0) {
        var8 = data + var10;
        var9 = data;
        var11 = y;
        do {
            var12 = var8;
            var0 = *var12;
            var8 = var8 + -1;
            var9 = var9 + -0.25;
            var10 = var10 - 1;
            var11 = var0 + var11;
            *var12 = var11;
            var11 = var11 * x;
        } while (!((var10 - 1) == 0));
    }
}
