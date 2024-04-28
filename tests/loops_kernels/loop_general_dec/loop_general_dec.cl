__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void loop_general(__global int *data, const int from, const int to, const int x) {
    size_t id = get_global_id(0);
    int acc = data[id];
    for (int i = from; i > to; i--) {
        acc = acc * x + i;
    }
    data[id] = acc;
}
