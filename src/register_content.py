
from src.register_type import RegisterType


class RegisterContent:
    def __init__(
            self,
            content: any,
            type_: RegisterType,
            size: int,
    ):
        self.content = content
        self.type = type_
        self.size = size


class EmptyRegisterContent(RegisterContent):
    def __init__(self, size: int):
        super().__init__(None, RegisterContentType.EMPTY, size)
