from typing import Any

from src.ir.instructions.types import IRType
from src.ir.kernel_components import (
    KernelArguments,
    KernelGlobalMemory,
    KernelInstructions,
    KernelLocalMemory,
    KernelPredicates,
)
from src.ir.registers.reg import PredReg


class _OperationTypeUnset:
    pass


OP_TYPE_UNSET = _OperationTypeUnset()
OperationTypeArg = IRType | _OperationTypeUnset


class Kernel:
    def __init__(self, name: str, work_group_size: list[int]):
        self.name = name
        self.work_group_size = work_group_size

        self._instructions = KernelInstructions()
        self._arguments = KernelArguments()
        self._local_memory = KernelLocalMemory()
        self._global_memory = KernelGlobalMemory()
        self._predicates = KernelPredicates()

    @property
    def instructions(self) -> KernelInstructions:
        return self._instructions

    @property
    def arguments(self) -> KernelArguments:
        return self._arguments

    @property
    def local_memory(self) -> KernelLocalMemory:
        return self._local_memory

    @property
    def global_memory(self) -> KernelGlobalMemory:
        return self._global_memory

    @property
    def predicates(self) -> KernelPredicates:
        return self._predicates

    def to_text(self) -> str:
        lines = [
            f".WGS {self.work_group_size}",
            f"define kernel {self.name} (",
        ]

        arguments = [arg for arg in self.arguments.all() if not arg.hidden]
        for index, argument in enumerate(arguments):
            comma = "," if index < len(arguments) - 1 else ""
            lines.append(f"    {argument}{comma}")

        lines.extend(
            [
                ")",
                "{",
            ]
        )

        for instruction in self.instructions.get():
            instruction_text = instruction.to_text()
            if instruction_text:
                lines.append(f"    {instruction_text}")

        lines.append("}")
        return "\n\n".join(lines)

    def create_instruction(
        self,
        instruction_class: type,
        *args: Any,
        predicate: str | PredReg | None = None,
        predicate_negated: bool = False,
        op_type: OperationTypeArg = OP_TYPE_UNSET,
    ) -> "Kernel":
        if op_type is OP_TYPE_UNSET:
            instruction = instruction_class(*args)
        elif isinstance(op_type, IRType):
            instruction = instruction_class(*args, op_type=op_type)
        else:
            raise InvalidOperationTypeError
        predicate_reg = self._coerce_predicate(predicate)
        if predicate_reg is not None:
            instruction.set_predicate(predicate_reg, predicate_negated=predicate_negated)

        self.instructions.append(instruction)
        return self

    @staticmethod
    def _coerce_predicate(predicate: str | PredReg | None) -> PredReg | None:
        if predicate is None:
            return None
        if isinstance(predicate, PredReg):
            return predicate
        return PredReg(predicate)


class InvalidOperationTypeError(TypeError):
    def __init__(self) -> None:
        super().__init__("op_type must be an IRType")
