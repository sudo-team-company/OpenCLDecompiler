__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_unrolled(__global int *data, int x)
{
    int var0;
    var0 = data[get_global_id(0)];
    int acc = var0 * x;
    for (int i = 1; i <= 63; i = i + 1) {
        acc = (ulong)i + (ulong)(acc * x);
    }
    data[get_global_id(0)] = acc;
}
