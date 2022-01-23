from dataclasses import dataclass
from typing import Optional, List, Tuple


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[List[int]]
    local_size: Optional[int]
    params: List[Tuple[str, str]]
