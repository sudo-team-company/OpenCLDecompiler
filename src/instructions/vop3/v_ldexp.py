from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.register import check_and_split_regs


class VLdexp(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.offset = self.instruction[3]

    def to_fill_node(self):
        start_to_registers, _ = check_and_split_regs(self.vdst)
        start_from_registers, _ = check_and_split_regs(self.src0)
        if self.offset == "32":
            data_type = self.node.state[start_from_registers].data_type
            if data_type == "u32":
                data_type = "u64"
            elif data_type == "i32":
                data_type = "i64"
            self.decompiler_data.names_of_vars[self.node.state[start_from_registers].val] = self.suffix
            reg_type = self.node.state[start_from_registers].type
            new_value = self.node.state[start_from_registers].val
        else:
            raise NotImplementedError
        return set_reg_value(self.node, new_value, start_to_registers, [], data_type, reg_type=reg_type)
