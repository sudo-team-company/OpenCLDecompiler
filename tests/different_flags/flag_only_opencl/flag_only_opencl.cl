// MIT License
//
// Copyright (c) 2020-2024 Sudo Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
