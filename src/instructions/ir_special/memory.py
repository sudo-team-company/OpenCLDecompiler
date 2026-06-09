from src.base_instruction import BaseInstruction
from src.kernel_params import process_arg
from src.model.config_data import KernelArgument
from src.opencl_types import evaluate_size, make_asm_type


class MemoryAllocation(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.operands[0]

        self.decompiler_data.init_ptr(self.node.state, dest)
        return self.node


class StoreInMem(BaseInstruction):
    def to_fill_node(self):
        # self.node.instruction "store"
        # self.node.operands[0] destination
        # self.node.operands[1] arg_type
        # self.node.operands[2] arg_name
        # self.node.operands[3] offset
        from_registers = self.node.operands[0].name
        type_name = self.node.operands[1].value
        arg_name = self.node.operands[2].value
        offset = self.node.operands[3].value

        self.decompiler_data.type_params[arg_name] = type_name
        arguments = self.decompiler_data.config_data.arguments
        found_arg = next((arg for arg in arguments if arg.name == arg_name), None)
        ka = KernelArgument(
            type_name=type_name,
            name=arg_name,
            offset=int(offset),
            size=8 if arg_name.startswith("*") else evaluate_size(make_asm_type(type_name))[0],
            hidden=False,
            const=found_arg.const if found_arg else False,
        )

        if not ka.is_vector():
            process_arg(ka.offset, ka, from_registers)
        else:
            for shift in range(0, ka.size, ka.basic_size()):
                process_arg(ka.offset + shift, ka, from_registers)
        return self.node
