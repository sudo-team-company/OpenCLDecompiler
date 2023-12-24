from dataclasses import dataclass
from typing import Optional, List, Tuple, Dict

from src.register_content import RegisterContent


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[List[int]]
    local_size: Optional[int]
    params: List[Tuple[str, str]]
    setup_params_offsets: List[str]
    offset_to_content: Optional[Dict[str, RegisterContent]]=None
