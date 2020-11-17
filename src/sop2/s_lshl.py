from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


class SLshl(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'b32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, ssrc0_flag, ssrc1_flag = make_op(node, ssrc0, str(pow(2, int(ssrc1))), " * ", '', '')
                if node.state.registers[ssrc0].type == Type.work_group_id_x:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_x_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.work_group_id_y:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_y_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                elif node.state.registers[ssrc0].type == Type.work_group_id_z:
                    node.state.registers[sdst] = Register(new_val, Type.work_group_id_z_local_size, Integrity.integer)
                    node.state.registers["scc"] = Register(sdst + "!= 0", Type.int32, Integrity.integer)
                else:
                    node.state.registers[sdst] = Register(new_val, node.state.registers[ssrc0].type, Integrity.integer)
                decompiler_data.make_version(node.state, decompiler_data.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                decompiler_data.make_version(node.state, decompiler_data.versions, "scc")
                node.state.registers["scc"].type_of_data = suffix
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                return node
            return output_string
        if suffix == 'b64':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(sdst, ssrc0)
                from_registers = name_of_from + str(first_from)
                to_registers = name_of_to + str(first_to)
                from_registers1 = name_of_from + str(first_from + 1)
                to_registers1 = name_of_to + str(first_to + 1)
                new_val0, ssrc0_flag0, ssrc1_flag0 = make_op(node, from_registers,
                                                             str(pow(2, int(ssrc1))), " * ", '', '')
                new_val1, ssrc0_flag1, ssrc1_flag1 = make_op(node, from_registers1,
                                                             str(pow(2, int(ssrc1))), " * ", '', '')
                node.state.registers[to_registers] = \
                    Register(new_val0, node.state.registers[from_registers].type, Integrity.low_part)
                node.state.registers[to_registers1] = \
                    Register(new_val1, node.state.registers[from_registers1].type, Integrity.high_part)
                decompiler_data.make_version(node.state, decompiler_data.versions, to_registers)
                node.state.registers[to_registers].type_of_data = suffix
                if to_registers in [from_registers, ssrc1]:
                    node.state.registers[to_registers].make_prev()
                decompiler_data.make_version(node.state, decompiler_data.versions, to_registers1)
                node.state.registers[to_registers1].type_of_data = suffix
                if to_registers1 in [from_registers1, ssrc1]:
                    node.state.registers[to_registers1].make_prev()
                return node
            return output_string
