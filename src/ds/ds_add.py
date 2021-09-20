from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class DsAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        addr = instruction[1]
        vdata0 = instruction[2]
        offset = int(instruction[3][7:]) if len(instruction) == 4 else 0

        if suffix == "u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                v = "V" + str(decompiler_data.number_of_v)
                decompiler_data.write("uint* " + v + " = (uint*)(DS + ((" + addr + " + "
                                      + str(offset) + ")&~3)) // ds_add_u32\n")
                decompiler_data.write("*" + v + " = *" + v + " + " + vdata0 + "  // atomic operation\n")
                decompiler_data.number_of_v += 1
                return node
            new_value, src0_flag, src1_flag = make_op(node, addr, "4", " / ", '', '')
            name = decompiler_data.lds_vars[offset][0] + "[" + new_value + "]"
            if flag_of_status == OperationStatus.to_fill_node:
                new_value = node.state.registers[name].val + " + " + node.state.registers[vdata0].val
                return make_new_value_for_reg(node, new_value, name, [], suffix)
            if flag_of_status == OperationStatus.to_print:
                output_string = name + " += " + node.state.registers[vdata0].val
                return output_string
