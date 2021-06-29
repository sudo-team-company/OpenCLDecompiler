from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class VMulF64(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]
        if flag_of_status == OperationStatus.to_print_unresolved:
            decompiler_data.write(vdst + " = as_double(" + src0 + ") * as_double(" + src1 + ") // v_mul_f64\n")
            return node
