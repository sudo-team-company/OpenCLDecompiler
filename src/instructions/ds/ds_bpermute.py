from src.base_instruction import BaseInstruction


class DsBpermute(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.dst = self.instruction[1]
        self.addr = self.instruction[2]
        self.src = self.instruction[3]
        self.offset = self.instruction[4][7:]

    def to_print_unresolved(self):
        if self.suffix == "b32":
            tab = "    "
            tmp = "tmp" + str(self.decompiler_data.number_of_tmp)
            self.decompiler_data.write("ulong " + tmp + " // ds_bpermute_b32\n")
            self.decompiler_data.write("for (short i = 0; i < 64; i++)\n")
            self.decompiler_data.write("{\n")
            self.decompiler_data.write(tab + "uint lane_id = " + self.addr
                                       + "[(i + (" + self.offset + " >> 2)) & 63]\n")
            self.decompiler_data.write(tab + tmp + "[i] = exec & (1ULL << lane_id) != 0) ? "
                                       + self.src + "[lane_id] : 0\n")
            self.decompiler_data.write("}\n")
            self.decompiler_data.write("for (short i = 0; i < 64; i++)\n")
            self.decompiler_data.write(tab + "if (exec & (1ULL << i) != 0)\n")
            self.decompiler_data.write(tab + tab + self.dst + "[i] = " + tmp + "[i]\n")
            self.decompiler_data.number_of_tmp += 1
            return self.node
        return super().to_print_unresolved()
