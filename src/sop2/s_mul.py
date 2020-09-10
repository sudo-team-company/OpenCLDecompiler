from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class SMul(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                new_val, ssrc0_reg, ssrc1_reg = decompiler_data.make_op(node, ssrc0, ssrc1, " * ")
                if ssrc0_reg and ssrc1_reg:
                    if node.state.registers[ssrc0].type == Type.local_size_x \
                            and node.state.registers[ssrc1].type == Type.work_group_id_x:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_x_local_size, Integrity.integer)
                    elif node.state.registers[ssrc0].type == Type.local_size_y \
                            and node.state.registers[ssrc1].type == Type.work_group_id_y:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_y_local_size, Integrity.integer)
                    elif node.state.registers[ssrc0].type == Type.local_size_z \
                            and node.state.registers[ssrc1].type == Type.work_group_id_z:
                        node.state.registers[sdst] = \
                            Register(new_val, Type.work_group_id_z_local_size, Integrity.integer)
                    else:
                        node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                node.state.make_version(decompiler_data.versions, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
