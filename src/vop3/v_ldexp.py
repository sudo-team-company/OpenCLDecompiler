from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from

class VLDEXP(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]
        offset = instruction[3]
        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(vdst, src0)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)
        if flag_of_status == OperationStatus.to_fill_node:
            if offset == '32':
                suffix = node.state.registers[from_registers].type_of_data
                if suffix == 'u32':
                    suffix = 'u64'
                elif suffix == 'i32':
                    suffix = 'i64'
                decompiler_data.names_of_vars[node.state.registers[from_registers].val] = suffix
                type_reg = node.state.registers[from_registers].type
                new_val = node.state.registers[from_registers].val
                node.state.registers[to_registers] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if node.state.registers[to_registers].type_of_data is None:
                    node.state.registers[to_registers].type_of_data = suffix
            return node
        return output_string
