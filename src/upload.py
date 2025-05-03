from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import *
from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import DecompilerData, make_elem_from_addr
from src.integrity import Integrity
from src.register import Register, check_and_split_regs, get_next_reg
from src.register_content import RegisterContent
from src.register_type import RegisterType

usesetup_dict = {
    "0x0": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="",
            type_=RegisterType.GENERAL_SETUP,
            expression_node=ExpressionManager().get_empty_node()
        ),
    ),
    #  TODO: Подумать, как лучше вписать, что здесь и LOCAL_SIZE_X, и LOCAL_SIZE_Y
    "0x4": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_local_size(0)",
            type_=RegisterType.LOCAL_SIZE_X,
            expression_node=ExpressionManager().get_empty_node()
        ),
    ),
    "0x8": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_local_size(2)",
            type_=RegisterType.LOCAL_SIZE_Z,
            expression_node=ExpressionManager().add_register_node(RegisterType.LOCAL_SIZE_Z, "get_local_size(2)")
        ),
    ),
    "0xc": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(0)",
            type_=RegisterType.GLOBAL_SIZE_X,
            expression_node=ExpressionManager().add_register_node(RegisterType.GLOBAL_SIZE_X, "get_global_size(0)")
        ),
    ),
    "0x10": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(1)",
            type_=RegisterType.GLOBAL_SIZE_Y,
            expression_node=ExpressionManager().add_register_node(RegisterType.GLOBAL_SIZE_Y, "get_global_size(1)")
        ),
    ),
    "0x14": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(2)",
            type_=RegisterType.GLOBAL_SIZE_Z,
            expression_node=ExpressionManager().add_register_node(RegisterType.GLOBAL_SIZE_Z, "get_global_size(2)")
        ),
    ),
    "0x18": Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="",
            type_=RegisterType.UNKNOWN,
            expression_node=ExpressionManager().get_empty_node()
        ),
    ),
}


def upload_usesetup(state, to_registers, offset):
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    while True:
        decompiler_data.set_reg_make_version(state, curr_to_register, usesetup_dict[offset])
        offset = hex(int(offset, 16) + 4)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)


def upload_kernel_param(state, offset, to_registers):
    decompiler_data = DecompilerData()
    start, end = check_and_split_regs(to_registers)
    start, end = int(start[1:]), int(end[1:])
    while start <= end:
        content = decompiler_data.config_data.offset_to_content.get(hex(offset))
        if not content:
            # Motivation example:
            #   1. We have three args of size and align 4 and then arg with size and align 8
            #   2. If we want to load four DWORDs we will load three args and some trash into last DWORD
            # This last argument isn't there since it's aligned.
            break
        if content.get_size() <= 4:  # noqa: PLR2004
            decompiler_data.set_reg_make_version(
                state, f"s{start}", Register(integrity=Integrity.ENTIRE, register_content=content)
            )
            start += 1
            offset += 4
        elif content.get_size() == 8:  # noqa: PLR2004
            if start + 1 > end:
                decompiler_data.set_reg_make_version(
                    state, f"s{start}", Register(integrity=Integrity.ENTIRE, register_content=content)
                )
                break
            decompiler_data.set_reg_make_version(
                state, f"s{start}", Register(integrity=Integrity.LOW_PART, register_content=content)
            )
            decompiler_data.set_reg_make_version(
                state, f"s{start + 1}", Register(integrity=Integrity.HIGH_PART, register_content=content)
            )
            start += 2
            offset += 8
        else:
            break


def upload_global_data_pointer(state, to_registers, from_registers):
    decompiler_data = DecompilerData()
    start_to_register, _ = check_and_split_regs(to_registers)
    start_from_register, _ = check_and_split_regs(from_registers)
    data_type = state[start_from_register].data_type
    new_val = make_elem_from_addr(state[start_from_register].val)
    decompiler_data.set_reg_make_version(
        state,
        start_to_register,
        Register(
            integrity=Integrity.ENTIRE,
            register_content=RegisterContent(
                value=new_val,
                type_=RegisterType.GLOBAL_DATA_POINTER,
                data_type=data_type,
                expression_node=state[start_from_register].register_content._expression_node
            ),
        ),
    )


