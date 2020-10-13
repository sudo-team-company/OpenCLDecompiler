def make_type(asm_type):
    if asm_type == "u32":
        return "uint"
    elif asm_type == "i32":
        return "int"
    elif asm_type == "u64":
        return "ulong"
    elif asm_type == "i64":
        return "long"
    elif asm_type == "b32":
        return "uint"
    elif asm_type == "b64":
        return "ulong"
    elif asm_type == "dword":
        return "int"
    elif asm_type == "dwordx2":
        return "dwordx2"
    elif asm_type == "f32":
        return "float"
