from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.operation_status import OperationStatus
from src.register import Register
from src.register_type import RegisterType


class VMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_print_unresolved:
                decompiler_data.write(vdst + " = " + src0 + " // v_mov_b32\n")
                return node
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(src0) is not None:
                    type_of_data = node.state.registers[src0].type_of_data
                    node.state.registers[vdst] = \
                        Register(node.state.registers[src0].val, node.state.registers[src0].type,
                                 Integrity.entire)
                    node.state.registers[vdst].type_of_data = type_of_data
                else:
                    node.state.registers[vdst] = Register(src0, RegisterType.int32, Integrity.entire)
                decompiler_data.make_version(node.state, vdst)
                if vdst in [src0]:
                    node.state.registers[vdst].make_prev()
                if node.state.registers[vdst].type_of_data is None:
                    node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
