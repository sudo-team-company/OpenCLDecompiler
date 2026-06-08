from src.ir.instructions.special.memory import MemoryAllocation, Store
from src.ir.passes.base import PassContext
from src.ir.registers.reg import Val


class MaterializeArgumentStoresPass:
    name = "materialize-argument-stores"

    def run(self, kernel, _context: PassContext) -> None:
        if kernel.arguments.is_materialized():
            return

        arg_ptr = kernel.arguments.arg_ptr()
        if arg_ptr is None:
            return

        stores = [
            Store(
                arg_ptr,
                Val(argument.name),
                Val(argument.type_name),
                Val(str(argument.offset)),
            )
            for argument in kernel.arguments.all()
        ]
        instructions = [MemoryAllocation(arg_ptr), *stores]

        kernel.instructions.prepend_list(instructions)
        kernel.arguments.mark_materialized()
