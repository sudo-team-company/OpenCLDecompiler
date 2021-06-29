from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class VSubrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u32":
            vdst = instruction[1]
            vcc = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
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
                new_val, src0_reg, src1_reg = make_op(node, src1, src0, " - ", '(ulong)', '(ulong)')
                new_integrity = node.state.registers[src1].integrity
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
