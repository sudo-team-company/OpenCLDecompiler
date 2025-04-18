import copy
from src.utils.singleton import Singleton
from src.expression_manager.expression_node import *
from src.register_type import RegisterType, CONSTANT_VALUES

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
        assert(node is not None)
        
        if expression_to_string(node) == "get_global_offset(0) + (uint)arg0___s0":
            pass
        assert(node.value_type_hint != OpenCLTypes.UNKNOWN)
        
        print("add_node:", expression_to_string(node))
        self._nodes.append(node)

    #todo: rename
    def add_offset_thingy_node(self, s0: ExpressionNode, s1: ExpressionNode, data_size: int):
        data_size_node = self.add_const_node(data_size, OpenCLTypes.UINT)
        div_node = self.add_operation(s1, data_size_node, ExpressionOperationType.DIV, OpenCLTypes.UINT)
        expr_node = self.add_operation(s0, div_node, ExpressionOperationType.PLUS, OpenCLTypes.UINT)
        
        print("added offset thingy node:", expression_to_string(expr_node))
        return expr_node
    
    def get_empty_op_node(self, op: ExpressionOperationType) -> ExpressionNode:
        node = ExpressionNode()
        node.type = ExpressionType.OP
        node.value = op
        return node

    def add_operation(self, s0: ExpressionNode, s1: ExpressionNode, op: ExpressionOperationType, value_type_hint: OpenCLTypes):        
        assert(s0 is not None and s1 is not None)

        if op == ExpressionOperationType.XOR:
            if s0.type == ExpressionType.UNKNOWN:
                operation_node = ExpressionNode()
                operation_node.type = ExpressionType.OP
                operation_node.value = ExpressionOperationType.NOT
                #todo bool?
                operation_node.value_type_hint = s1.value_type_hint
                operation_node.left = s1
                self.add_node(operation_node)
                return operation_node
            elif s1.type == ExpressionType.UNKNOWN:
                operation_node = ExpressionNode()
                operation_node.type = ExpressionType.OP
                operation_node.value = ExpressionOperationType.NOT
                #todo bool?
                operation_node.value_type_hint = s0.value_type_hint
                operation_node.left = s0
                self.add_node(operation_node)
                return operation_node



        operation_node = ExpressionNode()
        operation_node.type = ExpressionType.OP
        operation_node.value = op

        #todo optimize if one is empty

        #todo find var_ptrs inside
        if s0.type == ExpressionType.VAR_PTR or TypeModifiers.GLOBAL in s0.value_type_hint.value.modifiers:
            #todo limit
            operation_node.value_type_hint = s0.value_type_hint
        elif s1.type == ExpressionType.VAR_PTR or TypeModifiers.GLOBAL in s1.value_type_hint.value.modifiers:
            #todo limit
            operation_node.value_type_hint = s1.value_type_hint
        elif (op == ExpressionOperationType.PLUS or op == ExpressionOperationType.MINUS) and (str(s0.value) == "0" or str(s1.value) == "0"):
            if str(s0.value) == "0":
                operation_node.value_type_hint = s1.value_type_hint
            elif str(s1.value) == "0":
                operation_node.value_type_hint = s0.value_type_hint
        else:
            if value_type_hint == OpenCLTypes.UNKNOWN:
                value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)
            operation_node.value_type_hint = value_type_hint# get_common_type(get_common_type(s0.value_type_hint, s1.value_type_hint), value_type_hint)
        operation_node.left = s0
        operation_node.right = s1

        s0.parent = operation_node
        s1.parent = operation_node

        self.add_node(operation_node)
        print("added operation:", expression_to_string(operation_node))
        return operation_node
    
    def invert_node(self, node: ExpressionNode) -> ExpressionNode:
        print("INVERTING NODE")
        if node.type == ExpressionType.OP and node.value.is_compare_operator():
            tmp = ExpressionNode()
            tmp.type = ExpressionType.OP
            tmp.value = ExpressionOperationType.NOT
            #todo bool?
            tmp.value_type_hint = node.value_type_hint
            tmp.left = node
            self.add_node(tmp)
            return tmp
        else:
            tmp = self.add_const_node(-1, OpenCLTypes.INT)
            return self.add_operation(tmp, node, ExpressionOperationType.MUL, node.value_type_hint)

    def add_kernel_argument(self, arg, offset: int, ignore_duplicate: bool = False) -> ExpressionNode:
        from src.model.kernel_argument import KernelArgument
        arg: KernelArgument = arg
        if arg.hidden:
            for reg_type in CONSTANT_VALUES:
                reg_type_name = CONSTANT_VALUES[reg_type][0]
                if arg.name == reg_type_name:
                    return self.add_register_node(reg_type, arg.name)

            #most likely other stuff is some hidden buffers like e.g. printfbuffer, but need to check that
            return None
        

        name = arg.name if not arg.is_vector() else arg.get_vector_element_by_offset(offset)
        return self.add_variable_node(name, make_opencl_type(arg.type_name), ignore_duplicate)
    
    def get_empty_node(self):
        empty_node = ExpressionNode()
        empty_node.value = "UNKNOWN VALUE"
        return empty_node

    def add_register_node(self, reg_type: RegisterType, value=None) -> ExpressionNode:
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
            assert(value is not None)
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
    
    def add_if_ternary_node(self, cond: ExpressionNode, s0: ExpressionNode, s1: ExpressionNode):
        if_ternary_node = ExpressionNode()
        if_ternary_node.type = ExpressionType.IF_TERNARY
        if_ternary_node.value = cond
        if_ternary_node.left = s0
        if_ternary_node.right = s1
        if_ternary_node.value_type_hint = get_common_type(s0.value_type_hint, s1.value_type_hint)

        s0.parent = if_ternary_node
        s1.parent = if_ternary_node

        self.add_node(if_ternary_node)

        return if_ternary_node

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
    
    #todo rename??
    def add_operations(self, nodes: list[ExpressionNode], op: ExpressionOperationType):
        assert(len(nodes) > 0)

        if len(nodes) == 1:
            return nodes[0]
            
        prev_node = nodes[0]
        for cur_node in nodes[1:]:
            prev_node = self.add_operation(prev_node, cur_node, op, OpenCLTypes.UNKNOWN)
        
        return prev_node
        
    def add_variable_node(self, name: str, value_type_hint: OpenCLTypes, ignore_duplicate: bool = False):
        #todo - check could be better, pointer can have its own modifiers e.g.
        if name[0] == "*":
            var_node_type = ExpressionType.VAR_PTR
            var_node_name = name[1:]
        else:
            var_node_type = ExpressionType.VAR
            var_node_name = name

        if self._variables.get(var_node_name) is not None and not ignore_duplicate:
            return self._variables[var_node_name]
        # "{var}__s{idx}" case
        if name.find("___") != -1 and value_type_hint.value.number_of_components > 1:
            # just to be sure "full" variable is there
            base_name = name[:name.find("___")]
            if self._variables.get(base_name) is None and not ignore_duplicate:
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
                    if node.left is not None:                 
                        node.left = self.replace_given_node_in_node(node.left, from_node, to_node)
                    if node.right is not None:
                        node.right = self.replace_given_node_in_node(node.right, from_node, to_node)
            case ExpressionType.IF_TERNARY:
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
                    if node.value is not None:
                        node.value = self.replace_given_node_in_node(node.value, from_node, to_node)
                    if node.left is not None:                 
                        node.left = self.replace_given_node_in_node(node.left, from_node, to_node)
                    if node.right is not None:
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