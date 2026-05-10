from typing import Any
from src.ir.registers.reg import PredReg
from src.ir.kernel_components import (
    KernelArguments,
    KernelLocalMemory,
    KernelPredicates,
    KernelInstructions,
)


class Kernel:
    def __init__(self, name: str, work_group_size: list[int]):
        self.name = name
        self.work_group_size = work_group_size

        self._instructions = KernelInstructions()
        self._arguments = KernelArguments()
        self._local_memory = KernelLocalMemory()
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
    def predicates(self) -> KernelPredicates:
        return self._predicates

    def create_instruction(
           self,
           instruction_class: type,
           *args: Any,
           is_scalar: bool = False,
           predicate: str | PredReg | None = None,
        ) -> "Kernel":
           instruction = instruction_class(*args, is_scalar=is_scalar)
           predicate_reg = self._coerce_predicate(predicate)
           if predicate_reg is not None:
               instruction.set_predicate(predicate_reg)

           self.instructions.append(instruction)
           return self

    @staticmethod
    def _coerce_predicate(predicate: str | PredReg | None) -> PredReg | None:
        if predicate is None:
            return None
        if isinstance(predicate, PredReg):
            return predicate
        return PredReg(predicate)
