from src.base_instruction import BaseInstruction


class SSetGprIdxOff(BaseInstruction):
    def to_print_unresolved(self):
        self.decompiler_data.write("mode = (mode & ~(1U << 27)) // s_set_gpr_id_off\n")
        return self.node
