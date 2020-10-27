__kernel void three_unused_params(int n, int w, int z, __global int *data, int ww, __global int *data1, int x, int y)
{
    int id0 = get_global_id(0);
    int id1 = get_global_id(1);
    if(id0 < n) data[id0] = x;
    else data[id1] = y + data1[id1];
}
