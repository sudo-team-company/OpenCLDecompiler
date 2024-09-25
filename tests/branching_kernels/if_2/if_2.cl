__kernel __attribute((reqd_work_group_size(8, 8, 1)))
void if_2(int x, __global int *data, int y)
{
  uint id = get_global_id(0);
  if (id == 0) {
    id = get_global_id(1);
  }
  data[id] = x;
}
