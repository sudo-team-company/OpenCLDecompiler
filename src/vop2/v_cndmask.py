from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class VCndmask(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            ssrc2 = instruction[4]
            variable = "var" + str(decompiler_data.num_of_var)
            if flag_of_status:
                node.state.registers[vdst] = Register(variable, Type.program_param, Integrity.integer)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_date = suffix

                if node.state.registers[vdst].type == Type.param_global_id_x:
                    variable = "*" + variable
                node.state.registers[vdst].val = variable
                decompiler_data.num_of_var += 1
                decompiler_data.variables[node.state.registers[vdst].version] = variable
                decompiler_data.names_of_vars[variable] = suffix
                return node
            output_string = node.state.registers[vdst].val + " = " + node.state.registers[ssrc2].val \
                            + " ? " + node.state.registers[src1].val + " : " \
                            + node.parent[0].state.registers[src0].val
            return output_string
