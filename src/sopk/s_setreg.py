from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class SSetreg(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == 'b32':
            hwreg = instruction[1]
            hwregname = instruction[2]
            bitoffset = instruction[3]
            bitsize = instruction[4]
            sdst = instruction[5]
            if flag_of_status == OperationStatus.to_print_unresolved:
                mask = "mask" + str(decompiler_data.number_of_mask)
                decompiler_data.write("uint " + mask + " = (1U << " + bitsize
                                      + ") - 1U) << " + bitoffset + " // s_setreg_b32 \n")
                decompiler_data.write(hwreg + " = (" + hwreg + "& ~" + mask + ") | (("
                                      + sdst + " << " + bitoffset + ") & " + mask + ")\n")
                decompiler_data.number_of_mask += 1
                return node