def upload_by_offset(
    state,
    to_registers: str,
    offset: str,
    bits: int = -1,
):
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    written_bits = 0

    state[curr_to_register] = Register(
        integrity=Integrity.ENTIRE,
        register_content=CombinedRegisterContent(register_contents=[]),
    )

    while True:
        if (bits != -1 and written_bits >= bits) or offset not in decompiler_data.config_data.offset_to_content:
            break

        register_content = decompiler_data.config_data.offset_to_content[offset]
        if (
            state[curr_to_register].register_content.get_size() + register_content.get_size()
            < state[curr_to_register].get_size()
        ) or (
            state[curr_to_register].register_content.get_size() + register_content.get_size()
            == state[curr_to_register].get_size()
            and state[curr_to_register].register_content.get_count() != 0
        ):
            state[curr_to_register].register_content.append_content(register_content)
            decompiler_data.make_version(state, curr_to_register)

            offset = hex(int(offset, 16) + register_content.get_size() // 8)
            written_bits += register_content.get_size()
        elif (
            state[curr_to_register].register_content.get_size() + register_content.get_size()
            == state[curr_to_register].get_size()
        ):
            if state[curr_to_register].register_content.get_count() == 0:
                state[curr_to_register] = Register(
                    integrity=Integrity.ENTIRE,
                    register_content=RegisterContent(
                        value=register_content.get_value(),
                        type_=register_content.get_type(),
                        data_type=register_content.get_data_type(),
                        expression_node=register_content._expression_node
                    ),
                )
            else:
                state[curr_to_register].register_content.append_content(register_content)
            decompiler_data.make_version(state, curr_to_register)

            if curr_to_register == end_to_register:
                break

            state[curr_to_register].try_simplify()
            curr_to_register = get_next_reg(curr_to_register)
            state[curr_to_register] = Register(
                integrity=Integrity.ENTIRE,
                register_content=CombinedRegisterContent(
                    register_contents=[],
                ),
            )

            offset = hex(int(offset, 16) + register_content.get_size() // 8)
            written_bits += register_content.get_size()
        else:
            if (
                state[curr_to_register].register_content.get_size() == 0
                and register_content.get_size() == state[curr_to_register].get_size() * 2
            ):
                decompiler_data.set_reg_make_version(
                    state,
                    curr_to_register,
                    Register(
                        integrity=Integrity.LOW_PART,
                        register_content=RegisterContent(
                            value=register_content.get_value(),
                            type_=register_content.get_type(),
                            data_type=register_content.get_data_type(),
                            expression_node=register_content._expression_node
                        ),
                    ),
                )
                written_bits += register_content.get_size() // 2
                if curr_to_register == end_to_register:
                    break
                state[curr_to_register].try_simplify()
                curr_to_register = get_next_reg(curr_to_register)
                decompiler_data.set_reg_make_version(
                    state,
                    curr_to_register,
                    Register(
                        integrity=Integrity.HIGH_PART,
                        register_content=RegisterContent(
                            value=register_content.get_value(),
                            type_=register_content.get_type(),
                            data_type=register_content.get_data_type(),
                            expression_node=register_content._expression_node
                        ),
                    ),
                )

                offset = hex(int(offset, 16) + register_content.get_size() // 8)
                written_bits += register_content.get_size() // 2

            if curr_to_register == end_to_register:
                break

            state[curr_to_register].try_simplify()
            curr_to_register = get_next_reg(curr_to_register)
            state[curr_to_register] = Register(
                integrity=Integrity.ENTIRE,
                register_content=CombinedRegisterContent(register_contents=[]),
            )

    state[curr_to_register].try_simplify()
