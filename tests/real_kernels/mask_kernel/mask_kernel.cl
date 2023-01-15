__kernel void mask_kernel(int n, __global float *x, float mask_num, __global float *mask, float scale)
{
	int i = get_global_id(2) * get_global_size(0) * get_global_size(1) +
		get_global_id(1) * get_global_size(0) + get_global_id(0);
	if (i < n && mask[i] == mask_num) x[i] *= scale;
}