__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_reverse_char2(__global char2 *edges1, char2 edges2)
{
    edges1[get_global_id(0)] = edges2.s10;
}
