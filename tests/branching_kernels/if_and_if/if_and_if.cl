__kernel __attribute((reqd_work_group_size(8, 4, 2)))
void if_and_if(int x, __global int *data, int y)
{
  uint id = get_global_id(0);
  if (id == 0) {
    id = get_global_id(1);
  }
  data[id] = x;
  if (x < y) {
    id = get_global_id(2);
  }
  data[id] = y;
}