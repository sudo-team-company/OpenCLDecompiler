__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if(int x, __global int *data, int y)
{
    int var0;
    if ((int)0 == (int)get_global_id(0)) {
        var0 = data[get_global_id(1)];
        if ((int)y > (int)var0) {
            data[get_global_id(2)] = x;
        }
        else {
            data[get_global_id(1)] = 0;
        }
    }
    data[get_global_id(0)] = y;
}
