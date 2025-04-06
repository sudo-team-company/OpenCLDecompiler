__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_x_x(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)x * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + (uint)x;
    data[get_global_id(1)] = get_global_offset(1) + (uint)x;
    data[get_global_id(2)] = get_global_offset(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = (ulong)x + get_local_id(0);
    data[get_global_id(1)] = (ulong)x + get_local_id(1);
    data[get_global_id(2)] = (ulong)x + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + (uint)x;
    data[get_global_id(1)] = get_group_id(1) + (uint)x;
    data[get_global_id(2)] = get_group_id(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (uint)x + 2;
    data[get_global_id(1)] = (uint)x + 2;
    data[get_global_id(2)] = (uint)x + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_x(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + (ulong)x;
    data[get_global_id(1)] = (ulong)x + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = (ulong)x + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_x(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + (uint)x;
    data[get_global_id(1)] = get_global_size(1) + (uint)x;
    data[get_global_id(2)] = get_global_size(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_x(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + (uint)x;
    data[get_global_id(1)] = get_global_size(1) + (uint)x;
    data[get_global_id(2)] = get_global_size(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_x(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)x + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_offset(0) + (uint)x;
    data[get_global_id(1)] = get_global_offset(1) + (uint)x;
    data[get_global_id(2)] = get_global_offset(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_offset(0) + 2;
    data[get_global_id(1)] = get_global_offset(1) + 2;
    data[get_global_id(2)] = get_global_offset(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) * 2 + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_work_dim();
    data[get_global_id(1)] = get_global_offset(1) + get_work_dim();
    data[get_global_id(2)] = get_global_offset(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)x + get_local_id(0);
    data[get_global_id(1)] = (ulong)x + get_local_id(1);
    data[get_global_id(2)] = (ulong)x + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * 2;
    data[get_global_id(1)] = get_local_id(1) * 2;
    data[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 + get_local_id(0);
    data[get_global_id(1)] = 2 + get_local_id(1);
    data[get_global_id(2)] = 4 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_local_id(0);
    data[get_global_id(1)] = get_local_id(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_local_id(0) + get_work_dim();
    data[get_global_id(1)] = get_local_id(1) + get_work_dim();
    data[get_global_id(2)] = get_local_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) + (uint)x;
    data[get_global_id(1)] = get_group_id(1) + (uint)x;
    data[get_global_id(2)] = get_group_id(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 2;
    data[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) + 2;
    data[get_global_id(1)] = get_group_id(1) + 2;
    data[get_global_id(2)] = get_group_id(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_group_id(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_work_dim();
    data[get_global_id(1)] = get_group_id(1) + get_work_dim();
    data[get_global_id(2)] = get_group_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = (uint)x + 16;
    data[get_global_id(1)] = (uint)x + 2;
    data[get_global_id(2)] = (uint)x + 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + 2;
    data[get_global_id(1)] = get_global_offset(1) + 16;
    data[get_global_id(2)] = get_global_offset(2) + 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = 8 + get_local_id(0);
    data[get_global_id(1)] = 4 + get_local_id(1);
    data[get_global_id(2)] = 2 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + 2;
    data[get_global_id(1)] = get_group_id(1) + 16;
    data[get_global_id(2)] = get_group_id(2) + 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 4;
    data[get_global_id(1)] = 4;
    data[get_global_id(2)] = 8;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + 2;
    data[get_global_id(1)] = 2 + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = 4 + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + 16;
    data[get_global_id(1)] = get_global_size(1) + 2;
    data[get_global_id(2)] = get_global_size(2) + 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + 2;
    data[get_global_id(1)] = get_global_size(1) + 2;
    data[get_global_id(2)] = get_global_size(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 + get_work_dim();
    data[get_global_id(1)] = 2 + get_work_dim();
    data[get_global_id(2)] = 4 + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = (ulong)x + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = (ulong)x + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = (ulong)x + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = 2 + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = 4 + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = BROOO;
    data[get_global_id(1)] = get_global_offset(1) + get_global_id(1) - get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) + get_global_id(2) - get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + (uint)x;
    data[get_global_id(1)] = get_global_size(1) + (uint)x;
    data[get_global_id(2)] = get_global_size(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + 2;
    data[get_global_id(1)] = get_global_size(1) + 2;
    data[get_global_id(2)] = get_global_size(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * 2;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_size(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_work_dim();
    data[get_global_id(1)] = get_global_size(1) + get_work_dim();
    data[get_global_id(2)] = get_global_size(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + (uint)x;
    data[get_global_id(1)] = get_global_size(1) + (uint)x;
    data[get_global_id(2)] = get_global_size(2) + (uint)x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) + 2;
    data[get_global_id(1)] = get_global_size(1) + 2;
    data[get_global_id(2)] = get_global_size(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_global_size(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1) + get_global_id(1) - get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2) + get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_size(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_size(2);
}

