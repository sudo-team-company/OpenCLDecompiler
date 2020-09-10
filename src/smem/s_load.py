from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class SLoad(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()  # may be should add types, not sure
        output_string = ""
        if suffix == 'dword':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if decompiler_data.usesetup == False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string

        elif suffix == 'dwordx2':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if decompiler_data.usesetup == False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string

        elif suffix == 'dwordx4' or suffix == 'dwordx8':
            sdata = instruction[1]
            sbase = instruction[2]
            offset = instruction[3]
            first_to, last_to, num_of_registers, from_registers, to_registers, name_of_register, name_of_from, first_from \
                = node.state.find_first_last_num_to_from(sdata, sbase)
            if flag_of_status:
                if decompiler_data.usesetup == False and sbase == "s[4:5]" \
                        or decompiler_data.usesetup == True and sbase == "s[6:7]":
                    node.state.upload(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                else:
                    node.state.upload_usesetup(sdata, sbase, offset, decompiler_data.params, decompiler_data.versions)
                node.state.registers[to_registers].type_of_data = suffix
                return node
            return output_string
