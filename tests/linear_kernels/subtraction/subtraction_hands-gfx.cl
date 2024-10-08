__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_x(__global int *data, int x)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_x(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - x;
    data[get_global_id(1)] = (long)get_global_offset(1) - x;
    data[get_global_id(2)] = (long)get_global_offset(2) - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)x;
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)x;
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - x;
    data[get_global_id(1)] = (long)get_group_id(1) - x;
    data[get_global_id(2)] = (long)get_group_id(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_x(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - x;
    data[get_global_id(1)] = 2 - x;
    data[get_global_id(2)] = 4 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_x(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_offset(0) + ((uint)(get_global_id(0) - get_global_offset(0)) - (uint)x);
    data[get_global_id(1)] = get_global_id(1) - (uint)x;
    data[get_global_id(2)] = get_global_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_x(__global int *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - x;
    data[get_global_id(1)] = (long)get_global_size(1) - x;
    data[get_global_id(2)] = (long)get_global_size(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - x;
    data[get_global_id(1)] = (long)get_num_groups(1) - x;
    data[get_global_id(2)] = (long)get_num_groups(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = x - (long)get_global_offset(0);
    data[get_global_id(1)] = x - (long)get_global_offset(1);
    data[get_global_id(2)] = x - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_offset(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_offset(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - (long)get_global_offset(0);
    data[get_global_id(1)] = 2 - (long)get_global_offset(1);
    data[get_global_id(2)] = 4 - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_global_size(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_global_size(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_offset(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_offset(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)x - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)x - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)x - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - (uint)get_local_id(0);
    data[get_global_id(1)] = 2 - (uint)get_local_id(1);
    data[get_global_id(2)] = 4 - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_id(int x, __global uint *data)
{
    data[2*get_group_id(0) + (ulong)get_local_id(0)] = (ulong)(get_group_id(0) * 2) + (ulong)get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 0 + ((uint)get_num_groups(0) - (uint)get_local_id(0));
    data[get_global_id(1)] = 0 + ((uint)get_num_groups(1) - (uint)get_local_id(1));
    data[get_global_id(2)] = 0 + ((uint)get_num_groups(2) - (uint)get_local_id(2));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = x - (long)get_group_id(0);
    data[get_global_id(1)] = x - (long)get_group_id(1);
    data[get_global_id(2)] = x - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_global_offset(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_global_offset(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_group_id(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_group_id(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - (long)get_group_id(0);
    data[get_global_id(1)] = 2 - (long)get_group_id(1);
    data[get_global_id(2)] = 4 - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_offset(0) + ((uint)(get_global_id(0) - get_global_offset(0)) - (uint)get_group_id(0));
    data[get_global_id(1)] = get_global_id(1) - (uint)get_group_id(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_global_size(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_global_size(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_group_id(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_group_id(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = x + (-16);
    data[get_global_id(1)] = x + (-2);
    data[get_global_id(2)] = x + (-2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) + (-2);
    data[get_global_id(1)] = (ulong)get_global_offset(1) + (-16);
    data[get_global_id(2)] = (ulong)get_global_offset(2) + (-2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = (-8) + (ulong)get_local_id(0);
    data[get_global_id(1)] = (-4) + (ulong)get_local_id(1);
    data[get_global_id(2)] = (-2) + (ulong)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) + (-2);
    data[get_global_id(1)] = (ulong)get_group_id(1) + (-16);
    data[get_global_id(2)] = (ulong)get_group_id(2) + (-2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) + (ulong)(-2);
    data[get_global_id(1)] = (ulong)(-2) + get_global_id(1);
    data[get_global_id(2)] = (ulong)(-4) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) + (-16);
    data[get_global_id(1)] = (ulong)get_global_size(1) + (-2);
    data[get_global_id(2)] = (ulong)get_global_size(2) + (-2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)get_num_groups(0) + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_num_groups(1) + (ulong)(-2);
    data[get_global_id(2)] = (ulong)get_num_groups(2) + (ulong)(-4);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)(-2) + (ulong)get_work_dim();
    data[get_global_id(1)] = (ulong)(-2) + (ulong)get_work_dim();
    data[get_global_id(2)] = (ulong)(-4) + (ulong)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)x - get_global_id(0);
    data[get_global_id(1)] = (uint)x - get_global_id(1);
    data[get_global_id(2)] = (uint)x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = 0 - (uint)(get_global_id(0) - get_global_offset(0));
    data[get_global_id(1)] = 0 - (uint)(get_global_id(1) - get_global_offset(1));
    data[get_global_id(2)] = 0 - (uint)(get_global_id(2) - get_global_offset(2));
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_group_id(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_group_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - get_global_id(0);
    data[get_global_id(1)] = 2 - get_global_id(1);
    data[get_global_id(2)] = 4 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_global_size(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_global_size(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 0 + ((uint)get_num_groups(0) - get_global_id(0));
    data[get_global_id(1)] = 0 + ((uint)get_num_groups(1) - get_global_id(1));
    data[get_global_id(2)] = 0 + ((uint)get_num_groups(2) - get_global_id(2));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(0);
    data[get_global_id(1)] = (uint)get_work_dim() - get_global_id(1);
    data[get_global_id(2)] = (uint)get_work_dim() - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = x - (long)get_global_size(0);
    data[get_global_id(1)] = x - (long)get_global_size(1);
    data[get_global_id(2)] = x - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_global_offset(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_global_offset(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_size(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_size(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - (long)get_global_size(0);
    data[get_global_id(1)] = 2 - (long)get_global_size(1);
    data[get_global_id(2)] = 4 - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (uint)get_global_size(0);
    data[get_global_id(1)] = get_global_id(1) - (uint)get_global_size(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_size(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_size(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)x - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)x - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)x - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 + ((uint)0 - (uint)get_num_groups(0));
    data[get_global_id(1)] = 2 + ((uint)0 - (uint)get_num_groups(1));
    data[get_global_id(2)] = 4 + ((uint)0 - (uint)get_num_groups(2));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (ulong)get_num_groups(0);
    data[get_global_id(1)] = get_global_id(1) - (ulong)get_num_groups(1);
    data[get_global_id(2)] = get_global_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - (ulong)get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - (ulong)get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)x - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 - (uint)get_work_dim();
    data[get_global_id(1)] = 2 - (uint)get_work_dim();
    data[get_global_id(2)] = 4 - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = get_global_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = get_global_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (uint)get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) - (uint)get_work_dim();
    data[get_global_id(2)] = 0 + ((uint)get_num_groups(2) - (uint)get_work_dim());
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)x - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_offset_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_group_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_size_64(int x, __global uint *data)
{
    data[get_global_id(0)] = 64 - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_size_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_num_groups_64(int x, __global uint *data)
{
    data[get_global_id(0)] = 0 + ((uint)get_num_groups(0) - get_global_id(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_x_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)(x - (long)(get_group_id(1) * 8)) - ((ulong)get_global_offset(1) + (ulong)get_local_id(1));
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_offset_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_group_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_size_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(0) - get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_size_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_global_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_num_groups_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = ((long)get_num_groups(0) - (long)get_num_groups(1)) - 0;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_work_dim_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_x(__global long *data, int x)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_x(int x, __global long *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - x;
    data[get_global_id(1)] = (long)get_global_offset(1) - x;
    data[get_global_id(2)] = (long)get_global_offset(2) - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_x(int x, __global long *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)x;
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)x;
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_x(int x, __global long *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - x;
    data[get_global_id(1)] = (long)get_group_id(1) - x;
    data[get_global_id(2)] = (long)get_group_id(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - x;
    data[get_global_id(1)] = 2 - x;
    data[get_global_id(2)] = 4 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_x(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_offset(0) + ((uint)(get_global_id(0) - get_global_offset(0)) - (uint)x);
    data[get_global_id(1)] = get_global_id(1) - (uint)x;
    data[get_global_id(2)] = get_global_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_x(__global long *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - x;
    data[get_global_id(1)] = (long)get_global_size(1) - x;
    data[get_global_id(2)] = (long)get_global_size(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - x;
    data[get_global_id(1)] = (long)get_num_groups(1) - x;
    data[get_global_id(2)] = (long)get_num_groups(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_offset(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - (ulong)get_global_offset(0);
    data[get_global_id(1)] = (ulong)x - (ulong)get_global_offset(1);
    data[get_global_id(2)] = (ulong)x - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = 0 - 0;
    data[get_global_id(1)] = 0 - 0;
    data[get_global_id(2)] = 0 - 0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - get_global_offset(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - get_global_offset(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_global_offset(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_global_offset(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - (ulong)get_global_offset(0);
    data[get_global_id(1)] = 2 - (ulong)get_global_offset(1);
    data[get_global_id(2)] = 4 - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_offset(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - (ulong)get_global_offset(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - (ulong)get_global_offset(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (ulong)get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) - (ulong)get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_global_offset(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_global_offset(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - get_local_id(0);
    data[get_global_id(1)] = (ulong)x - get_local_id(1);
    data[get_global_id(2)] = (ulong)x - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - get_local_id(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - get_local_id(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - get_local_id(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - get_local_id(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - get_local_id(0);
    data[get_global_id(1)] = 2 - get_local_id(1);
    data[get_global_id(2)] = 4 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_local_id(0);
    data[get_global_id(1)] = get_global_id(1) - get_local_id(1);
    data[get_global_id(2)] = get_global_id(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - get_local_id(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - get_local_id(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) - get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_local_id(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_local_id(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_group_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - (ulong)get_group_id(0);
    data[get_global_id(1)] = (ulong)x - (ulong)get_group_id(1);
    data[get_global_id(2)] = (ulong)x - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_group_id(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_group_id(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - get_group_id(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - get_group_id(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - (ulong)get_group_id(0);
    data[get_global_id(1)] = 2 - (ulong)get_group_id(1);
    data[get_global_id(2)] = 4 - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_group_id(0);
    data[get_global_id(1)] = get_global_id(1) - get_group_id(1);
    data[get_global_id(2)] = get_global_id(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_group_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - (ulong)get_group_id(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - (ulong)get_group_id(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (ulong)get_group_id(0);
    data[get_global_id(1)] = get_num_groups(1) - (ulong)get_group_id(1);
    data[get_global_id(2)] = get_num_groups(2) - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_group_id(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_group_id(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_size(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x + (ulong)(-16);
    data[get_global_id(1)] = (ulong)x + (ulong)(-2);
    data[get_global_id(2)] = (ulong)x + (ulong)(-2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_global_offset(1) + (ulong)(-16);
    data[get_global_id(2)] = (ulong)get_global_offset(2) + (ulong)(-2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = (-8) + (ulong)get_local_id(0);
    data[get_global_id(1)] = (-4) + (ulong)get_local_id(1);
    data[get_global_id(2)] = (-2) + (ulong)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_group_id(1) + (ulong)(-16);
    data[get_global_id(2)] = (ulong)get_group_id(2) + (ulong)(-2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + (ulong)(-2);
    data[get_global_id(1)] = get_global_id(1) + (ulong)(-2);
    data[get_global_id(2)] = get_global_id(2) + (ulong)(-4);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_size(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) + (ulong)(-16);
    data[get_global_id(1)] = (ulong)get_global_size(1) + (ulong)(-2);
    data[get_global_id(2)] = (ulong)get_global_size(2) + (ulong)(-2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) + (ulong)(-2);
    data[get_global_id(1)] = get_num_groups(1) + (ulong)(-2);
    data[get_global_id(2)] = get_num_groups(2) + (ulong)(-4);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_work_dim() + (ulong)(-2);
    data[get_global_id(2)] = (ulong)get_work_dim() + (ulong)(-4);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - get_global_id(0);
    data[get_global_id(1)] = (ulong)x - get_global_id(1);
    data[get_global_id(2)] = (ulong)x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - get_global_id(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - get_global_id(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - get_global_id(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - get_global_id(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - get_global_id(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - get_global_id(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - get_global_id(0);
    data[get_global_id(1)] = 2 - get_global_id(1);
    data[get_global_id(2)] = 4 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = 0 - 0;
    data[get_global_id(1)] = get_global_id(1) - get_global_id(1);
    data[get_global_id(2)] = get_global_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_id(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - get_global_id(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - get_global_id(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) - get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_global_id(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_global_id(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_size(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - (ulong)get_global_size(0);
    data[get_global_id(1)] = (ulong)x - (ulong)get_global_size(1);
    data[get_global_id(2)] = (ulong)x - (ulong)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_global_size(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_global_size(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - get_global_size(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - get_global_size(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_global_size(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_global_size(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - (ulong)get_global_size(0);
    data[get_global_id(1)] = 2 - (ulong)get_global_size(1);
    data[get_global_id(2)] = 4 - (ulong)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_global_size(0);
    data[get_global_id(1)] = get_global_id(1) - get_global_size(1);
    data[get_global_id(2)] = get_global_id(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_size(__global long *data, int x)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (ulong)get_global_size(0);
    data[get_global_id(1)] = get_num_groups(1) - (ulong)get_global_size(1);
    data[get_global_id(2)] = get_num_groups(2) - (ulong)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_global_size(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_global_size(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_num_groups(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)x - get_num_groups(0);
    data[get_global_id(1)] = (ulong)x - get_num_groups(1);
    data[get_global_id(2)] = (ulong)x - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) - get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_global_offset(1) - get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_global_offset(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_local_id(0) - get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_local_id(1) - get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_local_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) - get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_group_id(1) - get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_group_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - get_num_groups(0);
    data[get_global_id(1)] = 2 - get_num_groups(1);
    data[get_global_id(2)] = 4 - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_num_groups(0);
    data[get_global_id(1)] = get_global_id(1) - get_num_groups(1);
    data[get_global_id(2)] = get_global_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_num_groups(__global long *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) - get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_global_size(1) - get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_global_size(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() - get_num_groups(0);
    data[get_global_id(1)] = (ulong)get_work_dim() - get_num_groups(1);
    data[get_global_id(2)] = (ulong)get_work_dim() - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_work_dim(__global long *data, int x)
{
    data[get_global_id(0)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)x - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = 2 - (uint)get_work_dim();
    data[get_global_id(1)] = 2 - (uint)get_work_dim();
    data[get_global_id(2)] = 4 - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = get_global_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = get_global_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_work_dim(__global long *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (uint)get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) - (uint)get_work_dim();
    data[get_global_id(2)] = 0 + ((uint)get_num_groups(2) - (uint)get_work_dim());
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)x - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_offset_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0 - (uint)(get_global_id(0) - get_global_offset(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_group_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_size_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = 64 - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_size_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_num_groups_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_x_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)(x - (long)(get_group_id(1) * 8)) - ((ulong)get_global_offset(1) + (ulong)get_local_id(1));
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_offset_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_group_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_size_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_id(0) - get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_size_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_global_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_num_groups_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_work_dim_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_x(__global char *data, int x)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_x(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - x;
    data[get_global_id(1)] = (long)get_global_offset(1) - x;
    data[get_global_id(2)] = (long)get_global_offset(2) - x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_x(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)x;
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)x;
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_x(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - x;
    data[get_global_id(1)] = (long)get_group_id(1) - x;
    data[get_global_id(2)] = (long)get_group_id(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (ushort)x;
    data[get_global_id(1)] = 2 - (ushort)x;
    data[get_global_id(2)] = 4 - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_x(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_offset(0) + ((uint)(get_global_id(0) - get_global_offset(0)) - (uint)x);
    data[get_global_id(1)] = get_global_id(1) - (uint)x;
    data[get_global_id(2)] = get_global_id(2) - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_x(__global char *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - x;
    data[get_global_id(1)] = (long)get_global_size(1) - x;
    data[get_global_id(2)] = (long)get_global_size(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - x;
    data[get_global_id(1)] = (long)get_num_groups(1) - x;
    data[get_global_id(2)] = (long)get_num_groups(2) - x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_offset(__global char *data, int x)
{
    data[get_global_id(0)] = x - (long)get_global_offset(0);
    data[get_global_id(1)] = x - (long)get_global_offset(1);
    data[get_global_id(2)] = x - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_offset(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_offset(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (long)get_global_offset(0);
    data[get_global_id(1)] = 2 - (long)get_global_offset(1);
    data[get_global_id(2)] = 4 - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_offset(__global char *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_global_size(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_global_size(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_offset(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_offset(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_offset(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_offset(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_id(__global char *data, int x)
{
    data[get_global_id(0)] = (uint)x - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)x - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)x - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_id(0);
    data[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = (ushort)get_group_id(0) - (ushort)get_local_id(0);
    data[get_global_id(1)] = (ushort)get_group_id(1) - (ushort)get_local_id(1);
    data[get_global_id(2)] = (ushort)get_group_id(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (ushort)get_local_id(0);
    data[get_global_id(1)] = 2 - (ushort)get_local_id(1);
    data[get_global_id(2)] = 4 - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_id(int x, __global uchar *data)
{
    data[2*get_group_id(0) + (ulong)get_local_id(0)] = (ulong)(get_group_id(0) * 2) + (ulong)get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) - (uint)get_local_id(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_id(__global char *data, int x)
{
    data[get_global_id(0)] = (ushort)get_global_size(0) - (ushort)get_local_id(0);
    data[get_global_id(1)] = (ushort)get_global_size(1) - (ushort)get_local_id(1);
    data[get_global_id(2)] = (ushort)get_global_size(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_num_groups(0) - (ushort)get_local_id(0);
    data[get_global_id(1)] = (ushort)get_num_groups(1) - (ushort)get_local_id(1);
    data[get_global_id(2)] = (ushort)get_num_groups(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_work_dim() - (ushort)get_local_id(0);
    data[get_global_id(1)] = (ushort)get_work_dim() - (ushort)get_local_id(1);
    data[get_global_id(2)] = (ushort)get_work_dim() - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_group_id(__global char *data, int x)
{
    data[get_global_id(0)] = x - (long)get_group_id(0);
    data[get_global_id(1)] = x - (long)get_group_id(1);
    data[get_global_id(2)] = x - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_global_offset(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_global_offset(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_group_id(0);
    data[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_group_id(1);
    data[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (long)get_group_id(0);
    data[get_global_id(1)] = 2 - (long)get_group_id(1);
    data[get_global_id(2)] = 4 - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_offset(0) + ((uint)(get_global_id(0) - get_global_offset(0)) - (uint)get_group_id(0));
    data[get_global_id(1)] = get_global_id(1) - (uint)get_group_id(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_group_id(__global char *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_global_size(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_global_size(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_group_id(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_group_id(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_group_id(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_group_id(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_size(__global char *data, int x)
{
    data[get_global_id(0)] = x + (ulong)0xf0;
    data[get_global_id(1)] = (ulong)x + (ulong)(-2);
    data[get_global_id(2)] = (ulong)x + (ulong)(-2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = (ulong)get_global_offset(0) + 0xfe;
    data[get_global_id(1)] = (int)get_global_offset(1) + (int)0xf0;
    data[get_global_id(2)] = (ulong)get_global_offset(2) + 0xfe;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = (ulong)0xf8 + (ulong)get_local_id(0);
    data[get_global_id(1)] = (ulong)0xfc + (ulong)get_local_id(1);
    data[get_global_id(2)] = (ulong)0xfe + (ulong)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = (ulong)get_group_id(0) + 0xfe;
    data[get_global_id(1)] = (int)get_group_id(1) + (int)0xf0;
    data[get_global_id(2)] = (ulong)get_group_id(2) + 0xfe;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_global_id(1) + (ulong)(-2);
    data[get_global_id(2)] = (ulong)get_global_id(2) + (ulong)(-4);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_size(__global char *data, int x)
{
    data[get_global_id(0)] = (ulong)get_global_size(0) + (ulong)0xf0;
    data[get_global_id(1)] = (ulong)get_global_size(1) + 0xfe;
    data[get_global_id(2)] = (ulong)get_global_size(2) + 0xfe;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ulong)get_num_groups(0) + (ulong)0xfe;
    data[get_global_id(1)] = (ulong)get_num_groups(1) + (ulong)0xfe;
    data[get_global_id(2)] = (ulong)get_num_groups(2) + (ulong)0xfc;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ulong)get_work_dim() + (ulong)(-2);
    data[get_global_id(1)] = (ulong)get_work_dim() + (ulong)(-2);
    data[get_global_id(2)] = (ulong)0xfc + (ulong)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_id(__global char *data, int x)
{
    data[get_global_id(0)] = (uint)x - get_global_id(0);
    data[get_global_id(1)] = (uint)x - get_global_id(1);
    data[get_global_id(2)] = (uint)x - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = 0 - (ushort)(get_global_id(0) - get_global_offset(0));
    data[get_global_id(1)] = 0 - (ushort)(get_global_id(1) - get_global_offset(1));
    data[get_global_id(2)] = 0 - (ushort)(get_global_id(2) - get_global_offset(2));
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_local_id(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_local_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_group_id(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_group_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (ushort)get_global_id(0);
    data[get_global_id(1)] = 2 - (ushort)get_global_id(1);
    data[get_global_id(2)] = 4 - (ushort)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_id(__global char *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - get_global_id(0);
    data[get_global_id(1)] = (uint)get_global_size(1) - get_global_id(1);
    data[get_global_id(2)] = (uint)get_global_size(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) - get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) - get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(0);
    data[get_global_id(1)] = (uint)get_work_dim() - get_global_id(1);
    data[get_global_id(2)] = (uint)get_work_dim() - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_size(__global char *data, int x)
{
    data[get_global_id(0)] = x - (long)get_global_size(0);
    data[get_global_id(1)] = x - (long)get_global_size(1);
    data[get_global_id(2)] = x - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_global_offset(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_global_offset(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_global_size(0);
    data[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_global_size(1);
    data[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (long)get_global_size(0);
    data[get_global_id(1)] = 2 - (long)get_global_size(1);
    data[get_global_id(2)] = 4 - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (uint)get_global_size(0);
    data[get_global_id(1)] = get_global_id(1) - (uint)get_global_size(1);
    data[get_global_id(2)] = get_global_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_size(__global char *data, int x)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_size(0);
    data[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_size(1);
    data[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_size(0);
    data[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_size(1);
    data[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_num_groups(__global char *data, int x)
{
    data[get_global_id(0)] = x - (long)get_num_groups(0);
    data[get_global_id(1)] = x - (long)get_num_groups(1);
    data[get_global_id(2)] = x - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_num_groups(0);
    data[get_global_id(1)] = (long)get_global_offset(1) - (long)get_num_groups(1);
    data[get_global_id(2)] = (long)get_global_offset(2) - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_num_groups(0);
    data[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_num_groups(1);
    data[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_num_groups(0);
    data[get_global_id(1)] = (long)get_group_id(1) - (long)get_num_groups(1);
    data[get_global_id(2)] = (long)get_group_id(2) - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (long)get_num_groups(0);
    data[get_global_id(1)] = 2 - (long)get_num_groups(1);
    data[get_global_id(2)] = 4 - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - get_num_groups(0);
    data[get_global_id(1)] = get_global_id(1) - get_num_groups(1);
    data[get_global_id(2)] = get_global_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_num_groups(__global char *data, int x)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_num_groups(0);
    data[get_global_id(1)] = (long)get_global_size(1) - (long)get_num_groups(1);
    data[get_global_id(2)] = (long)get_global_size(2) - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_num_groups(0);
    data[get_global_id(1)] = (uint)get_work_dim() - get_num_groups(1);
    data[get_global_id(2)] = (uint)get_work_dim() - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_work_dim(__global char *data, int x)
{
    data[get_global_id(0)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)x - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)x - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = 2 - (ushort)get_work_dim();
    data[get_global_id(1)] = 2 - (ushort)get_work_dim();
    data[get_global_id(2)] = 4 - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (ushort)get_global_id(1) - (ushort)get_work_dim();
    data[get_global_id(2)] = (ushort)get_global_id(2) - (ushort)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_work_dim(__global char *data, int x)
{
    data[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    data[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    data[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) - (uint)get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) - (uint)get_work_dim();
    data[get_global_id(2)] = 0 + ((uint)get_num_groups(2) - (uint)get_work_dim());
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
    data[get_global_id(1)] = 0;
    data[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)x - get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_offset_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_global_offset(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_group_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_group_id(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_size_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = 64 - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_size_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_global_size(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_num_groups_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_num_groups(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_work_dim() - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_x_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)(x - (long)(get_group_id(1) * 8)) - ((ulong)get_global_offset(1) + (ulong)get_local_id(1));
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_offset_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_group_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_size_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (ushort)get_global_id(0) - (ushort)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_size_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_global_size(0) - (long)get_global_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_num_groups_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (long)get_num_groups(0) - (long)get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_work_dim_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (uint)get_work_dim() - get_global_id(1);
}
