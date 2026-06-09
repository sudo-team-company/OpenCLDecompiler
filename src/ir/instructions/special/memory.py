from src.instructions.ir_special.memory import MemoryAllocation as DecMA
from src.instructions.ir_special.memory import StoreInMem
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.lowering import NodeLoweringContext
from src.ir.registers.reg import Reg64, Reg_ty, Val


class MemoryAllocation(GenericInstruction):
    def __init__(self, destination: Reg64):
        super().__init__("alloc", destination)

    def _get_normalize_opcode(self) -> str:
        return "s_alloc"

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            DecMA,
            self._get_normalize_opcode(),
            self.operands,
        )


class Store(GenericInstruction):
    def __init__(self, destination: Reg_ty, arg_name: Val, arg_type: Val, offset: Val):
        super().__init__("store", destination, arg_type, arg_name, offset)
        self.destination = destination
        self.arg_name = arg_name
        self.arg_type = arg_type
        self.offset = offset

    def _get_normalize_opcode(self) -> str:
        return "s_store"

    def set_arg_type(self, type_name: str) -> None:
        self.arg_type = Val(type_name)
        self.operands = (self.destination, self.arg_type, self.arg_name, self.offset)

    def to_fill_node(self, state, parents):
        return NodeLoweringContext(state, parents).emit_backend(
            StoreInMem,
            self._get_normalize_opcode(),
            self.operands,
        )
