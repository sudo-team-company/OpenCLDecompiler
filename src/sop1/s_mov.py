from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.global_data import get_gdata_offset


class SMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b32' or suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " // s_mov_" + suffix + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(ssrc0) is not None:
                    node.state.registers[sdst] = \
                        Register(node.state.registers[ssrc0].val, node.state.registers[ssrc0].type, Integrity.entire)
                else:
                    if ".gdata" in ssrc0:
                        id = get_gdata_offset(ssrc0)
                        node.state.registers[sdst] = Register("gdata" + str(id), Type.global_data_pointer,
                                                              Integrity.entire)
                    else:
                        node.state.registers[sdst] = Register(ssrc0, Type.int32, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
