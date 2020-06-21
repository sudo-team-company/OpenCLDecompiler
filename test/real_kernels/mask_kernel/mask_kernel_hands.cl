__kernel void mask_kernel(int n, __global float *x, float mask_num, __global float *mask, float scale)
{
	float var0;
	float var1;
	if (n > (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)) {
	    var0 = mask[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
	    if (mask_num == var0) {
	        var1 = x[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
	        x[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)] = scale * var1;
	    }
	}
}