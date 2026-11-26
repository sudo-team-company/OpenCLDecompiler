import copy
import operator
from collections import Counter
from dataclasses import dataclass

from src.decompiler_data import DecompilerData
from src.expression_manager.expression_helper_functions import (
    RewriteRule,
    create_var_node,
    replace_subtree,
    rewrite,
)
from src.expression_manager.expression_manager import ExpressionManager
from src.expression_manager.expression_node import ExpressionNode, ExpressionType, ExpressionValueTypeHint
from src.expression_manager.types.opencl_types import OpenCLTypes
from src.ir.registers.reg import BaseReg, expand_register_names
from src.node import Node
from src.node_effects import NodeEffects
from src.region_type import RegionType
from src.regions.region import Region
from src.unrolled_loops import UnrolledLoopData
from src.unrolled_loops.loop_data import ACCUMULATOR, LOOP_VARIABLE
from src.unrolled_loops.sequences import ArithmeticSequence, IteratorSequence, detect_sequence, to_int32


class Vertex:
    def __init__(self, num: int, node: Node):
        self.num: int = num
        self.node: Node = node
        self.child: set[int] = set()
        self.used: bool = False
        self.merged_vertices: list[int] = [num]
        self.merged_child: list[int] = []
        # register read by the node -> vertex that last wrote it (None: written before the region or never)
        self.sources: dict[str, int | None] = {}

    @property
    def instruction(self) -> str:
        return self.node.instruction

    def reset(self):
        self.used = False
        self.merged_vertices = [self.num]
        self.merged_child = list(self.child)


def reset_vertices(vertices: list[Vertex]):
    for vertex in vertices:
        vertex.reset()


def to_int(x: str) -> int | None:
    try:
        return int(x)
    except ValueError:
        try:
            return int(x, 16)
        except ValueError:
            return None


def is_node_chain(region: Region) -> bool:
    cur: Node = region.start
    while cur != region.end:
        if len(cur.children) != 1 or not isinstance(cur, Node):
            return False
        cur = cur.children[0]
    return True


def effects_of(node: Node) -> NodeEffects:
    return node.effects if node.effects is not None else NodeEffects.from_operands(node.operands)


def build_def_use_graph(region: Region) -> list[Vertex]:
    vertices: list[Vertex] = []
    last_writer: dict[str, int] = {}

    cur: Node = region.start
    while cur != region.end:
        assert isinstance(cur, Node)
        cur = cur.children[0]
        idx = len(vertices)
        vertices.append(Vertex(idx, cur))
        effects = effects_of(cur)
        for reg in effects.reads:
            writer = last_writer.get(reg)
            vertices[idx].sources[reg] = writer
            if writer is not None:
                vertices[writer].child.add(idx)
        for reg in effects.writes:
            last_writer[reg] = idx

    return vertices


def count_frequent_instructions(vertices: list[Vertex], unrolling_limit: int) -> list[tuple[str, int]]:
    counters: dict[str, int] = {}
    for vertex in vertices:
        instruction: str = vertex.instruction
        if instruction == "s_nop":
            continue
        counters[instruction] = counters.get(instruction, 0) + 1

    frequent = [(name, cnt) for name, cnt in counters.items() if cnt >= unrolling_limit]
    frequent.sort(key=operator.itemgetter(1), reverse=True)
    return frequent


