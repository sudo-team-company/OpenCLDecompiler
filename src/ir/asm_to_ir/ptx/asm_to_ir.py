from src.ir.kernel import Kernel

from src.ir.instructions.special.memory import MemoryAllocation
from src.ir.instructions.special.InitReg import InitReg
from src.ir.registers.reg import Val, RegOrVal_ty, Reg64

from src.ir.asm_to_ir.ptx.register_factory import RegFactory

from src.ir.instructions.special.memory import Store
from src.ir.asm_to_ir.ptx.instruction_dict import instruction_dict

from src.ir.asm_to_ir.ptx.ptx_kernel import PTXKernel, PTXArgument
from src.ir.instructions.special.local_memory import LocalAdd


def _create_instruction_from_opcode(kernel: Kernel, opcode: str, operands: list[RegOrVal_ty], args_offset):
    if  instruction_dict.get(opcode):
        instr_class = instruction_dict[opcode]
    else:
        raise NotImplementedError
    
    if "param" in opcode:
        kernel.create_instruction(
            instr_class, 
            operands[0],
            Reg64("argptr"),
            args_offset[operands[1].name],
            is_scalar=False
        )
        return

    if instr_class == LocalAdd:
        kernel.create_instruction(
                    instr_class, 
                    operands[1], 
                    operands[2],
                    is_scalar=False
        )
        return

    kernel.create_instruction(
        instr_class, 
        *operands,
        is_scalar=False
    )

#TODO(GFV) наду унифицировать типы в двух asm_to_text
def _normalize_arg_type(arg: PTXArgument) -> str:
    alignment_to_type = {
        1: "char",
        2: "short",
        4: "int",
        8: "long",
    }
    type_to_type = {
        "u32": "uint",
        "u64": "ulong",
    }

    if arg.is_pointer:
        return f'__{arg.address_space} {alignment_to_type[arg.alignment]}'
    return type_to_type[arg.type_name]

def _normalize_arg_name(arg: PTXArgument) -> str:
    if arg.is_pointer:
        return "*" + arg.name
    return arg.name

def _init_special_registers(kernel: Kernel, rf: RegFactory, special_registers: list[str]):
    for reg_name in special_registers:
        value = None
        if reg_name[0] == "[" and reg_name[-1] == "]":
            reg_name = reg_name[1:-1]

        if reg_name in ("%envreg0", "%envreg1", "%envreg2"):
            value = "0"

        elif reg_name in ("%envreg3", "%envreg4", "%envreg5"):
            dim = int(reg_name[-1]) - 3
            value = f"get_global_offset({dim})"

        elif reg_name in ("%envreg6", "%envreg7", "%envreg8"):
            dim = int(reg_name[-1]) - 6
            value = f"get_num_groups({dim})"

        elif reg_name == "%envreg9":
            value = "get_work_dim()"
            
        elif reg_name in ("%tid.x", "%tid.y", "%tid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_local_id({dim})"

        elif reg_name in ("%ctaid.x", "%ctaid.y", "%ctaid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_group_id({dim})"

        elif reg_name in ("%ntid.x", "%ntid.y", "%ntid.z"):
            dim_map = {"x": 0, "y": 1, "z": 2}
            dim = dim_map[reg_name[-1]]
            value = f"get_local_size({dim})"

        if value is not None:
            kernel.create_instruction(InitReg, rf.get_or_create_auto(reg_name), Val(value))

def textToIR(kernel_info: PTXKernel) -> Kernel:
    rf = RegFactory()

    kernel = Kernel(kernel_info.name, kernel_info.work_group_size)
    
    for name, size in kernel_info.locals.items():
        kernel.set_local_memory(name, size)
        parsed_operand = rf.get_or_create(name, "64")

    args_offset = {}
    offset = 0
    for arg in kernel_info.arguments:
        kernel.add_argument(_normalize_arg_name(arg), _normalize_arg_type(arg), arg.is_const)
        args_offset[arg.name] = Val(str(offset))
        offset += 8
    
    arg_reg_name = "argptr"
    agr_reg = Reg64(arg_reg_name)
    kernel.create_instruction(MemoryAllocation, agr_reg)

    for arg in kernel_info.arguments:
        kernel.create_instruction(Store, 
                                  agr_reg, 
                                  Val(_normalize_arg_name(arg)), 
                                  Val(_normalize_arg_type(arg)), 
                                  args_offset[arg.name]
                                  )

    _init_special_registers(kernel, rf, kernel_info.special_registers)


    for line in kernel_info.instructions:
        line = line.strip()
        if not line:
            continue
        
        parts = line.split()
        if not parts:
            continue
        
        opcode = parts[0]
        operands = []
        
        for operand in parts[1:]:
            parsed_operand = rf.get_or_create_auto(operand.rstrip(','))
            operands.append(parsed_operand)
        
        _create_instruction_from_opcode(kernel, opcode, operands, args_offset)
    kernel.close()
    return kernel