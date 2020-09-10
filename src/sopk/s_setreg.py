from base_instruction import BaseInstruction
from decompiler_data import DecompilerData
from integrity import Integrity
from register import Register
from type_of_reg import Type


class SSetreg(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix, output_string):
        decompiler_data = DecompilerData.Instance()
        if suffix == 'b32':
            hwreg = instruction[1]
            hwregname = instruction[2]
            bitoffset = instruction[3]
            bitsize = instruction[4]
            sdst = instruction[5]
            mask = "mask" + str(decompiler_data.number_of_mask)
            decompiler_data.output_file.write("uint " + mask + " = (1U << " + bitsize + ") - 1U) << " + bitoffset + "\n")
            decompiler_data.output_file.write(
                hwreg + " = (" + hwreg + "& ~" + mask + ") | ((" + sdst + " << " + bitoffset + ") & " + mask
                + ")\n")
            decompiler_data.number_of_mask += 1