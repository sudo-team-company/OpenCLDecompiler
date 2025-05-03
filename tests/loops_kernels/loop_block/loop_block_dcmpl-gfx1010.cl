__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, int block, int x)
{
    int var0;
    int var3;
    uchar var4;
    __global int *var5;
    __global int *var6;
    if (block < 1) {
        var5 = data + (get_global_id(0) * block);
        var4 = 0;
        var6 = data + (((get_global_id(0) * block) + (get_global_id(0) * (block / 2147483648)) + (get_global_offset(0) * block)) * 4);
        do {
            var0 = *data[block*get_global_id(0)];
            var3 = var0;
            var3 = x * var3;
            var3 = (int)var4 + var3;
            var4 = var4 + 1;
            *var5 = var3;
            var5 = data + (get_global_id(0) * block) + (__global int *)1.0;
            var6 = data + (((get_global_id(0) * block) + (get_global_id(0) * (block / 2147483648)) + (get_global_offset(0) * block)) * 4);
        } while (!(block == (var4 + var4 + 1)));
    }
}
