from src.base_instruction import BaseInstruction
from src.operation_status import OperationStatus


class VCmpxClass(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        if suffix == "f64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                # decompiler_data.write("Not resolve yet. Maybe you lose.\n")
                return None
