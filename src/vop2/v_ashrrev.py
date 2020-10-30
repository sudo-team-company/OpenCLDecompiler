from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.integrity import Integrity
from src.register import Register
from src.operation_status import OperationStatus
from src.state import find_first_last_num_to_from


class VAshrrev(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        output_string = ""
        if suffix == "i32":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[vdst] = \
                    Register(node.state.registers[src1].val, node.state.registers[src1].type, Integrity.integer)
                # node.state.registers[vdst].version = node.parent[0].state.registers[vdst].version
                node.state.make_version(decompiler_data.versions, vdst)
                if vdst in [src0, src1]:
                    node.state.registers[vdst].make_prev()
                node.state.registers[vdst].type_of_data = suffix
                return node
            return output_string

        elif suffix == "i64":
            vdst = instruction[1]
            src0 = instruction[2]
            src1 = instruction[3]
            first_to, last_to, name_of_to, name_of_from, first_from, last_from \
                = find_first_last_num_to_from(vdst, src1)
            from_registers = name_of_from + str(first_from)
            to_registers = name_of_to + str(first_to)
            if flag_of_status == OperationStatus.to_fill_node:
                if node.state.registers[from_registers].val == "0":
                    node.state.registers[from_registers].val = \
                        node.state.registers[name_of_from + str(first_from + 1)].val
                new_val, src1_flag, src0_flag = make_op(node, from_registers, str(pow(2, int(src0))),
                                                        " / ", '', '(long)')
                node.state.registers[to_registers] = \
                    Register(new_val, node.state.registers[from_registers].type, Integrity.low_part)
                # node.state.registers[to_registers].version = \
                #     node.parent[0].state.registers[to_registers].version
                node.state.make_version(decompiler_data.versions, to_registers)
                node.state.registers[to_registers].type_of_data = suffix
                to_registers_1 = name_of_to + str(last_to)
                node.state.registers[to_registers_1] = \
                    Register(new_val, node.state.registers[from_registers].type, Integrity.high_part)
                # node.state.registers[to_registers_1].version = \
                #     node.parent[0].state.registers[to_registers_1].version
                node.state.make_version(decompiler_data.versions, to_registers_1)
                node.state.registers[to_registers_1].type_of_data = suffix
                return node
            return output_string
