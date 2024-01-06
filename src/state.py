from typing import Optional

from src.combined_register_content import CombinedRegisterContent
from src.integrity import Integrity
from src.logical_variable import ExecCondition
from src.register import Register
from src.register_content import RegisterContent
from src.register_type import RegisterType


class State:
    def __init__(self):
        self.registers: dict[str, Optional[Register]] = \
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

    def init_work_group(self, dim, g_id_dim, version_g_id, version_v, is_rdna3: bool):
        v_dim = "v" + str(dim)
        if is_rdna3:
            v_dim = "v0"
        if dim == 0:
            type_g = RegisterType.WORK_GROUP_ID_X
            if not is_rdna3:
                type_v = RegisterType.WORK_ITEM_ID_X
        elif dim == 1:
            type_g = RegisterType.WORK_GROUP_ID_Y
            if not is_rdna3:
                type_v = RegisterType.WORK_ITEM_ID_Y
        else:
            type_g = RegisterType.WORK_GROUP_ID_Z
            if not is_rdna3:
                type_v = RegisterType.WORK_ITEM_ID_Z
        self.registers[g_id_dim] = Register(
            integrity=Integrity.ENTIRE,
            register_content=RegisterContent(
                value=f"get_group_id({dim})",
                type_=type_g,
            )
        )
        self.registers[g_id_dim].add_version(g_id_dim, version_g_id)

        if is_rdna3:
            register_content = CombinedRegisterContent(
                register_contents=[
                    RegisterContent(
                        value="get_local_id(0)",
                        type_=RegisterType.WORK_ITEM_ID_X,
                        size=10,
                    ),
                    RegisterContent(
                        value="get_local_id(1)",
                        type_=RegisterType.WORK_ITEM_ID_Y,
                        size=10,
                    ),
                    RegisterContent(
                        value="get_local_id(2)",
                        type_=RegisterType.WORK_ITEM_ID_Z,
                        size=10,
                    ),
                ]
            )
        else:
            register_content = RegisterContent(
                value=f"get_local_id({dim})",
                type_=type_v,
            )

        self.registers[v_dim] = Register(
            integrity=Integrity.ENTIRE,
            register_content=register_content
        )
        self.registers[v_dim].add_version(v_dim, version_v)

    def init_exec(self, version):
        self.registers["exec"] = Register(
            integrity=Integrity.ENTIRE,
            exec_condition=ExecCondition.DEFAULT,
            register_content=RegisterContent(
                value=None,
                type_=RegisterType.UNKNOWN,
            ),
        )
        self.registers["exec"].add_version("exec", version)
        self.registers["exec"].exec_condition = ExecCondition.default()
