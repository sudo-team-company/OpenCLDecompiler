__kernel void weighted_sum_kernel(int n, __global float *a, __global float *b, __global float *s, __global float *c)
{
    float var0;
    float var3;
    float var4;
    float var5;
    if (b == 0) {
        var3 = 0;
    }
    else {
        var0 = b[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + get_global_id(0)];
        var3 = var0;
    }
    if (n > ((((get_global_size(1) * get_global_id(2)) + get_global_id(1)) * get_global_size(0)) + get_global_id(0))) {
        var4 = a[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + get_global_id(0)];
        var5 = s[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + get_global_id(0)];
        c[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + get_global_id(0)] = (var5 * var4) + (var3 * (1.0 - var5));
    }
}
