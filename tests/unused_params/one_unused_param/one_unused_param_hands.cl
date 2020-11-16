__kernel void one_unused_param(int n, int w, __global int *data, __global int *data1, int x, int y)
{
    uint var3;
    if ((int)n > (int)get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = x;
    }
    else {
        var3 = data1[(get_global_id(1) / (long)1073741824) * 1073741824];
        data[(get_global_id(1) / (long)1073741824) * 1073741824] = (ulong)y + (ulong)var3;
    }
}
