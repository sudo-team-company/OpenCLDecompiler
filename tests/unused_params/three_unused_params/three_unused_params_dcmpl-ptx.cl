__kernel void three_unused_params(uint arg0, uint arg1, uint arg2, __global uint *arg3, uint arg4, __global uint *arg5, uint arg6, uint arg7)
{
    uint var0;
    if (get_global_id(0) >= arg0) {
        var0 = arg5[get_global_id(1)];
        arg3[get_global_id(1)] = var0 + arg7;
    }
    else {
        arg3[get_global_id(0)] = arg6;
    }
}
