from src.ir.kernel import Kernel
from src.model.config_data import ConfigData

from src.ir.instructions.special.memory import MemoryAllocation
from src.ir.instructions.special.memory import Store
from src.ir.instructions.special.InitReg import InitReg
from src.ir.instructions.special.generic import GenericInstruction

from src.ir.registers.reg import Reg64, Reg32, CompositeReg, Val, PredReg, Reg_ty, RegOrVal_ty
from typing import Optional, Dict
from src.register import is_range, is_reg, split_range


class RegFactory:
    _registry: Dict[str, Reg_ty] = {}

    @classmethod
    def get_or_create(cls, name: str, reg_type: str, sub_regs: Optional[list[str]] = None) -> Reg_ty:
        if name in cls._registry:
            existing_reg = cls._registry[name]
            
            expected_class = cls._type_string_to_class(reg_type)
            if not isinstance(existing_reg, expected_class):
                raise ValueError(
                    f"Конфликт типов для регистра '{name}': "
                    f"уже существует как {type(existing_reg).__name__}, "
                    f"попытка создать как {reg_type}"
                )
            
            return existing_reg

        new_reg: Reg_ty

        if reg_type == "32":
            new_reg = Reg32(name)
        elif reg_type == "64":
            new_reg = Reg64(name)
        elif reg_type == "pred":
            new_reg = PredReg(name)
        elif reg_type == "composite":
            resolved_sub_regs = [cls.get_or_create(sub_name, "32") for sub_name in sub_regs]
            new_reg = CompositeReg(name, resolved_sub_regs)
        else:
            raise ValueError(f"Unknown type: {reg_type}")

        cls._registry[name] = new_reg
        return new_reg

    @classmethod
    def _type_string_to_class(cls, t: str):
        if t == "32": return Reg32
        if t == "64": return Reg64
        if t == "pred": return PredReg
        if t == "composite": return CompositeReg
        raise ValueError(f"Unknown type {t}")

    @classmethod
    def clear_registry(cls):
        cls._registry.clear()

def get_reg(name: str, reg_type: str = "auto", sub_regs: Optional[list[str]] = None) -> Reg_ty:
    return RegFactory.get_or_create(name, reg_type, sub_regs)


def parse_operand(token: str) -> RegOrVal_ty:
    if is_range(token):
        prefix = token[0]
        start_idx, end_idx = split_range(token)
        start_idx, end_idx = int(start_idx[1:]), int(end_idx[1:])
        generated_regs: list[Reg_ty] = []

        current_idx = start_idx
        while current_idx <= end_idx:
            reg_name = f"{prefix}{current_idx}"
            sub_reg = get_reg(reg_name, reg_type="32") 
            generated_regs.append(sub_reg)
            
            current_idx += 1

        composite_reg = get_reg(
            name=token, 
            reg_type="composite", 
            sub_regs=[r.name for r in generated_regs]
        )
        
        return composite_reg

    elif is_reg(token):
        return get_reg(token, reg_type="32")

    else:
        return Val(token)

# TODO на данный момент работает только с .amdcl2
def textToIR(text: list[str], cf: ConfigData) -> Kernel:
    RegFactory.clear_registry()

    kernel = Kernel(cf.kernel_name, cf.size_of_work_groups)
    
    # Добавляем видимые аргументы ядра
    for arg in cf.arguments:
        if not arg.hidden:
            kernel.add_argument(arg.name, arg.type_name, arg.const)
    
    agr_reg = parse_operand("s[4:5]")
    kernel.create_instruction(MemoryAllocation, agr_reg)
    for arg in cf.arguments:
        name_to_check = arg.name
        if name_to_check.startswith('*'):
            name_to_check = name_to_check[1:]
        if not name_to_check.startswith('_'):    
            kernel.create_instruction(Store, agr_reg, Val(arg.name), Val(arg.type_name), Val(str(arg.offset)))
    
    g_id_shift = 6 # особенность .amdcl2
    dimensions = max(cf.dimensions.split(","), key=len)
    for dim in range(len(dimensions)):
        kernel.create_instruction(InitReg, parse_operand(f"s{g_id_shift + dim}"), Val(f"get_group_id({dim})"))
        kernel.create_instruction(InitReg, parse_operand(f"v{dim}"), Val(f"get_local_id({dim})"))

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
            parsed_operand = parse_operand(operand.rstrip(','))
            operands.append(parsed_operand)
        
        kernel.create_instruction(GenericInstruction, opcode, *operands)
    
    return kernel