__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void unrolled_counter(__global int *data, int x)
{
    int var0;
    var0 = data[get_global_id(0)];
    int acc = var0;
    for (int i = 0; i <= 19; i = i + 1) {
        acc = 5 + (acc * x);
    }
    data[get_global_id(0)] = acc;
}
