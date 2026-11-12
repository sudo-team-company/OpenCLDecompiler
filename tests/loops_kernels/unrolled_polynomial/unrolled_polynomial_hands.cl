__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void unrolled_polynomial(__global int *data, int x)
{
    int var0;
    var0 = data[get_global_id(0)];
    int acc = 1 + (var0 * x * x);
    for (int i = 2; i <= 19; i = i + 1) {
        acc = (i * i) + (acc * x);
    }
    data[get_global_id(0)] = acc;
}
