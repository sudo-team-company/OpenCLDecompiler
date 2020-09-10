from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from register import Register
from type_of_reg import Type


class VAnd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_flag, src1_flag = decompiler_data.make_op(node, src1, src0[1:], " * ")
                # check is this expression correctly, may be add to make_op
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
