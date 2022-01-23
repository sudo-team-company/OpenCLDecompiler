from dataclasses import dataclass
from typing import Optional, List, Tuple


@dataclass
class ConfigData:
    dimensions: str
    usesetup: bool
    size_of_work_groups: Optional[List[int]]
    local_size: Optional[int]
    params: List[Tuple[str, str]]

    def get_function_definition(self, name_of_program: str) -> str:
        definition: str = "__kernel "

        if self.size_of_work_groups:
            size_of_work_groups = ", ".join(map(str, self.size_of_work_groups))
            definition += f"__attribute__((reqd_work_group_size({size_of_work_groups})))\n"

        params = ", ".join([f"{ptype} {pname}" for ptype, pname in self.params])
        definition += f"void {name_of_program}({params})\n"

        return definition
