__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint4_float4(float4 smth2, int smth3, int smth4, int smth5, __global int4 *smth)
{
    smth[get_global_id(0)] = convert_int4(smth2);
}
