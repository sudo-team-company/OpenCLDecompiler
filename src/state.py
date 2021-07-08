from src.integrity import Integrity
from src.register import Register
from src.register_type import RegisterType


class State:
    def __init__(self):
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
            type_g = RegisterType.work_group_id_x
            type_v = RegisterType.work_item_id_x
        elif dim == 1:
            type_g = RegisterType.work_group_id_y
            type_v = RegisterType.work_item_id_y
        else:
            type_g = RegisterType.work_group_id_z
            type_v = RegisterType.work_item_id_z
        self.registers[g_id_dim] = Register("get_group_id(" + str(dim) + ")", type_g, Integrity.entire)
        self.registers[g_id_dim].add_version(g_id_dim, version_g_id)
        self.registers[v_dim] = Register("get_local_id(" + str(dim) + ")", type_v, Integrity.entire)
        self.registers[v_dim].add_version(v_dim, version_v)
