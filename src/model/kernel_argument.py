from dataclasses import dataclass


@dataclass
class KernelArgument:
    type_name: str
    name: str
    offset: int
    size: int
    hidden: bool = False
    const: bool = False

    def __str__(self):
        return f"{self.type_name} {self.name}"

    def is_vector(self) -> bool:
        return len(self.type_name) > 0 and self.type_name[-1].isdigit() and self.name[0] != "*"

    def basic_size(self) -> int:
        return self.size if not self.is_vector() else self.size // int(self.type_name[-1])

    def get_vector_element_by_offset(self, offset: int) -> str:
        assert self.is_vector()
        shift = offset - self.offset
        return self.name + f"___s{shift // self.basic_size()}"
