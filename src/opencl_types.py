def make_type(asm_type):
    if asm_type == "u32":
        opencl_type = "uint"
    elif asm_type == "i32":
        opencl_type = "int"
    elif asm_type == "u64":
        opencl_type = "ulong"
    elif asm_type == "i64":
        opencl_type = "long"
    elif asm_type == "b32":
        opencl_type = "uint"
    elif asm_type == "b64":
        opencl_type = "ulong"
    elif asm_type == "dword":
        opencl_type = "int"
    elif asm_type == "dwordx2":
        opencl_type = "long"
    elif asm_type == "f32":
        opencl_type = "float"
    elif asm_type == "f64":
        opencl_type = "double"
    elif asm_type == "int2":
        opencl_type = "int2"
    elif asm_type == "int4":
        opencl_type = "int4"
    elif asm_type == "int8":
        opencl_type = "int8"
    else:
        opencl_type = "unknown type"
    return opencl_type


def make_asm_type(opencl_type):
    if opencl_type == "uint":
        asm_type = "u32"
    elif opencl_type == "int":
        asm_type = "i32"
    elif opencl_type == "ulong":
        asm_type = "u64"
    elif opencl_type == "long":
        asm_type = "i64"
    elif opencl_type == "float":
        asm_type = "f32"
    elif opencl_type == "double":
        asm_type = "f64"
    else:
        asm_type = "unknown type"
    return asm_type


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
