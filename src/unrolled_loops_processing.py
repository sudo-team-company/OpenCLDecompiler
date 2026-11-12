import copy
import operator

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
from src.ir.registers.reg import is_reg
from src.node import Node
from src.region_type import RegionType
from src.regions.region import Region
from src.unrolled_loops import UnrolledLoopData
from src.unrolled_loops.loop_data import ACCUMULATOR, LOOP_VARIABLE
from src.unrolled_loops.sequences import ArithmeticSequence, IteratorSequence, detect_sequence, to_int32


class Vertex:
    def __init__(self, num: int, node: Node):
        self.num: int = num
        self.node: Node = node
        self.parent: set[int] = set()
        self.child: set[int] = set()
        self.used: bool = False
        self.merged_vertices: list[int] = [num]
        self.merged_child: list[int] = []

    @property
    def instruction(self) -> str:
        return self.node.instruction

    @property
    def src_args(self) -> list[str]:
        return self.node.operands[1:]

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


def build_def_use_graph(region: Region) -> list[Vertex]:
    vertices: list[Vertex] = []
    last_writer: dict[str, int] = {}

    cur: Node = region.start
    while cur != region.end:
        assert isinstance(cur, Node)
        cur = cur.children[0]
        idx = len(vertices)
        vertices.append(Vertex(idx, cur))
        for arg in cur.operands[1:]:
            if not is_reg(arg):
                continue
            writer = last_writer.get(arg.name)
            if writer is not None:
                vertices[writer].child.add(idx)
                vertices[idx].parent.add(writer)
        if len(cur.operands) > 0:
            last_writer[cur.operands[0].name] = idx

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


Iteration = list[int] # vertex indices


def build_register_usages_table(vertices: list[Vertex], iterations: list[Iteration]) -> list[list[str]]:
    rows = [[arg.name for num in iteration for arg in vertices[num].src_args] for iteration in iterations]
    return [list(column) for column in zip(*rows, strict=True)]


def _first_is_peeled(column: list[str]) -> bool:
    return column[0] != column[1] and len(set(column[1:])) == 1


def trim_peeled_iterations(vertices: list[Vertex], iterations: list[Iteration]) -> list[Iteration]:
    while len(iterations) > 2:  # noqa: PLR2004
        table = build_register_usages_table(vertices, iterations)
        if any(_first_is_peeled(column) for column in table):
            iterations = iterations[1:]
        elif any(_first_is_peeled(column[::-1]) for column in table):
            iterations = iterations[:-1]
        else:
            return iterations
    return iterations


def dst_of(vertices: list[Vertex], iteration: Iteration) -> str:
    return vertices[iteration[-1]].node.operands[0].name


def is_well_formed(vertices: list[Vertex], iterations: list[Iteration]) -> bool:
    if len({dst_of(vertices, iteration) for iteration in iterations}) != 1:
        return False
    nums = {num for iteration in iterations for num in iteration}
    first, last = min(nums), max(nums)
    if last == len(vertices) - 1:
        return False
    return all(num in nums or vertices[num].instruction == "s_nop" for num in range(first, last + 1))


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

    dst = dst_of(vertices, iterations[0])
    nums = [num for iteration in iterations for num in iteration]
    before_loop: Node = vertices[min(nums) - 1].node if min(nums) > 0 else region.start
    after_loop: Node = vertices[max(nums) + 1].node
    if dst not in before_loop.state or dst not in after_loop.state:
        return
    results = [vertices[iteration[-1]].node.state[dst].get_expression_node() for iteration in iterations]
    prev_values = [before_loop.state[dst].get_expression_node(), *results[:-1]]

    expression_manager = ExpressionManager()
    acc_node = expression_manager.add_variable_node(ACCUMULATOR, ExpressionValueTypeHint(OpenCLTypes.UINT))
    body = build_body(prev_values, results, constants, iterator, acc_node)
    if body is None:
        return
    acc_init = expression_manager.expression_to_string(prev_values[0])

    before_loop.children = [after_loop]
    after_loop.state[dst].register_content._value = ACCUMULATOR  # noqa: SLF001
    replace_after_loop(after_loop, region.end, results[-1], acc_node)
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
