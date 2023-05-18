kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_with_long_expr(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  uint id2 = get_global_id(2);
  if ((id0 == 7) && (id2 == 12) && (x < y)) {
    data[id0] = x * id1 - y;
  }
  else {
    data[id0] = y * id0;
  }
  data[id1] = x;
}
