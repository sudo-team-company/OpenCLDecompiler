from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.versions import make_version


class SBfe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                if ssrc1 == "0x20010":
                    node.state.registers[sdst] = Register("get_work_dim()", Type.work_dim, Integrity.integer)
                elif ssrc1 == '0x100010':
                    node.state.registers[sdst] = Register("get_local_size(1)", Type.local_size_y, Integrity.integer)
                else:
                    print("Unknown pattern in s_bfe")
                make_version(node.state, decompiler_data.versions, sdst)
                return node
            return output_string

        if suffix == "i32":
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                return node
            return output_string
