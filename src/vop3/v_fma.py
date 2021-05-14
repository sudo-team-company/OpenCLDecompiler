from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, check_reg_for_val
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from


class VFma(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ''
        if suffix == "f32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            if flag_of_status == OperationStatus.to_fill_node:
                src0, _ = check_reg_for_val(node, src0)
                src1, _ = check_reg_for_val(node, src1)
                src2, _ = check_reg_for_val(node, src2)
                new_val = "fma(" + src0 + ", " + src1 + ', ' + src2 + ")"
                node.state.registers[vdst] = Register(new_val, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1, src2]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + "as_double(" + src0 + ") * as_double("
                                      + src1 + ") + as_double(" + src2 + ") // v_fma_f32\n")
                return node
            return output_string
        elif suffix == 'f64':
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            if flag_of_status == OperationStatus.to_fill_node:
                _, _, _, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(vdst, src0)
                from_registers_src0 = name_of_from + str(first_from)
                _, _, _, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(vdst, src1)
                from_registers_src1 = name_of_from + str(first_from)
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(vdst, src2)
                from_registers_scr2 = name_of_from + str(first_from)
                to_registers = name_of_to + str(first_to)
                # new_val = "fma(" + node.state.registers[from_registers_src0].val + ", " \
                #           + node.state.registers[from_registers_src1].val + ', ' \
                #           + node.state.registers[from_registers_scr2].val + ")"
                new_val = node.state.registers[from_registers_src1].val
                node.state.registers[to_registers] = Register(new_val, Type.unknown, Integrity.entire)
                decompiler_data.make_version(node.state, to_registers)
                if to_registers in [src0, src1, src2]:
                    node.state.registers[to_registers].make_prev()
                node.state.registers[to_registers].type_of_data = suffix
                return node
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + "as_double(" + src0 + ") * as_double("
                                      + src1 + ") + as_double(" + src2 + ") // v_fma_f32\n")
                return node
            return output_string