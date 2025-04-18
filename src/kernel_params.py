from src.decompiler_data import DecompilerData
from src.expression_manager.expression_manager import ExpressionManager
from src.opencl_types import make_asm_type
from src.register_content import RegisterContent
from src.register_type import RegisterType

from .model import KernelArgument


def get_bfe_offset(name_of_param: str, offset: int, arg: KernelArgument):
    load_offset = offset - offset % 4
    param_size_bit = hex(arg.basic_size() * 8)
    offset_in_reg = hex((offset - load_offset) * 8)
    bfe_offset = param_size_bit + "".rjust(4 - len(offset_in_reg[2:]), "0") + offset_in_reg[2:]
    value = DecompilerData().config_data.offset_to_content[hex(load_offset)].get_value()
    DecompilerData().bfe_offsets[value, bfe_offset] = name_of_param
    ExpressionManager().add_kernel_argument(arg, offset)


def get_reg_type(value: str) -> RegisterType:
    if value == "get_global_offset(0)":
        return RegisterType.GLOBAL_OFFSET_X
    if value == "get_global_offset(1)":
        return RegisterType.GLOBAL_OFFSET_Y
    if value == "get_global_offset(2)":
        return RegisterType.GLOBAL_OFFSET_Z
    if value.startswith("*"):
        return RegisterType.ADDRESS_KERNEL_ARGUMENT
    return RegisterType.KERNEL_ARGUMENT_VALUE


def process_arg(offset: int, arg: KernelArgument):
    value = arg.name.removeprefix("*") if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
    if offset % 4 == 0:
        DecompilerData().config_data.offset_to_content[hex(offset)] = RegisterContent(
            value=value, 
            type_=get_reg_type(arg.name),
            size=arg.basic_size(), 
            data_type=make_asm_type(arg.type_name),
            expression_node=ExpressionManager().add_kernel_argument(arg, offset)
        )
    if "short" in arg.type_name or "char" in arg.type_name:
        get_bfe_offset(value, offset, arg)


def process_kernel_params():
    for arg in DecompilerData().config_data.arguments:
        if not arg.type_name:
            continue
        if not arg.is_vector():
            process_arg(arg.offset, arg)
        else:
            for shift in range(0, arg.size, arg.basic_size()):
                process_arg(arg.offset + shift, arg)
