__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void uint8_type_test(uint8 param1, __global uint *data, uint param2, uint8 param3, ulong param5, long param6)
{
    data[get_global_id(0)] = param1.s1 + param1.s2 + param6;
}
