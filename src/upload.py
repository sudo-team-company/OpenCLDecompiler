from src.combined_register_content import CombinedRegisterContent
from src.decompiler_data import DecompilerData, make_elem_from_addr
from src.integrity import Integrity
from src.opencl_types import make_asm_type
from src.register import Register, check_and_split_regs, get_next_reg, check_and_split_regs_range_to_full_list
from src.register_content import RegisterContent
from src.register_type import RegisterType

usesetup_dict = {
    '0x0': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="",
            type_=RegisterType.GENERAL_SETUP,
        )
    ),
    #  TODO: Подумать, как лучше вписать, что здесь и LOCAL_SIZE_X, и LOCAL_SIZE_Y
    '0x4': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_local_size(0)",
            type_=RegisterType.LOCAL_SIZE_X,
        )
    ),
    '0x8': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_local_size(2)",
            type_=RegisterType.LOCAL_SIZE_Z,
        )
    ),
    '0xc': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(0)",
            type_=RegisterType.GLOBAL_SIZE_X,
        )
    ),
    '0x10': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(1)",
            type_=RegisterType.GLOBAL_SIZE_Y,
        )
    ),
    '0x14': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="get_global_size(2)",
            type_=RegisterType.GLOBAL_SIZE_Z,
        )
    ),
    '0x18': Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value="",
            type_=RegisterType.UNKNOWN,
        )
    ),
}


def upload_usesetup(state, to_registers, offset):
    decompiler_data = DecompilerData()
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    while True:
        state.registers[curr_to_register] = usesetup_dict[offset]
        decompiler_data.make_version(state, curr_to_register)
        offset = hex(int(offset, 16) + 4)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)


def upload_kernel_param(state, offset, kernel_params, to_registers):
    decompiler_data = DecompilerData()
    to_registers = check_and_split_regs_range_to_full_list(to_registers)
    for (reg, val) in kernel_params[offset]:
        if reg not in to_registers:
            continue
        value_for_type = val
        if value_for_type.find("___") != -1:
            value_for_type = value_for_type[:value_for_type.find("___")]
        data_type = make_asm_type(decompiler_data.type_params[value_for_type])
        if val[0] == "*":
            type_param = RegisterType.ADDRESS_KERNEL_ARGUMENT
            val = val[1:]
        else:
            type_param = RegisterType.KERNEL_ARGUMENT_VALUE
        state.registers[reg] = Register(
            integrity=Integrity.ENTIRE,
            register_content=RegisterContent(
                value=val,
                type_=type_param,
            ),
        )
        state.registers[reg].register_content._data_type = data_type
        decompiler_data.make_version(state, reg)


def upload_global_data_pointer(state, to_registers, from_registers):
    decompiler_data = DecompilerData()
    start_to_register, _ = check_and_split_regs(to_registers)
    start_from_register, _ = check_and_split_regs(from_registers)
    data_type = state.registers[start_from_register].data_type
    new_val = make_elem_from_addr(state.registers[start_from_register].val)
    state.registers[start_to_register] = Register(
        integrity=Integrity.ENTIRE,
        register_content=RegisterContent(
            value=new_val,
            type_=RegisterType.GLOBAL_DATA_POINTER,
        ),
    )
    state.registers[start_to_register].data_type = data_type
    decompiler_data.make_version(state, start_to_register)


