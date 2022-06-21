vector_type_dict = {
    'char2': 'char2',
    'char4': 'char4',
    'char8': 'char8',
    'uchar2': 'uchar2',
    'uchar4': 'uchar4',
    'uchar8': 'uchar8',
    'short2': 'short2',
    'short4': 'short4',
    'short8': 'short8',
    'ushort2': 'ushort2',
    'ushort4': 'ushort4',
    'ushort8': 'ushort8',
    'int2': 'int2',
    'int4': 'int4',
    'int8': 'int8',
    'uint2': 'uint2',
    'uint4': 'uint4',
    'uint8': 'uint8',
    'long2': 'long2',
    'long4': 'long4',
    'long8': 'long8',
    'ulong2': 'ulong2',
    'ulong4': 'ulong4',
    'ulong8': 'ulong8',
    'float2': 'float2',
    'float4': 'float4',
    'float8': 'float8',
    'half2': 'half2',
    'half4': 'half4',
    'half8': 'half8'}

asm_to_opencl_scalar_dict = {
    "u32": "uint",
    "gu32": "__global uint",
    "i32": "int",
    "gi32": "__global int",
    "u64": "ulong",
    "gu64": "__global ulong",
    "i64": "long",
    "gi64": "__global long",
    "f32": "float",
    "gf32": "__global float",
    "f64": "double",
    "gf64": "__global double",
    "b32": "uint",
    "b64": "ulong",
    "dword": "int",
    "dwordx2": "long"
}


def make_opencl_type(asm_type):
    return {**asm_to_opencl_scalar_dict, **vector_type_dict}.get(asm_type, "unknown type")


opencl_to_asm_dict = {
    "uint": "u32",
    "__global uint": "gu32",
    "int": "i32",
    "__global int": "gi32",
    "ulong": "u64",
    "__global ulong": "gu64",
    "long": "i64",
    "__global long": "gi64",
    "float": "f32",
    "__global float": "gf32",
    "double": "f64",
    "__global double": "gf64",
    "__global int2": "int2",
    "__global uint2": "uint2",
    "__global int4": "int4",
    "__global uint4": "uint4",
    "__global int8": "int8",
    "__global uint8": "uint8",
    "__global float4": "float4",
    "char": "char",
    "__global char2": "char2",
    "__global char4": "char4",
    "short": "short"
}


def make_asm_type(opencl_type):
    return {**opencl_to_asm_dict, **vector_type_dict}.get(opencl_type, "unknown type")


# get size and priority
def evaluate_size(asm_type, only_size=False):
    if asm_type in ("gu32", "u32", "gi32", "i32", "gf32", "f32", "b32", "dword"):
        if asm_type == "f32:":
            information = (4, 1)
        else:
            information = (4, 0)
    elif asm_type in ("gu64", "u64", "gi64", "i64", "f64", "gf64", "uint2", "int2", "b64", "dword2"):
        if asm_type == "f64:":
            information = (8, 1)
        else:
            information = (8, 0)
    elif asm_type in ["uint4", "int4"]:
        information = (16, 0)
    elif asm_type in ["uint8", "int8"]:
        information = (32, 0)
    elif asm_type == "char":
        information = (1, 1)
    elif asm_type in ["short", "char2"]:
        information = (2, 1)
    elif only_size:
        if "bytes" in asm_type:
            information = (int(asm_type[0]), 1)
        else:
            information = (1, 1)
    else:
        information = (-1, -1)

    return information


# use for pair of regs connection
def most_common_type(fst_asm_type, snd_asm_type):
    fst_information = evaluate_size(fst_asm_type)
    snd_information = evaluate_size(snd_asm_type)
    if fst_information[0] >= snd_information[0]:
        if fst_information[0] == snd_information[0]:
            if fst_information[1] > snd_information[1]:
                return fst_asm_type
            return snd_asm_type
        return fst_asm_type
    return snd_asm_type