def choose_most_frequent_user(
    vertices: list[Vertex], chosen: list[int], unrolling_limit: int
) -> tuple[str, int] | None:
    counters: dict[tuple[str, int], int] = {}
    for i in chosen:
        parent: Vertex = vertices[i]
        for slot, c in enumerate(parent.merged_child):
            child: Vertex = vertices[c]
            if child.used:
                continue
            instruction: str = child.instruction
            if instruction == "s_nop":
                continue
            counters[instruction, slot] = counters.get((instruction, slot), 0) + 1

    suitable = [(key, cnt) for key, cnt in counters.items() if cnt >= unrolling_limit and cnt > len(chosen) // 2]
    if not suitable:
        return None
    return max(suitable, key=operator.itemgetter(1))[0]


def has_user(vertices: list[Vertex], parent: Vertex, slot: int, instruction: str) -> bool:
    if slot >= len(parent.merged_child):
        return False
    child = vertices[parent.merged_child[slot]]
    return not child.used and child.instruction == instruction


def extend_loop_body(vertices: list[Vertex], chosen: list[int], unrolling_limit: int) -> list[int]:
    while True:
        most_frequent_user = choose_most_frequent_user(vertices, chosen, unrolling_limit)
        if most_frequent_user is None:
            return chosen

        name, slot = most_frequent_user
        chosen = [i for i in chosen if has_user(vertices, vertices[i], slot, name)]
        for i in chosen:
            parent: Vertex = vertices[i]
            child: Vertex = vertices[parent.merged_child[slot]]
            child.used = True
            parent.merged_vertices.append(child.num)
            parent.merged_child.extend(child.merged_child)


Iteration = list[int]  # vertex indices, in template order: iteration[j] is the j-th template instruction

INTERNAL = "internal"  # written earlier in the same iteration
CARRIED = "carried"  # written by the previous iteration
OUTSIDE = "outside"  # written before the loop, or not in the region at all
DISTANT = "distant"  # written by an iteration before the previous one

DATAFLOW = "*"  # a register operand matched by data flow, not by name


@dataclass(frozen=True, order=True)
class Source:
    """Where a register read by a template instruction comes from."""

    kind: str
    position: int = -1  # template position of the writer (INTERNAL, CARRIED, DISTANT)
    register: str = ""  # register name (OUTSIDE)


Owners = dict[int, tuple[int, int]]  # vertex index -> (iteration, template position)


def owners_of(iterations: list[Iteration]) -> Owners:
    return {num: (k, j) for k, iteration in enumerate(iterations) for j, num in enumerate(iteration)}


def source_of(owners: Owners, reader: int, register: str, writer: int | None) -> Source:
    """Where ``register`` read by the loop vertex ``reader`` comes from."""
    where = owners.get(writer) if writer is not None else None
    if where is None:
        return Source(OUTSIDE, register=register)
    reader_iteration = owners[reader][0]
    writer_iteration, position = where
    if writer_iteration == reader_iteration:
        return Source(INTERNAL, position)
    if writer_iteration == reader_iteration - 1:
        return Source(CARRIED, position)
    return Source(DISTANT, position)


def node_sources(vertices: list[Vertex], owners: Owners, vertex_num: int) -> tuple[Source, ...]:
    """Sources of all registers read by a loop vertex, as a sorted multiset."""
    sources = vertices[vertex_num].sources.items()
    return tuple(sorted(source_of(owners, vertex_num, reg, writer) for reg, writer in sources))


def is_inner_dataflow_operand(vertex: Vertex, owners: Owners, operand: BaseReg) -> bool:
    return any(
        source_of(owners, vertex.num, part, vertex.sources.get(part)).kind != OUTSIDE
        for part in expand_register_names(operand)
    )


def read_operand_positions(vertex: Vertex, owners: Owners) -> list[tuple[int, bool]]:
    """``(operand index, is inner data flow)`` for the constants and the registers the node reads, in order."""
    reads = effects_of(vertex.node).reads
    positions = []
    for index, operand in enumerate(vertex.node.operands):
        # constant
        if not isinstance(operand, BaseReg):
            positions.append((index, False))
        elif reads.intersection(expand_register_names(operand)):
            positions.append((index, is_inner_dataflow_operand(vertex, owners, operand)))
    return positions


def build_register_usages_table(vertices: list[Vertex], iterations: list[Iteration]) -> list[list[str]]:
    """One column per read operand of the template, one row per iteration.

    A constant gives its value and a register read from outside the loop gives its name. A register written inside
    the loop (a temporary or the loop-carried value) gives ``DATAFLOW``, so different register names in different
    iterations do not matter. Which operands are data flow is decided by the middle iteration: the first and the last
    ones may be peeled.
    """
    owners = owners_of(iterations)
    middle = iterations[len(iterations) // 2]
    positions = [read_operand_positions(vertices[num], owners) for num in middle]
    rows = [
        [
            DATAFLOW if flow else vertices[num].node.operands[index].name
            for j, num in enumerate(iteration)
            for index, flow in positions[j]
        ]
        for iteration in iterations
    ]
    return [list(column) for column in zip(*rows, strict=True)]


def _first_is_peeled(column: list[str]) -> bool:
    return column[0] != column[1] and len(set(column[1:])) == 1


def trim_peeled_iterations(vertices: list[Vertex], iterations: list[Iteration]) -> list[Iteration]:
    while len(iterations) > 2 and any(  # noqa: PLR2004
        _first_is_peeled(column) for column in build_register_usages_table(vertices, iterations)
    ):
        iterations = iterations[1:]
    return iterations


@dataclass(frozen=True)
class LoopShape:
    carried_position: int  # template position of the instruction that writes the loop-carried value
    carried: list[str]  # registers holding the loop-carried value after each iteration
    initial: str  # register holding its value before the loop


def _by_kind(sources: tuple[Source, ...], kind: str) -> Counter[Source]:
    return Counter(source for source in sources if source.kind == kind)


def initial_register(first: list[tuple[Source, ...]], reference: list[tuple[Source, ...]]) -> str | None:
    """Find accumulator initial value register from iteration's intruction's read operand source."""
    initial: set[str] = set()
    for got, expected in zip(first, reference, strict=True):
        # same number of registers read from same position in this iter
        if _by_kind(got, INTERNAL) != _by_kind(expected, INTERNAL):
            return None
        got_outside, expected_outside = _by_kind(got, OUTSIDE), _by_kind(expected, OUTSIDE)
        if expected_outside - got_outside:
            return None
        extra = got_outside - expected_outside
        if extra.total() != _by_kind(expected, CARRIED).total():
            return None
        initial.update(source.register for source in extra)
    return next(iter(initial)) if len(initial) == 1 else None


def is_used_after_loop_only_as_carried(
    vertices: list[Vertex], iterations: list[Iteration], owners: Owners, shape: LoopShape
) -> bool:
    """After the loop, only the final loop-carried value may be read: other values of the iterations are lost."""
    last_num = max(num for iteration in iterations for num in iteration)
    final = (len(iterations) - 1, shape.carried_position)
    for vertex in vertices[last_num + 1 :]:
        for writer in vertex.sources.values():
            where = owners.get(writer) if writer is not None else None
            if where is not None and where != final:
                return False
    return True


def analyse_loop(vertices: list[Vertex], iterations: list[Iteration]) -> LoopShape | None:
    if len(iterations) < 2:  # noqa: PLR2004
        return None
    owners = owners_of(iterations)
    sources = [[node_sources(vertices, owners, num) for num in iteration] for iteration in iterations]
    reference = sources[1]
    if any(sources[k] != reference for k in range(2, len(iterations))):
        return None
    initial = initial_register(sources[0], reference)
    if initial is None:
        return None

    # template idx from prev iteration that is read by the current iteration
    positions = {source.position for node in reference for source in node if source.kind == CARRIED}

    # assume only accumulator is carried for now
    if len(positions) != 1:
        return None

    (position,) = positions
    carried = carried_registers(vertices, iterations, position)
    if carried is None:
        return None

    shape = LoopShape(position, carried, initial)
    return shape if is_used_after_loop_only_as_carried(vertices, iterations, owners, shape) else None


def carried_registers(vertices: list[Vertex], iterations: list[Iteration], position: int) -> list[str] | None:
    """List of registers for each iteration that are read by the next iteration, in template order."""
    carried = []
    for iteration in iterations:
        writes = effects_of(vertices[iteration[position]].node).writes
        if len(writes) != 1:
            return None
        carried.append(next(iter(writes)))
    return carried


def is_simple_instruction(node: Node) -> bool:
    effects = effects_of(node)
    return not effects.has_side_effects and not effects.is_control_flow


def is_well_formed(vertices: list[Vertex], iterations: list[Iteration]) -> bool:
    nums = {num for iteration in iterations for num in iteration}
    first, last = min(nums), max(nums)
    if last == len(vertices) - 1:
        return False
    removed = range(first, last + 1)
    if not all(num in nums or vertices[num].instruction == "s_nop" for num in removed):
        return False
    if not all(is_simple_instruction(vertices[num].node) for num in removed):
        return False
    return analyse_loop(vertices, iterations) is not None


def find_iterations(vertices: list[Vertex], unrolling_limit: int) -> list[Iteration] | None:
    best: list[Iteration] | None = None
    best_key: tuple[int, int] = (0, 0)
    for name, _ in count_frequent_instructions(vertices, unrolling_limit):
        reset_vertices(vertices)
        chosen = [vertex.num for vertex in vertices if vertex.instruction == name]
        for num in chosen:
            vertices[num].used = True
        chosen = extend_loop_body(vertices, chosen, unrolling_limit)

        iterations = trim_peeled_iterations(vertices, [list(vertices[anchor].merged_vertices) for anchor in chosen])
        if len(iterations) <= unrolling_limit or not is_well_formed(vertices, iterations):
            continue
        key = (len(iterations), max(iterations[-1]))
        if key > best_key:
            best, best_key = iterations, key
    return best


def detect_iterator(vertices: list[Vertex], iterations: list[Iteration]) -> tuple[IteratorSequence, list[int]] | None:
    varying = [column for column in build_register_usages_table(vertices, iterations) if len(set(column)) > 1]
    if not varying:
        return ArithmeticSequence.counter(len(iterations)), []

    columns: list[list[int]] = []
    for column in varying:
        values = [to_int(e) for e in column]
        values = [None if v is None else to_int32(v) for v in values]
        if any(v is None for v in values):
            return None
        columns.append(values)
    if any(column != columns[0] for column in columns[1:]):
        return None

    sequence = detect_sequence(columns[0])
    return None if sequence is None else (sequence, columns[0])


def replace_constant(value: int, expr: str) -> RewriteRule:
    def rule(node: ExpressionNode) -> ExpressionNode | None:
        if node.type != ExpressionType.CONST:
            return None
        const = to_int(str(node.value))
        if const is None or to_int32(const) != value:
            return None
        return create_var_node(expr, copy.deepcopy(node.value_type_hint))

    return rule


def both(first: RewriteRule, second: RewriteRule) -> RewriteRule:
    def rule(node: ExpressionNode) -> ExpressionNode | None:
        replacement = first(node)
        return replacement if replacement is not None else second(node)

    return rule


def build_body(
    prev_values: list[ExpressionNode],
    results: list[ExpressionNode],
    constants: list[int],
    iterator: IteratorSequence,
    acc_node: ExpressionNode,
) -> str | None:
    value_expr = iterator.value(LOOP_VARIABLE)
    expression_manager = ExpressionManager()
    bodies = set()
    for k, (prev, result) in enumerate(zip(prev_values, results, strict=True)):
        rule = replace_subtree(prev, acc_node)
        if constants:
            rule = both(rule, replace_constant(constants[k], value_expr))
        bodies.add(expression_manager.expression_to_string(rewrite(result, rule)))
        if len(bodies) > 1:
            return None
    return bodies.pop()


def replace_after_loop(start: Node, end: Node, last_result: ExpressionNode, acc_node: ExpressionNode):
    rule = replace_subtree(last_result, acc_node)
    cur = start
    while True:
        for reg_name in cur.state:
            register = cur.state[reg_name]
            expr = register.get_expression_node()
            if expr is None:
                continue
            new_expr = rewrite(expr, rule)
            if new_expr is not expr:
                register.set_expression_node(new_expr)
        if cur == end:
            return
        cur = cur.children[0]


def fold_loop(region: Region, vertices: list[Vertex], iterations: list[Iteration]):
    detected = detect_iterator(vertices, iterations)
    if detected is None:
        return
    iterator, constants = detected

    shape = analyse_loop(vertices, iterations)
    if shape is None:
        return

    dst = shape.carried[-1]
    nums = [num for iteration in iterations for num in iteration]
    before_loop: Node = vertices[min(nums) - 1].node if min(nums) > 0 else region.start
    after_loop: Node = vertices[max(nums) + 1].node
    if shape.initial not in before_loop.state or dst not in after_loop.state:
        return

    acc_expressions = [
        vertices[iteration[shape.carried_position]].node.state[reg].get_expression_node()
        for iteration, reg in zip(iterations, shape.carried, strict=True)
    ]
    prev_values = [before_loop.state[shape.initial].get_expression_node(), *acc_expressions[:-1]]

    expression_manager = ExpressionManager()
    acc_node = expression_manager.add_variable_node(ACCUMULATOR, ExpressionValueTypeHint(OpenCLTypes.UINT))
    body = build_body(prev_values, acc_expressions, constants, iterator, acc_node)
    if body is None:
        return
    acc_init = expression_manager.expression_to_string(prev_values[0])

    before_loop.children = [after_loop]
    after_loop.state[dst].register_content._value = ACCUMULATOR  # noqa: SLF001
    replace_after_loop(after_loop, region.end, acc_expressions[-1], acc_node)
    before_loop.add_first_child(Region(RegionType.UNROLLED_LOOP, UnrolledLoopData(acc_init, iterator, body)))


def process_unrolled_loops():
    decompiler_data = DecompilerData()
    region: Region = decompiler_data.improve_cfg
    if region.type != RegionType.LINEAR or not is_node_chain(region):
        return
    vertices = build_def_use_graph(region)
    iterations = find_iterations(vertices, decompiler_data.unrolling_limit)
    if iterations is not None:
        fold_loop(region, vertices, iterations)
