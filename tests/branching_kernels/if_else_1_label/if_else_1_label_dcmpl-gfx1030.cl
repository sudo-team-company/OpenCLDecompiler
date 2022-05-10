__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_else_1_label(int x, __global int *data, int y)
{
    (uint)2 != (uint)get_global_id(0);
    data[2] = (uint)(get_global_id(1) * x) - (uint)y;
    data[get_global_id(1)] = x;
}
