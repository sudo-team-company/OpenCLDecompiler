from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.global_data import get_gdata_offset
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class SMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]

        if suffix == 'b32' or suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " // s_mov_" + suffix + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(ssrc0) is not None:
                    new_value = node.state.registers[ssrc0].val
                    reg_type = node.state.registers[ssrc0].type
                    type_of_value = node.state.registers[ssrc0].type_of_data
                else:
                    if ".gdata" in ssrc0:
                        new_value = "gdata" + str(get_gdata_offset(ssrc0))
                        reg_type = RegisterType.global_data_pointer
                    else:
                        new_value = ssrc0
                        reg_type = RegisterType.int32
                    type_of_value = suffix
                return make_new_value_for_reg(node, new_value, sdst, [], type_of_value, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
