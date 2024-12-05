from src.base_instruction import BaseInstruction


class DsRead2(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.addr = self.instruction[2]
        self.offset0 = self.instruction[3][8:]
        self.offset1 = self.instruction[4][8:]

    def to_print_unresolved(self):
        if self.suffix == "b64":
            v0 = f"V0{self.decompiler_data.number_of_v0}"
            v1 = f"V1{self.decompiler_data.number_of_v1}"
            self.decompiler_data.write(
                f"ulong* {v0} = (ulong*)(ds + ({self.addr} + {self.offset0} * 8) & ~7) // {self.name}\n"
            )
            self.decompiler_data.write(f"ulong* {v1} = (ulong*)(ds + ({self.addr} + {self.offset1} * 8) & ~7)\n")
            self.decompiler_data.write(f"{self.vdst} = *{v0} | (ulonglong(*{v1}) << 64)\n")  # uint128????
            self.decompiler_data.number_of_v0 += 1
            self.decompiler_data.number_of_v1 += 1
            return self.node
        return super().to_print_unresolved()
