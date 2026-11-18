from src.ir.asm_to_ir.amd.register_factory import RegFactory
from src.ir.registers.reg import Val
from src.node import Node
from src.node_effects import NodeEffects
from src.region_type import RegionType
from src.regions.region import Region
from src.unrolled_loops_processing import build_def_use_graph, dst_of, is_well_formed


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


def test_dst_is_the_only_written_register():
    region = chain(
        node("v_mul_lo_u32", "v2", "v2", "s0"),
        node("v_lshlrev_b64", "v[0:1]", "2", "v[0:1]"),
        store("v[0:1]", "v2"),
    )
    vertices = build_def_use_graph(region)

    assert dst_of(vertices, [0]) == "v2"
    assert dst_of(vertices, [1]) is None  # writes v0 and v1
    assert dst_of(vertices, [2]) is None  # writes nothing


def iterations_of(body) -> tuple[list, list[list[int]]]:
    """Three copies of ``body()`` followed by one more node; returns the vertices and the iterations."""
    nodes = [n for _ in range(3) for n in body()]
    region = chain(*nodes, node("v_mov_b32", "v9", "v2"))
    size = len(nodes) // 3
    return build_def_use_graph(region), [list(range(k * size, (k + 1) * size)) for k in range(3)]


def test_iterations_without_side_effects_can_be_folded():
    vertices, iterations = iterations_of(
        lambda: [node("v_mul_lo_u32", "v2", "v2", "s0"), node("v_add_u32", "v2", "1", "v2")]
    )

    assert is_well_formed(vertices, iterations)


def test_iterations_with_a_store_are_not_folded():
    vertices, iterations = iterations_of(
        lambda: [node("v_mul_lo_u32", "v2", "v2", "s0"), store("v[0:1]", "v2"), node("v_add_u32", "v2", "1", "v2")]
    )

    # the store is in the middle, so the iterations still end with a write to v2
    assert dst_of(vertices, iterations[0]) == "v2"
    assert not is_well_formed(vertices, iterations)


def test_iterations_with_control_flow_are_not_folded():
    label = NodeEffects(is_control_flow=True)
    vertices, iterations = iterations_of(lambda: [node(".L1", effects=label), node("v_mul_lo_u32", "v2", "v2", "s0")])

    assert not is_well_formed(vertices, iterations)
