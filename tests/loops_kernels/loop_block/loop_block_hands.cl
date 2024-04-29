__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, int block, int x)
{
    int var0;
    uint var3;
    int var4;
    __global int var5;
    uint var6;
    if ((int)block < (int)1) {
        var5 = data + ((get_global_id(0) * block) * 4) / 4;
        var4 = 0;
        var6 = (ulong)data + (ulong)(((ulong)((ulong)(get_global_id(0) * block) + (ulong)(get_global_id(0) * ((int)block / 2147483648))) + (ulong)(((ulong)get_global_offset(0) + (ulong)0) * block)) * 4);
        do {
            var0 = *(__global int*)(var5);
            var3 = var0;
            var3 = x * var3;
            var3 = (ulong)var4 + (ulong)(x * varvar4);
            var4 = (ulong)var4 + (ulong)1;
            *(__global int*)(var5) = var3;
            var5 = var5 + 4 / 4;
            var6 = (ulong)0 + (ulong)(var6);
        } while (!((uint)block == (uint)((ulong)var4 + (ulong)1)));
    }
}
