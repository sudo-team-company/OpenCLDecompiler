from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.operation_status import OperationStatus


class DsWrite(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "b32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            if flag_of_status == OperationStatus.to_print_unresolved:
                v = "V" + str(decompiler_data.number_of_v)
                decompiler_data.write("uint* " + v + " // ds_write_b32\n")
                decompiler_data.write(v + " = (uint*)(ds + ((" + addr + " + " + str(offset) + ") & ~3))\n")
                decompiler_data.write("*" + v + " = " + vdata0 + "\n")
                decompiler_data.number_of_v += 1
                # decompiler_data.write(name + " = " + vdata0 + "\n")
                return node
            decompiler_data.check_lds_vars(offset, suffix)
            new_value, src0_flag, src1_flag = make_op(node, addr, "4", " / ", '', '')
            name = decompiler_data.lds_vars[offset][0] + "[" + new_value + "]"
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[name] = \
                    Register(node.state.registers[vdata0].val, node.state.registers[vdata0].type, Integrity.entire)
                decompiler_data.make_version(node.state, name)
                node.state.registers[name].type_of_data = "u" + suffix[1:]
                return node
            output_string = name + " = " + node.state.registers[name].val
            return output_string

        elif suffix == "b64":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = instruction[3][7:] if len(instruction) > 3 else "0"
            if flag_of_status == OperationStatus.to_print_unresolved:
                v = "V" + str(decompiler_data.number_of_v)
                decompiler_data.write("ulong* " + v + " // ds_write_b64\n")
                decompiler_data.write(v + " = (ulong*)(ds + ((" + addr + " + " + offset + ") & ~7))\n")
                decompiler_data.write("*" + v + " = " + vdata0 + "\n")
                decompiler_data.number_of_v += 1
                return node
