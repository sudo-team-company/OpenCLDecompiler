__kernel void mask_kernel(int n, __global float *x, float mask_num, __global float *mask, float scale)
{
    uint var0;
    uint var1;
    if ((int)n > (int)((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0))) {
        var0 = mask[(((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0)) * 4) / 4];
        if (as_float(mask_num) == as_float(var0)) {
            var1 = x[(((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0)) * 4) / 4];
            x[(((ulong)(((ulong)((ulong)get_global_offset(1) + (ulong)(get_global_size(1) * get_global_id(2))) + (ulong)(get_global_id(1) - get_global_offset(1))) * get_global_size(0)) + (ulong)get_global_id(0)) * 4) / 4] = as_float(scale) * as_float(var1);
        }
    }
}
