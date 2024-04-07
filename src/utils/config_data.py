from dataclasses import dataclass
from typing import Optional

from src.register_content import RegisterContent
from .kernel_argument import KernelArgument


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[list[int]]
    local_size: Optional[int]
    arguments: list[KernelArgument]
    setup_params_offsets: list[str]
    offset_to_content: Optional[dict[str, RegisterContent]] = None
