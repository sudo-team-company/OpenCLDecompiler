from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.register_type import RegisterType


class SAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                decompiler_data.write("ulong " + temp + " = (ulong)" + ssrc0
                                      + " + (ulong)" + ssrc1 + " // s_add_u32\n")
                decompiler_data.write(sdst + " = " + temp + "\n")
                decompiler_data.write("scc = " + temp + " >> 32\n")
                decompiler_data.number_of_temp += 1
                return node
            new_val, ssrc0_reg, ssrc1_reg = make_op(node, ssrc0, ssrc1, " + ", '(ulong)', '(ulong)')
            if flag_of_status == OperationStatus.to_fill_node:
                if ssrc0_reg and ssrc1_reg:
                    if node.state.registers[ssrc0].type == RegisterType.work_group_id_x_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_x:
                        node.state.registers[sdst] = \
                            Register(new_val, RegisterType.work_group_id_x_local_size_offset, Integrity.entire)
                    elif node.state.registers[ssrc0].type == RegisterType.work_group_id_y_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_y:
                        node.state.registers[sdst] = \
                            Register(new_val, RegisterType.work_group_id_y_local_size_offset, Integrity.entire)
                    elif node.state.registers[ssrc0].type == RegisterType.work_group_id_z_local_size \
                            and node.state.registers[ssrc1].type == RegisterType.global_offset_z:
                        node.state.registers[sdst] = \
                            Register(new_val, RegisterType.work_group_id_z_local_size_offset, Integrity.entire)
                    elif node.state.registers[ssrc0].type == RegisterType.global_data_pointer:
                        name = node.state.registers[ssrc0].val
                        if node.state.registers[ssrc1].type_of_data == '4 bytes':
                            new_value, src0_flag, src1_flag = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val = name + "[" + new_value + "]"
                            node.state.registers[sdst] = \
                                Register(new_val, RegisterType.global_data_pointer, Integrity.entire)
                            suffix = '4 bytes'
                        else:
                            new_value, src0_flag, src1_flag = make_op(node, ssrc1, "8", " / ", '', '')
                            new_val = name + "[" + new_value + "]"
                            node.state.registers[sdst] = \
                                Register(new_val, RegisterType.global_data_pointer, Integrity.entire)
                            suffix = '8 bytes'
                    elif node.state.registers[ssrc0].type == RegisterType.paramA:
                        if node.state.registers[ssrc0].type_of_data == 'u32' \
                                or node.state.registers[ssrc0].type_of_data == 'i32':
                            new_val, _, _ = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val, _, _ = make_op(node, ssrc0, new_val, " + ", '(ulong)', '(ulong)')
                            node.state.registers[sdst] = \
                                Register(new_val, RegisterType.paramA, Integrity.entire)
                    elif node.state.registers[ssrc0].type == RegisterType.param \
                            or node.state.registers[ssrc1].type == RegisterType.param:
                        node.state.registers[sdst] = \
                            Register(new_val, RegisterType.param, Integrity.entire)
                    else:
                        node.state.registers[sdst] = \
                            Register(new_val, RegisterType.unknown, Integrity.entire)
                else:
                    type_reg = RegisterType.int32
                    if ssrc0_reg:
                        type_reg = node.state.registers[ssrc0].type
                    if ssrc1_reg:
                        type_reg = node.state.registers[ssrc1].type
                    if node.state.registers[ssrc0].type == RegisterType.paramA:
                        if node.state.registers[ssrc0].type_of_data == 'u32' \
                                or node.state.registers[ssrc0].type_of_data == 'i32':
                            new_val, _, _ = make_op(node, ssrc1, "4", " / ", '', '')
                            new_val, _, _ = make_op(node, ssrc0, new_val, " + ", '(ulong)', '(ulong)')
                    node.state.registers[sdst] = \
                        Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, sdst)
                if sdst in [ssrc0, ssrc1]:
                    node.state.registers[sdst].make_prev()
                if not (node.state.registers[ssrc0].type == RegisterType.global_data_pointer):
                # if node.state.registers[ssrc0].type_of_data is not None:
                    node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
