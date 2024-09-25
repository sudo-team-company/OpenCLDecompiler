from src.combined_register_content import CombinedRegisterContent
from src.integrity import Integrity
from src.logical_variable import ExecCondition
from src.register import Register
from src.register_content import RegisterContent
from src.register_type import RegisterType


class KernelState:
    def __init__(self):
        self._registers: dict[str, Register] = {}

    def get(self, key: str, default: Register | None = None) -> Register | None:
        return self._registers.get(key, default)

    def __getitem__(self, key: str) -> Register:
        return self._registers[key]

    def __setitem__(self, key: str, value: Register):
        assert isinstance(key, str) and isinstance(value, Register)
        self._registers[key] = value

    def __iter__(self):
        return self._registers.__iter__()

    def __contains__(self, key: str) -> bool:
        return key in self._registers

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
        self[g_id_dim] = Register(
            integrity=Integrity.ENTIRE,
            register_content=RegisterContent(
                value=f"get_group_id({dim})",
                type_=type_g,
            )
        )
        self[g_id_dim].add_version(g_id_dim, version_g_id)

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

        self[v_dim] = Register(
            integrity=Integrity.ENTIRE,
            register_content=register_content
        )
        self[v_dim].add_version(v_dim, version_v)

    def init_exec(self, version):
        self["exec"] = Register(
            integrity=Integrity.ENTIRE,
            exec_condition=ExecCondition.DEFAULT,
            register_content=RegisterContent(
                value=None,
                type_=RegisterType.UNKNOWN,
            ),
        )
        self["exec"].add_version("exec", version)
        self["exec"].exec_condition = ExecCondition.default()
