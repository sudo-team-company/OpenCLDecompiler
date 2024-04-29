__kernel void weighted_sum_kernel(int n, __global float *a, __global float *b, __global float *s, __global float *c)
{
    float var0;
    float var3;
    float var4;
    float var5;
    if ((ulong)b == (ulong)0) {
        var3 = 0;
    }
    else {
        var0 = b[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)];
        var3 = var0;
    }
    if ((int)n > (int)((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0))) {
        var4 = a[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)];
        var5 = s[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)];
        c[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)] = as_float(var5) * as_float(var4) + as_float(as_float(var3) * as_float((as_float(1.0) - as_float(var5))));
    }
}
