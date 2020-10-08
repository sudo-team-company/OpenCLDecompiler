from src.state import State


class Singleton:
    """
    A non-thread-safe helper class to ease implementing singletons.
    This should be used as a decorator -- not a metaclass -- to the
    class that should be a singleton.

    The decorated class can define one `__init__` function that
    takes only the `self` argument. Other than that, there are
    no restrictions that apply to the decorated class.

    To get the singleton instance, use the `Instance` method. Trying
    to use `__call__` will result in a `TypeError` being raised.

    Limitations: The decorated class cannot be inherited from.

    """

    def __init__(self, decorated):
        self._decorated = decorated

    def Instance(self):
        """
        Returns the singleton instance. Upon its first call, it creates a
        new instance of the decorated class and calls its `__init__` method.
        On all subsequent calls, the already created instance is returned.

        """
        try:
            return self._instance
        except AttributeError:
            self._instance = self._decorated()
            return self._instance

    def __call__(self):
        raise TypeError('Singletons must be accessed through `Instance()`.')

    def __instancecheck__(self, inst):
        return isinstance(inst, self._decorated)


@Singleton
class DecompilerData:
    def __init__(self):
        self.output_file = ""
        self.usesetup = False
        self.size_of_work_groups = []
        self.cfg = None
        self.improve_cfg = None
        self.number_of_temp = 0  # versions for asm code if decompilation is not success (версии для ассемблерного кода в случае отсутствия перевода)
        self.number_of_shift = 0
        self.number_of_length = 0
        self.number_of_mask = 0
        self.number_of_cc = 0
        self.number_of_sf0 = 0
        self.number_of_sf1 = 0
        self.number_of_sf2 = 0
        self.number_of_tmp = 0
        self.number_of_v0 = 0
        self.number_of_v1 = 0
        self.number_of_v = 0
        self.number_of_vm = 0
        self.number_of_p = 0
        self.initial_state = State()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
        self.params = {}
        self.to_node = {}  # the label at which the block starts -> node (метка, с которой начинается блок -> вершина)
        self.from_node = {}  # the label the vertex is expecting -> node (метка, которую ожидает вершина -> вершина ("лист ожидания"))
        self.starts_regions = {}  # Node or Region -> Region
        self.ends_regions = {}  # Node or Region -> Region
        self.label = None
        self.parents_of_label = []
        self.flag_of_else = False
        self.version_wait = None
        self.type_params = {}
        self.variables = {}
        self.checked_variables = {}
        self.versions = {
            "s0": 0,
            "s1": 0,
            "s2": 0,
            "s3": 0,
            "s4": 0,
            "s5": 0,
            "s6": 0,
            "s7": 0,
            "s8": 0,
            "s9": 0,
            "s10": 0,
            "s11": 0,
            "s12": 0,
            "s13": 0,
            "s14": 0,
            "s15": 0,
            "s16": 0,
            "s17": 0,
            "s18": 0,
            "s19": 0,
            "s20": 0,
            "s21": 0,
            "s22": 0,
            "v0": 0,
            "v1": 0,
            "v2": 0,
            "v3": 0,
            "v4": 0,
            "v5": 0,
            "v6": 0,
            "v7": 0,
            "v8": 0,
            "v9": 0,
            "v10": 0,
            "v11": 0,
            "v12": 0,
            "v13": 0,
            "v14": 0,
            "v15": 0,
            "v16": 0,
            "v17": 0,
            "v18": 0,
            "v19": 0,
            "v20": 0,
            "pc": 0,
            "scc": 0,
            "vcc": 0,
            "exec": 0
        }
        self.names_of_vars = {}
        self.localsize = 0
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []

    def reset(self, output_file):
        self.output_file = output_file
        self.usesetup = False
        self.size_of_work_groups = []
        self.cfg = None
        self.improve_cfg = None
        self.number_of_temp = 0  # versions for asm code if decompilation is not success (версии для ассемблерного кода в случае отсутствия перевода)
        self.number_of_shift = 0
        self.number_of_length = 0
        self.number_of_mask = 0
        self.number_of_cc = 0
        self.number_of_sf0 = 0
        self.number_of_sf1 = 0
        self.number_of_sf2 = 0
        self.number_of_tmp = 0
        self.number_of_v0 = 0
        self.number_of_v1 = 0
        self.number_of_v = 0
        self.number_of_vm = 0
        self.number_of_p = 0
        self.initial_state = State()  # start state of registers (начальное состояние регистров)
        self.sgprsnum = 0  # number of s registers used by system (количество s регистров, используемых системой)
        self.vgprsnum = 0  # number of v registers used by system (количество v регистров, используемых системой)
        self.params = {}
        self.to_node = {}  # the label at which the block starts -> node (метка, с которой начинается блок -> вершина)
        self.from_node = {}  # the label the vertex is expecting -> node (метка, которую ожидает вершина -> вершина ("лист ожидания"))
        self.starts_regions = {}  # Node or Region -> Region
        self.ends_regions = {}  # Node or Region -> Region
        self.label = None
        self.parents_of_label = []
        self.flag_of_else = False
        self.version_wait = None
        self.type_params = {}
        self.variables = {}
        self.checked_variables = {}
        self.versions = {
            "s0": 0,
            "s1": 0,
            "s2": 0,
            "s3": 0,
            "s4": 0,
            "s5": 0,
            "s6": 0,
            "s7": 0,
            "s8": 0,
            "s9": 0,
            "s10": 0,
            "s11": 0,
            "s12": 0,
            "s13": 0,
            "s14": 0,
            "s15": 0,
            "s16": 0,
            "s17": 0,
            "s18": 0,
            "s19": 0,
            "s20": 0,
            "s21": 0,
            "s22": 0,
            "v0": 0,
            "v1": 0,
            "v2": 0,
            "v3": 0,
            "v4": 0,
            "v5": 0,
            "v6": 0,
            "v7": 0,
            "v8": 0,
            "v9": 0,
            "v10": 0,
            "v11": 0,
            "v12": 0,
            "v13": 0,
            "v14": 0,
            "v15": 0,
            "v16": 0,
            "v17": 0,
            "v18": 0,
            "v19": 0,
            "v20": 0,
            "pc": 0,
            "scc": 0,
            "vcc": 0,
            "exec": 0
        }
        self.names_of_vars = {}
        self.localsize = 0
        self.lds_vars = {}
        self.lds_var_number = 0
        self.num_of_var = 0
        self.num_of_label = 0
        self.wait_labels = []

    def make_op(self, node, register0, register1, operation):
        register0_flag = True
        register1_flag = True
        if register0.find("s") != -1 or register0.find("v") != -1:
            new_val0 = node.state.registers[register0].val
        else:
            new_val0 = register0
            register0_flag = False
        if register1.find("s") != -1 or register1.find("v") != -1:
            new_val1 = node.state.registers[register1].val
        else:
            new_val1 = register1
            register1_flag = False
        if new_val0.find("-") != -1 or new_val0.find("+") != -1 or new_val0.find("*") != -1 or new_val0.find("/") != -1:
            new_val0 = "(" + new_val0 + ")"
        if new_val1.find("-") != -1 or new_val1.find("+") != -1 or new_val1.find("*") != -1 or new_val1.find("/") != -1:
            new_val1 = "(" + new_val1 + ")"
        new_val = new_val0 + operation + new_val1
        return new_val, register0_flag, register1_flag
