from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SSetGprIdxOn(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        ssrc0 = instruction[1]
        imm8 = instruction[2]

        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write("mode = (mode & ~(1U << 27)) | (1U << 27) // s_set_gpr_idx_on\n")
            decompiler_data.write("m0 = (m0 & 0xffff0f00) | ((" + imm8 + " & 15) << 12) | (" + ssrc0 + " & 0xff)\n")
            return node
