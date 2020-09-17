__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void barrier_1(__global int *res)
{
    __local uint lds0[64];
    __local uint lds1[64];
    lds0[(get_global_id(0) * 4) / 4] = 0;
    lds1[(get_global_id(1) * 4) / 4] = 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    lds0[(get_global_id(0) * 4) / 4] += 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    barrier(CLK_LOCAL_MEM_FENCE);
    lds1[(get_global_id(0) * 4) / 4] = lds0[(get_global_id(0) * 4) / 4];
    lds1[(get_global_id(1) * 4) / 4] += 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    lds0[(get_global_id(0) * 4) / 4] = lds1[(get_global_id(1) * 4) / 4];
    barrier(CLK_LOCAL_MEM_FENCE);
    res[(get_global_id(0) / 1073741824) * 1073741824] = lds0[(get_global_id(0) * 4) / 4];
    res[(get_global_id(1) / 1073741824) * 1073741824] = lds1[(get_global_id(1) * 4) / 4];
}
