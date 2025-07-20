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

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_x(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_x(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_x(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_x(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_x(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_x(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - x;
	data[g1] = g1 - x;
	data[g2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_x(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_x(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_x(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_work_dim();
	data[g0] = o0 - x;
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_offset(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_offset(0);
	data[id1] = x - get_global_offset(1);
	data[id2] = x - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_offset(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_offset(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_offset(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_offset(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_offset(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_offset(0);
	data[g1] = g1 - get_global_offset(1);
	data[g2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_offset(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_offset(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_offset(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_offset(0);
	data[g1] = o0 - get_global_offset(1);
	data[g2] = o0 - get_global_offset(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_id(0);
	data[id1] = x - get_local_id(1);
	data[id2] = x - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_id(0);
	data[g1] = g1 - get_local_id(1);
	data[g2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_id(0);
	data[g1] = o0 - get_local_id(1);
	data[g2] = o0 - get_local_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_group_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_group_id(0);
	data[id1] = x - get_group_id(1);
	data[id2] = x - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_group_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_group_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_group_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_group_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_group_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_group_id(0);
	data[g1] = g1 - get_group_id(1);
	data[g2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_group_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_group_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_group_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_group_id(0);
	data[g1] = o0 - get_group_id(1);
	data[g2] = o0 - get_group_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_size(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_size(0);
	data[id1] = x - get_local_size(1);
	data[id2] = x - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_size(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_size(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_size(0);
	data[g1] = g1 - get_local_size(1);
	data[g2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_size(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_size(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_size(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_size(0);
	data[g1] = o0 - get_local_size(1);
	data[g2] = o0 - get_local_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_id(0);
	data[id1] = x - get_global_id(1);
	data[id2] = x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_id(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_id(0);
	data[g1] = g1 - get_global_id(1);
	data[g2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_id(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_id(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_id(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_id(0);
	data[g1] = o0 - get_global_id(1);
	data[g2] = o0 - get_global_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_size(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_size(0);
	data[id1] = x - get_global_size(1);
	data[id2] = x - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_size(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_size(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_size(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_size(0);
	data[g1] = g1 - get_global_size(1);
	data[g2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_size(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_size(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_size(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_size(0);
	data[g1] = o0 - get_global_size(1);
	data[g2] = o0 - get_global_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_num_groups(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_num_groups(0);
	data[id1] = x - get_num_groups(1);
	data[id2] = x - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_num_groups(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_num_groups(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_num_groups(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_num_groups(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_num_groups(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_num_groups(0);
	data[g1] = g1 - get_num_groups(1);
	data[g2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_num_groups(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_num_groups(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_num_groups(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_num_groups(0);
	data[g1] = o0 - get_num_groups(1);
	data[g2] = o0 - get_num_groups(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_work_dim(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_work_dim();
	data[id1] = x - get_work_dim();
	data[id2] = x - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_work_dim(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_work_dim(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_work_dim(int x, __global int *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_work_dim(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_work_dim(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_work_dim();
	data[g1] = g1 - get_work_dim();
	data[g2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_work_dim(__global int *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_work_dim(int x, __global uint *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_work_dim(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_work_dim();
	data[g1] = o0 - get_work_dim();
	data[g2] = o0 - get_work_dim();
}



__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	data[g0] = x - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_offset_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_id_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_group_id_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_size_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_id_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	data[g0] = g0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_size_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_num_groups_64(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_work_dim(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_work_dim();
	data[g0] = o0 - g0;
}



__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_x_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = x - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_offset_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	uint o1 = get_global_offset(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_id_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	uint o1 = get_local_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_group_id_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	uint o1 = get_group_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_size_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	uint o1 = get_local_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_id_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = g0 - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_size_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	uint o1 = get_global_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_num_groups_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	uint o1 = get_num_groups(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_work_dim_8_8(int x, __global uint *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint o0 = get_work_dim();
	data[g0] = o0 - g1;
}



__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_x(__global long *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_x(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_x(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_x(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_x(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_x(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - x;
	data[g1] = g1 - x;
	data[g2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_x(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_x(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_x(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_work_dim();
	data[g0] = o0 - x;
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_offset(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_offset(0);
	data[id1] = x - get_global_offset(1);
	data[id2] = x - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_offset(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_offset(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_offset(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_offset(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_offset(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_offset(0);
	data[g1] = g1 - get_global_offset(1);
	data[g2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_offset(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_offset(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_offset(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_offset(0);
	data[g1] = o0 - get_global_offset(1);
	data[g2] = o0 - get_global_offset(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_id(0);
	data[id1] = x - get_local_id(1);
	data[id2] = x - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_id(0);
	data[g1] = g1 - get_local_id(1);
	data[g2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_id(0);
	data[g1] = o0 - get_local_id(1);
	data[g2] = o0 - get_local_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_group_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_group_id(0);
	data[id1] = x - get_group_id(1);
	data[id2] = x - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_group_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_group_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_group_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_group_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_group_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_group_id(0);
	data[g1] = g1 - get_group_id(1);
	data[g2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_group_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_group_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_group_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_group_id(0);
	data[g1] = o0 - get_group_id(1);
	data[g2] = o0 - get_group_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_size(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_size(0);
	data[id1] = x - get_local_size(1);
	data[id2] = x - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_size(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_size(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_size(0);
	data[g1] = g1 - get_local_size(1);
	data[g2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_size(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_size(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_size(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_size(0);
	data[g1] = o0 - get_local_size(1);
	data[g2] = o0 - get_local_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_id(0);
	data[id1] = x - get_global_id(1);
	data[id2] = x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_id(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_id(0);
	data[g1] = g1 - get_global_id(1);
	data[g2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_id(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_id(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_id(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_id(0);
	data[g1] = o0 - get_global_id(1);
	data[g2] = o0 - get_global_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_size(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_size(0);
	data[id1] = x - get_global_size(1);
	data[id2] = x - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_size(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_size(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_size(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_size(0);
	data[g1] = g1 - get_global_size(1);
	data[g2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_size(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_size(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_size(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_size(0);
	data[g1] = o0 - get_global_size(1);
	data[g2] = o0 - get_global_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_num_groups(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_num_groups(0);
	data[id1] = x - get_num_groups(1);
	data[id2] = x - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_num_groups(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_num_groups(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_num_groups(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_num_groups(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_num_groups(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_num_groups(0);
	data[g1] = g1 - get_num_groups(1);
	data[g2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_num_groups(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_num_groups(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_num_groups(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_num_groups(0);
	data[g1] = o0 - get_num_groups(1);
	data[g2] = o0 - get_num_groups(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_work_dim(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_work_dim();
	data[id1] = x - get_work_dim();
	data[id2] = x - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_work_dim(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_work_dim(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_work_dim(int x, __global long *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_work_dim(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_work_dim(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_work_dim();
	data[g1] = g1 - get_work_dim();
	data[g2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_work_dim(__global long *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_work_dim(int x, __global ulong *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_work_dim(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_work_dim();
	data[g1] = o0 - get_work_dim();
	data[g2] = o0 - get_work_dim();
}



__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	data[g0] = x - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_offset_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_id_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_group_id_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_size_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_id_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	data[g0] = g0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_size_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_num_groups_64(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_work_dim(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_work_dim();
	data[g0] = o0 - g0;
}



__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_x_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = x - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_offset_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	uint o1 = get_global_offset(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_id_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	uint o1 = get_local_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_group_id_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	uint o1 = get_group_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_size_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	uint o1 = get_local_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_id_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = g0 - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_size_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	uint o1 = get_global_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_num_groups_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	uint o1 = get_num_groups(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_work_dim_8_8(int x, __global ulong *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint o0 = get_work_dim();
	data[g0] = o0 - g1;
}



__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_x(__global char *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_x(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_x(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_x(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_x(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_x(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - x;
	data[g1] = g1 - x;
	data[g2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_x(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_x(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - x;
	data[id1] = g1 - x;
	data[id2] = g2 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_x(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_work_dim();
	data[g0] = o0 - x;
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_offset(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_offset(0);
	data[id1] = x - get_global_offset(1);
	data[id2] = x - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_offset(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_offset(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_offset(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_offset(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_offset(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_offset(0);
	data[g1] = g1 - get_global_offset(1);
	data[g2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_offset(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_offset(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_offset(0);
	data[id1] = g1 - get_global_offset(1);
	data[id2] = g2 - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_offset(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_offset(0);
	data[g1] = o0 - get_global_offset(1);
	data[g2] = o0 - get_global_offset(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_id(0);
	data[id1] = x - get_local_id(1);
	data[id2] = x - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_id(0);
	data[g1] = g1 - get_local_id(1);
	data[g2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_id(0);
	data[id1] = g1 - get_local_id(1);
	data[id2] = g2 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_id(0);
	data[g1] = o0 - get_local_id(1);
	data[g2] = o0 - get_local_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_group_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_group_id(0);
	data[id1] = x - get_group_id(1);
	data[id2] = x - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_group_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_group_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_group_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_group_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_group_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_group_id(0);
	data[g1] = g1 - get_group_id(1);
	data[g2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_group_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_group_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_group_id(0);
	data[id1] = g1 - get_group_id(1);
	data[id2] = g2 - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_group_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_group_id(0);
	data[g1] = o0 - get_group_id(1);
	data[g2] = o0 - get_group_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_size(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_local_size(0);
	data[id1] = x - get_local_size(1);
	data[id2] = x - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_size(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_size(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_local_size(0);
	data[g1] = g1 - get_local_size(1);
	data[g2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_size(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_size(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_local_size(0);
	data[id1] = g1 - get_local_size(1);
	data[id2] = g2 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_size(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_local_size(0);
	data[g1] = o0 - get_local_size(1);
	data[g2] = o0 - get_local_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_id(0);
	data[id1] = x - get_global_id(1);
	data[id2] = x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_id(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_id(0);
	data[g1] = g1 - get_global_id(1);
	data[g2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_id(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_id(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_id(0);
	data[id1] = g1 - get_global_id(1);
	data[id2] = g2 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_id(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_id(0);
	data[g1] = o0 - get_global_id(1);
	data[g2] = o0 - get_global_id(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_size(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_global_size(0);
	data[id1] = x - get_global_size(1);
	data[id2] = x - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_size(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_size(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_size(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_global_size(0);
	data[g1] = g1 - get_global_size(1);
	data[g2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_size(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_size(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_global_size(0);
	data[id1] = g1 - get_global_size(1);
	data[id2] = g2 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_size(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_global_size(0);
	data[g1] = o0 - get_global_size(1);
	data[g2] = o0 - get_global_size(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_num_groups(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_num_groups(0);
	data[id1] = x - get_num_groups(1);
	data[id2] = x - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_num_groups(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_num_groups(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_num_groups(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_num_groups(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_num_groups(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_num_groups(0);
	data[g1] = g1 - get_num_groups(1);
	data[g2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_num_groups(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_num_groups(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_num_groups(0);
	data[id1] = g1 - get_num_groups(1);
	data[id2] = g2 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_num_groups(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_num_groups(0);
	data[g1] = o0 - get_num_groups(1);
	data[g2] = o0 - get_num_groups(2);
}



__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_work_dim(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	data[id0] = x - get_work_dim();
	data[id1] = x - get_work_dim();
	data[id2] = x - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_work_dim(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_offset(0);
	uint g1 = get_global_offset(1);
	uint g2 = get_global_offset(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_work_dim(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_id(0);
  	uint g1 = get_local_id(1);
  	uint g2 = get_local_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_work_dim(int x, __global char *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_group_id(0);
  	uint g1 = get_group_id(1);
  	uint g2 = get_group_id(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_work_dim(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_local_size(0);
  	uint g1 = get_local_size(1);
	uint g2 = get_local_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_work_dim(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
  	uint o0 = get_global_offset(0);
  	uint g1 = get_global_id(1);
  	uint g2 = get_global_id(2);
	data[g0 - o0] = g0 - get_work_dim();
	data[g1] = g1 - get_work_dim();
	data[g2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_work_dim(__global char *data, int x)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
	uint g0 = get_global_size(0);
	uint g1 = get_global_size(1);
	uint g2 = get_global_size(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_work_dim(int x, __global uchar *data)
{
	uint id0 = get_global_id(0);
	uint id1 = get_global_id(1);
	uint id2 = get_global_id(2);
  	uint g0 = get_num_groups(0);
  	uint g1 = get_num_groups(1);
  	uint g2 = get_num_groups(2);
	data[id0] = g0 - get_work_dim();
	data[id1] = g1 - get_work_dim();
	data[id2] = g2 - get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_work_dim(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint g2 = get_global_id(2);
  	uint o0 = get_work_dim();
	data[g0] = o0 - get_work_dim();
	data[g1] = o0 - get_work_dim();
	data[g2] = o0 - get_work_dim();
}



__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	data[g0] = x - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_offset_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_id_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_group_id_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_size_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_id_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	data[g0] = g0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_size_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_num_groups_64(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	data[g0] = o0 - g0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_work_dim(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_work_dim();
	data[g0] = o0 - g0;
}



__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_x_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = x - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_offset_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_offset(0);
	uint o1 = get_global_offset(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_id_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_id(0);
	uint o1 = get_local_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_group_id_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_group_id(0);
	uint o1 = get_group_id(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_size_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_local_size(0);
	uint o1 = get_local_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_id_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	data[g0] = g0 - g1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_size_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_global_size(0);
	uint o1 = get_global_size(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_num_groups_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint o0 = get_num_groups(0);
	uint o1 = get_num_groups(1);
	data[g0] = o0 - o1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_work_dim_8_8(int x, __global uchar *data)
{
	uint g0 = get_global_id(0);
	uint g1 = get_global_id(1);
	uint o0 = get_work_dim();
	data[g0] = o0 - g1;
}
