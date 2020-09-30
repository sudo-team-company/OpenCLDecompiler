from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.register import Register
from src.type_of_reg import Type


class VMulLo(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == "u32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                new_integrity = node.state.registers[src1].integrity
                new_val, src0_reg, src1_reg = decompiler_data.make_op(node, src0, src1, " * ")
                node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
