# OpenCLDecompiler

![CPU](https://img.shields.io/badge/GPU-AMD_GCN-red) 
![CPU](https://img.shields.io/badge/GPU-AMD_RDNA-red) 
![Python](https://img.shields.io/badge/python-v3.10-blue) 
![GitHub repo size](https://img.shields.io/github/repo-size/sudo-team-company/OpenCLDecompiler) 
![GitHub last commit](https://img.shields.io/github/last-commit/sudo-team-company/OpenCLDecompiler/develop) 
![Test](https://github.com/sudo-team-company/OpenCLDecompiler/workflows/Test/badge.svg?branch=develop) 
![Lint](https://github.com/sudo-team-company/OpenCLDecompiler/workflows/Lint/badge.svg?branch=develop)

## Introduction
*OpenCLDecompiler* is a decompiler OpenCL for GPU AMD with GCN architecture. For disassembly used the GCN disassembler - clrxdisasm from [CLRadeonExtender project](https://clrx.nativeboinc.org/).
 The experiments were conducted on an AMD Radeon RX 580 graphics card. The project is still in active development.
 
## Features
*OpenCLDecompiler* can decompile:
- linear programs
- some simple branching constructs (if, if-else)
- variables located in local memory
- some variable types

## Requirements

- Python 3+
- CLRX Disassembler ([Github](https://github.com/CLRX/CLRX-mirror))
- Compiled OpenCL file 

## Instruction
Firstly, you need to disassembler compiled OpenCL kernel in .asm file.

**Sample usages of CLRX disassembler**
```
clrxdisasm.exe input.bin -dCfs > output.asm
```
Where _input.bin_ - compiled OpenCL binary file; _output.asm_ - is disassembled kernel file, would be _input_file.asm_ 
in next operation.

Next - decompiler work.

**Sample usages**

```
python3 parser_for_instructions.py --input <input_file.asm> --output <output_file.cl> --flag <flag_for_decompilation>
python3 parser_for_instructions.py -i <input_file.asm> -o <output_file.cl> -f <flag_for_decompilation>
```
Where _input_file.asm_ - an AMD GCN assembler file; _output_file.cl_ - decompiled OpenCL.  
To get _input_file.asm_ you need to use CLRX disassembler.  
_flag_for_decompilation_ is an optional parameter. It can be _auto_decompilation_ or _only_clrx_ or _only_opencl_.
The default is _auto_decompilation_. Other flag values are not allowed.  
* _auto_decompilation_. If the decompilation was successful, the result of the program execution will be the OpenCL code. 
Otherwise, the program returns the OpenCL code obtained by translating the assembler using the site (http://clrx.nativeboinc.org/wiki2/wiki/wiki/GcnIsa).
Also it prints unresolved command before the body of the OpenCL program.  
* _only_clrx_. The program always returns the OpenCL code obtained by translating the assembler using the site (http://clrx.nativeboinc.org/wiki2/wiki/wiki/GcnIsa).
* _only_opencl_. The program always returns OpenCL code (without the "clrx translation").
If the decompilation was not successful, the program prints unresolved command before the decompiled body of the OpenCL program. 

## Examples

**Assembly**

```assembly
/* Disassembling 'branching_kernels\if_1\if_1.bin' */
.amdcl2
.gpu Iceland
.64bit
.arch_minor 0
.arch_stepping 4
.driver_version 200406
.kernel if_1
    .config
        .dims xy
        .cws 8, 8, 1
        .sgprsnum 16
        .vgprsnum 5
        .floatmode 0xc0
        .pgmrsrc1 0x00ac0081
        .pgmrsrc2 0x0000098c
        .dx10clamp
        .ieeemode
        .useargs
        .priority 0
        .arg _.global_offset_0, "size_t", long
        .arg _.global_offset_1, "size_t", long
        .arg _.global_offset_2, "size_t", long
        .arg _.printf_buffer, "size_t", void*, global, , rdonly
        .arg _.vqueue_pointer, "size_t", long
        .arg _.aqlwrap_pointer, "size_t", long
        .arg x, "int", int
        .arg data, "int*", int*, global, 
        .arg y, "int", int
    .text
        s_load_dwordx4  s[0:3], s[4:5], 0x0
        s_waitcnt       lgkmcnt(0)
        s_lshl_b32      s1, s6, 3
        v_add_u32       v0, vcc, s1, v0
        s_lshl_b32      s1, s7, 3
        s_add_u32       s1, s1, s2
        v_add_u32       v0, vcc, s0, v0
        v_add_u32       v2, vcc, s1, v1
        v_cmp_eq_i32    vcc, 1, v0
        s_load_dwordx2  s[0:1], s[4:5], 0x38
        s_load_dword    s2, s[4:5], 0x30
        s_and_saveexec_b64 s[6:7], vcc
        s_cbranch_execz .L120_0
        s_load_dword    s3, s[4:5], 0x40
        s_waitcnt       lgkmcnt(0)
        v_mul_lo_u32    v3, v2, s2
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v4, s1
        v_addc_u32      v1, vcc, v4, v1, vcc
        v_subrev_u32    v3, vcc, s3, v3
        flat_store_dword v[0:1], v3
.L120_0:
        s_mov_b64       exec, s[6:7]
        v_mov_b32       v3, 0
        v_lshlrev_b64   v[0:1], 2, v[2:3]
        s_waitcnt       lgkmcnt(0)
        v_add_u32       v0, vcc, s0, v0
        v_mov_b32       v2, s1
        v_addc_u32      v1, vcc, v2, v1, vcc
        v_mov_b32       v2, s2
        flat_store_dword v[0:1], v2
        s_endpgm

```
**Decompiled code**

```c++
__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_1(int x, __global int *data, int y)
{
    if (1 == get_global_id(0)) {
        data[(get_global_id(0) * 4) / 4] = (get_global_id(1) * x) - y;
    }
    data[(get_global_id(1) * 4) / 4] = x;
}
```
**Source code**

```c++
__kernel __attribute__((reqd_work_group_size(8, 8, 1)))
void if_1(int x, __global int *data, int y)
{
  uint id0 = get_global_id(0);
  uint id1 = get_global_id(1);
  if (id0 == 1) {
    data[id0] = x * id1 - y;
  }
  data[id1] = x;
}
```
