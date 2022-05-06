__constant float gdata0[] = {-1.0, 1.0, -2.200000047683716, 3.9000000953674316, -4.199999809265137, 5.123449802398682};

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void float_test(__global float *out, int i)
{
    float var0;
    var0 = gdata0[get_global_id(0)];
    out[get_global_id(0)] = var0;
}
