from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class VSubrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        vcc = instruction[2]
        src0 = instruction[3]
        src1 = instruction[4]

        if suffix == "u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                mask = "mask" + str(decompiler_data.number_of_mask)
                decompiler_data.write("ulong " + temp + " = (ulong)" + src1
                                      + " - (ulong)" + src0 + " // v_subrev_u32\n")
                decompiler_data.write(vdst + " = CLAMP ? (" + temp + ">>32 ? 0 : " + temp + ") : " + temp + "\n")
                decompiler_data.write(vcc + " = 0\n")  # vop2, sdst
                decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID)\n")
                decompiler_data.write(vcc + " = (" + vcc + "&~" + mask + ") | (("
                                      + temp + ">>32) ? " + mask + " : 0)\n")
                decompiler_data.number_of_temp += 1
                decompiler_data.number_of_mask += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_reg, src1_reg = make_op(node, src1, src0, " - ", '(ulong)', '(ulong)')
                new_integrity = node.state.registers[src1].integrity
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
