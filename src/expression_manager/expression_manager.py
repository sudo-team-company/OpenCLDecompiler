import copy
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
        self._variables_value: dict[str, ExpressionNode] = {}

    def reset(self):
        self._nodes = []
        self._variables: dict[str, ExpressionNode] = {}
        self._variables_value: dict[str, ExpressionNode] = {}

    def add_node(self, node: ExpressionNode):
        if node is None:
            return
        
        if node.value == "edges1":
            pass
        
        print("add_node:", expression_to_string(node))
        self._nodes.append(node)

    #todo: rename
    def add_offset_thingy_node(self, s0: ExpressionNode, s1: ExpressionNode, data_size: int):
        data_size_node = self.add_const_node(data_size, OpenCLTypes.UINT)
        div_node = self.add_operation(s1, data_size_node, ExpressionOperationType.DIV, OpenCLTypes.UINT)
        expr_node = self.add_operation(s0, div_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT)
        
        print("added offset thingy node:", expression_to_string(expr_node))
        return expr_node

    def add_operation(self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, value_type_hint: OpenCLTypes):        
        assert(s0 is not None and s1 is not None)
        operation_node = ExpressionNode()
        operation_node.type = ExpressionType.OP
        operation_node.value = op

        #todo optimize if one is empty

        #todo find var_ptrs inside
        if s0.type == ExpressionType.VAR_PTR or TypeModifiers.GLOBAL in s0.value_type_hint.value.modifiers:
            #todo limit
            operation_node.value_type_hint = s0.value_type_hint
        else:
            operation_node.value_type_hint = get_common_type(get_common_type(s0.value_type_hint, s1.value_type_hint), value_type_hint)
        operation_node.left = s0
        operation_node.right = s1

        s0.parent = operation_node
        s1.parent = operation_node

        self.add_node(operation_node)
        print("added operation:", expression_to_string(operation_node))
        return operation_node

    def add_kernel_argument(self, arg: KernelArgument, offset: int) -> ExpressionNode:
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            #most likely other stuff is some hidden buffers like e.g. printfbuffer, but need to check that
            return None
        

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)        
        return self.add_variable_node(name, make_opencl_type(arg.type_name))
    
    def get_empty_node(self):
        empty_node = ExpressionNode()
        empty_node.value = "UNKNOWN VALUE"
        return empty_node

    def add_register_node(self, reg_type: RegisterType, value) -> ExpressionNode:
        if reg_type == RegisterType.UNKNOWN:
            return None
        
        # special cases
        if reg_type == RegisterType.WORK_GROUP_ID_X_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_X, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_X, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
        elif reg_type == RegisterType.WORK_GROUP_ID_Y_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_Y, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_Y, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
        elif reg_type == RegisterType.WORK_GROUP_ID_Z_LOCAL_SIZE:
            left_node = self.add_register_node(RegisterType.WORK_GROUP_ID_Z, "")
            right_node = self.add_register_node(RegisterType.LOCAL_SIZE_Z, "")
            return self.add_operation(left_node, right_node, ExpressionOperationType.MUL, OpenCLTypes.UINT)
        
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
        const_node = ExpressionNode()
        const_node.type = ExpressionType.CONST
        const_node.value = value
        const_node.value_type_hint = value_type_hint

        self.add_node(const_node)
        return const_node
    
    def add_permute_node(self, s0: ExpressionNode, s1: ExpressionNode) -> ExpressionNode:
        assert(s0 and s1 and s0.type == ExpressionType.VAR and s1.type == ExpressionType.VAR)
        permute_node = ExpressionNode()
        permute_node.type = ExpressionType.PERMUTE
        permute_node.left = s0
        permute_node.right = s1

        s0.parent = permute_node
        s1.parent = permute_node

        #todo double check that
        new_value_type_hint = copy.deepcopy(get_common_type(s0.value_type_hint, s1.value_type_hint).value)
        new_value_type_hint.number_of_components = s0.value_type_hint.value.number_of_components + s1.value_type_hint.value.number_of_components
        permute_node.value_type_hint = make_opencl_type(str(new_value_type_hint))

        self.add_node(permute_node)

        return permute_node
        
    def add_variable_node(self, name: str, value_type_hint: OpenCLTypes):
        #todo - check could be better, pointer can have its own modifiers e.g.
        if name[0] == "*":
            var_node_type = ExpressionType.VAR_PTR
            var_node_name = name[1:]
        else:
            var_node_type = ExpressionType.VAR
            var_node_name = name

        if self._variables.get(var_node_name) is not None:
            return self._variables[var_node_name]
        # "{var}__s{idx}" case
        if name.find("___") != -1 and value_type_hint.value.number_of_components > 1:
            # just to be sure "full" variable is there
            base_name = name[:name.find("___")]
            if self._variables.get(base_name) is None:
                self.add_variable_node(base_name, value_type_hint)

            new_value_type_hint = copy.deepcopy(value_type_hint.value)
            new_value_type_hint.number_of_components = 1
            value_type_hint = make_opencl_type(str(new_value_type_hint))


        var_node = ExpressionNode()
        var_node.type = var_node_type
        var_node.value = var_node_name
        var_node.value_type_hint = value_type_hint

        self._variables[var_node_name] = var_node
        self.add_node(var_node)

        return var_node
    
    def replace_given_node_in_node(self, node: ExpressionNode, from_node: ExpressionNode, to_node: ExpressionNode) -> ExpressionNode:
        assert(node is not None and from_node is not None and to_node is not None)
        print("node:", expression_to_string(node))
        print("from_node:", expression_to_string(from_node))
        print("to_node:", expression_to_string(to_node))
        match node.type:
            case ExpressionType.OP:
                if node == from_node:
                    if node.parent is not None:
                        if node == node.parent.left:
                            node.parent.left = to_node
                        elif node == node.parent.right:
                            node.parent.right = to_node
                        else:
                            #todo delete it
                            assert(False)
                    
                    to_node.parent = node.parent
                    node = to_node
                else:                    
                    node.left = self.replace_given_node_in_node(node.left, from_node, to_node)
                    node.right = self.replace_given_node_in_node(node.right, from_node, to_node)
            case _:
                if node == from_node:
                    if node.parent is not None:
                        if node == node.parent.left:
                            node.parent.left = to_node
                        elif node == node.parent.right:
                            node.parent.right = to_node
                        else:
                            #todo delete it
                            assert(False)
                    
                    to_node.parent = node.parent
                    node = to_node

        return node