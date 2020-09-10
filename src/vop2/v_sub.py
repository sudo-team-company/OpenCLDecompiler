from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from register import Register
from type_of_reg import Type


class VSub(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == "u32":
            vdst = instruction[1]
            vcc = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            if flag_of_status:
                new_val, src0_reg, src1_reg = decompiler_data.make_op(node, src0, src1, " - ")
                type_reg = Type.int32
                if src0_reg:
                    type_reg = node.state.registers[src0].integrity
                elif src1_reg:
                    type_reg = node.state.registers[src1].integrity
                node.state.registers[vdst] = Register(new_val, Type.unknown, type_reg)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
