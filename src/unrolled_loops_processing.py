import operator

from src.decompiler_data import DecompilerData
from src.node import Node
from src.region_type import RegionType
from src.regions.region import Region


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
        return self.node.instruction[0]

    @property
    def src_args(self) -> list[str]:
        return self.node.instruction[2:]

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


def process_unrolled_loops():  # pylint: disable=R0914
    decompiler_data = DecompilerData()
    unrolling_limit = decompiler_data.unrolling_limit
    region: Region = decompiler_data.improve_cfg
    if region.type == RegionType.LINEAR:
        vertices: list[Vertex] = []

        cur: Node = region.start
        edge_ends = {}
        while cur != region.end:
            if len(cur.children) != 1:
                return
            if not isinstance(cur, Node):
                return
            cur = cur.children[0]
            vertices.append(Vertex(len(vertices), cur))
            idx = len(vertices) - 1
            if len(cur.instruction) > 2:
                for arg in cur.instruction[2:]:
                    if arg[0] not in "sv":
                        continue
                    fromm = edge_ends.get(arg)
                    if fromm:
                        vertices[fromm].child.add(idx)
                        vertices[idx].parent.add(fromm)
            if len(cur.instruction) > 1:
                reg = cur.instruction[1]
                edge_ends[reg] = idx

        counters: dict[str, int] = {}
        for vertex in vertices:
            instruction: str = vertex.instruction
            if instruction == "s_nop":
                continue
            counters[instruction] = counters.get(instruction, 0) + 1

        counters: list[tuple[str, int]] = [(name, cnt) for name, cnt in counters.items() if cnt >= unrolling_limit]
        counters.sort(key=operator.itemgetter(1), reverse=True)

        chosen = []
        for name, cnt in counters:
            reset_vertices(vertices)
            chosen = []
            for i, vertex in enumerate(vertices):
                if vertex.instruction == name:
                    chosen.append(i)
                    vertex.used = True

            while True:
                counters2: dict[tuple[str, int], int] = {}
                for i in chosen:
                    parent: Vertex = vertices[i]
                    for j, c in enumerate(parent.merged_child):
                        child: Vertex = vertices[c]
                        if child.used:
                            continue
                        instruction: str = child.instruction
                        if instruction == "s_nop":
                            continue
                        counters2[instruction, j] = counters2.get((instruction, j), 0) + 1

                counters2: list[tuple[str, int, int]] = [
                    (name, num, cnt)
                    for (name, num), cnt in counters2.items()
                    if cnt >= unrolling_limit and cnt > len(chosen) // 2
                ]
                counters2.sort(key=operator.itemgetter(2), reverse=True)
                if len(counters2) == 0:
                    break

                name2, child_num2, _ = counters2[0]
                chosen = [i for i in chosen if vertices[vertices[i].merged_child[child_num2]].instruction == name2]
                for i in chosen:
                    parent: Vertex = vertices[i]
                    child: Vertex = vertices[parent.merged_child[child_num2]]
                    child.used = True
                    parent.merged_vertices.append(child.num)
                    parent.merged_child.extend(child.merged_child)
            if len(chosen) > unrolling_limit:
                break
        if len(chosen) > unrolling_limit:
            progressions = []
            for v in map(vertices.__getitem__, [chosen[0], *vertices[chosen[0]].merged_vertices]):
                progressions.extend([] for _ in v.src_args)
            for i in chosen:
                idx = 0
                for v in map(vertices.__getitem__, [i, *vertices[i].merged_vertices]):
                    v.node.exclude_unrolled = True
                    for arg in v.src_args:
                        progressions[idx].append(arg)
                        idx += 1

            progressions = filter(lambda es: not all(e == es[0] for e in es), progressions)
            progressions = (list(map(to_int, es)) for es in progressions)
            progressions = list(progressions)

            for es in progressions:
                for e in es:
                    if e is None:
                        return

            if len(progressions) == 0:
                first, last, diff = 0, len(chosen), "i++"
            else:
                constants = progressions[0]
                first = constants[0]
                last = constants[-1]
                diff = constants[1] - constants[0]
                diff = f"i = i - {-diff}" if diff < 0 else f"i = i + {diff}"

            dst = vertices[vertices[chosen[-1]].merged_vertices[-1]].node.instruction[1]

            cur = decompiler_data.improve_cfg.start
            end = decompiler_data.improve_cfg.end
            while cur != end and not cur.children[0].exclude_unrolled:
                cur = cur.children[0]
            before = cur.state[dst].val
            inside: str = vertices[vertices[chosen[0]].merged_vertices[-1]].node.state[dst].val
            inside = inside.replace(f"({before})", "acc").replace(f"{before}", "acc")
            if len(progressions) != 0:
                inside = inside.replace(str(progressions[0][0]), "i")
            while cur != end and cur.children[0].exclude_unrolled:
                child: Node = cur.children[0]
                cur.children = child.children

            cur.children[0].state[dst].register_content._value = "acc"  # pylint: disable=W0212
            cur.add_first_child(Region(RegionType.UNROLLED_LOOP, (before, first, last, diff, inside)))
