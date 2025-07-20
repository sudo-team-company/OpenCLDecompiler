// MIT License
//
// Copyright (c) 2020-2024 Sudo Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void barrier_1(__global int *res)
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
