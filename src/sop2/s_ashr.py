from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SAshr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = (int)" + ssrc0 + " >> (" + ssrc1 + " & 31) // s_ashr_i32 \n")
                decompiler_data.write("scc = " + sdst + "!=0\n")
                return node
            new_val, ssrc0_flag, ssrc1_flag = \
                make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ", '(int)', '')
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[sdst] = \
                    Register(new_val, Type.unknown, Integrity.integer)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
