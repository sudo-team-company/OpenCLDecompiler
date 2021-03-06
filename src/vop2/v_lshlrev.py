from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from
from src.versions import make_version


class VLshlrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_flag, src1_flag = make_op(node, src1, str(pow(2, int(src0))), " * ", '', '')
                node.state.registers[vdst] = Register(new_val, node.state.registers[src1].type, Integrity.integer)
                node.state.registers[vdst].version = node.parent[0].state.registers[src1].version
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "b64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src1)
            if "s" in name_of_from or "v" in name_of_from:
                from_registers = name_of_from + str(first_from)
            else:
                from_registers = src1
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_fill_node:
                to_registers_1 = name_of_to + str(last_to)
                from_registers_1 = name_of_from + str(first_from + 1)
                new_val, src1_flag, src0_flag = make_op(node, from_registers, str(pow(2, int(src0))), " * ", '', '')
                if src0_flag and src1_flag:
                    if node.state.registers[from_registers].type \
                            in [Type.global_id_x, Type.global_id_y, Type.global_id_z] \
                            and node.state.registers[name_of_to + str(first_from + 1)].val == "0":
                        node.state.registers[to_registers] = \
                            Register(new_val, node.state.registers[from_registers].type, Integrity.low_part)
                        make_version(node.state, decompiler_data.versions, to_registers)
                        node.state.registers[to_registers].type_of_data = suffix
                        node.state.registers[to_registers_1] = \
                            Register(node.state.registers[from_registers_1].val,
                                     node.state.registers[from_registers].type,
                                     Integrity.high_part)
                        make_version(node.state, decompiler_data.versions, to_registers_1)
                        node.state.registers[to_registers_1].type_of_data = suffix
                    else:
                        node.state.registers[to_registers] = node.state.registers[from_registers]
                        make_version(node.state, decompiler_data.versions, to_registers)
                        node.state.registers[to_registers_1] = node.state.registers[from_registers_1]
                        make_version(node.state, decompiler_data.versions, to_registers_1)
                else:
                    type_reg = Type.int32
                    if src0_flag:
                        type_reg = node.state.registers[src0].type
                    if src1_flag:
                        type_reg = node.state.registers[from_registers].type
                    node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.low_part)
                    make_version(node.state, decompiler_data.versions, to_registers)
                    node.state.registers[to_registers_1] = Register(new_val, type_reg, Integrity.high_part)
                    make_version(node.state, decompiler_data.versions, to_registers_1)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
