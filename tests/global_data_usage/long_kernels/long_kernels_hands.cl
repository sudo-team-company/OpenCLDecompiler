__constant long gdata0[] = {1, 2, 3, 4, 5, 6, 7};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void long_test(__global long *out, int i)
{
    out[get_global_id(0)] = gdata0[i];
}
