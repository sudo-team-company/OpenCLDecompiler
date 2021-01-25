from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class DsWrite2(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "b64":
            addr = instruction[1]
            vdata0 = instruction[2]
            vdata1 = instruction[3]
            offset0 = instruction[4][8:]
            offset1 = instruction[5][8:]
            if flag_of_status == OperationStatus.to_print_unresolved:
                v0 = "V0" + str(decompiler_data.number_of_v0)
                v1 = "V1" + str(decompiler_data.number_of_v1)
                decompiler_data.write(
                    "ulong* " + v0 + " = (ulong*)(ds + (" + addr + " + " + offset0 + " * 8) & ~7) // ds_write2_b64 \n")
                decompiler_data.write(
                    "ulong* " + v1 + " = (ulong*)(ds + (" + addr + " + " + offset1 + " * 8) & ~7)\n")
                decompiler_data.write("*" + v0 + " = " + vdata0 + "\n")
                decompiler_data.write("*" + v1 + " = " + vdata1 + "\n")
                decompiler_data.number_of_v0 += 1
                decompiler_data.number_of_v1 += 1
                return node
