__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void circleBreakKernel(__global uint *data,
		               uint x,
                       uint y,
                       uint unrollingBreaker
                      )
{
    for (uint i = 0; i < unrollingBreaker; i++) {
      data[i] += y;
      if (data[i] == 0) {
        break;
      }
      y = x * data[i];
    }
    data[get_global_id(0)] += x;
}
