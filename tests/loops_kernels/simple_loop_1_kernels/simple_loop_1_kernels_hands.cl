__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_incoherent_body_kernel(__global uint *data, uint x, uint y, uint iters_num)
{
    uint var0;
    uint var10;
    uint var11;
    uint var7;
    int var8;
    __global uint var9;
    if (var8 == 0) {
        var7 = get_global_id(0) * var8;
        do {
            var7 = (ulong)1 + (ulong)(var7);
            var8 = (ulong)var8 + (ulong)(-1);
            var9 = data + ((get_global_id(0) * iters_num) * 4) / 4;
            var10 = (ulong)data + (ulong)(var10);
            var0 = data[iters_num*get_global_id(0)];
            var11 = var0;
            var11 = var11 * x;
            var11 = (ulong)y + (ulong)(var11);
            data[iters_num*get_global_id(0)] = (ulong)y + (ulong)(var11);
        } while (!(((ulong)var8 + (ulong)(-1)) == 0));
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_coherent_body_kernel(__global uint *data, uint x, uint y, uint iters_num)
{
    uint var0;
    uint var7;
    int var8;
    if (var8 == 0) {
        var0 = data[get_global_id(0)];
        var7 = var0;
        do {
            var7 = var7 * x;
            var8 = (ulong)var8 + (ulong)(-1);
            var7 = (ulong)y + (ulong)(var7);
        } while (!(((ulong)var8 + (ulong)(-1)) == 0));
        data[get_global_id(0)] = (ulong)y + (ulong)(var7);
    }
}
