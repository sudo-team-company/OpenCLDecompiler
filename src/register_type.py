from enum import Enum, auto


class RegisterType(Enum):
    UNKNOWN = auto()
    EMPTY = auto()

    GLOBAL_ID_X = auto()
    GLOBAL_ID_Y = auto()
    GLOBAL_ID_Z = auto()

    WORK_GROUP_ID_X = auto()
    WORK_GROUP_ID_Y = auto()
    WORK_GROUP_ID_Z = auto()

    WORK_ITEM_ID_X = auto()
    WORK_ITEM_ID_Y = auto()
    WORK_ITEM_ID_Z = auto()

    GLOBAL_OFFSET_X = auto()
    GLOBAL_OFFSET_Y = auto()
    GLOBAL_OFFSET_Z = auto()

    GLOBAL_DATA_POINTER = auto()

    ARGUMENTS_POINTER = auto()
    DISPATCH_POINTER = auto()

    WORK_GROUP_ID_X_LOCAL_SIZE = auto()
    WORK_GROUP_ID_Y_LOCAL_SIZE = auto()
    WORK_GROUP_ID_Z_LOCAL_SIZE = auto()

    WORK_GROUP_ID_X_LOCAL_SIZE_OFFSET = auto()
    WORK_GROUP_ID_Y_LOCAL_SIZE_OFFSET = auto()
    WORK_GROUP_ID_Z_LOCAL_SIZE_OFFSET = auto()

    WORK_GROUP_ID_X_WORK_ITEM_ID = auto()
    WORK_GROUP_ID_Y_WORK_ITEM_ID = auto()
    WORK_GROUP_ID_Z_WORK_ITEM_ID = auto()

    KERNEL_ARGUMENT_ELEMENT = auto()  # data[id]
    ADDRESS_KERNEL_ARGUMENT_ELEMENT = auto()  # address data[id]

    LOCAL_SIZE_X = auto()
    LOCAL_SIZE_Y = auto()
    LOCAL_SIZE_Z = auto()

    GLOBAL_SIZE_X = auto()
    GLOBAL_SIZE_Y = auto()
    GLOBAL_SIZE_Z = auto()

    NUM_GROUPS_X = auto()
    NUM_GROUPS_Y = auto()
    NUM_GROUPS_Z = auto()

    KERNEL_ARGUMENT_VALUE = auto()  # x, y, z
    KERNEL_ARGUMENT_PTR = auto()  # __global *data
    ADDRESS_KERNEL_ARGUMENT = auto()  # address data

    PROGRAM_PARAM = auto()

    INT32 = auto()

    WORK_DIM = auto()

    GENERAL_SETUP = auto()

    DIVISION_RECIPROCAL = auto()
    DIVISION_PT2 = auto()
    DIVISION_PT3 = auto()
    DIVISION_PT4 = auto()
    DIVISION_PT5 = auto()
    DIVISION_PT6 = auto()
    DIVISION_PT7 = auto()
    DIVISION_PT8 = auto()
    DIVISION_PT9 = auto()
    DIVISION_PT10 = auto()
    DIVISION_PASS = auto()


class RegisterSignType(Enum):
    POSITIVE = 0
    NEGATIVE = 1

    def __invert__(self):
        if self.value == 0:
            return RegisterSignType.NEGATIVE
        if self.value == 1:
            return RegisterSignType.POSITIVE
        raise ValueError


# Data for known register values
CONSTANT_VALUES: dict[RegisterType, tuple[str, int, str, RegisterSignType]] = {
    RegisterType.WORK_DIM: ("get_work_dim()", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_X: ("get_global_size(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_Y: ("get_global_size(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_SIZE_Z: ("get_global_size(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_X: ("get_global_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_Y: ("get_global_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_ID_Z: ("get_global_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_X: ("get_local_size(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_Y: ("get_local_size(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.LOCAL_SIZE_Z: ("get_local_size(2)", 32, "u32", RegisterSignType.POSITIVE),
    # u32 get_enqueued_local_size(0)
    # u32 get_enqueued_local_size(1)
    # u32 get_enqueued_local_size(2)
    RegisterType.WORK_ITEM_ID_X: ("get_local_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_ITEM_ID_Y: ("get_local_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_ITEM_ID_Z: ("get_local_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_X: ("get_num_groups(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_Y: ("get_num_groups(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.NUM_GROUPS_Z: ("get_num_groups(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_X: ("get_group_id(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_Y: ("get_group_id(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.WORK_GROUP_ID_Z: ("get_group_id(2)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_X: ("get_global_offset(0)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_Y: ("get_global_offset(1)", 32, "u32", RegisterSignType.POSITIVE),
    RegisterType.GLOBAL_OFFSET_Z: ("get_global_offset(2)", 32, "u32", RegisterSignType.POSITIVE),
    # u32 get_global_linear_id()
    # u32 get_local_linear_id()
    # u32 get_sub_group_size()
    # u32 get_max_sub_group_size()
    # u32 get_num_sub_groups()
    # u32 get_enqueued_num_sub_groups()
    # u32 get_sub_group_id()
    # u32 get_sub_group_local_id()
}
