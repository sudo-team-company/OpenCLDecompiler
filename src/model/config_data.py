from dataclasses import dataclass, field

from src.model.kernel_argument import KernelArgument
from src.register_content import RegisterContent


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: list[int] | None

    arguments: list[KernelArgument]
    local_size: int = 0
    offset_to_content: dict[str, dict[str, RegisterContent]] = field(default_factory=dict)
    kernel_name: str = ""
