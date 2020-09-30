from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register


class DsWrite(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            if decompiler_data.lds_vars.get(offset) is None:
                decompiler_data.lds_vars[offset] = ["lds" + str(decompiler_data.lds_var_number), "u" + suffix[1:]]
                decompiler_data.lds_var_number += 1
            new_value, src0_flag, src1_flag = decompiler_data.make_op(node, addr, "4", " / ")
            name = decompiler_data.lds_vars[offset][0] + "[" + new_value + "]"
            if flag_of_status:
                node.state.registers[name] = \
                    Register(node.state.registers[vdata0].val, node.state.registers[vdata0].type, Integrity.integer)
                if decompiler_data.versions.get(name) is None:
                    decompiler_data.versions[name] = 0
                node.state.make_version(decompiler_data.versions, name)
                node.state.registers[name].type_of_data = "u" + suffix[1:]
                return node
            output_string = name + " = " + node.state.registers[name].val
            return output_string

        elif suffix == "b64":
            v = "v" + str(decompiler_data.number_of_v)
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = instruction[3][7:]
            decompiler_data.output_file.write("ulong* " + v + "\n")
            decompiler_data.output_file.write(v + " = (ulong*)(ds + ((" + addr + " + " + offset + ") & ~3))\n")
            decompiler_data.output_file.write("*" + v + " = " + vdata0 + "\n")
            decompiler_data.number_of_v += 1
