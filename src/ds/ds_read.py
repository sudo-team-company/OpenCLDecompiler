from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register


class DsRead(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b32":
            vdst = instruction[1]
            addr = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            name = decompiler_data.lds_vars[offset][0] + "[" + node.state.registers[addr].val + "]"
            if flag_of_status:
                node.state.registers[vdst] = Register(name, node.state.registers[name].type, Integrity.integer)
                node.state.make_version(decompiler_data.versions, vdst)
                node.state.registers[vdst].type_of_data = "u" + suffix[1:]
                return node
            return output_string

        elif suffix == "b64":  # think about this part
            vdst = instruction[1]
            addr = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            name = self.lds_vars[offset][0] + "[" + node.state.registers[addr].var + "]"
            if flag_of_status:
                node.state.registers[vdst] = Register(name, node.state.registers[name].type, Integrity.integer)
                node.state.make_version(self.versions, vdst)
                node.state.registers[vdst].type_of_data = "u" + suffix[1:]
                return node
            return output_string