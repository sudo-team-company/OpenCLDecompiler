from typing import Any, Optional
from src.ir.instructions.IRInstruction import IRInstruction
from src.model.config_data import KernelArgument
from src.opencl_types import evaluate_size, make_asm_type
from src.ir.registers.register_manager import RegisterManager

class Kernel:
    def __init__(self, name: str, work_group_size: list[int]):
        self.name = name
        self.work_group_size = work_group_size
        self.arguments: list[KernelArgument] = []
        self.instructions: list[IRInstruction] = []
        self._register_manager: Optional[RegisterManager] = None

    def add_argument(self, name: str, type_name: str, const: bool = False):
        self.arguments.append(
            KernelArgument(
                type_name=type_name,
                name=name,
                offset=0,
                size=8 if name.startswith("*") else evaluate_size(make_asm_type(type_name))[0],
                hidden=False,
                const=const,
            )
        )
        return self
    

    def create_instruction(self, instruction_class: type, *args: Any) -> 'Kernel':
        self._register_manager = None
        self.instructions.append(instruction_class(*args))
        return self
    

    def get_instructions_parts(self) -> list[list[str]]:
        return [instr.get_parts() for instr in self.instructions]
    
    def get_normalize_instructions_parts(self) -> list[list[str]]:
        self._normalize_registers()
        return [instr.get_parts(self._register_manager) for instr in self.instructions]
    
    def get_instructions(self) -> list[str]:
        return [instr.to_text() for instr in self.instructions]

    def to_text(self) -> str:
        lines = [
            f"; Kernel: {self.name}",
            f"; Work group size: [{', '.join(map(str, self.work_group_size))}]",
            f"define kernel {self.name} (",
        ]

        for i, arg in enumerate(self.arguments):
            const_str = "const " if arg.const else ""
            suffix = "," if i < len(self.arguments) - 1 else ""
            lines.append(f"    {const_str}{arg.type_name} {arg.name}{suffix}")

        lines.append(")")
        lines.append("{")

        for instr in self.instructions:
            lines.append(f"  {instr.to_text()}")

        lines.append("}")

        return '\n'.join(lines)
    
    def _normalize_registers(self) -> None:
        if self._register_manager is not None:
            return

        self._register_manager = RegisterManager()
        operands = [
            operand
            for instr in self.instructions
            for operand in instr.get_operands()
        ]
        self._register_manager.build_mapping(operands)

    def get_register_manager(self) -> Optional[RegisterManager]:
        return self._register_manager