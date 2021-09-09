from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.register_type import RegisterType


class VAddc(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "u32":
            vdst = instruction[1]
            sdst = instruction[2]
            src0 = instruction[3]
            src1 = instruction[4]
            ssrc2 = instruction[5]
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
            new_val, src0_reg, src1_reg = make_op(node, src0, src1, " + ", '(ulong)', '(ulong)')
            if flag_of_status == OperationStatus.to_fill_node:
                if src0_reg and src1_reg:
                    if node.state.registers[src0].type == RegisterType.address_paramA \
                            and node.state.registers[src1].type == RegisterType.global_id_x:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = \
                            Register(node.state.registers[src0].val + "[get_global_id(0)]",
                                     RegisterType.address_param_global_id_x, new_integrity)
                    else:
                        new_integrity = node.state.registers[src1].integrity
                        node.state.registers[vdst] = Register(new_val, RegisterType.unknown, new_integrity)
                else:
                    type_reg = RegisterType.int32
                    if src0_reg:
                        type_reg = node.state.registers[src0].type
                    if src1_reg:
                        type_reg = node.state.registers[src1].type
                    node.state.registers[vdst] = Register(new_val, type_reg, Integrity.entire)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
