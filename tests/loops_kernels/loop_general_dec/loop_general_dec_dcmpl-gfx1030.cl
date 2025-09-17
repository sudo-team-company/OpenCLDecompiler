__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, int from, int to, int x)
{
    int var0;
    int var2;
    int var3;
    int var4;
    int var5;
    var0 = data[get_global_id(0)];
    var4 = var0;
    var5 = from;
    if (var5 <= to) {
        do {
            var3 = x * var4;
            var4 = var5 + var3;
            var5 = var5 - 1;
        } while (!((var5 - 1) <= to));
        var2 = (var3 + var5 + 1) - 1;
    }
    data[get_global_id(0)] = var2;
}
