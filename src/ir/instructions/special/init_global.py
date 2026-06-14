from src.instructions.ir_special.global_mem import GlobalMemory as DecGlobalMemory
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import Reg64, Val


class InitGlobalMemory(GenericInstruction):
    def __init__(self, destination: Reg64, values: list[str]):
        self.destination = destination
        self.values = list(values)
        super().__init__("init_global", destination, *(Val(value) for value in self.values))

    def _get_normalize_opcode(self) -> str:
        return "s_init_global"

    def to_text(self) -> str:
        values = ", ".join(self.values)
        if not values:
            return f"{self.opcode} {self.destination.to_text()}"
        return f"{self.opcode} {self.destination.to_text()}, [{values}]"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            DecGlobalMemory,
            self._get_normalize_opcode(),
            self.operands,
        )
