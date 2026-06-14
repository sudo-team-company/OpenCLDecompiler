__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_reverse_char2(__global char2 *arg0, char2 arg1)
{
    arg0[get_global_id(0)] = arg1.s10;
}
