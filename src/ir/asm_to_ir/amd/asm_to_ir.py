from src.ir.kernel import Kernel
from src.model.config_data import ConfigData

from src.ir.instructions.special.memory import MemoryAllocation
from src.ir.instructions.special.memory import Store
from src.ir.instructions.special.InitReg import InitReg
from src.ir.instructions.generic import GenericInstruction
from src.ir.registers.reg import Val, Reg_ty, RegOrVal_ty, Reg64, CompositeReg, Reg32

from src.ir.asm_to_ir.amd.register_factory import RegFactory

from src.ir.instructions.common.add import Add, AddC
from src.ir.instructions.common.cvt import Cvt64_32

from src.ir.instructions.common.sub import Sub, SubRev
from src.ir.asm_to_ir.amd.instruction_dict import instruction_dict
from src.ir.instructions.special.local_memory import LocalAdd, LocalStore, LocalLoad
from src.ir.instructions.common.mov import Mov


def init_dispatch_reg(dispatch_reg: Reg_ty, kernel: Kernel):
    kernel.create_instruction(MemoryAllocation, dispatch_reg)
    kernel.create_instruction(Store, dispatch_reg, Val("general_setup"), Val("uint"), Val("0"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(0)"), Val("uint"), Val("4"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_local_size(2)"), Val("uint"), Val("8"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(0)"), Val("uint"), Val("12"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(1)"), Val("uint"), Val("16"))
    kernel.create_instruction(Store, dispatch_reg, Val("get_global_size(2)"), Val("uint"), Val("20"))
    kernel.create_instruction(Store, dispatch_reg, Val("UNKNOWN"), Val("uint"), Val("24"))

def create_instruction_from_opcode(kernel: Kernel, opcode: str, operands: list[RegOrVal_ty]):
    def is_scalar(opcode: str):
        return opcode[0] == 's'
    
    if  instruction_dict.get(opcode):
        instr_class = instruction_dict[opcode]
    else:
        raise NotImplementedError

    if instr_class == Add or instr_class == AddC:
            if len(operands) >= 4 and operands[1].name == 'vcc':
                kernel.create_instruction(
                    instr_class, 
                    operands[0], 
                    operands[2], 
                    operands[3],
                    is_scalar=is_scalar(opcode)
                )
                return
    if instr_class == Sub or instr_class == SubRev:
            if len(operands) >= 4 and operands[1].name == 'vcc':
                kernel.create_instruction(
                    instr_class, 
                    operands[0], 
                    operands[2], 
                    operands[3],
                    is_scalar=is_scalar(opcode)
                )
                return
      
    if instr_class == LocalAdd or instr_class == LocalStore:
            local_tmp_reg = Reg64("lm")
            local_tmp_it = Reg64("it64")
            local_tmp_offset_reg = Reg64("lm_offset")
            #ds_write_b32    v4, v5 offset:256
            #ds_add_u32      v4, v5 offset:256
            kernel.create_instruction(
                Mov, 
                local_tmp_reg,
                operands[2], 
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                Cvt64_32, 
                local_tmp_it,
                operands[0],
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                Add, 
                local_tmp_offset_reg,
                local_tmp_reg,
                local_tmp_it, 
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                instr_class, 
                local_tmp_offset_reg, 
                operands[1],
                is_scalar=is_scalar(opcode)
            )
            return
    
    if instr_class == LocalLoad:
            local_tmp_reg = Reg64("lm")
            local_tmp_it = Reg64("it64")
            local_tmp_offset_reg = Reg64("lm_offset")
            #ds_read_b32     v3, v4 offset:256
            kernel.create_instruction(
                Mov, 
                local_tmp_reg,
                operands[2], 
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                Cvt64_32, 
                local_tmp_it,
                operands[1],
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                Add, 
                local_tmp_offset_reg,
                local_tmp_reg,
                local_tmp_it, 
                is_scalar=is_scalar(opcode)
            )
            kernel.create_instruction(
                instr_class, 
                operands[0],
                local_tmp_offset_reg, 
                is_scalar=is_scalar(opcode)
            )
            return
    

    kernel.create_instruction(
        instr_class, 
        *operands,
        is_scalar=is_scalar(opcode)
    )


# TODO(GFV) на данный момент работает только с .amdcl2
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

    if cf.usesetup:
        g_id_shift = 8
    else:
        g_id_shift = 6
    dimensions = max(cf.dimensions.split(","), key=len)
    for dim in range(len(dimensions)):
        kernel.create_instruction(InitReg, rf.parse_operand(f"s{g_id_shift + dim}"), Val(f"get_group_id({dim})"))
        kernel.create_instruction(InitReg, rf.parse_operand(f"v{dim}"), Val(f"get_local_id({dim})"))

    offset_map: dict[int, str] = {}
    for line in text:
        line = line.strip()
        if not line:
            continue
        
        parts = line.split()
        if not parts:
            continue
        
        opcode = parts[0]
        operands = []
        if 'ds' in opcode and 'offset' not in parts[-1]:
            parts.append('offset:0')
        
        if len(parts) > 1 and parts[1] == 'm0,':
            continue

        for operand in parts[1:]:
                 
            operand = operand.rstrip(',')
            parsed_operand = rf.parse_operand(operand)
            if 'offset' in operand:
                offset = int(operand[7:])
                offset_map[offset] = "lc" + str(offset)
                operand = offset_map[offset]
                parsed_operand = rf.get_or_create(operand, "64")
            operands.append(parsed_operand)
        
        create_instruction_from_opcode(kernel, opcode, operands)
    
    offsets = list(offset_map.keys())
    offsets.append(cf.local_size)
    offsets.sort()
    for key in range(len(offsets) - 1):
        lc_name = offset_map[offsets[key]]
        lc_size = int((offsets[key + 1] - offsets[key]))
        kernel.set_local_memory(lc_name, lc_size)

    return kernel.close()