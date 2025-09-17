Not resolved yet. flat_load_sshort v4, v[4:5]
__kernel void sum(__global short *A, __global ulong *C, uint size, __local ulong *L)
{
    size > get_local_id(0);
}
