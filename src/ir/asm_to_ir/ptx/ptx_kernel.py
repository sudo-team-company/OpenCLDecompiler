from dataclasses import dataclass, field

@dataclass
class PTXArgument:
    name: str = ''
    size: int = 32
    type_name: str = 'u32'
    is_const: bool = False
    is_pointer: bool = False
    address_space: str | None = None
    alignment: int | None = None

@dataclass
class PTXRegister:
    name: str
    reg_type: str

@dataclass
class PTXKernel:
    name: str
    locals: dict[str, int] = field(default_factory=dict)
    work_group_size: list[int] = field(default_factory=lambda: [1, 1, 1])
    arguments: list[PTXArgument] = field(default_factory=list)
    registers: list[PTXRegister] = field(default_factory=list)
    special_registers: list[str] = field(default_factory=list)
    instructions: list[str] = field(default_factory=list)
