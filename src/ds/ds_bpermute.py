from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class DsBpermute(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "b32":
            tab = "    "
            tmp = "tmp" + str(decompiler_data.number_of_tmp)
            dst = instruction[1]
            addr = instruction[2]
            src = instruction[3]
            offset = instruction[4][7:]
            decompiler_data.write("uint64 " + tmp + "\n")
            decompiler_data.write("for (short i = 0; i < 64; i++)\n")
            decompiler_data.write("{\n")
            decompiler_data.write(tab + "uint lane_id = " + addr + "[(i + (" + offset + " >> 2)) & 63]\n")
            decompiler_data.write(tab + tmp + "[i] = exec & (1ULL << lane_id) != 0) ? "
                                              + src + "[lane_id] : 0\n")
            decompiler_data.write("}\n")
            decompiler_data.write("for (short i = 0; i < 64; i++)\n")
            decompiler_data.write(tab + "if (exec & (1ULL << i) != 0)\n")
            decompiler_data.write(tab + tab + dst + "[i] = " + tmp + "[i]\n")
            decompiler_data.number_of_tmp += 1
