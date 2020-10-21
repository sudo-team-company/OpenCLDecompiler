from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData
from src.integrity import Integrity
from src.register import Register
from src.type_of_reg import Type
from src.operation_status import OperationStatus


class VMov(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "b32":
            vdst = instruction[1]
            src0 = instruction[2]
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers.get(src0) is not None:
                    node.state.registers[vdst] = \
                        Register(node.state.registers[src0].val, node.state.registers[src0].type,
                                 Integrity.integer)
                else:
                    node.state.registers[vdst] = Register(src0, Type.int32, Integrity.integer)
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string
