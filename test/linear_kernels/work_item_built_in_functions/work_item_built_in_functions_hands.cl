__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy_x(__global int *data, int x)
{
    data[get_global_id(0)] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void copy_get_global_offset(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_offset(0);
    data[get_global_id(1)] = get_global_offset(1);
    data[get_global_id(2)] = get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 4)))
void copy_get_local_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_local_id(0);
    data[get_global_id(1)] = get_local_id(1);
    data[get_global_id(2)] = get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(4, 16, 2)))
void copy_get_group_id(int x, __global int *data)
{
    data[get_global_id(0)] = get_group_id(0);
    data[get_global_id(1)] = get_group_id(1);
    data[get_global_id(2)] = get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_local_size(int x, __global uint *data)
{
    data[get_global_id(0)] = 2;
    data[get_global_id(1)] = 2;
    data[get_global_id(2)] = 4;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_global_id(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = get_global_id(0);
    data[get_global_id(1)] = get_global_id(1);
    data[get_global_id(2)] = get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void copy_get_global_size(__global int *data, int x)
{
    data[get_global_id(0)] = get_global_size(0);
    data[get_global_id(1)] = get_global_size(1);
    data[get_global_id(2)] = get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_num_groups(int x, __global uint *data)
{
    data[get_global_id(0)] = get_num_groups(0);
    data[get_global_id(1)] = get_num_groups(1);
    data[get_global_id(2)] = get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy_get_work_dim(int x, __global uint *data)
{
    data[get_global_id(0)] = get_work_dim();
}