def upload_setup_argument(state, to_registers, offset):
    decompiler_data = DecompilerData()
    offset = hex(decompiler_data.config_data.setup_params_offsets.index(offset) * 8)
    start_to_register, end_to_register = check_and_split_regs(to_registers)
    curr_to_register = start_to_register
    while True:
        register_content = decompiler_data.setup_argument_dict[offset]
        state.registers[curr_to_register] = Register(
            integrity=Integrity.ENTIRE,
            register_content=register_content,
        )
        decompiler_data.make_version(state, curr_to_register)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)
        register_content = decompiler_data.setup_argument_dict[offset]
        state.registers[curr_to_register] = Register(
            integrity=Integrity.ENTIRE,
            register_content=register_content,
        )
        decompiler_data.make_version(state, curr_to_register)
        offset = hex(int(offset, 16) + 8)
        if curr_to_register == end_to_register:
            break
        curr_to_register = get_next_reg(curr_to_register)


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

    state.registers[curr_to_register] = Register(
        integrity=Integrity.ENTIRE,
        register_content=CombinedRegisterContent(
            register_contents=[]
        ),
    )

    while True:
        if bits != -1:
            if written_bits > bits:
                break

            if written_bits == bits:
                break

        if offset not in decompiler_data.config_data.offset_to_content:
            break

        register_content = decompiler_data.config_data.offset_to_content[offset]
        if (
                state.registers[curr_to_register].register_content.get_size() + register_content.get_size() <
                state.registers[curr_to_register].get_size()
        ) or (
                state.registers[curr_to_register].register_content.get_size() + register_content.get_size() ==
                state.registers[curr_to_register].get_size() and
                state.registers[curr_to_register].register_content.get_count() != 0
        ):
            state.registers[curr_to_register].register_content.append_content(register_content)
            decompiler_data.make_version(state, curr_to_register)

            offset = hex(int(offset, 16) + register_content.get_size() // 8)
            written_bits += register_content.get_size()
        elif state.registers[curr_to_register].register_content.get_size() + register_content.get_size() == \
                state.registers[curr_to_register].get_size():

            if state.registers[curr_to_register].register_content.get_count() == 0:
                state.registers[curr_to_register] = Register(
                    integrity=Integrity.ENTIRE,
                    register_content=RegisterContent(
                        value=register_content.get_value(),
                        type_=register_content.get_type(),
                        data_type=register_content.get_data_type(),
                    ),
                )
            else:
                state.registers[curr_to_register].register_content.append_content(register_content)
            decompiler_data.make_version(state, curr_to_register)

            if curr_to_register == end_to_register:
                break

            state.registers[curr_to_register].try_simplify()
            curr_to_register = get_next_reg(curr_to_register)
            state.registers[curr_to_register] = Register(
                integrity=Integrity.ENTIRE,
                register_content=CombinedRegisterContent(
                    register_contents=[],
                ),
            )

            offset = hex(int(offset, 16) + register_content.get_size() // 8)
            written_bits += register_content.get_size()
        else:
            if state.registers[curr_to_register].register_content.get_size() == 0 and \
                    register_content.get_size() == state.registers[curr_to_register].get_size() * 2:
                state.registers[curr_to_register] = Register(
                    integrity=Integrity.LOW_PART,
                    register_content=RegisterContent(
                        value=register_content.get_value(),
                        type_=register_content.get_type(),
                        data_type=register_content.get_data_type(),
                    )
                )
                decompiler_data.make_version(state, curr_to_register)
                written_bits += register_content.get_size() // 2
                if curr_to_register == end_to_register:
                    break
                state.registers[curr_to_register].try_simplify()
                curr_to_register = get_next_reg(curr_to_register)
                state.registers[curr_to_register] = Register(
                    integrity=Integrity.HIGH_PART,
                    register_content=RegisterContent(
                        value=register_content.get_value(),
                        type_=register_content.get_type(),
                        data_type=register_content.get_data_type(),
                    )
                )
                decompiler_data.make_version(state, curr_to_register)

                offset = hex(int(offset, 16) + register_content.get_size() // 8)
                written_bits += register_content.get_size() // 2

            if curr_to_register == end_to_register:
                break

            state.registers[curr_to_register].try_simplify()
            curr_to_register = get_next_reg(curr_to_register)
            state.registers[curr_to_register] = Register(
                integrity=Integrity.ENTIRE,
                register_content=CombinedRegisterContent(
                    register_contents=[]
                ),
            )

    state.registers[curr_to_register].try_simplify()


def upload(state, to_registers, from_registers, offset, kernel_params, bits: int = -1):
    decompiler_data = DecompilerData()
    if decompiler_data.is_rdna3:
        upload_by_offset(state, to_registers, offset, bits)
        return

    start_from_register, _ = check_and_split_regs(from_registers)
    if state.registers[start_from_register].type == RegisterType.ARGUMENTS_POINTER:
        if offset in DecompilerData().config_data.setup_params_offsets:
            upload_setup_argument(state, to_registers, offset)
        else:
            upload_kernel_param(state, offset, kernel_params, to_registers)
    elif state.registers[start_from_register].type == RegisterType.GLOBAL_DATA_POINTER:
        upload_global_data_pointer(state, to_registers, from_registers)
