__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_x_x(__global int *data, int x)
{
    data[get_global_id(0)] = x * 2;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + x;
    data[get_global_id(1)] = get_global_offset(1) + x;
    data[get_global_id(2)] = get_global_offset(2) + x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = x + get_local_id(0);
    data[get_global_id(1)] = x + get_local_id(1);
    data[get_global_id(2)] = x + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_group_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + x;
    data[get_global_id(1)] = get_group_id(1) + x;
    data[get_global_id(2)] = get_group_id(2) + x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_x(int x, __global uint *data)
{
    data[get_global_id(0)] = x + 2;
    data[get_global_id(1)] = x + 2;
    data[get_global_id(2)] = x + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_x(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + x + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = x + get_global_id(1);
    data[get_global_id(2)] = x + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_x(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + x;
    data[get_global_id(1)] = get_global_size(1) + x;
    data[get_global_id(2)] = get_global_size(2) + x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_x(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) + x;
    data[get_global_id(1)] = get_num_groups(1) + x;
    data[get_global_id(2)] = get_num_groups(2) + x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_x(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_offset(0) + x;
    data[get_global_id(1)] = get_global_offset(1) + x;
    data[get_global_id(2)] = get_global_offset(2) + x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
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
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_global_offset(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
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
    data[get_global_id(0)] = get_num_groups(0) + get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) + get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() + get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = x + get_local_id(0);
    data[get_global_id(1)] = x + get_local_id(1);
    data[get_global_id(2)] = x + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * 2;
    data[get_global_id(1)] = get_local_id(1) * 2;
    data[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
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
    data[get_global_id(0) - get_global_offset(0)] = get_local_id(0) + get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) + get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) + get_global_id(2);
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
    data[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + get_local_id(0);
    data[get_global_id(1)] = get_work_dim() + get_local_id(1);
    data[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) + x;
    data[get_global_id(1)] = get_group_id(1) + x;
    data[get_global_id(2)] = get_group_id(2) + x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
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
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_group_id(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_size(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_size(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_num_groups(0);
    data[get_global_id(1)] = get_group_id(1) + get_num_groups(1);
    data[get_global_id(2)] = get_group_id(2) + get_num_groups(2);
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
    data[get_global_id(0)] = x + 16;
    data[get_global_id(1)] = x + 2;
    data[get_global_id(2)] = x + 2;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + 4;
    data[get_global_id(1)] = get_global_offset(1) + 16;
    data[get_global_id(2)] = get_global_offset(2) + 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = 8 + get_local_id(0);
    data[get_global_id(1)] = 4 + get_local_id(1);
    data[get_global_id(2)] = 4 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_group_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + 4;
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
    data[get_global_id(0) - get_global_offset(0)] = 2 + get_global_id(0);
    data[get_global_id(1)] = 2 + get_global_id(1);
    data[get_global_id(2)] = 4 + get_global_id(2);
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
    data[get_global_id(0)] = get_num_groups(0) + 2;
    data[get_global_id(1)] = get_num_groups(1) + 2;
    data[get_global_id(2)] = get_num_groups(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + 2;
    data[get_global_id(1)] = get_work_dim() + 2;
    data[get_global_id(2)] = get_work_dim() + 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = x + get_global_id(0);
    data[get_global_id(1)] = x + get_global_id(1);
    data[get_global_id(2)] = x + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) + get_global_id(0);
    data[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    data[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) + get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) + get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_group_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) + get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = 2 + get_global_id(0);
    data[get_global_id(1)] = 2 + get_global_id(1);
    data[get_global_id(2)] = 4 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) + get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + get_global_id(0);
    data[get_global_id(1)] = get_work_dim() + get_global_id(1);
    data[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) + x;
    data[get_global_id(1)] = get_global_size(1) + x;
    data[get_global_id(2)] = get_global_size(2) + x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
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
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_global_size(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) + get_global_id(2);
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
    data[get_global_id(0)] = get_global_size(0) + get_num_groups(0);
    data[get_global_id(1)] = get_global_size(1) + get_num_groups(1);
    data[get_global_id(2)] = get_global_size(2) + get_num_groups(2);
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
    data[get_global_id(0)] = get_num_groups(0) + x;
    data[get_global_id(1)] = get_num_groups(1) + x;
    data[get_global_id(2)] = get_num_groups(2) + x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) + get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) + get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_group_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) + get_group_id(0);
    data[get_global_id(1)] = get_num_groups(1) + get_group_id(1);
    data[get_global_id(2)] = get_num_groups(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) + 2;
    data[get_global_id(1)] = get_num_groups(1) + 2;
    data[get_global_id(2)] = get_num_groups(2) + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_num_groups(0) + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) + get_global_size(0);
    data[get_global_id(1)] = get_num_groups(1) + get_global_size(1);
    data[get_global_id(2)] = get_num_groups(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) + get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) + get_work_dim();
    data[get_global_id(2)] = get_num_groups(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = get_work_dim() + x;
    data[get_global_id(1)] = get_work_dim() + x;
    data[get_global_id(2)] = get_work_dim() + x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_global_offset_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() + get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() + get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void add_get_local_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() + get_local_id(0);
    data[get_global_id(1)] = get_work_dim() + get_local_id(1);
    data[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void add_get_group_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() + get_group_id(0);
    data[get_global_id(1)] = get_work_dim() + get_group_id(1);
    data[get_global_id(2)] = get_work_dim() + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + 2;
    data[get_global_id(1)] = get_work_dim() + 2;
    data[get_global_id(2)] = get_work_dim() + 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_offset(0) + get_work_dim() + get_global_id(0) - get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() + get_global_id(1);
    data[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = get_work_dim() + get_global_size(0);
    data[get_global_id(1)] = get_work_dim() + get_global_size(1);
    data[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() + get_num_groups(0);
    data[get_global_id(1)] = get_work_dim() + get_num_groups(1);
    data[get_global_id(2)] = get_work_dim() + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 2;
}
