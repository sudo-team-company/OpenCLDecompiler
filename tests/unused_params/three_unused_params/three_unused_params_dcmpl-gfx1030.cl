__kernel void three_unused_params(int n, int w, int z, __global int *data, int ww, __global int *data1, int x, int y)
{
    int var0;
    if ((int)n > (int)get_global_id(0)) {
        data[get_global_id(0)] = x;
    }
    else {
        var0 = data1[get_global_id(1)];
        data[get_global_id(1)] = (ulong)y + (ulong)var0;
    }
}
