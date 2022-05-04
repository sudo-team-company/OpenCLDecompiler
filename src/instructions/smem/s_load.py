from src.base_instruction import BaseInstruction
from src.register import check_and_split_regs
from src.register_type import RegisterType
from src.upload import upload_usesetup, upload


class SLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdata = self.instruction[1]
        self.sbase = self.instruction[2]
        self.offset = self.instruction[3]

        self.from_registers, _ = check_and_split_regs(self.sbase)

    def to_print_unresolved(self):
        if self.suffix == 'dword':
            self.decompiler_data.write(self.sdata + " = *(uint*)(smem + (" + self.offset + " & ~3)) // s_load_dword\n")
            return self.node
        if self.suffix == 'dwordx2':
            self.decompiler_data.write(
                self.sdata + " = *(ulong*)(smem + (" + self.offset + " & ~3)) // s_load_dwordx2\n")
            return self.node
        if self.suffix in ['dwordx4', 'dwordx8']:
            i_cnt = self.suffix[-1]
            self.decompiler_data.write("for (BYTE i = 0; i < " + i_cnt + "; i++) // s_load_dword" + i_cnt + "\n")
            self.decompiler_data.write(
                "    " + self.sdata + "[i] = *(uint*)(SMEM + i*4 + (" + self.offset + " & ~3))\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['dword', 'dwordx2', 'dwordx4', 'dwordx8']:
            self.offset = hex(int(self.offset, 16) + int(self.node.state.registers[self.from_registers].val))
            if self.node.state.registers[self.from_registers] is not None \
                    and self.node.state.registers[self.from_registers].type \
                    in (RegisterType.GLOBAL_DATA_POINTER, RegisterType.ARGUMENTS_POINTER):
                upload(self.node.state, self.sdata, self.sbase, self.offset, self.decompiler_data.kernel_params)
            else:
                upload_usesetup(self.node.state, self.sdata, self.offset)
            return self.node
        return super().to_fill_node()
