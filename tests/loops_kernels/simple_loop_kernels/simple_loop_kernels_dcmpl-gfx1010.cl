__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    __global uint *var11;
    uint var12;
    uint var13;
    __global uint *var14;
    uchar var7;
    uchar var8;
    uint var9;
    var8 = 0;
    if (unrollingBreaker == 0) {
        do {
            var7 = var8 + 1;
            var14 = var10;
            var8 = var8 + var7;
            var9 = (uint)UNKNOWN VALUE + var9;
            var10 = var14 + 1.0;
            var13 = var9;
            var11 = var10;
            var12 = (var8 < 63) && ((!(unrollingBreaker)) != var8);
            var9 = var9 * x;
            *var14 = var13;
        } while ((var8 < 63) && ((!(unrollingBreaker)) != var8));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    uint var5;
    uint var6;
    __global uint *var7;
    __global uint *var8;
    uint var9;
    var5 = unrollingBreaker;
    if (var5 == 0) {
        do {
            var10 = var7;
            var5 = var5 - 1;
            var6 = (uint)UNKNOWN VALUE + var6;
            var7 = var10 + 1.0;
            var9 = var6;
            var8 = var7;
            var6 = var6 * x;
            *var10 = var9;
        } while (!((var5 - 1) == 0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data, uint x, uint y, uint unrollingBreaker)
{
    __global uint *var10;
    uint var11;
    __global uint *var12;
    uint var7;
    uint var8;
    __global uint *var9;
    var7 = unrollingBreaker;
    if (var7 == 0) {
        var9 = data + var7;
        var10 = data;
        do {
            var12 = var10 + var7;
            var7 = var7 - 1;
            var8 = (uint)UNKNOWN VALUE + var8;
            var9 = var10 + var7 + -1.0;
            var11 = var8;
            var10 = var10 + -0.25;
            var8 = var8 * x;
            *var12 = var11;
        } while (!((var7 - 1) == 0));
    }
}
