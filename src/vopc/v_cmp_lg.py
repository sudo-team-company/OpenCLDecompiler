from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.type_of_reg import Type


class VCmpLg(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (int)" + src0 + " != (int)" + src1 + " // v_cmp_lg_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_flag, src1_flag = make_op(node, src0, src1, " != ", '(int)', '(int)')
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + " // v_cmp_lg_u32\n")
                return node
