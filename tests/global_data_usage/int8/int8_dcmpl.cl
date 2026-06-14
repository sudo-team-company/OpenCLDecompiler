__constant int arr0__gdata[] = {1, 2, 3, 4, 5, 6, 7, 8};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void test(__global int *in, __global uint *out, int i)
{
    in[get_global_id(0)] = arr0__gdata[i];
}
