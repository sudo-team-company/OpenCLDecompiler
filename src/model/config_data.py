from dataclasses import dataclass, field

from src.model.kernel_argument import KernelArgument
from src.register_content import RegisterContent
from src.model.preloaded_registers import PreloadedRegs

@dataclass
class ConfigData:
    dimensions: str # по факту не нужен так как мы используем другой подход
    usesetup: bool # убираем (всегда false)
    size_of_work_groups: list[int] | None # много где используется -- НУЖНО
    # используется для локальных массивов, хранит сколько всего занято локальной памяти. нужно для восстановления размеров массивов
    
    arguments: list[KernelArgument] # много где используется -- НУЖНО
    local_size: int = 0
    offset_to_content: dict[str, dict[str, RegisterContent]] = field(default_factory=dict) # заполняется автоматически
    preloaded_reg: PreloadedRegs = None # пофиг это мое, нигде не используется 
    kernel_name: str = ""

