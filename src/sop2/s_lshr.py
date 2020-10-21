from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class SLshr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        sdst = instruction[1]
        ssrc0 = instruction[2]
        ssrc1 = instruction[3]
        if suffix == 'b32':
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers[ssrc0].type == Type.global_size_x \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[0]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(0)", node.state.registers[ssrc0].type, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.global_size_y \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[1]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(1)", node.state.registers[ssrc0].type, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.global_size_z \
                        and str(pow(2, int(ssrc1))) == decompiler_data.size_of_work_groups[2]:
                    node.state.registers[sdst] = \
                        Register("get_num_groups(2)", node.state.registers[ssrc0].type, Integrity.integer)
                else:
                    new_val, ssrc0_flag, ssrc1_flag = make_op(node, ssrc0, str(pow(2, int(ssrc1))), " / ")
                    node.state.registers[sdst] = Register(new_val, node.state.registers[ssrc0].type, Integrity.integer)
                node.state.make_version(decompiler_data.versions, sdst)
                return node
            return output_string
