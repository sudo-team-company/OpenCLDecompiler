from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SSwappc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        sdst = instruction[1]
        ssrc0 = instruction[2]

        if suffix == 'b64':
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = pc + 4 // s_swappc_b64\n")
                decompiler_data.write("pc = " + ssrc0 + "\n")
                return node
