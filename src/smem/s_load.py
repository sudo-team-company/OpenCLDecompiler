from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus
from src.upload import upload_usesetup, upload


class SLoad(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdata = instruction[1]
        sbase = instruction[2]
        offset = instruction[3]
        to_registers = sdata
        left_board_to = to_registers.find("[")
        if left_board_to != -1:
            separation_to = to_registers.index(":")
            first_to = int(to_registers[(left_board_to + 1):separation_to])
            name_of_to = to_registers[:left_board_to]
            to_registers = name_of_to + str(first_to)

        if suffix == 'dword':
            if flag_of_status == OperationStatus.to_fill_node:
                if decompiler_data.usesetup is False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup is True and sbase == "s[6:7]":
                    upload(node.state, sdata, sbase, offset, decompiler_data.kernel_params, decompiler_data.versions)
                else:
                    upload_usesetup(node.state, sdata, offset, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string

        elif suffix == 'dwordx2':
            if flag_of_status == OperationStatus.to_fill_node:
                if decompiler_data.usesetup is False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup is True and sbase == "s[6:7]":
                    upload(node.state, sdata, sbase, offset, decompiler_data.kernel_params, decompiler_data.versions)
                else:
                    upload_usesetup(node.state, sdata, offset, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string

        elif suffix == 'dwordx4' or suffix == 'dwordx8':
            if flag_of_status == OperationStatus.to_fill_node:
                if decompiler_data.usesetup is False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup is True and sbase == "s[6:7]":
                    upload(node.state, sdata, sbase, offset, decompiler_data.kernel_params, decompiler_data.versions)
                else:
                    upload_usesetup(node.state, sdata, offset, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
