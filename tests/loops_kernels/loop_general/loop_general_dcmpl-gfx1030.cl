__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, int from, int to, int x)
{
    int var0;
    int var2;
    int var3;
    uint var4;
    int var5;
    var0 = data[get_global_id(0)];
    var4 = var0;
    var5 = from;
    if ((int)var5 >= (int)to) {
        do {
            var3 = x * var4;
            var4 = (ulong)var5 + (ulong)(var3);
            var5 = (ulong)var5 + (ulong)1;
        } while (!((int)((ulong)var5 + (ulong)1) >= (int)to));
        var2 = (ulong)((ulong)(var3) + (ulong)((ulong)var5 + (ulong)1)) + (ulong)(-1);
    }
    data[get_global_id(0)] = var2;
}
