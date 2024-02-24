from dataclasses import dataclass
from typing import Optional

from src.register_content import RegisterContent


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[list[int]]
    local_size: Optional[int]
    params: list[tuple[str, str]]
    setup_params_offsets: list[str]
    offset_to_content: Optional[dict[str, RegisterContent]] = None
