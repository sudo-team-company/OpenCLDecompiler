__kernel void weighted_sum_kernel(int n, __global float *a, __global float *b, __global float *s, __global float *c)
{
	int i = get_global_id(2) * get_global_size(0) * get_global_size(1) +
		get_global_id(1) * get_global_size(0) + get_global_id(0);
	float m = 0.0;
	if(b != 0)
		m = b[i];
	if (i < n) {
		c[i] = s[i] * a[i] + (1 - s[i])*m;
	}
}