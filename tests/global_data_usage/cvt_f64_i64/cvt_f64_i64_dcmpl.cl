__constant double gdata0[] = {1e-323, 1.5e-323, 2.5e-323, 4e-323, 4.4e-323, 5e-323, 5.4e-323};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global double *out, int i)
{
    double var0;
    var0 = gdata0[get_global_id(0)];
    out[get_global_id(0)] = (double)var0;
}
