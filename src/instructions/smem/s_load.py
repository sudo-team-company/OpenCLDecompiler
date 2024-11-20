from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.register import check_and_split_regs, Register
from src.register_type import RegisterType
from src.upload import upload_usesetup, upload_by_offset, upload_kernel_param, upload_global_data_pointer


class SLoad(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.sdata = self.instruction[1]
        self.sbase = self.instruction[2]
        self.offset = self.instruction[3]

        self.from_registers, _ = check_and_split_regs(self.sbase)

    def to_print_unresolved(self):
        if self.suffix == "dword":
            self.decompiler_data.write(f"{self.sdata} = *(uint*)(smem + ({self.offset} & ~3)) // {self.name}\n")
            return self.node
        if self.suffix == "dwordx2":
            self.decompiler_data.write(f"{self.sdata} = *(ulong*)(smem + ({self.offset} & ~3)) // {self.name}\n")
            return self.node
        if self.suffix in ["dwordx4", "dwordx8"]:
            i_cnt = self.suffix[-1]
            self.decompiler_data.write(f"for (BYTE i = 0; i < {i_cnt}; i++) // {self.name}\n")
            self.decompiler_data.write(f"    {self.sdata}[i] = *(uint*)(SMEM + i*4 + ({self.offset} & ~3))\n")
            return self.node
        return super().to_print_unresolved()

    def to_fill_node(self):
        sbase: Register | None = self.node.state.get(self.from_registers)
        if sbase is not None and self.suffix in ["dword", "dwordx2", "dwordx4", "dwordx8", "b32", "b64", "b128"]:
            if sbase.val.isdigit():
                self.offset = hex(int(self.offset, 16) + int(sbase.val))
            if sbase.type in (RegisterType.GLOBAL_DATA_POINTER, RegisterType.ARGUMENTS_POINTER):
                if DecompilerData().is_rdna3:
                    bits = -1
                    if self.suffix.startswith("b"):
                        bits = int(self.suffix[1:])
                    upload_by_offset(
                        self.node.state,
                        self.sdata,
                        self.offset,
                        bits=bits,
                    )
                elif sbase.type == RegisterType.ARGUMENTS_POINTER:
                    upload_kernel_param(self.node.state, int(self.offset, 16), self.sdata)
                elif sbase.type == RegisterType.GLOBAL_DATA_POINTER:
                    upload_global_data_pointer(self.node.state, self.sdata, self.sbase)
            else:
                upload_usesetup(self.node.state, self.sdata, self.offset)
            return self.node
        return super().to_fill_node()
