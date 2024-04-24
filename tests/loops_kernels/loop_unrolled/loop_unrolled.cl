__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_unrolled(__global int *data, const int x) {
    size_t id = get_global_id(0);
    int acc = data[id];
    for (int i = 0; i < 64; i++) {
        acc = acc * x + i;
    }
    data[id] = acc;
}
