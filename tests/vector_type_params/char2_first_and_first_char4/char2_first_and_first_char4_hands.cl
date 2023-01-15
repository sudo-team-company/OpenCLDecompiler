__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_first_and_first_char4(__global char2 *edges1, char4 edges2, char4 edges3)
{
    edges1[get_global_id(0)] = (char2)(edges2.s0, edges3.s0);
}
