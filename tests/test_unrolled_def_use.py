from src.ir.asm_to_ir.amd.register_factory import RegFactory
from src.ir.registers.reg import Val
from src.node import Node
from src.node_effects import NodeEffects
from src.region_type import RegionType
from src.regions.region import Region
from src.unrolled_loops_processing import (
    LoopShape,
    analyse_loop,
    build_def_use_graph,
    build_register_usages_table,
    is_well_formed,
)


def chain(*nodes: Node) -> Region:
    """A linear region: an empty start node followed by ``nodes``."""
    start = Node("", [], {})
    prev = start
    for node in nodes:
        prev.add_child(node)
        node.add_parent(prev)
        prev = node
    region = Region(RegionType.LINEAR, start)
    region.end = prev
    return region


def node(instruction: str, *operands: str, effects: NodeEffects | None = None) -> Node:
    rf = RegFactory()
    parsed = [rf.parse_operand(op) if op[0] in "sv" else Val(op) for op in operands]
    result = Node(instruction, parsed, {})
    result.effects = effects if effects is not None else NodeEffects.from_operands(parsed)
    return result


def edges(region: Region) -> set[tuple[int, int]]:
    return {(vertex.num, child) for vertex in build_def_use_graph(region) for child in vertex.child}


def store(*operands: str) -> Node:
    rf = RegFactory()
    parsed = [rf.parse_operand(op) for op in operands]
    effects = NodeEffects.from_operands(parsed, writes_first_operand=False, has_side_effects=True)
    return node("flat_store_dword", *operands, effects=effects)


def test_read_of_register_range_links_to_writers_of_its_parts():
    region = chain(
        node("v_add_u32", "v0", "s2", "v0"),
        node("v_addc_u32", "v1", "v1", "v3"),
        node("v_mov_b32", "v6", "s0"),
        store("v[0:1]", "v6"),
    )

    assert edges(region) == {(0, 3), (1, 3), (2, 3)}


def test_write_of_register_range_defines_its_parts():
    region = chain(
        node("v_lshlrev_b64", "v[0:1]", "2", "v[0:1]"),
        node("v_add_u32", "v0", "s2", "v0"),
        node("v_addc_u32", "v1", "v1", "v3"),
    )

    assert edges(region) == {(0, 1), (0, 2)}


def test_store_does_not_define_its_address():
    region = chain(
        node("v_add_u32", "v0", "s2", "v0"),
        store("v[0:1]", "v6"),
        node("v_mov_b32", "v7", "v0"),
    )

    # v7 reads v0 written by the add, not by the store
    assert edges(region) == {(0, 1), (0, 2)}


def test_first_instruction_is_a_writer_too():
    region = chain(
        node("v_mov_b32", "v0", "s0"),
        node("v_add_u32", "v1", "v0", "1"),
    )

    assert edges(region) == {(0, 1)}


def iterations_of(body, count: int = 3, after: str = "v2") -> tuple[list, list[list[int]]]:
    """``count`` copies of ``body(k)`` followed by a node reading ``after``; returns the vertices and the iterations."""
    copies = [body(k) for k in range(count)]
    region = chain(*(n for copy in copies for n in copy), node("v_mov_b32", "v9", after))
    size = len(copies[0])
    return build_def_use_graph(region), [list(range(k * size, (k + 1) * size)) for k in range(count)]


def acc_times_x_plus_k(k: int, temporary: str = "v3", acc: str = "v2", next_acc: str = "v2") -> list[Node]:
    """``tmp = acc * x; acc' = tmp + k``."""
    return [node("v_mul_lo_u32", temporary, acc, "s0"), node("v_add_u32", next_acc, str(k), temporary)]


def test_loop_carried_value_is_found_by_data_flow():
    vertices, iterations = iterations_of(acc_times_x_plus_k)

    assert analyse_loop(vertices, iterations) == LoopShape(carried_position=1, carried=["v2"] * 3, initial="v2")


def test_temporaries_may_have_different_names():
    vertices, iterations = iterations_of(lambda k: acc_times_x_plus_k(k, temporary=f"v{3 + k % 2}"), count=4)

    assert analyse_loop(vertices, iterations) == LoopShape(carried_position=1, carried=["v2"] * 4, initial="v2")
    # the temporary is matched by data flow, only the constant changes between iterations
    table = build_register_usages_table(vertices, iterations)
    assert [column for column in table if len(set(column)) > 1] == [["0", "1", "2", "3"]]
    assert is_well_formed(vertices, iterations)


def test_loop_carried_value_may_rotate_between_registers():
    accs = ["v2", "v5", "v2", "v5"]
    vertices, iterations = iterations_of(lambda k: acc_times_x_plus_k(k, acc=accs[k], next_acc=accs[k + 1]), after="v5")

    assert analyse_loop(vertices, iterations) == LoopShape(carried_position=1, carried=["v5", "v2", "v5"], initial="v2")


def test_value_of_a_middle_iteration_used_after_the_loop_is_not_folded():
    accs = ["v2", "v5", "v2", "v5"]
    # v2 after the loop is the value of the second iteration, not the final one
    vertices, iterations = iterations_of(lambda k: acc_times_x_plus_k(k, acc=accs[k], next_acc=accs[k + 1]), after="v2")

    assert analyse_loop(vertices, iterations) is None


def test_different_invariants_are_not_folded():
    def body(k: int) -> list[Node]:
        return [node("v_mul_lo_u32", "v3", "v2", f"s{k % 2}"), node("v_add_u32", "v2", "1", "v3")]

    vertices, iterations = iterations_of(body, count=4)

    assert analyse_loop(vertices, iterations) is None


def test_two_loop_carried_values_are_not_folded_yet():
    def body(_: int) -> list[Node]:
        return [node("v_mul_lo_u32", "v2", "v2", "s0"), node("v_add_u32", "v3", "1", "v3")]

    vertices, iterations = iterations_of(body)

    assert analyse_loop(vertices, iterations) is None


def test_temporary_used_after_the_loop_is_not_folded():
    vertices, iterations = iterations_of(acc_times_x_plus_k, after="v3")

    assert analyse_loop(vertices, iterations) is None


def test_iterations_without_side_effects_can_be_folded():
    vertices, iterations = iterations_of(
        lambda _: [node("v_mul_lo_u32", "v2", "v2", "s0"), node("v_add_u32", "v2", "1", "v2")]
    )

    assert is_well_formed(vertices, iterations)


def test_iterations_with_a_store_are_not_folded():
    vertices, iterations = iterations_of(
        lambda _: [node("v_mul_lo_u32", "v2", "v2", "s0"), store("v[0:1]", "v2"), node("v_add_u32", "v2", "1", "v2")]
    )

    # the data flow is fine, only the side effect prevents folding
    assert analyse_loop(vertices, iterations) is not None
    assert not is_well_formed(vertices, iterations)


def test_iterations_with_control_flow_are_not_folded():
    label = NodeEffects(is_control_flow=True)
    vertices, iterations = iterations_of(lambda _: [node(".L1", effects=label), node("v_mul_lo_u32", "v2", "v2", "s0")])

    assert not is_well_formed(vertices, iterations)
