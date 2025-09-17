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

#define WORKGROUP 64
#define INF 1e12

__kernel __attribute__((reqd_work_group_size(WORKGROUP, 1, 1)))
void bellmanFordIter_ver1(
    uint nEdges,
    __global const uint2* restrict edges,
    __global const double* restrict weights,
    __global double* restrict d,
    __global uint* restrict changed
)
{
    uint edgeId = get_global_id(0);

    if (edgeId >= nEdges) {
        return;
    }

    if (d[edges[edgeId].x] < INF) {
        double relaxWeight = d[edges[edgeId].x] + weights[edgeId];

        if (d[edges[edgeId].y] > relaxWeight) {
            d[edges[edgeId].y] = relaxWeight;
            *changed = 1;
        }
    }
}
