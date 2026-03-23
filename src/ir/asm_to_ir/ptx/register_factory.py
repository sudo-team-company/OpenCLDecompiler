from src.ir.registers.reg import Reg64, Reg32, Val, Reg_ty, RegOrVal_ty

class RegFactory:
    def __init__(self):
        self._registry: dict[str, Reg_ty] = {}


    def _create_register(self, reg_name: str) -> RegOrVal_ty:
        if reg_name[0] == "[" and reg_name[-1] == "]":
            reg_name = reg_name[1:-1]
        
        if reg_name.startswith("%rd"):
            return Reg64(reg_name)

        if reg_name.startswith("%r") or reg_name.startswith("%rs"):
            return Reg32(reg_name)

        special_prefixes = ("%tid", "%ctaid", "%ntid", "%envreg")
        if any(reg_name.startswith(p) for p in special_prefixes):
            return Reg32(reg_name)

        return Val(reg_name)

    def get_or_create(self, reg_name: str) -> Reg32 | Reg64:
        if reg_name in self._registry:
            return self._registry[reg_name]

        reg = self._create_register(reg_name)
        self._registry[reg_name] = reg

        return reg


