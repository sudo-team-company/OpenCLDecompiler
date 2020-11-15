from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus
from src.upload import find_first_last_num_to_from
from src.versions import make_version


class VCmpGt(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u64":  # not very correct
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                    = find_first_last_num_to_from(src0, src1)
                src0 = name_of_to + str(first_to)
                src1 = name_of_from + str(first_from)
                new_val, src0_flag, src1_flag = make_op(node, src0, src1, " > ", '(ulong)', '(uint)')
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                make_version(node.state, decompiler_data.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
            # decompiler_data.output_file.write(sdst + " = (ulong)" + src0 + " > (uint)" + src1 + "\n")

        elif suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_flag, src1_flag = make_op(node, src0, src1, " > ", '(int)', '(int)')
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                make_version(node.state, decompiler_data.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
