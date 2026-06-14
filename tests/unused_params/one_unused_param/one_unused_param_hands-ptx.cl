__kernel void one_unused_param(uint arg0, uint arg1, __global uint *arg2, __global uint *arg3, uint arg4, uint arg5)
{
    uint var0;
    if (get_global_id(0) >= arg0) {
        var0 = arg3[get_global_id(1)];
        arg2[get_global_id(1)] = var0 + arg5;
    }
    else {
        arg2[get_global_id(0)] = arg4;
    }
}
