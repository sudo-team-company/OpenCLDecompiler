__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy(__global int *data, int x)
{
    data[get_global_id(0)] = x;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy2(int x, __global int *data)
{
    data[get_global_id(0)] = x;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void copy3(int x, __global int *data)
{
    data[get_global_id(0)] = get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy4(int x, __global int *data)
{
    data[get_global_id(0)] = x;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy5(int x, __global uint *data)
{
    data[get_global_id(0)] = (ulong)(((ulong)get_global_offset(2) + (ulong)get_global_offset(1)) + (ulong)(get_group_id(2) * 4)) + (ulong)(get_group_id(1) * 2) + ((ulong)get_local_id(2) + (ulong)get_local_id(1));
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy6(int x, __global uint *data)
{
    data[get_global_id(0) - get_global_offset(0)] = (ulong)(((ulong)get_global_offset(2) + (ulong)get_global_offset(1)) + (ulong)(get_group_id(2) * 4)) + (ulong)(get_group_id(1) * 2) + ((ulong)get_local_id(2) + (ulong)get_local_id(1));
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void cpFACE(__global int *data, int x)
{
    data[get_global_id(0)] = 0xface;
}
