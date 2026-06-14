__constant int arr0__gdata[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void int_test(__global int *out, int i)
{
    int var0;
    var0 = arr0__gdata[get_global_id(0)];
    out[get_global_id(0)] = var0;
}
