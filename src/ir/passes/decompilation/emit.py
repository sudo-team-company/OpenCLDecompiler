from src.code_printer import create_opencl_body
from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState


class EmitOpenCLPass:
    name = "emit-opencl"

    def run(self, _state: DecompilationState, _context: PassContext) -> None:
        create_opencl_body()
