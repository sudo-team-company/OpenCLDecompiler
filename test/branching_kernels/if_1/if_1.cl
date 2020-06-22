__kernel __attribute__((reqd_work_group_size(16, 16, 1)))
void localVarExample(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
  }
  data[id1] = x;
}