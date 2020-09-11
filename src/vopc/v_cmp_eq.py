from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class VCmpEq(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == "u32" or suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2] #  if instruction[2][0] != "v" else node.state.registers[instruction[2]].val
            src1 = instruction[3] #  if instruction[3][0] != "v" else node.state.registers[instruction[3]].val
            # I think that it not necessary now, check tests
            if flag_of_status:  # may be need uint
                new_val, src0_flag, src1_flag = decompiler_data.make_op(node, src0, src1, " == ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(decompiler_data.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string