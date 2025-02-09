__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_x_x(__global int *data, int x)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_x(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_x(int x, __global uint *data)
{
    data[get_global_id(0)] = x * 2;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_x(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * x;
    data[get_global_id(1)] = get_global_id(1) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_x(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_x(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_x(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_global_offset(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_global_offset(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = (int)get_local_id(0) * (int)get_local_id(0);
    data[get_global_id(1)] = (int)get_local_id(1) * (int)get_local_id(1);
    data[get_global_id(2)] = (int)get_local_id(2) * (int)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_local_id(0) * 2;
    data[get_global_id(1)] = get_local_id(1) * 2;
    data[get_global_id(2)] = get_local_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_local_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_local_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_local_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_local_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_local_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_work_dim();
    data[get_global_id(1)] = get_local_id(1) * get_work_dim();
    data[get_global_id(2)] = get_local_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 2;
    data[get_global_id(2)] = get_group_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_group_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_group_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_group_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_group_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_group_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_work_dim();
    data[get_global_id(1)] = get_group_id(1) * get_work_dim();
    data[get_global_id(2)] = get_group_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = x * 16;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 16;
    data[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * 8;
    data[get_global_id(1)] = get_local_id(1) * 4;
    data[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_local_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 16;
    data[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 4;
    data[get_global_id(1)] = 4;
    data[get_global_id(2)] = 16;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_local_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * 16;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_id(0) * x;
    data[get_global_id(1)] = get_global_id(1) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_global_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(0) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_global_id(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_id(0);
    data[get_global_id(1)] = get_work_dim() * get_global_id(1);
    data[get_global_id(2)] = get_work_dim() * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_global_size(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) * 2;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_size(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_size(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_num_groups(0);
    data[get_global_id(1)] = get_global_size(1) * get_num_groups(1);
    data[get_global_id(2)] = get_global_size(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_global_size(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_work_dim();
    data[get_global_id(1)] = get_global_size(1) * get_work_dim();
    data[get_global_id(2)] = get_global_size(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_num_groups(int x, __global int *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_group_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_group_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_num_groups(0) * get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_num_groups(__global int *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_size(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_size(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
    data[get_global_id(1)] = get_num_groups(1) * get_num_groups(1);
    data[get_global_id(2)] = get_num_groups(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) * get_work_dim();
    data[get_global_id(2)] = get_num_groups(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_x_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * x;
    data[get_global_id(1)] = get_work_dim() * x;
    data[get_global_id(2)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_global_offset_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_get_local_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() * get_local_id(0);
    data[get_global_id(1)] = get_work_dim() * get_local_id(1);
    data[get_global_id(2)] = get_work_dim() * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_get_group_id_get_work_dim(int x, __global int *data)
{
    data[get_global_id(0)] = get_work_dim() * get_group_id(0);
    data[get_global_id(1)] = get_work_dim() * get_group_id(1);
    data[get_global_id(2)] = get_work_dim() * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_local_size_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_global_id_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_work_dim() * get_global_id(0);
    data[get_global_id(1)] = get_global_id(1) * get_work_dim();
    data[get_global_id(2)] = get_global_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_get_global_size_get_work_dim(__global int *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * get_global_size(0);
    data[get_global_id(1)] = get_work_dim() * get_global_size(1);
    data[get_global_id(2)] = get_work_dim() * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_num_groups_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * get_num_groups(0);
    data[get_global_id(1)] = get_work_dim() * get_num_groups(1);
    data[get_global_id(2)] = get_work_dim() * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_get_work_dim_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
    data[get_global_id(1)] = get_work_dim() * get_work_dim();
    data[get_global_id(2)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_x_64(int x, __global uint *data)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_global_offset_64(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_local_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = (int)get_local_id(0) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_group_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_local_size_64(int x, __global uint *data)
{
    data[get_global_id(0)] = 0x1000;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_global_id_64(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(0) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_global_size_64(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_num_groups_64(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_x_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(1) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_global_offset_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_offset(1) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_local_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = (int)get_local_id(1) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_group_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_group_id(1) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_local_size_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = 64;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_global_id_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_global_size_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_size(1) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_num_groups_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(1) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_get_work_dim_8_8(int x, __global uint *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_x_x(__global long *data, int x)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_x(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_x(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_x(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = x * 2;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_x(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * x;
    data[get_global_id(1)] = get_global_id(1) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_x(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_x(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_global_offset(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_global_offset(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_global_offset(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_global_offset(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_local_id(__global long *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_local_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_local_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_local_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_local_id(0) * 2;
    data[get_global_id(1)] = get_local_id(1) * 2;
    data[get_global_id(2)] = get_local_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_local_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_local_id(__global long *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_local_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_local_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_local_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_work_dim();
    data[get_global_id(1)] = get_local_id(1) * get_work_dim();
    data[get_global_id(2)] = get_local_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_group_id(__global long *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_group_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 2;
    data[get_global_id(2)] = get_group_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_group_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_group_id(__global long *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_group_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_group_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_group_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_work_dim();
    data[get_global_id(1)] = get_group_id(1) * get_work_dim();
    data[get_global_id(2)] = get_group_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_local_size(__global long *data, int x)
{
    data[get_global_id(0)] = x * 16;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 16;
    data[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * 8;
    data[get_global_id(1)] = get_local_id(1) * 4;
    data[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_local_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 16;
    data[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = 4 * 1;
    data[get_global_id(1)] = 4 * 1;
    data[get_global_id(2)] = 16 * 1;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0)) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_local_size(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * 16;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_local_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_global_id(__global long *data, int x)
{
    data[get_global_id(0)] = ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0)) * x;
    data[get_global_id(1)] = ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1)) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0)) * get_global_offset(0);
    data[get_global_id(1)] = ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1)) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_local_id(0) * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_local_id(1) * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_global_id(int x, __global long *data)
{
    data[get_global_id(0)] = get_group_id(0) * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_group_id(1) * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0)) * 2;
    data[get_global_id(1)] = ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1)) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_global_id(1) * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_global_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_global_id(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_global_size(1) * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_num_groups(1) * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_global_id(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * ((get_global_id(0) - get_global_offset(0)) + (ulong)get_global_offset(0));
    data[get_global_id(1)] = get_work_dim() * ((get_global_id(1) - get_global_offset(1)) + (ulong)get_global_offset(1));
    data[get_global_id(2)] = get_work_dim() * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_global_size(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_global_size(int x, __global long *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_size(0) * 2;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_size(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_global_size(__global long *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_size(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_num_groups(0);
    data[get_global_id(1)] = get_global_size(1) * get_num_groups(1);
    data[get_global_id(2)] = get_global_size(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_global_size(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_work_dim();
    data[get_global_id(1)] = get_global_size(1) * get_work_dim();
    data[get_global_id(2)] = get_global_size(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_num_groups(__global long *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_num_groups(int x, __global long *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_group_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_group_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_num_groups(0) * get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_num_groups(__global long *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_size(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_size(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
    data[get_global_id(1)] = get_num_groups(1) * get_num_groups(1);
    data[get_global_id(2)] = get_num_groups(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_num_groups(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) * get_work_dim();
    data[get_global_id(2)] = get_num_groups(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_x_get_work_dim(__global long *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * x;
    data[get_global_id(1)] = get_work_dim() * x;
    data[get_global_id(2)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_global_offset_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_long_get_local_id_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = get_work_dim() * get_local_id(0);
    data[get_global_id(1)] = get_work_dim() * get_local_id(1);
    data[get_global_id(2)] = get_work_dim() * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_long_get_group_id_get_work_dim(int x, __global long *data)
{
    data[get_global_id(0)] = get_work_dim() * get_group_id(0);
    data[get_global_id(1)] = get_work_dim() * get_group_id(1);
    data[get_global_id(2)] = get_work_dim() * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_local_size_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_global_id_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_work_dim() * get_global_id(0);
    data[get_global_id(1)] = get_global_id(1) * get_work_dim();
    data[get_global_id(2)] = get_global_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_long_get_global_size_get_work_dim(__global long *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * get_global_size(0);
    data[get_global_id(1)] = get_work_dim() * get_global_size(1);
    data[get_global_id(2)] = get_work_dim() * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_num_groups_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * get_num_groups(0);
    data[get_global_id(1)] = get_work_dim() * get_num_groups(1);
    data[get_global_id(2)] = get_work_dim() * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_long_get_work_dim_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
    data[get_global_id(1)] = get_work_dim() * get_work_dim();
    data[get_global_id(2)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_x_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_global_offset_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_local_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = (int)get_local_id(0) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_group_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_local_size_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = 1 * 4096;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_global_id_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_id(0) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_global_size_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_num_groups_64(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_long_get_work_dim(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_x_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_id(1) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_global_offset_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_offset(1) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_local_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = (int)get_local_id(1) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_group_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_group_id(1) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_local_size_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = 64 * 1;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_global_id_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_global_size_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_size(1) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_num_groups_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_num_groups(1) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_long_get_work_dim_8_8(int x, __global ulong *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_x_x(__global char *data, int x)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_x(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_x(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_x(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = x * 2;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_x(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * x;
    data[get_global_id(1)] = get_global_id(1) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_x(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_x(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_global_offset(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_offset(0) * x;
    data[get_global_id(1)] = get_global_offset(1) * x;
    data[get_global_id(2)] = get_global_offset(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_global_offset(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 2;
    data[get_global_id(2)] = get_global_offset(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_global_offset(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_global_offset(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_local_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * x;
    data[get_global_id(1)] = get_local_id(1) * x;
    data[get_global_id(2)] = get_local_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = (int)get_local_id(0) * (int)get_local_id(0);
    data[get_global_id(1)] = (int)get_local_id(1) * (int)get_local_id(1);
    data[get_global_id(2)] = (int)get_local_id(2) * (int)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_local_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_local_id(0) * 2;
    data[get_global_id(1)] = get_local_id(1) * 2;
    data[get_global_id(2)] = get_local_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_local_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_local_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_local_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_local_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_local_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_work_dim();
    data[get_global_id(1)] = get_local_id(1) * get_work_dim();
    data[get_global_id(2)] = get_local_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_group_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * x;
    data[get_global_id(1)] = get_group_id(1) * x;
    data[get_global_id(2)] = get_group_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_local_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_local_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_group_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_group_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 2;
    data[get_global_id(2)] = get_group_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_group_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_group_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_size(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_size(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_num_groups(0);
    data[get_global_id(1)] = get_group_id(1) * get_num_groups(1);
    data[get_global_id(2)] = get_group_id(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_group_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_work_dim();
    data[get_global_id(1)] = get_group_id(1) * get_work_dim();
    data[get_global_id(2)] = get_group_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_local_size(__global char *data, int x)
{
    data[get_global_id(0)] = x * 16;
    data[get_global_id(1)] = x * 2;
    data[get_global_id(2)] = x * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_offset(0) * 2;
    data[get_global_id(1)] = get_global_offset(1) * 16;
    data[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * 8;
    data[get_global_id(1)] = get_local_id(1) * 4;
    data[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_local_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * 2;
    data[get_global_id(1)] = get_group_id(1) * 16;
    data[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = 4;
    data[get_global_id(1)] = 4;
    data[get_global_id(2)] = 16;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_local_size(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * 16;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_local_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_global_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_id(0) * x;
    data[get_global_id(1)] = get_global_id(1) * x;
    data[get_global_id(2)] = get_global_id(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_id(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_local_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_local_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_local_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_global_id(int x, __global char *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_group_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_group_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_id(0) * 2;
    data[get_global_id(1)] = get_global_id(1) * 2;
    data[get_global_id(2)] = get_global_id(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_id(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_id(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_global_id(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_global_id(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_id(0);
    data[get_global_id(1)] = get_work_dim() * get_global_id(1);
    data[get_global_id(2)] = get_work_dim() * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_global_size(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * x;
    data[get_global_id(1)] = get_global_size(1) * x;
    data[get_global_id(2)] = get_global_size(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_offset(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_offset(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_local_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_local_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_global_size(int x, __global char *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_group_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_group_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_size(0) * 2;
    data[get_global_id(1)] = get_global_size(1) * 2;
    data[get_global_id(2)] = get_global_size(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_size(0) * get_global_id(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_id(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_global_size(__global char *data, int x)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
    data[get_global_id(1)] = get_global_size(1) * get_global_size(1);
    data[get_global_id(2)] = get_global_size(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_num_groups(0);
    data[get_global_id(1)] = get_global_size(1) * get_num_groups(1);
    data[get_global_id(2)] = get_global_size(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_global_size(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_work_dim();
    data[get_global_id(1)] = get_global_size(1) * get_work_dim();
    data[get_global_id(2)] = get_global_size(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_num_groups(__global char *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * x;
    data[get_global_id(1)] = get_num_groups(1) * x;
    data[get_global_id(2)] = get_num_groups(2) * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_offset(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_offset(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_local_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_local_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_num_groups(int x, __global char *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_group_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_group_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * 2;
    data[get_global_id(1)] = get_num_groups(1) * 2;
    data[get_global_id(2)] = get_num_groups(2) * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_num_groups(0) * get_global_id(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_id(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_num_groups(__global char *data, int x)
{
    data[get_global_id(0)] = get_num_groups(0) * get_global_size(0);
    data[get_global_id(1)] = get_num_groups(1) * get_global_size(1);
    data[get_global_id(2)] = get_num_groups(2) * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
    data[get_global_id(1)] = get_num_groups(1) * get_num_groups(1);
    data[get_global_id(2)] = get_num_groups(2) * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_num_groups(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_work_dim();
    data[get_global_id(1)] = get_num_groups(1) * get_work_dim();
    data[get_global_id(2)] = get_num_groups(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_x_get_work_dim(__global char *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * x;
    data[get_global_id(1)] = get_work_dim() * x;
    data[get_global_id(2)] = get_work_dim() * x;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_global_offset_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = get_work_dim() * get_global_offset(0);
    data[get_global_id(1)] = get_work_dim() * get_global_offset(1);
    data[get_global_id(2)] = get_work_dim() * get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void mul_char_get_local_id_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = get_work_dim() * get_local_id(0);
    data[get_global_id(1)] = get_work_dim() * get_local_id(1);
    data[get_global_id(2)] = get_work_dim() * get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void mul_char_get_group_id_get_work_dim(int x, __global char *data)
{
    data[get_global_id(0)] = get_work_dim() * get_group_id(0);
    data[get_global_id(1)] = get_work_dim() * get_group_id(1);
    data[get_global_id(2)] = get_work_dim() * get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_local_size_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * 2;
    data[get_global_id(1)] = get_work_dim() * 2;
    data[get_global_id(2)] = get_work_dim() * 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_global_id_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_work_dim() * get_global_id(0);
    data[get_global_id(1)] = get_global_id(1) * get_work_dim();
    data[get_global_id(2)] = get_global_id(2) * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void mul_char_get_global_size_get_work_dim(__global char *data, int x)
{
    data[get_global_id(0)] = get_work_dim() * get_global_size(0);
    data[get_global_id(1)] = get_work_dim() * get_global_size(1);
    data[get_global_id(2)] = get_work_dim() * get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_num_groups_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * get_num_groups(0);
    data[get_global_id(1)] = get_work_dim() * get_num_groups(1);
    data[get_global_id(2)] = get_work_dim() * get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void mul_char_get_work_dim_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
    data[get_global_id(1)] = get_work_dim() * get_work_dim();
    data[get_global_id(2)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_x_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = x * x;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_global_offset_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_offset(0) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_local_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = (int)get_local_id(0) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_group_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_group_id(0) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_local_size_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_global_id_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_id(0) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_global_size_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_size(0) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_num_groups_64(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(0) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void mul_char_get_work_dim(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_work_dim() * get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_x_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_id(1) * x;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_global_offset_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_offset(1) * get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_local_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = (int)get_local_id(1) * (int)get_local_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_group_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_group_id(1) * get_group_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_local_size_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = 64;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_global_id_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_global_size_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_size(1) * get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_num_groups_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_num_groups(1) * get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void mul_char_get_work_dim_8_8(int x, __global uchar *data)
{
    data[get_global_id(0)] = get_global_id(1) * get_work_dim();
}
