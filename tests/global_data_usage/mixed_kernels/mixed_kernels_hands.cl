__constant int arr0__gdata[] = {1, 2, 3, 4, 5, 6, 7, 0};

__constant long arr32__gdata[] = {8, 9, 10, 11};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void some_array_test(__global long *out, __global int *res, int i)
{
    int var0;
    long var1;
    var0 = arr0__gdata[get_global_id(0)];
    var1 = arr32__gdata[get_global_id(0)];
    res[get_global_id(0)] = var0;
    out[get_global_id(1)] = var1;
}
