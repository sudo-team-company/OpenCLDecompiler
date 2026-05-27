from src.ir.registers.reg import CompositeReg, PredReg, Reg32, Reg64, Reg_ty, RegOrVal_ty, Val

PTX_32BIT_REGISTER_PREFIXES = ("%r", "%rs", "%f", "%tid", "%ctaid", "%ntid", "%envreg")


class RegFactory:
    def __init__(self):
        self._registry: dict[str, Reg_ty] = {}

    def _create_register(self, reg_name: str) -> RegOrVal_ty:
        if reg_name[0] == "{" and reg_name[-1] == "}":
            normalized_name = "{" + ", ".join(part.strip() for part in reg_name[1:-1].split(",")) + "}"
            sub_registers = [
                self.get_or_create_auto(part.strip()) for part in reg_name[1:-1].split(",") if part.strip()
            ]
            new_reg: RegOrVal_ty = CompositeReg(normalized_name, sub_registers)
        else:
            if reg_name[0] == "[" and reg_name[-1] == "]":
                reg_name = reg_name[1:-1]

            if reg_name.startswith(("%rd", "%fd")):
                new_reg = Reg64(reg_name)
            elif reg_name.startswith("%p"):
                new_reg = PredReg(reg_name)
            elif reg_name.startswith(PTX_32BIT_REGISTER_PREFIXES):
                new_reg = Reg32(reg_name)
            else:
                new_reg = Val(reg_name)

        return new_reg

    def get_or_create_auto(self, reg_name: str) -> RegOrVal_ty:
        if reg_name in self._registry:
            return self._registry[reg_name]

        reg = self._create_register(reg_name)
        self._registry[reg_name] = reg

        return reg

    def get_or_create(self, reg_name: str, reg_type: str) -> Reg_ty:
        if reg_name in self._registry:
            return self._registry[reg_name]

        if reg_type == "32":
            new_reg = Reg32(reg_name)
        elif reg_type == "64":
            new_reg = Reg64(reg_name)
        elif reg_type in ("pred", "predicate"):
            new_reg = PredReg(reg_name)
        else:
            raise UnknownPtxRegisterTypeError(reg_type)

        self._registry[reg_name] = new_reg

        return new_reg


class UnknownPtxRegisterTypeError(ValueError):
    def __init__(self, reg_type: str) -> None:
        super().__init__(f"Unknown PTX register type: {reg_type}")
