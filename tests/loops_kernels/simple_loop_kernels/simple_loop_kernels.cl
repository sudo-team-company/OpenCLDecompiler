__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_0(__global uint *data,
		           uint x,
                   uint y,
                   uint unrollingBreaker
                  )
{
    for (uint i = 0; i < 64; i++) {
      if(!unrollingBreaker++) {
        return;
      }
      data[i] += y;
      y = x * data[i];
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_1(__global uint *data,
		           uint x,
                   uint y,
                   uint unrollingBreaker
                  )
{
    for (uint i = 0; i < unrollingBreaker; i++) {
      data[i] += y;
      y = x * data[i];
    }
}

__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_kernel_2(__global uint *data,
		           uint x,
                   uint y,
                   uint unrollingBreaker
                  )
{
    for (uint i = unrollingBreaker; i > 0; i--) {
      data[i] += y;
      y = x * data[i];
    }
}
