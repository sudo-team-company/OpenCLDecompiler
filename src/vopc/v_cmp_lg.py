from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class VCmpLg(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "i32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                new_val, src0_flag, src1_flag = make_op(node, src0, src1, " != ")
                node.state.registers[sdst] = Register(new_val, Type.unknown, Integrity.integer)
                if decompiler_data.versions.get(sdst) is None:
                    decompiler_data.versions[sdst] = 0
                node.state.make_version(decompiler_data.versions, sdst)
                if sdst in [src0, src1]:
                    node.state.registers[sdst].make_prev()
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "u32":
            sdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            decompiler_data.output_file.write(sdst + " = (uint)" + src0 + " != (uint)" + src1 + "\n")
