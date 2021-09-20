from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.operation_status import OperationStatus


class VCmpxEq(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        sdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]

        if suffix == "f64":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(sdst + " = as_double(" + src0 + ") == as_double(" + src1 + ") // v_cmpx_eq_f64\n")
                decompiler_data.write("exec = " + sdst + "\n")
                return node
