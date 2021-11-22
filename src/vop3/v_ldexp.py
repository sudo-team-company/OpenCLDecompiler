from src.base_instruction import BaseInstruction
from src.decompiler_data import make_new_value_for_reg
from src.upload import find_first_last_num_to_from


class VLdexp(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.offset = self.instruction[3]

    def to_fill_node(self):
        first_to, last_to, name_of_to, name_of_from, first_from, last_from \
            = find_first_last_num_to_from(self.vdst, self.src0)
        from_registers = name_of_from + str(first_from)
        to_registers = name_of_to + str(first_to)
        data_type = self.suffix
        if self.offset == '32':
            data_type = self.node.state.registers[from_registers].data_type
            if data_type == 'u32':
                data_type = 'u64'
            elif data_type == 'i32':
                data_type = 'i64'
            self.decompiler_data.names_of_vars[self.node.state.registers[from_registers].val] = self.suffix
            reg_type = self.node.state.registers[from_registers].type
            new_value = self.node.state.registers[from_registers].val
        return make_new_value_for_reg(self.node, new_value, to_registers, [], data_type, reg_type=reg_type)
