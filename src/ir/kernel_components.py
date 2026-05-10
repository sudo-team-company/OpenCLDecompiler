from __future__ import annotations

from src.ir.registers.reg import PredReg, Reg64
from src.model.config_data import KernelArgument
from src.opencl_types import evaluate_size, make_asm_type
from src.ir.instructions.generic import GenericInstruction


class KernelArguments:
    def __init__(self) -> None:
        self._arg_ptr: Reg64 | None = None
        self._arguments: list[KernelArgument] = []
        self._stores_materialized = False
        self._by_name: dict[str, KernelArgument] = {}
        self._by_offset: dict[int, KernelArgument] = {}

    def add(
        self,
        name: str,
        type_name: str,
        const: bool = False,
        offset: int = 0,
        hidden: bool = False,
    ) -> KernelArgument:
        argument = KernelArgument(
            type_name=type_name,
            name=name,
            offset=offset,
            size=self._argument_size(name, type_name),
            hidden=hidden,
            const=const,
        )
        self._arguments.append(argument)
        self._by_name[name] = argument
        self._by_offset[offset] = argument
        return argument

    def get_by_offset(self, offset: int) -> KernelArgument | None:
        return self._by_offset.get(offset)
    
    def get_by_name(self, offset: int) -> KernelArgument | None:
        return self._by_name.get(offset)

    def all(self) -> list[KernelArgument]:
        return self._arguments

    def update_type(self, arg_name: str, type_name: str) -> bool:
        argument = self.get_by_name(arg_name)
        if argument is None:
            return False

        argument.type_name = type_name
        argument.size = self._argument_size(argument.name, type_name)
        return True

    def update_type_by_offset(self, offset: int, type_name: str) -> bool:
        argument = self.get_by_offset(offset)
        if argument is None:
            return False

        return self.update_type(argument.name, type_name)

    def set_arg_ptr(self, arg_ptr: Reg64) -> None:
        self._arg_ptr = arg_ptr
        self._stores_materialized = False

    def arg_ptr(self) -> Reg64 | None:
        return self._arg_ptr

    def is_materialized(self) -> bool:
        return self._stores_materialized

    def mark_materialized(self) -> None:
        self._stores_materialized = True

    @staticmethod
    def _argument_size(name: str, type_name: str) -> int:
        if name.startswith("*"):
            return 8

        size, _ = evaluate_size(make_asm_type(type_name))
        return size


class KernelLocalMemory:
    def __init__(self) -> None:
        self._local_memories: dict[str, int] = {}
        self._materialized = False

    def set(self, name: str, size: int) -> None:
        self._local_memories[name] = size

    def all(self) -> dict[str, int]:
        return dict(self._local_memories)

    def is_materialized(self) -> bool:
        return self._materialized

    def mark_materialized(self) -> None:
        self._materialized = True


class KernelPredicates:
    def __init__(self) -> None:
        self._predicates: list[PredReg] = []
        self._materialized = False

    def add(self, predicate: PredReg) -> None:
        self._predicates.append(predicate)

    def all(self) -> list[PredReg]:
        return list(self._predicates)

    def is_materialized(self) -> bool:
        return self._materialized

    def mark_materialized(self) -> None:
        self._materialized = True


class KernelInstructions:
    def __init__(self) -> None:
        self._instructions: list[GenericInstruction] = []


    def append(self, instruction: GenericInstruction) -> None:
        self._instructions.append(instruction)
        
    def prepend(self, instruction: GenericInstruction) -> None:
        self._instructions.append(instruction)

    def append_list(self, instructions: list[GenericInstruction]) -> None:
        self._instructions = self._instructions + instructions

    def prepend_list(self, instructions: list[GenericInstruction]) -> None:
        self._instructions = instructions + self._instructions

    def get(self) -> list[GenericInstruction]:
        return self._instructions