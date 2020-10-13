from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SCmpGe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == 'i32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers["scc"] = \
                    Register(node.state.registers[ssrc0].val + " >= " + node.state.registers[ssrc1].val, Type.unknown,
                             Integrity.integer)
                node.state.make_version(decompiler_data.versions, "scc")
                if "scc" in [ssrc0, ssrc1]:
                    node.state.registers["scc"].make_prev()
                node.state.registers["scc"].type_of_data = suffix
                return node
            return output_string
            # decompiler_data.output_file.write("scc = (int)" + ssrc0 + " >= (int)" + ssrc1 + "\n")

        elif suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            decompiler_data.output_file.write("scc = " + ssrc0 + " >= " + ssrc1 + "\n")
