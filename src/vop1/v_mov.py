from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class VMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        src0 = instruction[2]

        if suffix == "b32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + src0 + " // v_mov_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(src0) is not None:
                    type_of_value = node.state.registers[src0].type_of_data
                    new_value = node.state.registers[src0].val
                    reg_type = node.state.registers[src0].type
                else:
                    type_of_value = suffix
                    new_value = src0
                    reg_type = RegisterType.int32
                return make_new_value_for_reg(node, new_value, vdst, [src0], type_of_value, reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
