__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void unrolled_affine(__global int *data, int x)
{
    int var0;
    var0 = data[get_global_id(0)];
    int acc = var0;
    for (int i = 1; i <= 1048575; i = i * 2 + 1) {
        acc = i + (acc * x);
    }
    data[get_global_id(0)] = acc;
}
