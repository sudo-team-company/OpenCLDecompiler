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
    else:
        opencl_type = "unknown type"
    return opencl_type
