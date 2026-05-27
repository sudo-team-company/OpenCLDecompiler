from src.ir.registers.reg import CompositeReg, PredReg, Reg32, Reg64, Reg_ty, RegOrVal_ty, Val
from src.register import is_range, is_reg, split_range


class RegFactory:
    def __init__(self):
        self._registry: dict[str, Reg_ty] = {}

    def get_or_create(self, name: str, reg_type: str, sub_regs: list[str] | None = None) -> Reg_ty:
        if name in self._registry:
            existing_reg = self._registry[name]

            expected_class = self._type_string_to_class(reg_type)
            if not isinstance(existing_reg, expected_class):
                raise RegisterTypeConflictError(name, existing_reg, reg_type)

            return existing_reg

        new_reg: Reg_ty

        if reg_type == "32":
            new_reg = Reg32(name)
        elif reg_type == "64":
            new_reg = Reg64(name)
        elif reg_type == "pred":
            new_reg = PredReg(name)
        elif reg_type == "composite":
            resolved_sub_regs = [self.get_or_create(sub_name, "32") for sub_name in sub_regs]
            new_reg = CompositeReg(name, resolved_sub_regs)
        else:
            raise UnknownRegisterTypeError(reg_type)

        self._registry[name] = new_reg
        return new_reg

    def _type_string_to_class(self, t: str):
        if t == "32":
            return Reg32
        if t == "64":
            return Reg64
        if t == "pred":
            return PredReg
        if t == "composite":
            return CompositeReg
        raise UnknownRegisterTypeError(t)

    def clear(self) -> None:
        self._registry.clear()

    def parse_operand(self, token: str) -> RegOrVal_ty:
        if is_range(token):
            prefix = token[0]
            start_idx, end_idx = split_range(token)
            start_idx, end_idx = int(start_idx[1:]), int(end_idx[1:])

            generated_regs: list[Reg_ty] = []
            current_idx = start_idx

            while current_idx <= end_idx:
                reg_name = f"{prefix}{current_idx}"
                sub_reg = self.get_or_create(reg_name, "32")
                generated_regs.append(sub_reg)
                current_idx += 1

            return self.get_or_create(name=token, reg_type="composite", sub_regs=[r.name for r in generated_regs])
        if token in {"exec", "vcc", "scc"}:
            return self.get_or_create(token, "pred")
        if is_reg(token):
            return self.get_or_create(token, "32")
        return Val(token)


class RegisterTypeConflictError(ValueError):
    def __init__(self, name: str, existing_reg: Reg_ty, requested_type: str) -> None:
        super().__init__(
            f"Register '{name}' already exists as {type(existing_reg).__name__}, but was requested as {requested_type}"
        )


class UnknownRegisterTypeError(ValueError):
    def __init__(self, register_type: str) -> None:
        super().__init__(f"Unknown register type: {register_type}")
