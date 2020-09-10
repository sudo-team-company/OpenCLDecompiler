from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class SAddc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            new_val, ssrc0_reg, ssrc1_reg = decompiler_data.make_op(node, ssrc0, ssrc1, " + ")  # may be this should be (ulong)
            if flag_of_status:
                if ssrc0_reg and ssrc1_reg:
                    node.state.registers[sdst] = \
                        Register(new_val, Type.unknown, Integrity.integer)
                else:
                    type_reg = Type.int32
                    if ssrc0_reg:
                        type_reg = node.state.registers[ssrc0].type
                    if ssrc1_reg:
                        type_reg = node.state.registers[ssrc1].type
                    node.state.registers[sdst] = \
                        Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(decompiler_data.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
