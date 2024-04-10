from dataclasses import dataclass


@dataclass
class KernelArgument:
    type_name: str
    name: str
    offset: str | None

    def __str__(self):
        return f"{self.type_name} {self.name}"
