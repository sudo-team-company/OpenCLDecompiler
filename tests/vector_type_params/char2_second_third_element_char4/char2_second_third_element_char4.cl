__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void char2_second_third_element_char4(
    __global char2* restrict edges1,
    char4 edges2
)
{
      uint edgeId = get_global_id(0);
      edges1[edgeId] = (char2)(edges2.y, edges2.z);
}
