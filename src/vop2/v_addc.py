from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op, make_new_value_for_reg
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register_type import RegisterType


class VAddc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        vdst = instruction[1]
        sdst = instruction[2]
        src0 = instruction[3]
        src1 = instruction[4]
        ssrc2 = instruction[5]

        if suffix == "u32":
            if flag_of_status == OperationStatus.to_print_unresolved:
                temp = "temp" + str(decompiler_data.number_of_temp)
                mask = "mask" + str(decompiler_data.number_of_mask)
                cc = "cc" + str(decompiler_data.number_of_cc)
                decompiler_data.write("ulong " + mask + " = (1ULL<<LANEID) // v_addc_u32\n")
                decompiler_data.write("uchar " + cc + " = ((" + ssrc2 + "&" + mask + " ? 1 : 0)\n")
                decompiler_data.write("uint " + temp + " = (ulong)" + src0 + " + (ulong)" + src1 + " + " + cc + "\n")
                decompiler_data.write(sdst + " = 0\n")
                decompiler_data.write(vdst + " = CLAMP ? min(" + temp + ", 0xffffffff) : " + temp + "\n")
                decompiler_data.write(sdst + " = (" + sdst + "&~" + mask + ") | (("
                                      + temp + " >> 32) ? " + mask + " : 0)\n")
                decompiler_data.number_of_temp += 1
                decompiler_data.number_of_mask += 1
                decompiler_data.number_of_cc += 1
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                new_value, src0_reg, src1_reg = make_op(node, src0, src1, " + ", '(ulong)', '(ulong)')
                reg_type = RegisterType.unknown
                new_integrity = Integrity.entire
                if src0_reg and src1_reg:
                    new_integrity = node.state.registers[src1].integrity
                    if node.state.registers[src0].type == RegisterType.address_kernel_argument \
                            and node.state.registers[src1].type == RegisterType.global_id_x:
                        new_value = node.state.registers[src0].val + "[get_global_id(0)]"
                        reg_type = RegisterType.address_kernel_argument_element
                else:
                    reg_type = RegisterType.int32
                    if src0_reg:
                        reg_type = node.state.registers[src0].type
                    if src1_reg:
                        reg_type = node.state.registers[src1].type
                return make_new_value_for_reg(node, new_value, vdst, [src0, src1], suffix,
                                              reg_type=reg_type, reg_entire=new_integrity)
            if flag_of_status == OperationStatus.to_print:
                return output_string
