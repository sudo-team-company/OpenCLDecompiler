__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint4_float4(float4 arg0, uint arg1, uint arg2, uint arg3, __global uint4 *arg4)
{
    arg4[get_global_id(0)] = convert_uint4(arg0);
}
