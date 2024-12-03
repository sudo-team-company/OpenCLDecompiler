from src.base_instruction import BaseInstruction
from src.decompiler_data import make_op, set_reg_value


class DsWrite(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.addr = self.instruction[1]
        self.vdata0 = self.instruction[2]
        self.offset = int(self.instruction[3][7:]) if len(self.instruction) == 4 else 0  # noqa: PLR2004
        self.decompiler_data.check_lds_vars(self.offset, suffix)

    def to_print_unresolved(self):
        if self.suffix == "b32":
            v = f"V{self.decompiler_data.number_of_v}"
            self.decompiler_data.write(f"uint* {v} // {self.name}\n")
            self.decompiler_data.write(f"{v} = (uint*)(ds + (({self.addr} + {self.offset}) & ~3))\n")
            self.decompiler_data.write(f"*{v} = {self.vdata0}\n")
            self.decompiler_data.number_of_v += 1
            return self.node
        if self.suffix == "b64":
            v = f"V{self.decompiler_data.number_of_v}"
            self.decompiler_data.write(f"ulong* {v} // {self.name}\n")
            self.decompiler_data.write(f"{v} = (ulong*)(ds + (({self.addr} + {self.offset}) & ~7))\n")
            self.decompiler_data.write(f"*{v} = {self.vdata0}\n")
            self.decompiler_data.number_of_v += 1
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix == "b32":
            new_value = make_op(self.node, self.addr, "4", "/", suffix=self.suffix)
            name = f"{self.decompiler_data.lds_vars[self.offset][0]}[{new_value}]"
            new_value = self.node.state[self.vdata0].val
            reg_type = self.node.state[self.vdata0].type
            return set_reg_value(self.node, new_value, name, [], f"u{self.suffix[1:]}", reg_type=reg_type)
        return super().to_fill_node()

    def to_print(self):
        if self.suffix == "b32":
            new_value = make_op(self.node, self.addr, "4", "/", suffix=self.suffix)
            name = f"{self.decompiler_data.lds_vars[self.offset][0]}[{new_value}]"
            self.output_string = f"{name} = {self.node.state[name].val}"
            return self.output_string
        return super().to_print()
