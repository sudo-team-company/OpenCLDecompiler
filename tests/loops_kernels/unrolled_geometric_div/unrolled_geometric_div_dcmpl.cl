__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void unrolled_geometric_div(__global int *data, int x)
{
    int var0;
    var0 = data[get_global_id(0)];
    int acc = var0;
    for (int i = 1048576; i >= 1; i = i / 2) {
        acc = i + (acc * x);
    }
    data[get_global_id(0)] = acc;
}
