from src.base_instruction import BaseInstruction
from src.register_type import RegisterType
from src.upload import upload_usesetup, upload, find_first_last_num_to_from


class SLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdata = self.instruction[1]
        self.sbase = self.instruction[2]
        self.offset = self.instruction[3]
        self.first_to, self.last_to, self.name_of_to, self.name_of_from, self.first_from, self.last_from \
            = find_first_last_num_to_from(self.sdata, self.sbase)
        self.from_registers = self.name_of_from + str(self.first_from)

    def to_print_unresolved(self):
        if self.suffix == 'dword':
            self.decompiler_data.write(self.sdata + " = *(uint*)(smem + (" + self.offset + " & ~3)) // s_load_dword\n")
            return self.node
        elif self.suffix == 'dwordx2':
            self.decompiler_data.write(
                self.sdata + " = *(ulong*)(smem + (" + self.offset + " & ~3)) // s_load_dwordx2\n")
            return self.node
        elif self.suffix in ['dwordx4', 'dwordx8']:
            i_cnt = self.suffix[-1]
            self.decompiler_data.write("for (BYTE i = 0; i < " + i_cnt + "; i++) // s_load_dword" + i_cnt + "\n")
            self.decompiler_data.write(
                "    " + self.sdata + "[i] = *(uint*)(SMEM + i*4 + (" + self.offset + " & ~3))\n")
            return self.node
        else:
            return super().to_print_unresolved()

    def to_fill_node(self):
        if self.suffix in ['dword', 'dwordx2', 'dwordx4', 'dwordx8']:
            if self.node.state.registers[self.from_registers] is not None \
                    and self.node.state.registers[self.from_registers].type == RegisterType.GLOBAL_DATA_POINTER \
                    or self.decompiler_data.usesetup is False and self.sbase == "s[4:5]" \
                    or self.decompiler_data.usesetup is True and self.sbase == "s[6:7]":
                upload(self.node.state, self.sdata, self.sbase, self.offset, self.decompiler_data.kernel_params)
            else:
                upload_usesetup(self.node.state, self.sdata, self.offset)
            return self.node
        else:
            return super().to_fill_node()
