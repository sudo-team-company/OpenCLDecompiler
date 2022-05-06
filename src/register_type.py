from enum import Enum, auto


class RegisterType(Enum):
    UNKNOWN = auto()

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

    KERNEL_ARGUMENT_VALUE = auto()  # x, y, z
    KERNEL_ARGUMENT_PTR = auto()  # __global *data
    ADDRESS_KERNEL_ARGUMENT = auto()  # address data

    PROGRAM_PARAM = auto()

    INT32 = auto()

    WORK_DIM = auto()

    GENERAL_SETUP = auto()
