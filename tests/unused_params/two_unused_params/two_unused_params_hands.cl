__kernel void two_unused_params(int n, int w, int z, __global int *data, __global int *data1, int x, int y)
{
    int var0;
    if (n > get_global_id(0)) {
        data[get_global_id(0)] = x;
    }
    else {
        var0 = data1[get_global_id(1)];
        data[get_global_id(1)] = y + var0;
    }
}
