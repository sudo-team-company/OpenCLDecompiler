from typing import ClassVar

from src.ir.instructions.types import IRType
from src.ir.registers.reg import BaseReg, PredReg, Reg64, Reg_ty, expand_register_names, is_range


class GenericInstruction:
    allowed_types: ClassVar[tuple[IRType, ...] | None] = (IRType.NONE,)
    default_type: ClassVar[IRType] = IRType.NONE

    def __init__(
        self,
        opcode: str,
        *operands,
        op_type: IRType | None = None,
    ):
        self.opcode = opcode
        self.op_type = self._resolve_op_type(op_type)
        self.operands = tuple(operands)
        self._predicate: PredReg | None = None
        self._predicate_negated = False

    def to_text(self) -> str:
        opcode = self.opcode
        if self.op_type != IRType.NONE:
            opcode = f"{opcode}:{self.op_type.value}"

        if self.operands:
            operand_strings = [op.to_text() for op in self.operands]
            return f"{opcode} {', '.join(operand_strings)}"
        return opcode

    def get_operands(self):
        return self.operands

    def get_operation_type(self) -> IRType:
        return self.op_type

    def update_operands(self, *operands):
        self.operands = tuple(operands)

    def writes_first_operand(self) -> bool:
        return bool(self.operands)

    def get_predicate(self) -> PredReg | None:
        return self._predicate

    def set_predicate(self, predicate: PredReg | None, *, predicate_negated: bool = False) -> "GenericInstruction":
        self._predicate = predicate
        self._predicate_negated = predicate is not None and predicate_negated
        return self

    def has_predicate(self) -> bool:
        return self._predicate is not None

    def is_predicate_negated(self) -> bool:
        return self._predicate_negated

    def is_control_flow(self) -> bool:
        return False

    def is_label(self) -> bool:
        return False

    def get_written_registers(self) -> tuple[Reg_ty, ...]:
        if not self.writes_first_operand():
            return ()

        destination = self.operands[0]
        if isinstance(destination, BaseReg):
            if is_range(destination) and not isinstance(destination, Reg64):
                return destination.regs
            return (destination,)
        return ()

    def get_read_registers(self) -> tuple[Reg_ty, ...]:
        start_idx = 0
        if self.writes_first_operand():
            start_idx = 1

        registers: list[Reg_ty] = [operand for operand in self.operands[start_idx:] if isinstance(operand, BaseReg)]
        return tuple(registers)

    def get_written_register_names(self) -> set[str]:
        return self._expand_registers(self.get_written_registers())

    def get_read_register_names(self) -> set[str]:
        return self._expand_registers(self.get_read_registers())

    def get_written_predicate_names(self) -> set[str]:
        return {register.name for register in self.get_written_registers() if isinstance(register, PredReg)}

    def to_fill_node(self, state, parents):
        raise NotImplementedError

    @staticmethod
    def _expand_registers(registers: tuple[Reg_ty, ...]) -> set[str]:
        expanded: set[str] = set()
        for reg in registers:
            expanded.update(expand_register_names(reg))
        return expanded

    def _resolve_op_type(self, op_type: IRType | None) -> IRType:
        if op_type is None:
            resolved_type = self.default_type
        elif isinstance(op_type, IRType):
            resolved_type = op_type
        else:
            raise InvalidOperationTypeError

        allowed_types = self.allowed_types
        if allowed_types is not None and resolved_type not in allowed_types:
            allowed = ", ".join(ir_type.value for ir_type in allowed_types)
            raise UnsupportedOperationTypeError(self.__class__.__name__, resolved_type, allowed)
        return resolved_type


class InvalidOperationTypeError(TypeError):
    def __init__(self) -> None:
        super().__init__("op_type must be an IRType")


class UnsupportedOperationTypeError(ValueError):
    def __init__(self, instruction_name: str, resolved_type: IRType, allowed: str) -> None:
        super().__init__(
            f"{instruction_name} does not support operation type {resolved_type.value}; allowed types: {allowed}"
        )
