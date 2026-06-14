__kernel void two_unused_params(uint arg0, uint arg1, uint arg2, __global uint *arg3, __global uint *arg4, uint arg5, uint arg6)
{
    uint var0;
    if (get_global_id(0) >= arg0) {
        var0 = arg4[get_global_id(1)];
        arg3[get_global_id(1)] = var0 + arg6;
    }
    else {
        arg3[get_global_id(0)] = arg5;
    }
}
