from src.decompiler_data import set_reg_value
from src.instructions.flat.flat_load import FlatLoad
from src.register import check_and_split_regs
from src.register_type import RegisterType


class GlobalLoad(FlatLoad):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        if self.instruction[3] != "off":
            raise NotImplementedError(
                f"Only 'off' as saddr implemented for global_load instructions. "
                f"Current instruction: '{' '.join(self.instruction)}'"
            )
        self.saddr = "0"
        self.inst_offset = "0" if len(self.instruction) == 4 else self.instruction[4]

        self.from_registers, _ = check_and_split_regs(self.vaddr)

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(self.vdst + " = *(uint*)(" + self.vaddr + " + " + self.saddr + " + "
                                       + self.inst_offset + ") // global_load_dword\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write(self.vdst + " = *(ulong*)(" + self.vaddr + " + " + self.saddr + " + "
                                       + self.inst_offset + ")  // global_load_dwordx2\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ["ushort", "ubyte"] and \
                self.from_registers in self.node.state.registers and \
                self.node.state.registers[self.from_registers].type == RegisterType.DISPATCH_POINTER and \
                self.inst_offset == "inst_offset:2":
            return set_reg_value(
                node=self.node,
                new_value="get_work_dim()",
                to_reg=self.vdst,
                from_regs=[],
                data_type=self.suffix,
                reg_type=RegisterType.WORK_DIM,
            )
        return super().to_fill_node()
