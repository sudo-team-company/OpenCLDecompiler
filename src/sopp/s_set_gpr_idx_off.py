from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SSetGprIdxOff(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write("mode = (mode & ~(1U << 27)) // s_set_gpr_id_off\n")
            return node
