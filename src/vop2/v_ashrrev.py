from base_instruction import BaseInstruction
from integrity import Integrity
from register import Register


class VAshrrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        if suffix == "i32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status:
                node.state.registers[vdst] = \
                    Register(node.state.registers[src1].val, node.state.registers[src1].type, Integrity.integer)
                node.state.registers[vdst].version = node.parent[0].state.registers[vdst].version
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "i64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(vdst, src1)
            if flag_of_status:
                if node.state.registers[from_registers].val == "0":
                    node.state.registers[from_registers].val = \
                        node.state.registers[name_of_from + str(first_from + 1)].val
                node.state.registers[to_registers] = \
                    Register(node.state.registers[from_registers].val,
                             node.state.registers[from_registers].type,
                             Integrity.low_part)
                node.state.registers[to_registers].version = \
                    node.parent[0].state.registers[to_registers].version
                node.state.registers[to_registers].type_of_data = suffix
                to_registers_1 = name_of_register + str(last_to)
                node.state.registers[to_registers_1] = \
                    Register(node.state.registers[from_registers].val,
                             node.state.registers[from_registers].type,
                             Integrity.high_part)
                node.state.registers[to_registers_1].version = \
                    node.parent[0].state.registers[to_registers_1].version
                node.state.registers[to_registers_1].type_of_data = suffix
                return node
            return output_string
