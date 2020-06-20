__kernel void binary_gradient_array_kernel(__global float *x, __global float *dy, int n, int s, int a, __global float *dx)
{
    int id = get_global_id(2) * get_global_size(0) * get_global_size(1) +
		get_global_id(1) * get_global_size(0) + get_global_id(0);
    int i = id % s;
    int b = id / s;
    float x1 = x[b*s + i];
    float x2 = x[b*s + s/2 + i];
    if (id < n) {
        float de = dy[id];
        dx[b*s + i] = x2*de;
        dx[b*s + s/2 + i] = x1*de; 
    }
}