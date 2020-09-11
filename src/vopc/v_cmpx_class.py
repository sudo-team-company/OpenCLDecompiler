from base_instruction import BaseInstruction
from decompiler_data import DecompilerData


class VCmpxClass(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData.Instance()
        if suffix == "f64":
            decompiler_data.output_file.write("Not resolve yet. Maybe you lose.\n")
