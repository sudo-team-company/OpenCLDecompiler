from src.base_instruction import BaseInstruction
from src.decompiler_data import set_reg_value
from src.global_data import get_gdata_offset
from src.register_type import RegisterType


class SMov(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdst = self.instruction[1]
        self.ssrc0 = self.instruction[2]

    def to_print_unresolved(self):
        if self.suffix in ['b32', 'b64']:
            self.decompiler_data.write(self.sdst + " = " + self.ssrc0 + " // s_mov_" + self.suffix + "\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['b32', 'b64']:
            if self.sdst == "exec":
                self.node.state.exec_condition.pop()
            if "exec" in [self.sdst, self.ssrc0]:
                return set_reg_value(self.node, "exec", self.sdst, [], None)
            if self.node.state.registers.get(self.ssrc0) is not None:
                new_value = self.node.state.registers[self.ssrc0].val
                reg_type = self.node.state.registers[self.ssrc0].type
                data_type = self.node.state.registers[self.ssrc0].data_type
            else:
                if ".gdata" in self.ssrc0:
                    new_value = "gdata" + str(get_gdata_offset(self.ssrc0))
                    reg_type = RegisterType.GLOBAL_DATA_POINTER
                else:
                    new_value = self.ssrc0
                    reg_type = RegisterType.INT32
                data_type = self.suffix
            return set_reg_value(self.node, new_value, self.sdst, [], data_type, reg_type=reg_type)
        return super().to_fill_node()
