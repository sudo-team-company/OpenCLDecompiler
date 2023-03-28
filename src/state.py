from src.integrity import Integrity
from src.logical_variable import ExecCondition
from src.register import Register
from src.register_type import RegisterType


class State:
    def __init__(self):
        self.exec_condition = None
        self.registers = \
            {
                "s0": None,
                "s1": None,
                "s2": None,
                "s3": None,
                "s4": None,
                "s5": None,
                "s6": None,
                "s7": None,
                "s8": None,
                "s9": None,
                "s10": None,
                "s11": None,
                "s12": None,
                "s13": None,
                "s14": None,
                "s15": None,
                "s16": None,
                "s17": None,
                "s18": None,
                "s19": None,
                "s20": None,
                "s21": None,
                "s22": None,
                "v0": None,
                "v1": None,
                "v2": None,
                "v3": None,
                "v4": None,
                "v5": None,
                "v6": None,
                "v7": None,
                "v8": None,
                "v9": None,
                "v10": None,
                "v11": None,
                "v12": None,
                "v13": None,
                "v14": None,
                "v15": None,
                "v16": None,
                "v17": None,
                "v18": None,
                "v19": None,
                "v20": None,
                "pc": None,
                "scc": None,
                "vcc": None,
                "exec": None
            }

    def init_work_group(self, dim, g_id_dim, version_g_id, version_v):
        v_dim = "v" + str(dim)
        if dim == 0:
            type_g = RegisterType.WORK_GROUP_ID_X
            type_v = RegisterType.WORK_ITEM_ID_X
        elif dim == 1:
            type_g = RegisterType.WORK_GROUP_ID_Y
            type_v = RegisterType.WORK_ITEM_ID_Y
        else:
            type_g = RegisterType.WORK_GROUP_ID_Z
            type_v = RegisterType.WORK_ITEM_ID_Z
        self.registers[g_id_dim] = Register("get_group_id(" + str(dim) + ")", type_g, Integrity.ENTIRE)
        self.registers[g_id_dim].add_version(g_id_dim, version_g_id)
        self.registers[v_dim] = Register("get_local_id(" + str(dim) + ")", type_v, Integrity.ENTIRE)
        self.registers[v_dim].add_version(v_dim, version_v)

    def init_exec(self, version):
        self.registers["exec"] = Register("0xffffffffffffffff", RegisterType.UNKNOWN, Integrity.ENTIRE)
        self.registers["exec"].add_version("exec", version)
        self.exec_condition = ExecCondition([])