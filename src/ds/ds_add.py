from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class DsAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "u32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            name = decompiler_data.lds_vars[offset][0] + "[" + node.state.registers[addr].val + "]"
            if flag_of_status:
                node.state.registers[name].val = \
                    node.state.registers[name].val + " + " + node.state.registers[vdata0].val
                node.state.make_version(decompiler_data.versions, name)
                node.state.registers[name].type_of_data = suffix
                return node
            output_string = name + " += " + node.state.registers[vdata0].val
            return output_string
