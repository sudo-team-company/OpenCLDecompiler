from src.ir.registers.reg import PredReg, Reg_ty, BaseReg, CompositeReg, expand_register_names, is_range, Reg64

class GenericInstruction:
    def __init__(
        self,
        opcode: str,
        *operands,
        is_scalar: bool = False,
    ):
        self.opcode = opcode
        self.operands = tuple(operands)
        self._is_scalar = is_scalar

    def to_text(self) -> str:
        if self.operands:
            operand_strings = [op.to_text() for op in self.operands]
            return f"{self.opcode} {', '.join(operand_strings)}"
        return self.opcode
    
    
    def get_operands(self):
        return self.operands
    
    def update_operands(self, *operands):
        self.operands = tuple(operands)
    
    def is_scalar(self):
        return self._is_scalar
    
    def writes_first_operand(self) -> bool:
        return bool(self.operands)

    def get_predicate(self) -> PredReg | None:
        return self._predicate
    
    def set_predicate(self, predicate: PredReg | None) -> "GenericInstruction":
        self._predicate = predicate
        return self
    
    def has_predicate(self) -> bool:
        return self._predicate is not None
    
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

        registers: list[Reg_ty] = [
            operand
            for operand in self.operands[start_idx:]
            if isinstance(operand, BaseReg)
        ]
        return tuple(registers)
    
    def writes_any_predicate(self) -> bool:
        return any(isinstance(reg, PredReg) for reg in self.get_written_registers())
    
    def get_written_register_names(self) -> set[str]:
        return self._expand_registers(self.get_written_registers())

    def get_read_register_names(self) -> set[str]:
        return self._expand_registers(self.get_read_registers())
    
    def get_written_predicate_names(self) -> set[str]:
        return {
            register.name
            for register in self.get_written_registers()
            if isinstance(register, PredReg)
        }

    def to_fill_node(self, state, parents):
        raise NotImplementedError()

    
    @staticmethod
    def _expand_registers(registers: tuple[Reg_ty, ...]) -> set[str]:
        expanded: set[str] = set()
        for reg in registers:
            expanded.update(expand_register_names(reg))
        return expanded