from src.ir.kernel import Kernel
from src.model.config_data import ConfigData

from src.ir.instructions.special.memory import MemoryAllocation
from src.ir.instructions.special.memory import Store
from src.ir.instructions.special.InitReg import InitReg
from src.ir.instructions.special.generic import GenericInstruction
from src.ir.registers.reg import Val, Reg_ty

from src.ir.asm_to_ir.amd.register_factory import RegFactory


def init_dispatch_reg(dispatch_reg: Reg_ty, kernel: Kernel):
    kernel.create_instruction(MemoryAllocation, dispatch_reg)
    kernel.create_instruction(Store, dispatch_reg, Val("general_setup"), Val("uint"), Val("0"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(0)"), Val("uint"), Val("4"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(2)"), Val("uint"), Val("8"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(0)"), Val("uint"), Val("12"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(1)"), Val("uint"), Val("16"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(2)"), Val("uint"), Val("20"))
    kernel.create_instruction(Store, dispatch_reg, Val("UNKNOWN"), Val("uint"), Val("24"))

# TODO на данный момент работает только с .amdcl2
def textToIR(text: list[str], cf: ConfigData) -> Kernel:
    rf = RegFactory()

    kernel = Kernel(cf.kernel_name, cf.size_of_work_groups)
    
    # Добавляем видимые аргументы ядра
    for arg in cf.arguments:
        if not arg.hidden:
            kernel.add_argument(arg.name, arg.type_name, arg.const)
    
    if cf.usesetup:
        arg_reg_name = "s[6:7]"
    else:
        arg_reg_name = "s[4:5]"
    agr_reg = rf.parse_operand(arg_reg_name)
    kernel.create_instruction(MemoryAllocation, agr_reg)
    for arg in cf.arguments:
        name_to_check = arg.name
        if name_to_check.startswith('*'):
            name_to_check = name_to_check[1:]
        if not name_to_check.startswith('_'):    
            kernel.create_instruction(Store, agr_reg, Val(arg.name), Val(arg.type_name), Val(str(arg.offset)))
    
    if cf.usesetup:
        init_dispatch_reg(rf.parse_operand("s[4:5]"), kernel)

    # особенность .amdcl2
    if cf.usesetup:
        g_id_shift = 8
    else:
        g_id_shift = 6
    dimensions = max(cf.dimensions.split(","), key=len)
    for dim in range(len(dimensions)):
        kernel.create_instruction(InitReg, rf.parse_operand(f"s{g_id_shift + dim}"), Val(f"get_group_id({dim})"))
        kernel.create_instruction(InitReg, rf.parse_operand(f"v{dim}"), Val(f"get_local_id({dim})"))

    # Обработка инструкций
    for line in text:
        line = line.strip()
        if not line:
            continue
        
        parts = line.split()
        if not parts:
            continue
        
        opcode = parts[0]
        operands = []
        
        for operand in parts[1:]:
            parsed_operand = rf.parse_operand(operand.rstrip(','))
            operands.append(parsed_operand)
        
        kernel.create_instruction(GenericInstruction, opcode, *operands)
    
    return kernel