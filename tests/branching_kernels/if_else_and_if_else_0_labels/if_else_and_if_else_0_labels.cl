kernel __attribute((reqd_work_group_size(4, 4, 4)))
void if_else_and_if_else_0_labels(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  uint id2 = get_global_id(2);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
  }
  else {
    data[id0] = y * id0;
  }
  if (x < y) {
    data[id2] = x + id2;
  }
  else {
    data[id2] = y + id1;
  }
  data[id1] = x;
}
