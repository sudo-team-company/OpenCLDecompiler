from dataclasses import dataclass, field
from typing import Optional

from .kernel_argument import KernelArgument
from src.register_content import RegisterContent


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[list[int]]
    local_size: Optional[int]
    arguments: list[KernelArgument]
    offset_to_content: dict[str, RegisterContent] = field(default_factory=dict)
