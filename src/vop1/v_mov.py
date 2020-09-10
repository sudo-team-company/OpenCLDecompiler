from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class VMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status:
                if node.state.registers.get(src0) is not None:
                    node.state.registers[vdst] = \
                        Register(node.state.registers[src0].val, node.state.registers[src0].type,
                                 Integrity.integer)
                else:
                    node.state.registers[vdst] = Register(src0, Type.int32, Integrity.integer)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
