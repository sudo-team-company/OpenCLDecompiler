__kernel void binary_activate_array_kernel(__global float *x, int n, int s, int a, __global float *y)
{
    int id = get_global_id(2) * get_global_size(0) * get_global_size(1) +
		get_global_id(1) * get_global_size(0) + get_global_id(0);
    int i = id % s;
    int b = id / s;
    float x1 = x[b*s + i];
    float x2 = x[b*s + s/2 + i];
    if(id < n) y[id] = x1*x2;
}