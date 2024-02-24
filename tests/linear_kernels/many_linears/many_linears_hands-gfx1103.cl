__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = arg1;
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy2(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = arg0;
}

__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void copy3(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = get_global_id(1);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy4(int arg0, __global int *arg1)
{
    arg1[get_global_id(0)] = arg0;
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy5(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0)] = get_global_id(1) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(2, 2, 4)))
void copy6(int arg0, __global uint *arg1)
{
    arg1[get_global_id(0) - get_global_offset(0)] = get_global_id(1) + get_global_id(2);
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void cpFACE(__global int *arg0, int arg1)
{
    arg0[get_global_id(0)] = 0xface;
}
