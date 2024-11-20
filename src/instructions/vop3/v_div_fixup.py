from src.base_instruction import BaseInstruction


class VDivFixup(BaseInstruction):
    def __init__(self, node, suffix):
        super().__init__(node, suffix)
        self.vdst = self.instruction[1]
        self.src0 = self.instruction[2]
        self.src1 = self.instruction[3]
        self.src2 = self.instruction[4]

    def to_print_unresolved(self):
        tab = "    "
        if self.suffix == "f64":
            sf0 = f"sf0{self.decompiler_data.number_of_sf0}"
            sf1 = f"sf1{self.decompiler_data.number_of_sf1}"
            sf2 = f"sf2{self.decompiler_data.number_of_sf2}"
            self.decompiler_data.write(f"double {sf0} = as_double({self.src0}) // {self.name}\n")
            self.decompiler_data.write(f"double {sf1} = as_double({self.src1})\n")
            self.decompiler_data.write(f"double {sf2} = as_double({self.src2})\n")
            self.decompiler_data.write(f"if (isnan({sf1}) && !isnan({sf2}))\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = nan({sf1})\n")
            self.decompiler_data.write(f"else if (abs({sf2}))\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = nan({sf2})\n")
            self.decompiler_data.write(f"else if ({sf1} == 0.0 && {sf2} == 0.0)\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = NAN\n")
            self.decompiler_data.write(f"else if (abs({sf1}) == INFINITY)\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = -NAN\n")
            self.decompiler_data.write(f"else if ({sf1} == 0.0)\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = INFINITY * sign({sf1}) * sign({sf2})\n")
            self.decompiler_data.write(f"else if (abs({sf1}) == INFINITY)\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = sign({sf1}) * sign({sf2}) >= 0 ? 0.0 : -0.0\n")
            self.decompiler_data.write(f"else if (isnan({sf0}))\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = sign({sf1}) * sign({sf2}) * INFINITY\n")
            self.decompiler_data.write("else\n")
            self.decompiler_data.write(f"{tab}{self.vdst} = {sf0}\n")
            return self.node
        return super().to_print_unresolved()
