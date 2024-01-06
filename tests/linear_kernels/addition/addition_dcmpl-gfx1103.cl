__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_x_x(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + arg0;
    arg1[get_global_id(1)] = get_global_offset(1) + arg0;
    arg1[get_global_id(2)] = get_global_offset(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_id(0);
    arg1[get_global_id(1)] = arg0 + get_local_id(1);
    arg1[get_global_id(2)] = arg0 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + arg0;
    arg1[get_global_id(1)] = get_group_id(1) + arg0;
    arg1[get_global_id(2)] = get_group_id(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_size(0);
    arg1[get_global_id(1)] = arg0 + get_local_size(1);
    arg1[get_global_id(2)] = arg0 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = arg0 + get_global_id(0);
    arg1[get_global_id(1)] = arg0 + get_global_id(1);
    arg1[get_global_id(2)] = arg0 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_x(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_size(0);
    arg0[get_global_id(1)] = arg1 + get_global_size(1);
    arg0[get_global_id(2)] = arg1 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + arg0;
    arg1[get_global_id(1)] = get_num_groups(1) + arg0;
    arg1[get_global_id(2)] = get_num_groups(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_offset(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + arg1;
    arg0[get_global_id(1)] = get_global_offset(1) + arg1;
    arg0[get_global_id(2)] = get_global_offset(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) * 2;
    arg1[get_global_id(1)] = get_global_offset(1) * 2;
    arg1[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_global_offset(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_offset(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = ((get_group_id(0) + get_global_offset(0)) << 1) | get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_offset(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_work_dim();
    arg1[get_global_id(1)] = get_global_offset(1) + get_work_dim();
    arg1[get_global_id(2)] = get_global_offset(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_local_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_local_id(0);
    arg0[get_global_id(1)] = arg1 + get_local_id(1);
    arg0[get_global_id(2)] = arg1 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
    arg1[get_global_id(1)] = get_local_id(1) * 2;
    arg1[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_local_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_group_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_group_id(0) + arg1;
    arg0[get_global_id(1)] = get_group_id(1) + arg1;
    arg0[get_global_id(2)] = get_group_id(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_global_offset(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_offset(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
    arg1[get_global_id(1)] = get_group_id(1) * 2;
    arg1[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_group_id(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_group_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_group_id(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_group_id(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_group_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_work_dim();
    arg1[get_global_id(1)] = get_group_id(1) + get_work_dim();
    arg1[get_global_id(2)] = get_group_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_local_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_local_size(0);
    arg0[get_global_id(1)] = arg1 + get_local_size(1);
    arg0[get_global_id(2)] = arg1 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
    arg1[get_global_id(1)] = get_local_size(1) * 2;
    arg1[get_global_id(2)] = get_local_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_local_size(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_local_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_local_size(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_local_size(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_id(__global int *arg0, int arg1)
{
    arg0[get_global_offset(0)] = arg1 + get_global_offset(0) + 0;
    arg0[get_global_id(1)] = arg1 + get_global_id(1);
    arg0[get_global_id(2)] = arg1 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_offset(0)] = get_global_offset(0) + get_global_offset(0) + 0;
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_offset(0)] = get_group_id(0) + get_global_offset(0) + 0;
    arg1[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * 2;
    arg1[get_global_id(1)] = get_global_id(1) * 2;
    arg1[get_global_id(2)] = get_global_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_global_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_size(0);
    arg0[get_global_id(1)] = arg1 + get_global_size(1);
    arg0[get_global_id(2)] = arg1 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_size(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0);
    arg0[get_global_id(1)] = get_num_groups(1) * 4 + get_group_id(1) * get_local_size(1) * 2;
    arg0[get_global_id(2)] = get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2 + get_global_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) * 2 + get_global_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) * 4 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_num_groups(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) + arg1;
    arg0[get_global_id(1)] = get_num_groups(1) + arg1;
    arg0[get_global_id(2)] = get_num_groups(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_global_offset(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_offset(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_num_groups(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_num_groups(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) * 17 + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = get_num_groups(1) * 3 + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = get_num_groups(2) * 3 + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
    arg1[get_global_id(1)] = get_num_groups(1) * 2;
    arg1[get_global_id(2)] = get_num_groups(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_work_dim();
    arg1[get_global_id(1)] = get_num_groups(1) + get_work_dim();
    arg1[get_global_id(2)] = get_num_groups(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_x_get_work_dim(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + arg1;
    arg0[get_global_id(1)] = get_work_dim() + arg1;
    arg0[get_global_id(2)] = get_work_dim() + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_global_offset_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_offset(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_offset(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_get_local_id_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_get_group_id_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_work_dim();
    arg1[get_global_id(1)] = get_group_id(1) + get_work_dim();
    arg1[get_global_id(2)] = get_group_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_local_size_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_global_id_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_work_dim() + get_global_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_get_global_size_get_work_dim(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + get_global_size(0);
    arg0[get_global_id(1)] = get_work_dim() + get_global_size(1);
    arg0[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_num_groups_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_num_groups(0);
    arg1[get_global_id(1)] = get_work_dim() + get_num_groups(1);
    arg1[get_global_id(2)] = get_work_dim() + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_get_work_dim_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
    arg1[get_global_id(1)] = get_work_dim() * 2;
    arg1[get_global_id(2)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_x_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = arg0 * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_global_offset_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_local_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_group_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_local_size_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_global_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_global_size_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * get_local_size(0) * 2 + get_num_groups(0) * 128;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_num_groups_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_x_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_global_offset_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(1) + get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_local_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_group_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_local_size_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_local_size(1) + get_local_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_global_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_id(1) + get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_global_size_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (get_num_groups(1) + get_num_groups(0)) * 8 + get_group_id(1) * get_local_size(1) + get_group_id(0) * get_local_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_num_groups_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_get_work_dim_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_x_x(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + arg0;
    arg1[get_global_id(1)] = get_global_offset(1) + arg0;
    arg1[get_global_id(2)] = get_global_offset(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_id(0);
    arg1[get_global_id(1)] = arg0 + get_local_id(1);
    arg1[get_global_id(2)] = arg0 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + arg0;
    arg1[get_global_id(1)] = get_group_id(1) + arg0;
    arg1[get_global_id(2)] = get_group_id(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_size(0);
    arg1[get_global_id(1)] = arg0 + get_local_size(1);
    arg1[get_global_id(2)] = arg0 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = arg0 + get_global_id(0);
    arg1[get_global_id(1)] = arg0 + get_global_id(1);
    arg1[get_global_id(2)] = arg0 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_x(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_size(0);
    arg0[get_global_id(1)] = arg1 + get_global_size(1);
    arg0[get_global_id(2)] = arg1 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + arg0;
    arg1[get_global_id(1)] = get_num_groups(1) + arg0;
    arg1[get_global_id(2)] = get_num_groups(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_global_offset(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + arg1;
    arg0[get_global_id(1)] = get_global_offset(1) + arg1;
    arg0[get_global_id(2)] = get_global_offset(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_offset(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_offset(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_global_offset(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_global_offset(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_work_dim();
    arg1[get_global_id(1)] = get_global_offset(1) + get_work_dim();
    arg1[get_global_id(2)] = get_global_offset(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_local_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_local_id(0);
    arg0[get_global_id(1)] = arg1 + get_local_id(1);
    arg0[get_global_id(2)] = arg1 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
    arg1[get_global_id(1)] = get_local_id(1) * 2;
    arg1[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_local_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_group_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_group_id(0);
    arg0[get_global_id(1)] = arg1 + get_group_id(1);
    arg0[get_global_id(2)] = arg1 + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
    arg1[get_global_id(1)] = get_group_id(1) * 2;
    arg1[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_group_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_group_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_group_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_local_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_local_size(0) + arg1;
    arg0[get_global_id(1)] = get_local_size(1) + arg1;
    arg0[get_global_id(2)] = get_local_size(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
    arg1[get_global_id(1)] = get_local_size(1) * 2;
    arg1[get_global_id(2)] = get_local_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_local_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_local_size(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_local_size(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_local_size(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_work_dim();
    arg1[get_global_id(1)] = get_local_size(1) + get_work_dim();
    arg1[get_global_id(2)] = get_local_size(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_global_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_id(0) + arg1;
    arg0[get_global_id(1)] = get_global_id(1) + arg1;
    arg0[get_global_id(2)] = get_global_id(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_global_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_id(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_global_id(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_global_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_work_dim();
    arg1[get_global_id(1)] = get_global_id(1) + get_work_dim();
    arg1[get_global_id(2)] = get_global_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_global_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + arg1;
    arg0[get_global_id(1)] = get_global_size(1) + arg1;
    arg0[get_global_id(2)] = get_global_size(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_global_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) * 2;
    arg0[get_global_id(1)] = get_global_size(1) * 2;
    arg0[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_work_dim();
    arg1[get_global_id(1)] = get_global_size(1) + get_work_dim();
    arg1[get_global_id(2)] = get_global_size(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_num_groups(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) + arg1;
    arg0[get_global_id(1)] = get_num_groups(1) + arg1;
    arg0[get_global_id(2)] = get_num_groups(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_num_groups(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_num_groups(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_num_groups(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
    arg1[get_global_id(1)] = get_num_groups(1) * 2;
    arg1[get_global_id(2)] = get_num_groups(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_work_dim();
    arg1[get_global_id(1)] = get_num_groups(1) + get_work_dim();
    arg1[get_global_id(2)] = get_num_groups(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_x_get_work_dim(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + arg1;
    arg0[get_global_id(1)] = get_work_dim() + arg1;
    arg0[get_global_id(2)] = get_work_dim() + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_global_offset_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_offset(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_offset(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_long_get_local_id_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_long_get_group_id_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_work_dim();
    arg1[get_global_id(1)] = get_group_id(1) + get_work_dim();
    arg1[get_global_id(2)] = get_group_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_local_size_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_global_id_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_work_dim() + get_global_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_long_get_global_size_get_work_dim(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + get_global_size(0);
    arg0[get_global_id(1)] = get_work_dim() + get_global_size(1);
    arg0[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_num_groups_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_num_groups(0);
    arg1[get_global_id(1)] = get_work_dim() + get_num_groups(1);
    arg1[get_global_id(2)] = get_work_dim() + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_long_get_work_dim_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
    arg1[get_global_id(1)] = get_work_dim() * 2;
    arg1[get_global_id(2)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_x_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = arg0 * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_global_offset_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_local_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_group_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_local_size_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_global_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_global_size_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_num_groups_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_long_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_x_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_global_offset_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(1) + get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_local_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_group_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_local_size_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_local_size(1) + get_local_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_global_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_global_id(1) + get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_global_size_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (get_num_groups(1) + get_num_groups(0)) * 8 + get_group_id(1) * get_local_size(1) + get_group_id(0) * get_local_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_num_groups_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_long_get_work_dim_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_x_x(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + arg0;
    arg1[get_global_id(1)] = get_global_offset(1) + arg0;
    arg1[get_global_id(2)] = get_global_offset(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_id(0);
    arg1[get_global_id(1)] = arg0 + get_local_id(1);
    arg1[get_global_id(2)] = arg0 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + arg0;
    arg1[get_global_id(1)] = get_group_id(1) + arg0;
    arg1[get_global_id(2)] = get_group_id(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_local_size(0);
    arg1[get_global_id(1)] = arg0 + get_local_size(1);
    arg1[get_global_id(2)] = arg0 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = arg0 + get_global_id(0);
    arg1[get_global_id(1)] = arg0 + get_global_id(1);
    arg1[get_global_id(2)] = arg0 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_x(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_size(0);
    arg0[get_global_id(1)] = arg1 + get_global_size(1);
    arg0[get_global_id(2)] = arg1 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + arg0;
    arg1[get_global_id(1)] = get_num_groups(1) + arg0;
    arg1[get_global_id(2)] = get_num_groups(2) + arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_global_offset(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + arg1;
    arg0[get_global_id(1)] = get_global_offset(1) + arg1;
    arg0[get_global_id(2)] = get_global_offset(2) + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) * 2;
    arg1[get_global_id(1)] = get_global_offset(1) * 2;
    arg1[get_global_id(2)] = get_global_offset(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (get_global_offset(0) * 2) + (get_global_id(0) + -get_global_offset(0));
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_global_offset(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_work_dim();
    arg1[get_global_id(1)] = get_global_offset(1) + get_work_dim();
    arg1[get_global_id(2)] = get_global_offset(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_local_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_local_id(0);
    arg0[get_global_id(1)] = arg1 + get_local_id(1);
    arg0[get_global_id(2)] = arg1 + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
    arg1[get_global_id(1)] = get_local_id(1) * 2;
    arg1[get_global_id(2)] = get_local_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_local_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_group_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_group_id(0);
    arg0[get_global_id(1)] = arg1 + get_group_id(1);
    arg0[get_global_id(2)] = arg1 + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_group_id(0);
    arg1[get_global_id(1)] = get_local_id(1) + get_group_id(1);
    arg1[get_global_id(2)] = get_local_id(2) + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
    arg1[get_global_id(1)] = get_group_id(1) * 2;
    arg1[get_global_id(2)] = get_group_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_group_id(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_group_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_group_id(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_group_id(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_group_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_group_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_group_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_local_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_local_size(0);
    arg0[get_global_id(1)] = arg1 + get_local_size(1);
    arg0[get_global_id(2)] = arg1 + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_local_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_local_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
    arg1[get_global_id(1)] = get_local_size(1) * 2;
    arg1[get_global_id(2)] = get_local_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_local_size(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_local_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_local_size(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_local_size(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_local_size(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_global_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_id(0);
    arg0[get_global_id(1)] = arg1 + get_global_id(1);
    arg0[get_global_id(2)] = arg1 + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_id(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_id(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) * 2;
    arg1[get_global_id(1)] = get_global_id(1) * 2;
    arg1[get_global_id(2)] = get_global_id(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_global_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) + get_global_id(0);
    arg0[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    arg0[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_global_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_global_size(0);
    arg0[get_global_id(1)] = arg1 + get_global_size(1);
    arg0[get_global_id(2)] = arg1 + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_size(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_global_size(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_global_size(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_global_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_global_size(0) * 2;
    arg0[get_global_id(1)] = get_global_size(1) * 2;
    arg0[get_global_id(2)] = get_global_size(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_global_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_num_groups(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1 + get_num_groups(0);
    arg0[get_global_id(1)] = arg1 + get_num_groups(1);
    arg0[get_global_id(2)] = arg1 + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_global_offset(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_global_offset(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_num_groups(0);
    arg1[get_global_id(1)] = get_group_id(1) + get_num_groups(1);
    arg1[get_global_id(2)] = get_group_id(2) + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) + get_local_size(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_local_size(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_num_groups(0) + get_global_id(0);
    arg1[get_global_id(1)] = get_num_groups(1) + get_global_id(1);
    arg1[get_global_id(2)] = get_num_groups(2) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_num_groups(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_num_groups(0) + get_global_size(0);
    arg0[get_global_id(1)] = get_num_groups(1) + get_global_size(1);
    arg0[get_global_id(2)] = get_num_groups(2) + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
    arg1[get_global_id(1)] = get_num_groups(1) * 2;
    arg1[get_global_id(2)] = get_num_groups(2) * 2;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_num_groups(0);
    arg1[get_global_id(1)] = get_work_dim() + get_num_groups(1);
    arg1[get_global_id(2)] = get_work_dim() + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_x_get_work_dim(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + arg1;
    arg0[get_global_id(1)] = get_work_dim() + arg1;
    arg0[get_global_id(2)] = get_work_dim() + arg1;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_global_offset_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_offset(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_offset(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void add_char_get_local_id_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void add_char_get_group_id_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_work_dim();
    arg1[get_global_id(1)] = get_group_id(1) + get_work_dim();
    arg1[get_global_id(2)] = get_group_id(2) + get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_local_size_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_local_size(0);
    arg1[get_global_id(1)] = get_work_dim() + get_local_size(1);
    arg1[get_global_id(2)] = get_work_dim() + get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_global_id_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_work_dim() + get_global_id(0);
    arg1[get_global_id(1)] = get_work_dim() + get_global_id(1);
    arg1[get_global_id(2)] = get_work_dim() + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void add_char_get_global_size_get_work_dim(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = get_work_dim() + get_global_size(0);
    arg0[get_global_id(1)] = get_work_dim() + get_global_size(1);
    arg0[get_global_id(2)] = get_work_dim() + get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_num_groups_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_num_groups(0);
    arg1[get_global_id(1)] = get_work_dim() + get_num_groups(1);
    arg1[get_global_id(2)] = get_work_dim() + get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void add_char_get_work_dim_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
    arg1[get_global_id(1)] = get_work_dim() * 2;
    arg1[get_global_id(2)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_x_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = arg0 * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_global_offset_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_local_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_group_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_local_size_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_size(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_global_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_id(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_global_size_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_size(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_num_groups_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(0) * 2;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void add_char_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() * 2;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_x_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = arg0 + get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_global_offset_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_offset(1) + get_global_offset(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_local_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_id(0) + get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_group_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) + get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_local_size_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_local_size(1) + get_local_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_global_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_id(1) + get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_global_size_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_global_size(1) + get_global_size(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_num_groups_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_num_groups(1) + get_num_groups(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void add_char_get_work_dim_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + get_global_id(1);
}
