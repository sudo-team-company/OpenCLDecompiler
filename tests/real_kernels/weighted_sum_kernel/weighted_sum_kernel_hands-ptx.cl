__kernel void weighted_sum_kernel(uint arg0, __global float *arg1, __global float *arg2, __global float *arg3, __global float *arg4)
{
    float var0;
    float var1;
    float var2;
    float var3;
    var1 = 0.0;
    if (arg2 != 0) {
        var0 = arg2[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)];
        var1 = var0;
    }
    if (((((get_global_id(2) * get_num_groups(1) * get_local_size(1)) + get_global_id(1)) * get_num_groups(0) * get_local_size(0)) + get_global_id(0)) < arg0) {
        var2 = arg3[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)];
        var3 = arg1[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)];
        arg4[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)] = (var2 * var3) + (var1 * (1.0 - var2));
    }
}
