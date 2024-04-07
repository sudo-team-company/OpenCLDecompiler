from dataclasses import dataclass


@dataclass
class KernelArgument:
    type_name: str
    name: str
    offset: str | None
