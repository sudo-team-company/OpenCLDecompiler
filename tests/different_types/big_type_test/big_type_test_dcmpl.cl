__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void big_type_test(uint8 param1, __global uint *data, uint param2, uint8 param3, uint8 param7, uint8 param9, ulong param5, long param6)
{
    data[get_global_id(0)] = (ulong)((ulong)((ulong)param1.s1 + (ulong)param1.s2) + (ulong)param9.s1) + (ulong)param6;
}
