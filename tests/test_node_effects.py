from collections.abc import Iterator
from contextlib import contextmanager
from pathlib import Path

import pytest

from src.decompiler_data import DecompilerData
from src.flag_type import FlagType
from src.ir.asm_to_ir.amd.asm_to_ir import text_to_ir
from src.ir.asm_to_ir.amd.register_factory import RegFactory
from src.ir.passes.base import PassContext, PassPipeline
from src.ir.passes.decompilation import BuildDecompilerCfgPass, KernelToDecompilerPipelineAdaptor
from src.ir.passes.pipelines import COMMON_KERNEL_LOWERING_PIPELINE
from src.ir.registers.reg import Val
from src.ir.temporary_variable_allocator import TemporaryVariableAllocator
from src.kernel_parser import parse_kernel
from src.node import Node
from src.node_effects import NodeEffects

TESTS_PATH = Path(__file__).parent


@contextmanager
def isolated_temporary_names() -> Iterator[None]:
    """Number temporary registers from zero and leave the global counters as they were.

    The counters are shared by the whole test session, so shifting them could change other tests.
    """
    saved = dict(TemporaryVariableAllocator._counters)  # noqa: SLF001
    TemporaryVariableAllocator.reset()
    try:
        yield
    finally:
        TemporaryVariableAllocator.reset()
        TemporaryVariableAllocator._counters.update(saved)  # noqa: SLF001


def build_cfg(asm: Path) -> list[Node]:
    """Lower the first kernel of ``asm`` to decompiler nodes and return them (breadth-first from the root)."""
    decompiler_data = DecompilerData()
    decompiler_data.flag_for_decompilation = FlagType("AUTO_DECOMPILATION")
    with isolated_temporary_names():
        functions_data, decompiler_data.gpu = parse_kernel(asm.read_text(encoding="utf-8").splitlines())
        name, config, text, global_data_bytes, global_data_instructions = next(iter(functions_data))
        config.kernel_name = name
        kernel = text_to_ir(text, config, global_data_bytes, global_data_instructions)

        decompilation = PassPipeline.named("cfg-only", [BuildDecompilerCfgPass()])
        PassPipeline.named(
            "test-cfg", [COMMON_KERNEL_LOWERING_PIPELINE, KernelToDecompilerPipelineAdaptor(decompilation)]
        ).run(kernel, PassContext())

    nodes: list[Node] = []
    seen: set[int] = set()
    queue = [decompiler_data.cfg]
    while queue:
        node = queue.pop(0)
        if id(node) in seen:
            continue
        seen.add(id(node))
        nodes.append(node)
        queue.extend(child for child in node.children if isinstance(child, Node))
    return nodes


def by_instruction(nodes: list[Node], instruction: str) -> list[Node]:
    return [node for node in nodes if node.instruction == instruction]


def test_from_operands_expands_register_ranges():
    rf = RegFactory()
    effects = NodeEffects.from_operands([rf.parse_operand("v[2:3]"), rf.parse_operand("v[0:1]"), Val("4")])

    assert effects.writes == {"v2", "v3"}
    assert effects.reads == {"v0", "v1"}
    assert not effects.has_side_effects


def test_from_operands_without_destination():
    rf = RegFactory()
    effects = NodeEffects.from_operands(
        [rf.parse_operand("v[0:1]"), rf.parse_operand("v5")], writes_first_operand=False, has_side_effects=True
    )

    assert effects.writes == frozenset()
    assert effects.reads == {"v0", "v1", "v5"}
    assert effects.has_side_effects


@pytest.fixture(scope="module")
def if_else_nodes() -> list[Node]:
    return build_cfg(TESTS_PATH / "branching_kernels" / "if_else_1_label" / "if_else_1_label.asm")


@pytest.fixture(scope="module")
def local_memory_nodes() -> list[Node]:
    return build_cfg(TESTS_PATH / "local_memory_kernels" / "barrier_1" / "barrier_1.asm")


def test_every_lowered_node_has_effects(if_else_nodes):
    root, *lowered = if_else_nodes
    assert root.effects is None
    assert all(node.effects is not None for node in lowered)


def test_store_reads_address_and_value(if_else_nodes):
    stores = by_instruction(if_else_nodes, "flat_store_dword")
    assert stores
    for store in stores:
        assert store.effects.writes == frozenset()
        assert store.effects.has_side_effects
    # store:b32 v[0:1], v6
    assert any(store.effects.reads == {"v0", "v1", "v6"} for store in stores)


def test_arithmetic_writes_destination_only(if_else_nodes):
    # mul:u32 v6, v0, s1 (the else branch)
    (mul,) = [node for node in by_instruction(if_else_nodes, "v_mul_lo_i32") if node.effects.writes == {"v6"}]
    assert mul.effects.reads == {"v0", "s1"}
    assert not mul.effects.has_side_effects


def test_control_flow_and_masks(if_else_nodes):
    (label,) = by_instruction(if_else_nodes, ".L112_0")
    assert label.effects.is_control_flow

    masks = by_instruction(if_else_nodes, "change_mask")
    assert masks
    assert all(mask.effects.has_side_effects for mask in masks)


def test_argument_store_reads_arguments_pointer(if_else_nodes):
    stores = by_instruction(if_else_nodes, "s_store")
    assert stores
    for store in stores:
        assert store.effects.writes == frozenset()
        assert {"s4", "s5"} <= store.effects.reads
        assert store.effects.has_side_effects


def test_split_instruction_gets_effects_per_node(local_memory_nodes):
    """``cvt32to64:u64_u32 index, v2`` is lowered to ``s_mov index.lo, v2`` and ``s_mov index.hi, 0``."""
    low = next(
        node for node in by_instruction(local_memory_nodes, "s_mov_b32") if node.effects.writes == {"__tmp_index_0|lo"}
    )
    assert low.effects.reads == {"v2"}

    (high,) = low.children
    assert high.instruction == "s_mov_b32"
    assert high.effects.writes == {"__tmp_index_0|hi"}
    assert high.effects.reads == frozenset()


def test_local_store_does_not_write_address(local_memory_nodes):
    local_stores = by_instruction(local_memory_nodes, "ds_write_b32")
    assert local_stores
    for store in local_stores:
        assert store.effects.writes == frozenset()
        assert store.effects.has_side_effects
        assert any(name.startswith("__tmp_address_") for name in store.effects.reads)
