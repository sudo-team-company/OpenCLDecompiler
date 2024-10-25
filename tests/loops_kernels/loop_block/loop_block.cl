__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, const int block, const int x) {
    size_t id = get_global_id(0) * block;
    for (int i = 0; i < block; i++) {
        data[id + i] = data[id + i] * x + i;
    }
}
