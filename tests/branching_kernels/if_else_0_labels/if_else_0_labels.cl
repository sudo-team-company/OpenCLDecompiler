__kernel __attribute((reqd_work_group_size(8, 8, 1)))
void if_else_0_labels(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
  }
  else {
    data[id0] = y;
  }
  data[id1] = x;
}
