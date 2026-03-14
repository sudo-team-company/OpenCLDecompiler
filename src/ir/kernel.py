from typing import Any
from src.ir.instructions.IRInstruction import IRInstruction
from src.model.config_data import KernelArgument
from src.opencl_types import evaluate_size, make_asm_type

class Kernel:
    def __init__(self, name: str, work_group_size: list[int]):
        self.name = name
        self.work_group_size = work_group_size
        self.arguments: list[KernelArgument] = []
        self.instructions: list[IRInstruction] = []
    
    def add_argument(self, name: str, type_name: str, const: bool = False):
        """Добавление аргумента ядра"""
        self.arguments.append(
            KernelArgument(
                type_name=type_name,
                name=name,
                offset=0,
                size=evaluate_size(make_asm_type(type_name))[0],
                hidden=False,
                const=const,
            )
        )
        return self
    
    
    
    def create_instruction(self, instruction_class: type, *args: Any) -> 'Kernel':
        """Создание и добавление инструкции"""
        instruction = instruction_class(*args)
        self.instructions.append(instruction)
        return self
    
    def get_instructions(self) -> list[str]:
        return [instr.to_text() for instr in self.instructions]

    def to_text(self) -> str:
        """Генерация текстового представления IR"""
        lines = []
        
        wg_str = ', '.join(map(str, self.work_group_size))
        lines.append(f"; Kernel: {self.name}")
        lines.append(f"; Work group size: [{wg_str}]")
        
        # Секция аргументов
        lines.append(f"define kernel {self.name} (")
        if self.arguments:
            for i, arg in enumerate(self.arguments):
                const_str = "const " if arg.const else ""
                arg_line = f"    {const_str}{arg.type_name} {arg['name']}"
                if i < len(self.arguments) - 1:
                    arg_line += ","
                lines.append(arg_line)
        lines.append(") {")

        # Секция инструкций
        for instr in self.instructions:
            lines.append(f"  {instr.to_text()}")

        lines.append("}")
        
        return '\n'.join(lines)