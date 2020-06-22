__kernel __attribute((reqd_work_group_size(16, 16, 16)))
void localVarExample(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  int var = data[id1];
  if (id0 == 0) {
    if (y > var) {
      data[get_global_id(2)] = x;
    }
    else {
      data[id1] = id0;
    }
  }
  data[id0] = y;
}