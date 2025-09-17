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
void div_x_y_char(__global char *data, char x, char y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_uchar(__global uchar *data, uchar x, uchar y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_short(__global short *data, short x, short y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_ushort(__global ushort *data, ushort x, ushort y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_int(__global int *data, int x, int y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_uint(__global uint *data, uint x, uint y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_long(__global long *data, long x, long y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_ulong(__global ulong *data, ulong x, ulong y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_float(__global float *data, float x, float y)
{
    data[get_global_id(0)] = x / y;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void div_x_y_double(__global double *data, double x, double y)
{
    data[get_global_id(0)] = x / y;
}
