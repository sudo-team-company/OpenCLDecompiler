from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SMovk(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            simm16 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + simm16 + " // s_movk_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[sdst] = Register(simm16, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
