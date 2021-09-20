from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_new_value_for_reg
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class VCndmask(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        vdst = instruction[1]
        src0 = instruction[2]
        src1 = instruction[3]
        ssrc2 = instruction[4]

        if suffix == "b32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + ssrc2 + "&(1ULL<<LANEID) ? "
                                      + src1 + " : " + src0 + " // v_cndmask_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                variable = "var" + str(decompiler_data.num_of_var)
                if node.state.registers[vdst].type == RegisterType.kernel_argument_element:
                    variable = "*" + variable
                reg_type = RegisterType.program_param
                node = make_new_value_for_reg(node, variable, vdst, [src0, src1], suffix, reg_type=reg_type)
                decompiler_data.make_var(node.state.registers[vdst].version, variable, suffix)
                return node
            if flag_of_status == OperationStatus.to_print:
                if "?" in node.state.registers[ssrc2].val:
                    node.state.registers[ssrc2].val = "(" + node.state.registers[ssrc2].val + ")"
                if 's' in src1 or 'v' in src1:
                    src1_parent_val = node.parent[0].state.registers[src1].val
                else:
                    src1_parent_val = src1
                if 's' in src0 or 'v' in src0:
                    src0_parent_val = node.parent[0].state.registers[src0].val
                else:
                    src0_parent_val = src0
                output_string = node.state.registers[vdst].val + " = " + node.state.registers[ssrc2].val + " ? " + \
                    src1_parent_val + " : " + src0_parent_val
                return output_string
