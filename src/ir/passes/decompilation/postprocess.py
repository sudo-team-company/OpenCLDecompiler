from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState
from src.unrolled_loops_processing import process_unrolled_loops
from src.versions import change_values


class FinalizeDecompilerValuesPass:
    name = "finalize-decompiler-values"

    def run(self, state: DecompilationState, _context: PassContext) -> None:
        decompiler_data = state.decompiler_data
        if decompiler_data.checked_variables or decompiler_data.variables:
            change_values()


class ProcessUnrolledLoopsPass:
    name = "process-unrolled-loops"

    def run(self, _state: DecompilationState, _context: PassContext) -> None:
        process_unrolled_loops()
