from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SSetpc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == 'b64':
            ssrc0 = instruction[1]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("pc = " + ssrc0 + " // s_setpc_b64 \n")
                return node
