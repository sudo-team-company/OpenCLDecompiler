from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class VAnd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "b32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + src0 + " & " + src1 + " // v_and_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_integrity = node.state.registers[src1].integrity
                new_value, src0_flag, src1_flag = make_op(node, src1, src0[1:], " * ", '', '')
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
