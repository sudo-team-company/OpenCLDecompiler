__kernel void mask_kernel(uint arg0, __global float *arg1, float arg2, __global float *arg3, float arg4)
{
    float var0;
    float var1;
    if (((((get_global_id(2) * get_num_groups(1) * get_local_size(1)) + get_global_id(1)) * get_num_groups(0) * get_local_size(0)) + get_global_id(0)) < arg0) {
        var0 = arg3[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)];
        if (var0 == arg2) {
            var1 = arg1[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)];
            arg1[(get_global_id(1) + get_global_id(2)*get_local_size(1)*get_num_groups(1))*get_local_size(0)*get_num_groups(0) + get_global_id(0)] = var1 * arg4;
        }
    }
}
