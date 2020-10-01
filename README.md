# OpenCL Decompiler

![CPU](https://img.shields.io/badge/GPU-AMD_GCN-red) ![Python](https://img.shields.io/badge/python-v3.7-blue) ![GitHub repo size](https://img.shields.io/github/repo-size/KristinaMihajlenko/OpenCLDecompiler) ![GitHub last commit](https://img.shields.io/github/last-commit/KristinaMihajlenko/OpenCLDecompiler) ![branch](https://img.shields.io/branch)

## Introduction
*OpenCLDecompiler* is a decompiler OpenCL for GPU AMD with GCN architecture. For disassembly used the GCN disassembler - clrxdisasm from [CLRadeonExtender project](https://clrx.nativeboinc.org/)
This project is a bachelor's thesis. The experiments were conducted on an AMD Radeon RX 580 graphics card.

**Sample usages**

```
python3 parser_for_instructions.py --input <input_file.asm> --output <output_file.cl>
python3 parser_for_instructions.py -i <input_file.asm> -o <output_file.cl>
```
Where _input_file.asm_ - an AMD GCN assembler file; _output_file.cl_ - decompiled OpenCL
To get _input_file.asm_ you need to use CLRX disassembler. 

**Sample usages of CLRX disassembler**
```
clrxdisasm.exe input.bin -dCfs > output.asm
```
Where _input.bin_ - compiled OpenCL binary file; _output.asm_ - is _input_file.asm_ 
## Requirements

- Python 3+
- CLRX Disassembler ([Github](https://github.com/CLRX/CLRX-mirror))

## Examples

**Assembly**

```assembly
        s_lshl_b32      s0, s6, 1
        v_add_u32       v0, vcc, s0, v0
        s_lshl_b32      s0, s7, 1
        s_lshl_b32      s1, s8, 2
        s_load_dwordx4  s[8:11], s[4:5], 0x8
        s_load_dwordx2  s[2:3], s[4:5], 0x38
        s_waitcnt       lgkmcnt(0)
        s_add_u32       s0, s0, s8
        s_add_u32       s1, s1, s10
        v_add_u32       v3, vcc, s0, v1
        v_add_u32       v2, vcc, s1, v2
        v_mov_b32       v1, 0
        v_lshlrev_b64   v[0:1], 2, v[0:1]
        v_add_u32       v2, vcc, v2, v3
        v_add_u32       v0, vcc, s2, v0
        v_mov_b32       v3, s3
        v_addc_u32      v1, vcc, v3, v1, vcc
        flat_store_dword v[0:1], v2
        s_endpgm
```
**Decompiled code**

```c++
__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy(__global int *data, int x)
{
	data[get_global_id(0)] = x;
}
```
**Source code**

```c++
__kernel __attribute__((reqd_work_group_size(64, 1, 1)))
void copy(__global int *data, int x)
{
	uint id = get_global_id(0);
	data[id] = x;
}
```
