__kernel __attribute((reqd_work_group_size(16, 16, 16)))
void localVarExample(int x, __global int *data, int y)
{
  uint id = get_global_id(0);
  if (id == 0) {
    id = get_global_id(1);
  }
  data[id] = x;
}