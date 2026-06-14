__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_second_third_element_char4(__global char2 *arg0, char4 arg1)
{
    arg0[get_global_id(0)] = arg1.s12;
}
