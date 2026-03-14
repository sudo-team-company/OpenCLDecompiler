from src.base_instruction import BaseInstruction
from src.kernel_params import process_arg
from src.model.config_data import KernelArgument
from src.opencl_types import evaluate_size, make_asm_type
import src.register 

class MemoryAllocation(BaseInstruction):
    def to_fill_node(self):
        dest = self.node.instruction[1]
        lp, hp = src.register.split_range(dest)

        # TODO на данный момент работаем только с указателем на ARGUMENTS_POINTER
        # нужен еще RegisterType.DISPATCH_POINTER
        self.decompiler_data.init_ptr(self.node.state, lp, hp)
        return self.node
    

class StoreInMem(BaseInstruction):
    def to_fill_node(self):
        # self.node.instruction[0] "store"
        # self.node.instruction[1] destination
        # self.node.instruction[2] arg_type
        # self.node.instruction[3] arg_name
        # self.node.instruction[4] offset
        arg_name = self.node.instruction[3]
        type_name = self.node.instruction[2]
        # TODO тут надо определять что мы загружаем, но так как у нас есть только загрузка аргументов то пофиг 
        self.decompiler_data.type_params[arg_name] = type_name
        arguments = self.decompiler_data.config_data.arguments
        found_arg = next((arg for arg in arguments if arg.name == arg_name), None)
        ka = KernelArgument(
            type_name,
            arg_name,
            int(self.node.instruction[4]),
            8 if arg_name.startswith("*") else evaluate_size(make_asm_type(type_name))[0],
            False,
            found_arg.const if found_arg else False #TODO тут по факту надо определять конст не конст
            )
            

        if not ka.is_vector():
            process_arg(ka.offset, ka)
        else:
            for shift in range(0, ka.size, ka.basic_size()):
                process_arg(ka.offset + shift, ka)
        return self.node