__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_first_and_first_char4(__global char2 *arg0, char4 arg1, char4 arg2)
{
    arg0[get_global_id(0)] = (char2)(arg1.s0, arg2.s0);
}
