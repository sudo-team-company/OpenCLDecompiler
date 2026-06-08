from src.ir.instructions.special.init_global import InitGlobalMemory
from src.ir.instructions.special.local_memory import LocalMemory
from src.ir.passes.base import PassContext
from src.ir.registers.reg import Reg64, Val


class MaterializeMemoryPass:
    name = "materialize-memory"

    def run(self, kernel, _context: PassContext) -> None:
        instructions = []

        if not kernel.global_memory.is_materialized():
            instructions.extend(
                InitGlobalMemory(destination=Reg64(name), values=values)
                for name, values in kernel.global_memory.all().items()
            )
            kernel.global_memory.mark_materialized()

        if not kernel.local_memory.is_materialized():
            instructions.extend(
                LocalMemory(destination=Reg64(name), size=Val(str(size)))
                for name, size in kernel.local_memory.all().items()
            )
            kernel.local_memory.mark_materialized()

        kernel.instructions.prepend_list(instructions)
