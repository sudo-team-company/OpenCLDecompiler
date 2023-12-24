from typing import Optional

from src.register_type import RegisterType


class RegisterContent:
    def __init__(
            self,
            content: any,
            type_: RegisterType,
            size: int,
            data_type: Optional[str] = None
    ):
        self.content = content
        self.type = type_
        self.size = size
        self.data_type = data_type


class EmptyRegisterContent(RegisterContent):
    def __init__(self, size: int):
        super().__init__(None, RegisterType.UNKNOWN, size)
