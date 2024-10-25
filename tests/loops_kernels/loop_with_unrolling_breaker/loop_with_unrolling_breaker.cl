__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_with_unrolling_breaker(__global int *data, const int x, int unrollingBreaker) {
    size_t id = get_global_id(0);
    for (size_t i = 0; i < 64; i++) {
        if (unrollingBreaker-- < 0) {
            return;
        }
        data[id] = data[id] * x + i;
    }
}
