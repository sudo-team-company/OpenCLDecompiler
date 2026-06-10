from __future__ import annotations

from dataclasses import dataclass

from src.decompiler_data import DecompilerData
from src.expression_manager.expression_manager import ExpressionManager
from src.ir.kernel import Kernel
from src.node import Node


@dataclass
class OpenMask:
    change_mask: Node
    previous_branch_end: Node | None = None


@dataclass
class DecompilationState:
    kernel: Kernel
    decompiler_data: DecompilerData
    expression_manager: ExpressionManager
    last_node: Node
    masked_blocks: list[OpenMask]

    @classmethod
    def from_kernel(cls, kernel: Kernel) -> DecompilationState:
        decompiler_data = DecompilerData()
        expression_manager = ExpressionManager()

        decompiler_data.reset(kernel.name)
        expression_manager.reset(kernel.name)
        expression_manager.set_size_of_workgroups(kernel.work_group_size)
        decompiler_data.set_config_data(kernel)

        last_node = Node([""], [], decompiler_data.initial_state)
        decompiler_data.set_cfg(last_node)

        return cls(
            kernel=kernel,
            decompiler_data=decompiler_data,
            expression_manager=expression_manager,
            last_node=last_node,
            masked_blocks=[OpenMask(last_node)],
        )
