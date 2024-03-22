__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_incoherent_body_kernel(__global uint *data, uint x, uint y, uint iters_num)
{
    uint id = get_global_id(0) * iters_num;
    for (uint i = 0; i < iters_num; i++) {
      data[id + i] = data[id + i] * x + y;
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_coherent_body_kernel(__global uint *data, uint x, uint y, uint iters_num)
{
    uint id = get_global_id(0);
#pragma nounroll
    for (uint i = 0; i < iters_num; i++) {
      data[id] = data[id] * x + y;
    }
}
