from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SCselect(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = scc ? " + ssrc0 + " : " + ssrc1 + " // s_cselect_b64\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if ssrc0 == "exec":
                    ssrc0 = "1"
                new_val = node.state.registers["scc"].val + " ? " + ssrc0 + " : " + ssrc1
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
