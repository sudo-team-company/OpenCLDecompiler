__kernel void one_unused_param(int n, int w, __global int *data, __global int *data1, int x, int y)
{
    int id0 = get_global_id(0);
    int id1 = get_global_id(1);
    if(id0 < n) data[id0] = x;
    else data[id1] = y + data1[id1];
}
