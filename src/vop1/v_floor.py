from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.upload import find_first_last_num_to_from


class VFloor(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]

        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(vdst, src0)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)

        if suffix == "f16":
            if flag_of_status == OperationStatus.to_fill_node:
                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = suffix
                type_reg = node.state.registers[from_registers].type
                new_val = node.state.registers[from_registers].val
                node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if node.state.registers[to_registers].type_of_data is None:
                    node.state.registers[to_registers].type_of_data = 'i16'
                return node
            return output_string

        elif suffix == 'f32':
            if flag_of_status == OperationStatus.to_fill_node:
                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = suffix
                type_reg = node.state.registers[from_registers].type
                new_val = node.state.registers[from_registers].val
                node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if node.state.registers[to_registers].type_of_data is None:
                    node.state.registers[to_registers].type_of_data = 'i32'
                return node
            return output_string

        else:
            if flag_of_status == OperationStatus.to_fill_node:
                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = suffix
                type_reg = node.state.registers[from_registers].type
                new_val = node.state.registers[from_registers].val
                node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if node.state.registers[to_registers].type_of_data is None:
                    node.state.registers[to_registers].type_of_data = 'i64'
                return node
            return output_string
