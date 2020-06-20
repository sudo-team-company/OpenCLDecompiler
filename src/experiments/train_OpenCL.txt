__kernel __attribute__((reqd_work_group_size(16, 16, 16)))
void localVarExample(__global int *res)
{
    __local uint lds0[64];
    __local uint lds1[64];
    lds0[get_global_id(0)] = 0;
    lds1[get_global_id(1)] = 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    lds0[get_global_id(0)] += 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    barrier(CLK_LOCAL_MEM_FENCE);
    lds1[get_global_id(0)] = lds0[get_global_id(0)];
    lds1[get_global_id(1)] += 1;
    barrier(CLK_LOCAL_MEM_FENCE);
    lds0[get_global_id(0)] = lds1[get_global_id(1)];
    barrier(CLK_LOCAL_MEM_FENCE);
    res[get_global_id(0)] = lds0[get_global_id(0)];
    res[get_global_id(1)] = lds1[get_global_id(1)];
}
