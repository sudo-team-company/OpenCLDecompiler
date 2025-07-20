class UnknownTypeExceptionError(Exception):
    pass


class BaseType:
    def __init__(self, size_bytes=0, is_signed=True, is_integer=True, number_of_components=0):  # noqa: FBT002
        self.size_bytes = size_bytes
        self.is_signed = is_signed
        self.is_integer = is_integer
        self.number_of_components = number_of_components

    def get_size(self):
        return int(self.size_bytes) * int(self.number_of_components)

    def __eq__(self, other) -> bool:
        return (
            self.size_bytes == other.size_bytes
            and self.is_signed == other.is_signed
            and self.is_integer == other.is_integer
            and self.number_of_components == other.number_of_components
        )

    def __hash__(self):
        return hash((self.size_bytes, self.is_signed, self.is_integer, self.number_of_components))
