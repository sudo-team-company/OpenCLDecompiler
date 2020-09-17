from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register


class FlatStoreDwordx2(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        vaddr = instruction[1]
        vdata = instruction[2]
        inst_offset = "0" if len(instruction) < 4 else instruction[3]
        first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
            = node.state.find_first_last_num_to_from(vaddr, vdata)
        if flag_of_status:
            to_now = name_of_register + str(first_to + 1)
            node.state.registers[to_registers] = \
                Register(node.state.registers[from_registers].val, node.state.registers[from_registers].type,
                         Integrity.low_part)
            node.state.registers[to_registers].version = \
                node.parent[0].state.registers[to_registers].version
            node.state.registers[to_registers].type_of_data = "dwordx2"
            second_from = name_of_from + str(first_from + 1)
            node.state.registers[to_now] = \
                Register(node.state.registers[second_from].val, node.state.registers[second_from].type,
                         Integrity.high_part)
            if node.parent[0].state.registers[to_now] is not None:
                node.state.registers[to_now].version = node.parent[0].state.registers[to_now].version
            node.state.registers[to_now].type_of_data = "dwordx2"
            return node
        else:
            var = node.parent[0].state.registers[to_registers].val
            if node.state.registers.get(from_registers):
                output_string = var + " = " + node.state.registers[from_registers].val
            else:
                output_string = var + " = " + decompiler_data.initial_state.registers[from_registers].val
        return output_string
