kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_1(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  uint id2 = get_global_id(2);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
    if (x < y) {
      data[id2] = x * id2;
    }
    else {
      data[id2] = y * id1;
    }
  }
  else {
    data[id0] = y * id0;
    if (x < y) {
      data[id2] = x + id2;
    }
    else {
      data[id2] = y + id1;
    }
  }
  data[id1] = x;
}

kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_2(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  uint id2 = get_global_id(2);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
    if (id1 < id2) {
      data[id2] = x * id2;
    }
    else {
      data[id2] = y * id1;
    }
  }
  else {
    data[id0] = y * id0;
    if (id1 == id2) {
      data[id2] = x + id2;
    }
    else {
      data[id2] = y + id1;
    }
  }
}
