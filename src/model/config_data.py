from dataclasses import dataclass, field

from src.model.kernel_argument import KernelArgument
from src.register_content import RegisterContent


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: list[int] | None
    local_size: int | None
    arguments: list[KernelArgument]
    offset_to_content: dict[str, RegisterContent] = field(default_factory=dict)
