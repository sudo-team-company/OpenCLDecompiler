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
