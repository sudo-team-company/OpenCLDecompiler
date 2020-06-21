__kernel void binary_activate_array_kernel(__global float *x, int n, int s, int a, __global float *y)
{
    float var0;
    float var1;
    if (n > (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)) {
        var0 = x[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
        var1 = x[s/2 + (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
        y[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)] = var1 * var0;
    }
}