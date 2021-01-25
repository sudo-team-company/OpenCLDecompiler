from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SSub(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write(sdst + " = " + ssrc0 + " - " + ssrc1 + " // s_sub_i32 \n")
                decompiler_data.write("long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")
                decompiler_data.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
                decompiler_data.number_of_temp += 1
                return node

        elif suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write("ulong " + temp + " = (ulong)" + ssrc0
                                      + " - (ulong)" + ssrc1 + " // s_sub_u32 \n")
                decompiler_data.write(sdst + " = " + temp + "\n")
                decompiler_data.write("scc = (" + temp + ">>32)!=0\n")
                decompiler_data.number_of_temp += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_reg, src1_reg = make_op(node, ssrc0, ssrc1, " - ", '(ulong)', '(ulong)')
                new_integrity = node.state.registers[ssrc1].integrity
                node.state.registers[sdst] = Register(new_val, Type.unknown, new_integrity)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
