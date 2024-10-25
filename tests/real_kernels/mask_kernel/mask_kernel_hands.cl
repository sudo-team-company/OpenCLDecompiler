__kernel void mask_kernel(int n, __global float *x, float mask_num, __global float *mask, float scale)
{
    float var0;
    float var1;
    if ((int)n > (int)((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0))) {
        var0 = mask[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)];
        if ((float)mask_num == (float)var0) {
            var1 = x[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)];
            x[(get_global_id(1) + get_global_id(2)*get_global_size(1))*get_global_size(0) + (ulong)get_global_id(0)] = (float)scale * (float)var1;
        }
    }
}
