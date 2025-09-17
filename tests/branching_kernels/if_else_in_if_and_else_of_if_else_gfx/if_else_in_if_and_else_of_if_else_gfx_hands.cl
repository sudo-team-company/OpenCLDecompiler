__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_1(int x, __global int *data, int y)
{
    int var5;
    if (1 != get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if (x >= y) {
            var5 = y + get_global_id(1);
        }
        else {
            var5 = x + get_global_id(2);
        }
    }
    else {
        data[get_global_id(0)] = (get_global_id(1) * x) - y;
        if (x >= y) {
            var5 = get_global_id(1) * y;
        }
        else {
            var5 = get_global_id(2) * x;
        }
    }
    data[get_global_id(2)] = var5;
    data[get_global_id(1)] = x;
}

__kernel __attribute__((reqd_work_group_size(4, 4, 4)))
void if_else_in_if_and_else_of_if_else_2(int x, __global int *data, int y)
{
    int var5;
    if (1 != get_global_id(0)) {
        data[get_global_id(0)] = get_global_id(0) * y;
        if (get_global_id(1) != get_global_id(2)) {
            var5 = y + get_global_id(1);
        }
        else {
            var5 = x + get_global_id(1);
        }
    }
    else {
        data[get_global_id(0)] = (get_global_id(1) * x) - y;
        if (get_global_id(1) >= get_global_id(2)) {
            var5 = get_global_id(1) * y;
        }
        else {
            var5 = get_global_id(2) * x;
        }
    }
    data[get_global_id(2)] = var5;
}
