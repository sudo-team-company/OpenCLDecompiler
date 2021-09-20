from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class SOr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]

        if suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " | " + ssrc1 + "\n")
                decompiler_data.write("scc = " + sdst + "!=0\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_reg, src1_reg = make_op(node, ssrc0, ssrc1, " | ", '', '')
                new_integrity = node.state.registers[ssrc1].integrity
                return make_new_value_for_reg(node, new_value, sdst, [ssrc0, ssrc1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
