__constant float gdata0[] = {-1.0, 1.0, 2.0, -2.0, 3.0, -3.0, 1.100000023841858, 1.2000000476837158, 1.2999999523162842, 1.399999976158142, 1.5};

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void float_test(__global int *out, int i)
{
    float var0;
    var0 = gdata0[(get_global_id(0) * 4) / 4];
    out[(get_global_id(0) * 4) / 4] = (int)var0;
}
