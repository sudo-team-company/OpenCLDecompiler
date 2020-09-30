from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type


class SMovk(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == 'i32':
            sdst = instruction[1]
            simm16 = instruction[2]
            if flag_of_status:
                node.state.registers[sdst] = Register(simm16, Type.unknown, Integrity.integer)
                if decompiler_data.versions.get(sdst) is None:
                    decompiler_data.versions[sdst] = 0
                node.state.make_version(decompiler_data.versions, sdst)
                node.state.registers[sdst].type_of_data = suffix
                return node
            return output_string
