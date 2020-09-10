from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class SBfe(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        output_string = ""
        if suffix == 'u32':
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                if ssrc1 == "0x20010":
                    node.state.registers[sdst] = Register("get_work_dim()", Type.work_dim, Integrity.integer)
                else:
                    node.state.registers[sdst].val = "get_local_size(1)" # I think that it not all true
                node.state.make_version(decompiler_data.versions, sdst)
                return node
            return output_string

        if suffix == "i32":
            sdst = instruction[1]
            ssrc0 = instruction[2]
            ssrc1 = instruction[3]
            if flag_of_status:
                return node
            return output_string
