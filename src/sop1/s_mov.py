from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.versions import make_version


class SMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b32' or suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(ssrc0) is not None:
                    node.state.registers[sdst] = \
                        Register(node.state.registers[ssrc0].val, node.state.registers[ssrc0].type, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(ssrc0, Type.int32, Integrity.integer)
                make_version(node.state, decompiler_data.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
