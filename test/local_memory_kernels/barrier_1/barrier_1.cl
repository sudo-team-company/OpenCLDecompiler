__kernel __attribute__((reqd_work_group_size(16, 16, 16)))
void localVarExample(__global int *res)
{
  int id0 = get_global_id(0);
  int id1 = get_global_id(1);
  int id2 = get_global_id(2);
  __local int x[64];
  __local int y[64];
  __local int f;
  x[id0] = 0;
  y[id1] = 1;
  barrier(CLK_LOCAL_MEM_FENCE);
  atom_inc(&x[id0]);
  barrier(CLK_LOCAL_MEM_FENCE);
  barrier(CLK_LOCAL_MEM_FENCE);
  y[id0] = x[id0];
  atom_inc(&y[id1]);
  barrier(CLK_LOCAL_MEM_FENCE);
  x[id0] = y[id1];
  barrier(CLK_LOCAL_MEM_FENCE);
  res[id0] = x[id0];
  res[id1] = y[id1];
  res[id2] = f;
}