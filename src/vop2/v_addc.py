from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class VAddc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == "u32":
            vdst = instruction[1]
            sdst = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            ssrc2 = instruction[5]
            new_val, src0_reg, src1_reg = decompiler_data.make_op(node, src0, src1, " + ")  # may be this should be ulong
            if flag_of_status:
                if src0_reg and src1_reg:
                    if node.state.registers[src0].type == Type.paramA \
                            and node.state.registers[src1].type == Type.global_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register(node.state.registers[src0].val + "[get_global_id(0)]",
                                     Type.param_global_id_x, new_integrity)
                        # think about another case with paramA, it should be like v_add?
                    else:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, Type.unknown, new_integrity)
                else:
                    type_reg = Type.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.integer)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
