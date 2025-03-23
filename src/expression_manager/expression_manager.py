from src.model.kernel_argument import KernelArgument
from src.utils.singleton import Singleton
from src.expression_manager.expression_node import *
from src.register_content import RegisterType, CONSTANT_VALUES

class PointerInfo:
    def __init__(self):
        pass

class ExpressionManager(metaclass=Singleton):
    def __init__(self):
        self._nodes = []
        self._variables: dict[str, ExpressionNode] = {}

    def add_node(self, node: ExpressionNode):
        if node is None:
            return
        
        if node.value == 4:
            pass
        print("add_node:", expression_to_string(node))
        self._nodes.append(node)

    def add_operation(self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, value_type_hint: OpenCLTypes):        
        assert(s0 is not None and s1 is not None)
        operation_node = ExpressionNode(ExpressionType.OP, op, value_type_hint)
        operation_node.left = s0
        operation_node.right = s1

        s0.parent = operation_node
        s1.parent = operation_node

        self.add_node(operation_node)
        print("added operation:", expression_to_string(operation_node))
        return operation_node
    
    def add_kernel_argument(self, arg: KernelArgument) -> ExpressionNode:
        if arg.hidden:
            return None
        
        return self.add_variable_node(arg.name, make_opencl_type(arg.type_name))

    def add_register_node(self, reg_type: RegisterType, value):
        if reg_type == RegisterType.UNKNOWN:
            return None
        
        assert(reg_type in CONSTANT_VALUES or reg_type == RegisterType.INT32)
        
        new_node = None

        if reg_type in CONSTANT_VALUES:
            reg_type_name = CONSTANT_VALUES[reg_type][0]
            #we can deduce OpenCLType here, cause it's constant value, but let's set it to UINT for now
            new_node = self.add_const_node(reg_type_name, OpenCLTypes.UINT)
            # new_node = ExpressionNode(ExpressionType.FUNC, reg_type_name, OpenCLTypes.UINT)
        else:
            new_node = self.add_const_node(value, OpenCLTypes.INT)
        
        print("add_register_node:", reg_type, value, "node:", new_node.type, new_node.value_type_hint)
        return new_node
    
    def add_const_node(self, value, value_type_hint : OpenCLTypes):
        #todo: narrow down range?
        const_node = ExpressionNode(ExpressionType.CONST, value, value_type_hint)

        self.add_node(const_node)
        return const_node
        
    def add_variable_node(self, name: str, value_type_hint: OpenCLTypes):
        #todo - check could be better, pointer can have its own modifiers e.g.
        if name[0] == "*":
            var_node_type = ExpressionType.VAR_PTR
            var_node_name = name[1:]
        else:
            var_node_type = ExpressionType.VAR
            var_node_name = name
        
        var_node = ExpressionNode(var_node_type, var_node_name, value_type_hint)

        self._variables[var_node_name] = var_node
        self.add_node(var_node)

        return var_node
