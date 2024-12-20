__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_x(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_x(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_x(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)(get_num_groups(0) * 16) - (long)arg1 + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (long)(get_num_groups(1) * 2) - (long)arg1 + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (long)(get_num_groups(2) * 2) - (long)arg1 + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_x(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_offset(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_global_offset(0);
    arg0[get_global_id(1)] = (long)arg1 - (long)get_global_offset(1);
    arg0[get_global_id(2)] = (long)arg1 - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_offset(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_offset(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_offset(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_offset(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_offset(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + -get_global_offset(0);
    arg1[get_global_id(1)] = get_global_id(1) + -get_global_offset(1);
    arg1[get_global_id(2)] = get_global_id(2) + -get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_offset(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_global_offset(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_global_offset(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_offset(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_work_dim() - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_work_dim() - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_local_id(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_local_id(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)(get_num_groups(0) * 16) - (uint)get_local_id(0) + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (uint)(get_num_groups(1) * 2) - (uint)get_local_id(1) + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (uint)(get_num_groups(2) * 2) - (uint)get_local_id(2) + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 + (ulong)((uint)get_num_groups(0) - (uint)get_local_id(0));
    arg1[get_global_id(1)] = (ulong)0 + (ulong)((uint)get_num_groups(1) - (uint)get_local_id(1));
    arg1[get_global_id(2)] = (ulong)0 + (ulong)((uint)get_num_groups(2) - (uint)get_local_id(2));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_group_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_group_id(0);
    arg0[get_global_id(1)] = (long)arg1 - (long)get_group_id(1);
    arg0[get_global_id(2)] = (long)arg1 - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_group_id(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_group_id(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_group_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_group_id(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_group_id(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_group_id(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_group_id(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_group_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)(get_num_groups(0) * 16) - (long)get_group_id(0) + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (long)(get_num_groups(1) * 2) - (long)get_group_id(1) + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (long)(get_num_groups(2) * 2) - (long)get_group_id(2) + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_group_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_work_dim() - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_work_dim() - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_local_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_local_size(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_local_size(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_local_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_local_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_local_size(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_local_size(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_num_groups(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_num_groups(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_num_groups(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_local_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_id(__global int *arg0, int arg1)
{
    arg0[get_global_offset(0)] = (uint)arg1 - (uint)(get_global_offset(0) + 0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_global_id(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)0 - (uint)(get_global_id(0) + -get_global_offset(0));
    arg1[get_global_id(1)] = (uint)0 - (uint)(get_global_id(1) + -get_global_offset(1));
    arg1[get_global_id(2)] = (uint)0 - (uint)(get_global_id(2) + -get_global_offset(2));
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_id(int arg0, __global int *arg1)
{
    arg1[get_global_offset(0)] = (uint)get_group_id(0) - (uint)(get_global_offset(0) + 0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_id(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)(get_num_groups(0) * 16) - (uint)get_global_id(0) + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (uint)(get_num_groups(1) * 2) - (uint)get_global_id(1) + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (uint)(get_num_groups(2) * 2) - (uint)get_global_id(2) + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 + (ulong)((uint)get_num_groups(0) - (uint)get_global_id(0));
    arg1[get_global_id(1)] = (ulong)0 + (ulong)((uint)get_num_groups(1) - (uint)get_global_id(1));
    arg1[get_global_id(2)] = (ulong)0 + (ulong)((uint)get_num_groups(2) - (uint)get_global_id(2));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_id(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_global_size(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_global_size(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_global_size(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_global_size(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
    arg0[get_global_id(1)] = 0;
    arg0[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_num_groups(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_num_groups(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_num_groups(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_global_size(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_num_groups(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - (ulong)get_num_groups(0);
    arg0[get_global_id(1)] = (ulong)arg1 - (ulong)get_num_groups(1);
    arg0[get_global_id(2)] = (ulong)arg1 - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_num_groups(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_num_groups(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)(get_num_groups(0) * 15 + get_group_id(0) * get_local_size(0)) - (ulong)0;
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - (ulong)0;
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - (ulong)0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_num_groups(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_x_get_work_dim(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(1)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(2)] = (long)arg1 - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_global_offset_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_get_local_id_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_get_group_id_get_work_dim(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_local_size_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_global_id_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_get_global_size_get_work_dim(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_num_groups_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_get_work_dim_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_x_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_offset_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_group_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_local_size_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_id_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_global_size_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * get_local_size(0) + (uint)(get_num_groups(0) * 64) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_num_groups_64(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 + (ulong)((uint)get_num_groups(0) - (uint)get_global_id(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_get_work_dim(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_x_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_offset_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_group_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_local_size_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_local_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_id_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_id(0) - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_global_size_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = ((long)get_num_groups(0) - (long)get_num_groups(1)) * 8 + (uint)(get_group_id(0) * get_local_size(0)) - (uint)(get_group_id(1) * get_local_size(1));
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_num_groups_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - (ulong)get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_get_work_dim_8_8(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_x(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_x(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_x(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)(get_num_groups(0) * 16) - (long)arg1 + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (long)(get_num_groups(1) * 2) - (long)arg1 + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (long)(get_num_groups(2) * 2) - (long)arg1 + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_x(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_offset(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - (ulong)get_global_offset(0);
    arg0[get_global_id(1)] = (ulong)arg1 - (ulong)get_global_offset(1);
    arg0[get_global_id(2)] = (ulong)arg1 - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 - (ulong)0;
    arg1[get_global_id(1)] = (ulong)0 - (ulong)0;
    arg1[get_global_id(2)] = (ulong)0 - (ulong)0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_offset(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_offset(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_global_offset(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_global_offset(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - (ulong)get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - (ulong)get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_offset(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - (ulong)get_global_offset(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - (ulong)get_global_offset(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - (ulong)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - get_local_id(0);
    arg0[get_global_id(1)] = (ulong)arg1 - get_local_id(1);
    arg0[get_global_id(2)] = (ulong)arg1 - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_local_id(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_local_id(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - get_local_id(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - get_local_id(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_group_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - (ulong)get_group_id(0);
    arg0[get_global_id(1)] = (ulong)arg1 - (ulong)get_group_id(1);
    arg0[get_global_id(2)] = (ulong)arg1 - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_group_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_group_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_group_id(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_group_id(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - (ulong)get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - (ulong)get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_group_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - (ulong)get_group_id(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - (ulong)get_group_id(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - (ulong)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_local_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - get_local_size(0);
    arg0[get_global_id(1)] = (ulong)arg1 - get_local_size(1);
    arg0[get_global_id(2)] = (ulong)arg1 - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_local_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_local_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_local_size(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_local_size(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_local_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - get_local_size(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - get_local_size(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - get_global_id(0);
    arg0[get_global_id(1)] = (ulong)arg1 - get_global_id(1);
    arg0[get_global_id(2)] = (ulong)arg1 - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_id(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)0 - 0;
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_id(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_global_id(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_global_id(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_id(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - get_global_id(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - get_global_id(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_global_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - get_global_size(0);
    arg0[get_global_id(1)] = (ulong)arg1 - get_global_size(1);
    arg0[get_global_id(2)] = (ulong)arg1 - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_global_size(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_global_size(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
    arg0[get_global_id(1)] = 0;
    arg0[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_num_groups(1) - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_num_groups(2) - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_global_size(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - get_global_size(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - get_global_size(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_num_groups(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)arg1 - (ulong)get_num_groups(0);
    arg0[get_global_id(1)] = (ulong)arg1 - (ulong)get_num_groups(1);
    arg0[get_global_id(2)] = (ulong)arg1 - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_global_offset(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_global_offset(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_global_offset(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_id(0) - get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_local_id(1) - get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_local_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_num_groups(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_group_id(0) - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_group_id(1) - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_group_id(2) - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_local_size(0) - get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_local_size(1) - get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_local_size(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ulong)get_global_id(0) - get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_global_id(1) - get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_global_id(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_num_groups(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ulong)get_global_size(0) - get_num_groups(0);
    arg0[get_global_id(1)] = (ulong)get_global_size(1) - get_num_groups(1);
    arg0[get_global_id(2)] = (ulong)get_global_size(2) - get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_num_groups(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_work_dim() - (ulong)get_num_groups(0);
    arg1[get_global_id(1)] = (ulong)get_work_dim() - (ulong)get_num_groups(1);
    arg1[get_global_id(2)] = (ulong)get_work_dim() - (ulong)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_x_get_work_dim(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(1)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(2)] = (long)arg1 - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_global_offset_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_long_get_local_id_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_long_get_group_id_get_work_dim(int arg0, __global long *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_local_size_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_global_id_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_long_get_global_size_get_work_dim(__global long *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_num_groups_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_long_get_work_dim_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_x_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_offset_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)0 - (uint)(get_global_id(0) + -get_global_offset(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_group_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_local_size_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_id_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_global_size_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * get_local_size(0) + (uint)(get_num_groups(0) * 64) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_num_groups_64(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 + (ulong)((uint)get_num_groups(0) - (uint)get_global_id(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_long_get_work_dim(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_x_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_offset_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_group_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_local_size_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_local_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_id_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_id(0) - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_global_size_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = ((long)get_num_groups(0) - (long)get_num_groups(1)) * 8 + (uint)(get_group_id(0) * get_local_size(0)) - (uint)(get_group_id(1) * get_local_size(1));
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_num_groups_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (ulong)get_num_groups(0) - (ulong)get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_long_get_work_dim_8_8(int arg0, __global ulong *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_x(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_x(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)arg0;
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)arg0;
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_x(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)(get_num_groups(0) * 16) - (long)arg1 + get_group_id(0) * get_local_size(0);
    arg0[get_global_id(1)] = (long)(get_num_groups(1) * 2) - (long)arg1 + get_group_id(1) * get_local_size(1);
    arg0[get_global_id(2)] = (long)(get_num_groups(2) * 2) - (long)arg1 + get_group_id(2) * get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)arg0;
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)arg0;
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_x(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)arg0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_offset(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_global_offset(0);
    arg0[get_global_id(1)] = (long)arg1 - (long)get_global_offset(1);
    arg0[get_global_id(2)] = (long)arg1 - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_offset(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_offset(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_offset(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_offset(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_offset(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(0) + -get_global_offset(0);
    arg1[get_global_id(1)] = get_global_id(1) + -get_global_offset(1);
    arg1[get_global_id(2)] = get_global_id(2) + -get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_offset(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_global_offset(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_global_offset(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_offset(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)get_global_offset(0);
    arg1[get_global_id(1)] = (long)get_work_dim() - (long)get_global_offset(1);
    arg1[get_global_id(2)] = (long)get_work_dim() - (long)get_global_offset(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_local_id(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_local_id(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_id(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_group_id(0) - (ushort)get_local_id(0);
    arg1[get_global_id(1)] = (ushort)get_group_id(1) - (ushort)get_local_id(1);
    arg1[get_global_id(2)] = (ushort)get_group_id(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_size(0) - (ushort)get_local_id(0);
    arg1[get_global_id(1)] = (ushort)get_local_size(1) - (ushort)get_local_id(1);
    arg1[get_global_id(2)] = (ushort)get_local_size(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[2*get_group_id(0) + (ulong)get_local_id(0)] = get_global_offset(0) + get_group_id(0) * 2;
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_local_id(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (ushort)get_global_size(0) - (ushort)get_local_id(0);
    arg0[get_global_id(1)] = (ushort)get_global_size(1) - (ushort)get_local_id(1);
    arg0[get_global_id(2)] = (ushort)get_global_size(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_num_groups(0) - (ushort)get_local_id(0);
    arg1[get_global_id(1)] = (ushort)get_num_groups(1) - (ushort)get_local_id(1);
    arg1[get_global_id(2)] = (ushort)get_num_groups(2) - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_work_dim() - (ushort)get_local_id(0);
    arg1[get_global_id(1)] = (ushort)get_work_dim() - (ushort)get_local_id(1);
    arg1[get_global_id(2)] = (ushort)get_work_dim() - (ushort)get_local_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_group_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_group_id(0);
    arg0[get_global_id(1)] = (long)arg1 - (long)get_group_id(1);
    arg0[get_global_id(2)] = (long)arg1 - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_group_id(0);
    arg1[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_group_id(1);
    arg1[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_group_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_group_id(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_group_id(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_group_id(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_group_id(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_group_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_group_id(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_group_id(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_group_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)get_group_id(0);
    arg1[get_global_id(1)] = (long)get_work_dim() - (long)get_group_id(1);
    arg1[get_global_id(2)] = (long)get_work_dim() - (long)get_group_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_local_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_local_size(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_local_size(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_local_size(0);
    arg1[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_local_size(1);
    arg1[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_local_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_local_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_local_size(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_local_size(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_num_groups(0) - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_num_groups(1) - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_num_groups(2) - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_local_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_local_size(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_local_size(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_local_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_global_id(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_global_id(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)0 - (ushort)(get_global_id(0) + -get_global_offset(0));
    arg1[get_global_id(1)] = (ushort)0 - (ushort)(get_global_id(1) + -get_global_offset(1));
    arg1[get_global_id(2)] = (ushort)0 - (ushort)(get_global_id(2) + -get_global_offset(2));
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_id(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_id(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_global_id(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_global_id(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_num_groups(0) - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_num_groups(1) - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_num_groups(2) - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_id(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_id(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_id(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_global_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)arg1 - (uint)get_global_size(0);
    arg0[get_global_id(1)] = (uint)arg1 - (uint)get_global_size(1);
    arg0[get_global_id(2)] = (uint)arg1 - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_offset(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_global_offset(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_global_offset(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_global_size(0);
    arg1[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_global_size(1);
    arg1[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_global_size(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_group_id(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_group_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_global_size(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0;
    arg0[get_global_id(1)] = 0;
    arg0[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_num_groups(0) - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_num_groups(1) - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_num_groups(2) - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_global_size(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_work_dim() - (uint)get_global_size(0);
    arg1[get_global_id(1)] = (uint)get_work_dim() - (uint)get_global_size(1);
    arg1[get_global_id(2)] = (uint)get_work_dim() - (uint)get_global_size(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_num_groups(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_num_groups(0);
    arg0[get_global_id(1)] = (long)arg1 - (long)get_num_groups(1);
    arg0[get_global_id(2)] = (long)arg1 - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_num_groups(0);
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_num_groups(1);
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_num_groups(0);
    arg1[get_global_id(1)] = (ushort)get_local_id(1) - (ushort)get_num_groups(1);
    arg1[get_global_id(2)] = (ushort)get_local_id(2) - (ushort)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_num_groups(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_num_groups(0);
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_num_groups(1);
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_num_groups(0);
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_num_groups(1);
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (uint)get_global_id(0) - (uint)get_num_groups(0);
    arg1[get_global_id(1)] = (uint)get_global_id(1) - (uint)get_num_groups(1);
    arg1[get_global_id(2)] = (uint)get_global_id(2) - (uint)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_num_groups(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_num_groups(0);
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_num_groups(1);
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_num_groups(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_work_dim() - (long)get_num_groups(0);
    arg1[get_global_id(1)] = (long)get_work_dim() - (long)get_num_groups(1);
    arg1[get_global_id(2)] = (long)get_work_dim() - (long)get_num_groups(2);
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_x_get_work_dim(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(1)] = (long)arg1 - (long)get_work_dim();
    arg0[get_global_id(2)] = (long)arg1 - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_global_offset_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_global_offset(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_global_offset(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(8, 4, 2)))
void subtract_char_get_local_id_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_id(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_id(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 16, 2)))
void subtract_char_get_group_id_get_work_dim(int arg0, __global char *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_group_id(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_group_id(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_local_size_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_work_dim();
    arg1[get_global_id(1)] = (uint)get_local_size(1) - (uint)get_work_dim();
    arg1[get_global_id(2)] = (uint)get_local_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_global_id_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = (ushort)get_global_id(0) - (ushort)get_work_dim();
    arg1[get_global_id(1)] = (ushort)get_global_id(1) - (ushort)get_work_dim();
    arg1[get_global_id(2)] = (ushort)get_global_id(2) - (ushort)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(16, 2, 2)))
void subtract_char_get_global_size_get_work_dim(__global char *arg0, int arg1)
{
    arg0[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_work_dim();
    arg0[get_global_id(1)] = (uint)get_global_size(1) - (uint)get_work_dim();
    arg0[get_global_id(2)] = (uint)get_global_size(2) - (uint)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_num_groups_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_work_dim();
    arg1[get_global_id(1)] = (long)get_num_groups(1) - (long)get_work_dim();
    arg1[get_global_id(2)] = (long)get_num_groups(2) - (long)get_work_dim();
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void subtract_char_get_work_dim_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = 0;
    arg1[get_global_id(1)] = 0;
    arg1[get_global_id(2)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_x_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_offset_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_global_offset(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_group_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_group_id(0) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_local_size_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_size(0) - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_id_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = 0;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_global_size_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_group_id(0) * get_local_size(0) + (uint)(get_num_groups(0) * 64) - (uint)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_num_groups_64(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ulong)0 + (ulong)((uint)get_num_groups(0) - (uint)get_global_id(0));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void subtract_char_get_work_dim(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_work_dim() - (ushort)get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_x_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)arg0 - (uint)get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_offset_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_global_offset(0) - (long)get_global_offset(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (ushort)get_local_id(0) - (ushort)get_local_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_group_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_group_id(0) - (long)get_group_id(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_local_size_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_local_size(0) - (uint)get_local_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_id_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)(get_group_id(1) * -8) - (uint)(get_global_offset(1) + get_local_id(1)) + get_global_id(0);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_global_size_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (uint)get_global_size(0) - (uint)get_global_size(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_num_groups_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = (long)get_num_groups(0) - (long)get_num_groups(1);
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void subtract_char_get_work_dim_8_8(int arg0, __global uchar *arg1)
{
    arg1[get_global_id(0)] = get_work_dim() + (uint)(get_group_id(1) * -8) - (uint)(get_global_offset(1) + get_local_id(1));
}
