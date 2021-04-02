from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


def compare_in_s_cmp_eq(ssrc0, ssrc1, node, suffix):
    decompiler_data = DecompilerData()
    if 's' in ssrc1:
        cmpr_val = node.state.registers[ssrc1].val
    else:
        cmpr_val = ssrc1
    node.state.registers["scc"] = \
        Register(node.state.registers[ssrc0].val + " == " + cmpr_val, Type.unknown,
                 Integrity.integer)
    decompiler_data.make_version(node.state, "scc")
    if "scc" in [ssrc0, ssrc1]:
        node.state.registers["scc"].make_prev()
    node.state.registers["scc"].type_of_data = suffix
    return node


class SCmpEq(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == 'i32' or suffix == 'u32':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + ssrc0 + "==" + ssrc1 + " // s_cmp_eq_" + suffix + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_in_s_cmp_eq(ssrc0, ssrc1, node, suffix)
            return output_string

        if suffix == 'u64':
            ssrc0 = instruction[1]
            ssrc1 = instruction[2]
            ssrc0 = ssrc0[0] + ssrc0[2: ssrc0.find(':')]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write("scc = " + ssrc0 + "==" + ssrc1 + " // s_cmp_eq_" + suffix + "\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                return compare_in_s_cmp_eq(ssrc0, ssrc1, node, suffix)
            return output_string
