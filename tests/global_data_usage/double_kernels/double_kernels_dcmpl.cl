__constant double gdata0[] = {-1.0, 1.0, -2.2, 3.9, -4.2, 5.12345};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global double *out, int i)
{
    double var0;
    var0 = gdata0[get_global_id(0)];
    out[get_global_id(0)] = var0;
}
