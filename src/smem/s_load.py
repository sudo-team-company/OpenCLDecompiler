from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus
from src.register_type import RegisterType
from src.upload import upload_usesetup, upload, find_first_last_num_to_from


def s_load_fill_node(node, from_registers, sbase, sdata, offset):
    decompiler_data = DecompilerData()
    if node.state.registers[from_registers] is not None \
            and node.state.registers[from_registers].type == RegisterType.global_data_pointer \
            or decompiler_data.usesetup is False and sbase == "s[4:5]" \
            or decompiler_data.usesetup is True and sbase == "s[6:7]":
        upload(node.state, sdata, sbase, offset, decompiler_data.kernel_params)
    else:
        upload_usesetup(node.state, sdata, offset)
    return node


class SLoad(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdata = instruction[1]
        sbase = instruction[2]
        offset = instruction[3]
        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(sdata, sbase)
        from_registers = name_of_from + str(first_from)

        if suffix == 'dword':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdata + " = *(uint*)(smem + (" + offset + " & ~3)) // s_load_dword\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return s_load_fill_node(node, from_registers, sbase, sdata, offset)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == 'dwordx2':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdata + " = *(ulong*)(smem + (" + offset + " & ~3)) // s_load_dwordx2\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return s_load_fill_node(node, from_registers, sbase, sdata, offset)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == 'dwordx4' or suffix == 'dwordx8':
            if flag_of_status == OperationStatus.to_print_unresolved:
                i_cnt = suffix[-1]
                decompiler_data.write("for (BYTE i = 0; i < " + i_cnt + "; i++) // s_load_dword" + i_cnt + "\n")
                decompiler_data.write("    " + sdata + "[i] = *(uint*)(SMEM + i*4 + (" + offset + " & ~3))\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return s_load_fill_node(node, from_registers, sbase, sdata, offset)
            if flag_of_status == OperationStatus.to_print:
                return output_string
