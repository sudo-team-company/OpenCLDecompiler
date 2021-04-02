from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SMul(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = " + ssrc0 + " * " + ssrc1 + " // s_mul_i32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, ssrc0_reg, ssrc1_reg = make_op(node, ssrc0, ssrc1, " * ", '', '')
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
                decompiler_data.make_version(node.state, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
