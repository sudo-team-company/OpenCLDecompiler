__kernel void binary_gradient_array_kernel(__global float *x, __global float *dy, int n, int s, int a, __global float *dx)
{
    float var0;
    float var1;
    float var2;
    if (n > (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)) {
        var0 = dy[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
        var1 = x[s/2 + (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
        var2 = x[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
        dx[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)] = var1 * var0;
        dx[s/2 + (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)] = var2 * var0;
    }
}