from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.operation_status import OperationStatus


class DsRead(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        addr = instruction[2]
        offset = int(instruction[3][7:]) if len(instruction) == 4 else 0

        if suffix == "b32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = *(uint*)(DS + ((" + addr + " + "
                                      + str(offset) + ")&~3)) // ds_read_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_flag, src1_flag = make_op(node, addr, "4", " / ", '', '')
                name = decompiler_data.lds_vars[offset][0] + "[" + new_value + "]"
                reg_type = node.state.registers[name].type
                return make_new_value_for_reg(node, name, vdst, [], "u" + suffix[1:], reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string

        elif suffix == "b64":
            vdst = instruction[1]
            addr = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = *(ulong*)(DS + ((" + addr + " + "
                                      + str(offset) + ")&~7)) // ds_read_b64\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                name = decompiler_data.lds_vars[offset][0] + "[" + node.state.registers[addr].var + "]"
                reg_type = node.state.registers[name].type
                return make_new_value_for_reg(node, name, vdst, [], "u" + suffix[1:], reg_type=reg_type)
            if flag_of_status == OperationStatus.to_print:
                return output_string
