from src.ir.kernel import Kernel
from src.model.config_data import ConfigData

from src.ir.instructions.special.memory import MemoryAllocation
from src.ir.instructions.special.memory import Store
from src.ir.instructions.special.InitReg import InitReg
from src.ir.instructions.special.generic import GenericInstruction


# TODO на данный момент работает только с .amdcl2
def textToIR(text: list[str], cf: ConfigData) -> Kernel:
    kernel = Kernel(cf.kernel_name, cf.size_of_work_groups)
    
    # Добавляем видимые аргументы ядра
    for arg in cf.arguments:
        if not arg.hidden:
            kernel.add_argument(arg.name, arg.type_name, arg.const)
    

    kernel.create_instruction(MemoryAllocation, "s[4:5]")
    for arg in cf.arguments:
        name_to_check = arg.name
        if name_to_check.startswith('*'):
            name_to_check = name_to_check[1:]
        if not name_to_check.startswith('_'):    
            kernel.create_instruction(Store, "s[4:5]", arg.name, arg.type_name, arg.offset)
    
    g_id_shift = 6 # особенность .amdcl2
    dimensions = max(cf.dimensions.split(","), key=len)
    for dim in range(len(dimensions)):
        kernel.create_instruction(InitReg, f"s{g_id_shift + dim}", f"get_group_id({dim})")
        kernel.create_instruction(InitReg, f"v{dim}", f"get_local_id({dim})")

    # Обработка инструкций
    for line in text:
        line = line.strip()
        if not line:
            continue
        
        # Парсинг инструкции
        parts = line.split()
        if not parts:
            continue
        
        opcode = parts[0]
        operands = []
        
        for operand in parts[1:]:
            operands.append(operand.rstrip(','))
        
        kernel.create_instruction(GenericInstruction, opcode, *operands)
    
    return kernel