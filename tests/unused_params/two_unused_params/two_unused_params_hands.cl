__kernel void two_unused_params(int n, int w, int z, __global int *data, __global int *data1, int x, int y)
{
    uint var3;
    if (n > get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = x;
    }
    else {
        var3 = data1[(get_global_id(1) / 1073741824) * 1073741824];
        data[(get_global_id(1) / 1073741824) * 1073741824] = y + var3;
    }
}
