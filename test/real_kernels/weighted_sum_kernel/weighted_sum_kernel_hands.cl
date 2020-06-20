__kernel void weighted_sum_kernel(int n, __global float *a, __global float *b, __global float *s, __global float *c)
{
  float var0;
  float var1;
  float var2;
  if (b == 0) {
    var0 = 0;
  }
  else {
    var0 = b[i];
  }
  if (n > (get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)) {
    var1 = a[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
    var2 = s[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)];
    c[(get_global_offset(1) + get_global_size(1) * get_global_id(2) + get_local_size(1) * get_group_id(1) + get_local_id(1)) * get_global_size(0) + get_global_id(0)] = var2 * var1 + var0 * (1.0 - var2);
  }
}