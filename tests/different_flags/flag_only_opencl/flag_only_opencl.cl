__kernel void sum(__global const short *A,__global unsigned long  *C,uint size, __local unsigned long *L) {
            unsigned long sum=0;
            for(int i=get_local_id(0);i<size;i+=get_local_size(0))
                    sum+=A[i];
            L[get_local_id(0)]=sum;
            for(uint c=get_local_size(0)/2;c>0;c/=2)
            {
                    barrier(CLK_LOCAL_MEM_FENCE);
                    if(c>get_local_id(0))
                            L[get_local_id(0)]+=L[get_local_id(0)+c];
            }
            if(get_local_id(0)==0)
                    C[0]=L[0];
            barrier(CLK_LOCAL_MEM_FENCE);
}