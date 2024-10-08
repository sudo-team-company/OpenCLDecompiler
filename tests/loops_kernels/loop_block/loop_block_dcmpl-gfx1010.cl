__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, int block, int x)
{
    int var0;
    uint var3;
    int var4;
    __global int var5;
    uint var6;
    if (block < 1) {
        var5 = data + ((get_global_id(0) * block) * 4) / 4;
        var4 = 0;
        var6 = (ulong)data + (ulong)(((get_global_id(0) * block) + (get_global_id(0) * (block / 2147483648)) + (((ulong)get_global_offset(0) + 0) * block)) * 4);
        do {
            var0 = *(__global int*)(var5);
            var3 = var0;
            var3 = x * var3;
            var3 = (ulong)var4 + (x * varvar4);
            var4 = (ulong)var4 + 1;
            var5 = var3;
            var5 = var5 + 4 / 4;
            var6 = 0 + (var6);
        } while (!((uint)block == (uint)((ulong)var4 + 1)));
    }
}
