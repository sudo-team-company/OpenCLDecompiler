from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.register_type import RegisterType


class VMac(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "f32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = as_float(" + src0 + ") * as_float("
                                      + src1 + ") + as_float(" + vdst + ") // v_mac_f32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_reg, src1_reg = make_op(node, src0, src1, " * ", 'as_float(', 'as_float(')
                end_val = new_val + " + as_float(" + node.state.registers[vdst].val + ')'
                node.state.registers[vdst] = Register(end_val, RegisterType.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, vdst)
                node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
