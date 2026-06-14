from src.ir.instructions.common.endpgm import EndPgm
from src.ir.instructions.special.mask import ChangeMask, Unmask
from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState, OpenMask
from src.logical_variable import ExecCondition
from src.node import Node
from src.versions import find_max_and_prev_versions


def _get_exec(node: Node) -> ExecCondition:
    return node.state["$MASK"].exec_condition


def _contains_identity(nodes: list[Node], target: Node) -> bool:
    return any(node is target for node in nodes)


def _connect(parent: Node, child: Node) -> None:
    if parent is child:
        return

    if not _contains_identity(child.parent, parent):
        child.add_parent(parent)

    if not _contains_identity(parent.children, child):
        parent.add_child(child)


def _append_unique_node(nodes: list[Node], node: Node) -> None:
    if not _contains_identity(nodes, node):
        nodes.append(node)


def _find_open_mask_index(
    open_masks: list[OpenMask],
    exec_condition: ExecCondition,
    end: int | None = None,
) -> int | None:
    if end is None:
        end = len(open_masks)

    for index in range(end - 1, -1, -1):
        if _get_exec(open_masks[index].change_mask) == exec_condition:
            return index
    return None


def _add_closed_mask_parent(parents: list[Node], open_mask: OpenMask) -> None:
    if open_mask.previous_branch_end is not None:
        _append_unique_node(parents, open_mask.previous_branch_end)
        return

    _append_unique_node(parents, open_mask.change_mask)


def _close_open_masks(
    open_masks: list[OpenMask],
    exec_condition: ExecCondition,
    parents: list[Node],
) -> None:
    while len(open_masks) > 1 and _get_exec(open_masks[-1].change_mask).is_strict_superset_of(exec_condition):
        open_mask = open_masks.pop()
        _add_closed_mask_parent(parents, open_mask)


class BuildDecompilerCfgPass:
    name = "build-decompiler-cfg"

    def run(self, state: DecompilationState, _context: PassContext) -> None:  # noqa: PLR0912
        decompiler_data = state.decompiler_data
        masked_blocks = state.masked_blocks

        for instruction in state.kernel.instructions.get():
            last_node = state.last_node
            node_state = last_node.state
            parents = [last_node]
            change_mask_transition = None
            else_branch_index = None
            else_parent_index = None
            previous_branch_end = None

            if last_node.instruction == "s_branch":
                parents = []

            if isinstance(instruction, ChangeMask):
                prev_exec_condition = _get_exec(last_node)
                next_exec_condition = decompiler_data.exec_registers[instruction.predicate.name]
                else_parent_condition = prev_exec_condition.negated_sibling_parent(next_exec_condition)

                if next_exec_condition.is_strict_superset_of(prev_exec_condition):
                    change_mask_transition = "enter"
                elif next_exec_condition.is_strict_subset_of(prev_exec_condition):
                    change_mask_transition = "close"
                    _close_open_masks(masked_blocks, next_exec_condition, parents)
                elif else_parent_condition is not None:
                    change_mask_transition = "else"
                    else_branch_index = _find_open_mask_index(masked_blocks, prev_exec_condition)
                    if else_branch_index is not None:
                        previous_branch = masked_blocks[else_branch_index]
                        else_parent_index = _find_open_mask_index(
                            masked_blocks,
                            else_parent_condition,
                            else_branch_index,
                        )
                        if else_parent_index is None:
                            else_parent_index = max(else_branch_index - 1, 0)
                        parents = [previous_branch.change_mask]
                        node_state = previous_branch.change_mask.state
                        previous_branch_end = last_node

            if isinstance(instruction, EndPgm | Unmask):
                _close_open_masks(masked_blocks, ExecCondition.default(), parents)

            state.last_node = instruction.to_fill_node(node_state, parents)
            last_node = state.last_node

            if isinstance(instruction, ChangeMask):
                if change_mask_transition == "enter":
                    masked_blocks.append(OpenMask(last_node))
                elif change_mask_transition == "else" and else_branch_index is not None:
                    if else_parent_index is None:
                        else_parent_index = max(else_branch_index - 1, 0)
                    del masked_blocks[else_parent_index + 1 :]
                    masked_blocks.append(
                        OpenMask(
                            last_node,
                            previous_branch_end,
                        )
                    )

            if len(last_node.parent) > 1:
                find_max_and_prev_versions(last_node)
