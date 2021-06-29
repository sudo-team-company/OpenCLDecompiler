from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SCbranchVccnz(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        reladdr = instruction[1]
        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write("pc = vcc != 0 ? " + reladdr + " : pc + 4 // s_cbranch_vccnz\n")
            return node
