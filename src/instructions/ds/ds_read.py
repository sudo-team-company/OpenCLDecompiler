from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value
from src.register_type import RegisterType


class DsRead(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.addr = self.instruction[2]
        self.offset = int(self.instruction[3][7:]) if len(self.instruction) == 4 else 0

    def to_print_unresolved(self):
        if self.suffix == "b32":
            self.decompiler_data.write(self.vdst + " = *(uint*)(DS + ((" + self.addr + " + "
                                       + str(self.offset) + ")&~3)) // ds_read_b32\n")
            return self.node
        if self.suffix == "b64":
            self.decompiler_data.write(self.vdst + " = *(ulong*)(DS + ((" + self.addr + " + "
                                       + str(self.offset) + ")&~7)) // ds_read_b64\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            new_value = make_op(self.node, self.addr, '4', '/')
            name = self.decompiler_data.lds_vars[self.offset][0] + "[" + new_value + "]"
            if self.node.state.registers.get(name):
                reg_type = self.node.state.registers[name].type
            else:
                reg_type = RegisterType.UNKNOWN
            return set_reg_value(self.node, name, self.vdst, [], "u" + self.suffix[1:], reg_type=reg_type)
        if self.suffix == "b64":
            name = self.decompiler_data.lds_vars[self.offset][0] + "[" + self.node.state.registers[self.addr].var + "]"
            reg_type = self.node.state.registers[name].type
            return set_reg_value(self.node, name, self.vdst, [], "u" + self.suffix[1:], reg_type=reg_type)
        return super().to_fill_node()
