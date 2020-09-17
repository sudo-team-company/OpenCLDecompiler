from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from register import Register
from type_of_reg import Type


class SSub(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            temp = "temp" + str(decompiler_data.number_of_temp)
            decompiler_data.output_file.write(sdst + " = " + ssrc0 + " - " + ssrc1 + "\n")
            decompiler_data.output_file.write(
                "long " + temp + " = (long)" + ssrc0 + " - (long)" + ssrc1 + "\n")
            decompiler_data.output_file.write("scc = " + temp + " > ((1LL << 31) - 1) || " + temp + " < (-1LL << 31)\n")
            decompiler_data.number_of_temp += 1

        elif suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, src0_reg, src1_reg = decompiler_data.make_op(node, ssrc0, ssrc1, " - ")
                new_integrity = node.state.registers[ssrc1].integrity
                node.state.registers[sdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(decompiler_data.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
