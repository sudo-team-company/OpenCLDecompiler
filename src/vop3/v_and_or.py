from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class VAndOr(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = (" + src0 + " & " + src1 + ") | " + src2 + " // v_and_or_b32 \n")
                return node
