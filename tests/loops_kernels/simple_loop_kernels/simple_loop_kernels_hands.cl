__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    uint var0;
    uint var1;
    int var11;
    __global uint *var12;
    __global uint *var13;
    uint var14;
    __global uint *var15;
    uint var2;
    if (unrollingBreaker != 0) {
        var11 = 0x1;
        var14 = y;
        var12 = data;
        var13 = data;
        do {
            var15 = var12;
            var0 = *var15;
            var1 = (0 - unrollingBreaker) == var11 ? 0 : 1;
            var2 = var11 > 63 ? 0 : 1;
            var11 = var11 + 1;
            var12 = var12 + 1;
            var13 = var13;
            var14 = var0 + var14;
            *var15 = var14;
            var14 = var14 * x;
        } while (!(var1 || var2));
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
    if (var10 != 0) {
        var8 = data;
        var9 = data;
        var11 = y;
        do {
            var12 = var8;
            var0 = *var12;
            var8 = var8 + 1;
            var9 = var9;
            var10 = var10 + -1;
            var11 = var0 + var11;
            *var12 = var11;
            var11 = var11 * x;
        } while (!((var10 + -1) == 0));
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
    if (var10 != 0) {
        var8 = data + var10;
        var9 = data;
        var11 = y;
        do {
            var12 = var8;
            var0 = *var12;
            var8 = var8 + -1;
            var9 = var9 + -1;
            var10 = var10 + -1;
            var11 = var0 + var11;
            *var12 = var11;
            var11 = var11 * x;
        } while (!((unrollingBreaker + -1) == 0));
    }
}
