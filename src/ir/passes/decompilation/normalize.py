from src.decompiler_data import optimize_names_of_vars
from src.global_data import gdata_type_processing
from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState
from src.versions import check_for_use_new_version


class NormalizeDecompilerStatePass:
    name = "normalize-decompiler-state"

    def run(self, state: DecompilationState, _context: PassContext) -> None:
        decompiler_data = state.decompiler_data

        optimize_names_of_vars()
        if decompiler_data.global_data:
            gdata_type_processing()
        check_for_use_new_version()
        decompiler_data.remove_unusable_versions()
