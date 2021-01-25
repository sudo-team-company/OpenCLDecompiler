from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class GlobalLoad(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "dword":
            vdst = instruction[1]
            vaddr = instruction[2]
            saddr = "0" if instruction[3] == "off" else instruction[3]
            inst_offset = "0" if len(instruction) == 4 else instruction[4]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = *(uint*)(" + vaddr + " + " + saddr + " + "
                                      + inst_offset + ") // global_load_dword \n")
                return node

        elif suffix == "dwordx2":
            vdst = instruction[1]
            vaddr = instruction[2]
            saddr = "0" if instruction[3] == "off" else instruction[3]
            inst_offset = "0" if len(instruction) == 4 else instruction[4]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = *(ulong*)(" + vaddr + " + " + saddr + " + "
                                      + inst_offset + ")  // global_load_dwordx2 \n")
                return node
