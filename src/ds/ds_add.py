from src.base_instruction import BaseInstruction
from src.decompiler_data import DecompilerData, make_op
from src.operation_status import OperationStatus
from src.versions import make_version


class DsAdd(BaseInstruction):
    def execute(self, node, instruction, flag_of_status, suffix):
        decompiler_data = DecompilerData()
        if suffix == "u32":
            addr = instruction[1]
            vdata0 = instruction[2]
            offset = int(instruction[3][7:]) if len(instruction) == 4 else 0
            new_value, src0_flag, src1_flag = make_op(node, addr, "4", " / ", '', '')
            name = decompiler_data.lds_vars[offset][0] + "[" + new_value + "]"
            if flag_of_status == OperationStatus.to_fill_node:
                node.state.registers[name].val = \
                    node.state.registers[name].val + " + " + node.state.registers[vdata0].val
                make_version(node.state, decompiler_data.versions, name)
                node.state.registers[name].type_of_data = suffix
                return node
            output_string = name + " += " + node.state.registers[vdata0].val
            return output_string
