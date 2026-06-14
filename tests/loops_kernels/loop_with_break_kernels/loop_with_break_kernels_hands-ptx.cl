__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_break_kernel(__global uint *arg0, uint arg1, uint arg2, uint arg3)
{
    uint var0;
    uint var3;
    uint var4;
    uint var5;
    int var6;
    var5 = arg2;
    if (arg3 != 0) {
        var6 = 0;
        do {
            var0 = arg0[var6];
            var4 = var0 + var5;
            arg0[var6] = var4;
            if (!(var4 != 0)) {
                break;
            }
            var5 = var4 * arg1;
            var6 = var6 + 1;
        } while (!((var6 + 1) >= arg3));
    }
    var3 = arg0[get_global_id(0)];
    arg0[get_global_id(0)] = var3 + arg1;
}
