from src.decompiler_data import set_reg_value
from src.instructions.flat.flat_load import FlatLoad
from src.register import check_and_split_regs
from src.register_type import RegisterType
from src.upload import upload_by_offset


class GlobalLoad(FlatLoad):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.vaddr = self.instruction[2]
        self.saddr = self.instruction[3]
        if self.instruction[3] == "off":
            self.saddr = "0"
        self.inst_offset = "0" if len(self.instruction) == 4 else self.instruction[4]

        if self.instruction[3] == "off":
            self.from_registers, _ = check_and_split_regs(self.vaddr)
        else:
            begin_registers, end_registers = check_and_split_regs(self.saddr)

            if self.suffix in ["u16", "u8"]:
                self.from_registers = end_registers
                self.extra_registers = begin_registers
            else:
                self.from_registers = begin_registers

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(
                self.vdst
                + " = *(uint*)("
                + self.vaddr
                + " + "
                + self.saddr
                + " + "
                + self.inst_offset
                + ") // global_load_dword\n"
            )
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write(
                self.vdst
                + " = *(ulong*)("
                + self.vaddr
                + " + "
                + self.saddr
                + " + "
                + self.inst_offset
                + ")  // global_load_dwordx2\n"
            )
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if (
            self.suffix in ["ushort", "ubyte"]
            and self.from_registers in self.node.state
            and self.node.state[self.from_registers].type == RegisterType.DISPATCH_POINTER
            and self.inst_offset == "inst_offset:2"
        ):
            return set_reg_value(
                node=self.node,
                new_value="get_work_dim()",
                to_reg=self.vdst,
                from_regs=[],
                data_type=self.suffix,
                reg_type=RegisterType.WORK_DIM,
            )

        if self.suffix in ["b32", "u16", "u8"]:
            if self.node.state[self.from_registers].type == RegisterType.ARGUMENTS_POINTER:
                offset = hex(int(self.inst_offset.split(":")[-1]))
                if self.suffix in ["u16", "u8"]:
                    if "12 : 18" in self.node.state[self.extra_registers].get_value():
                        offset = "0x1c"
                    if "14 : 20" in self.node.state[self.extra_registers].get_value():
                        offset = "0x1e"
                    if "16 : 22" in self.node.state[self.extra_registers].get_value():
                        offset = "0x20"
                upload_by_offset(self.node.state, self.vdst, offset, bits=int(self.suffix[1:]))
                return self.node
        return super().to_fill_node()
