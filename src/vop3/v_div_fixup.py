from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData


class VDivFixup(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        tab = "    "
        if suffix == "f64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            src2 = instruction[4]
            sf0 = "sf0" + str(decompiler_data.number_of_sf0)
            sf1 = "sf1" + str(decompiler_data.number_of_sf1)
            sf2 = "sf2" + str(decompiler_data.number_of_sf2)
            decompiler_data.write("double " + sf0 + " = as_double(" + src0 + ")\n")
            decompiler_data.write("double " + sf1 + " = as_double(" + src1 + ")\n")
            decompiler_data.write("double " + sf2 + " = as_double(" + src2 + ")\n")
            decompiler_data.write("if (isnan(" + sf1 + ") && !isnan(" + sf2 + "))\n")
            decompiler_data.write(tab + vdst + " = nan(" + sf1 + ")\n")
            decompiler_data.write("else if (abs(" + sf2 + "))\n")
            decompiler_data.write(tab + vdst + " = nan(" + sf2 + ")\n")
            decompiler_data.write("else if (" + sf1 + " == 0.0 && " + sf2 + " == 0.0)\n")
            decompiler_data.write(tab + vdst + " = NAN\n")
            decompiler_data.write("else if (abs(" + sf1 + ") == INFINITY)\n")
            decompiler_data.write(tab + vdst + " = -NAN\n")
            decompiler_data.write("else if (" + sf1 + " == 0.0)\n")
            decompiler_data.write(tab + vdst + " = INFINITY * sign(" + sf1 + ") * sign(" + sf2 + ")\n")
            decompiler_data.write("else if (abs(" + sf1 + ") == INFINITY)\n")
            decompiler_data.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") >= 0 ? 0.0 : -0.0\n")
            decompiler_data.write("else if (isnan(" + sf0 + "))\n")
            decompiler_data.write(tab + vdst + " = sign(" + sf1 + ") * sign(" + sf2 + ") * INFINITY\n")
            decompiler_data.write("else\n")
            decompiler_data.write(tab + vdst + " = " + sf0 + "\n")
