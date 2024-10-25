__kernel __attribute__((reqd_work_group_size(64,1,1)))
void big_type_test(
  uint8 param1,
  __global uint* data,
  uint param2,
  uint8 param3,
  uint8 param7,
  uint8 param9,
  ulong param5,
  long param6
  )
{
	uint id = get_global_id(0);
	data[id] = param1.s1 + param1.s2 + param9.s1 + param6;
}
