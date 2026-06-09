__kernel void four_unused_params(uint arg0, __global int *arg1, uint arg2, uint arg3, __global uint *arg4, uint arg5, __global uint *arg6, uint arg7, uint arg8)
{
    uint var0;
    if (get_global_id(0) >= arg0) {
        var0 = arg6[get_global_id(1)];
        arg4[get_global_id(1)] = var0 + arg8;
    }
    else {
        arg4[get_global_id(0)] = arg7;
    }
}
