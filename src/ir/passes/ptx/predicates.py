from src.ir.instructions.common.not_instruction import Not
from src.ir.instructions.generic import GenericInstruction
from src.ir.instructions.special.mask import ChangeMask, Unmask
from src.ir.passes.base import PassContext
from src.ir.registers.reg import PredReg


class PTXPredicatesPass:
    name = "ptx-predicates"

    def run(self, kernel, _context: PassContext) -> None:
        instructions: list[GenericInstruction] = []
        open_predicate: PredReg | None = None

        for instruction in kernel.instructions.get():
            predicate = instruction.get_predicate()

            if predicate is None or instruction.is_control_flow():
                if open_predicate is not None:
                    instructions.append(Unmask())
                    open_predicate = None
                instructions.append(instruction)
                continue

            predicate_negated = instruction.is_predicate_negated()
            mask_predicate = predicate
            if predicate_negated:
                mask_predicate = PredReg(f"{predicate.name}Not")
                kernel.predicates.add(mask_predicate)

            if open_predicate is None:
                if predicate_negated:
                    instructions.append(Not(mask_predicate, predicate))
                instructions.append(ChangeMask(mask_predicate))
                open_predicate = mask_predicate
            elif open_predicate.name != mask_predicate.name:
                instructions.append(Unmask())
                if predicate_negated:
                    instructions.append(Not(mask_predicate, predicate))
                instructions.append(ChangeMask(mask_predicate))
                open_predicate = mask_predicate

            instruction.set_predicate(None)
            instructions.append(instruction)

        if open_predicate is not None:
            instructions.append(Unmask())

        kernel.instructions.replace_all(instructions)
