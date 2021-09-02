asm_to_opencl_dict = {
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
    "int2": "int2",
    "int4": "int4",
    "int8": "int8",
    "b32": "uint",
    "b64": "ulong",
    "dword": "int",
    "dwordx2": "long"
}


def make_opencl_type(asm_type):
    return asm_to_opencl_dict.get(asm_type, "unknown type")


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
    "__global double": "gf64"
}


def make_asm_type(opencl_type):
    return opencl_to_asm_dict.get(opencl_type, "unknown type")


# get size and priority
def evaluate_size(asm_type):
    if asm_type in ("u32", "i32", "b32", "dword", "f32"):
        if asm_type == "f32:":
            information = (4, 1)
        else:
            information = (4, 0)
    elif asm_type in ("u64", "i64", "b64", "dword2", "f64"):
        if asm_type == "f64:":
            information = (8, 1)
        else:
            information = (8, 0)
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
