from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.versions import make_version


class SMulk(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            simm16 = instruction[2][instruction[2].find("x") + 1:]
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, sdst_flag, simm16_flag = make_op(node, sdst, simm16, " * ", '', '')
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                make_version(node.state, decompiler_data.versions, sdst)
                node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
