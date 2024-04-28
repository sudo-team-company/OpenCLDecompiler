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

    def instruction(self) -> str:
        return self.node.instruction[0]

    def reset(self):
        self.used = False
        self.merged_vertices = [self.num]
        self.merged_child = list(self.child)


def reset_vertices(vertices: list[Vertex]):
    for vertex in vertices:
        vertex.reset()


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
                    if arg[0] not in 'sv':
                        continue
                    fromm = edge_ends.get(arg)
                    if fromm:
                        vertices[fromm].child.add(idx)
                        vertices[idx].parent.add(fromm)
            if len(cur.instruction) > 1:
                reg = cur.instruction[1]
                edge_ends[reg] = idx

        counters: dict[str, int] = {}
        for i, vertex in enumerate(vertices):
            instruction: str = vertex.instruction()
            if instruction == 's_nop':
                continue
            counters[instruction] = counters.get(instruction, 0) + 1

        counters: list[tuple[str, int]] = [(name, cnt) for name, cnt in counters.items() if cnt >= unrolling_limit]
        counters.sort(key=lambda x: x[1], reverse=True)

        chosen = []
        for name, cnt in counters:
            reset_vertices(vertices)
            chosen = []
            for i, vertex in enumerate(vertices):
                if vertex.instruction() == name:
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
                        instruction: str = child.instruction()
                        if instruction == 's_nop':
                            continue
                        counters2[(instruction, j)] = counters2.get((instruction, j), 0) + 1

                counters2: list[tuple[str, int, int]] = [(name, num, cnt) for (name, num), cnt in counters2.items() if
                                                         cnt >= unrolling_limit and cnt > len(chosen) // 2]
                counters2.sort(key=lambda x: x[2], reverse=True)
                if len(counters2) == 0:
                    break

                name2, child_num2, _ = counters2[0]
                chosen = [i for i in chosen if vertices[vertices[i].merged_child[child_num2]].instruction() == name2]
                for i in chosen:
                    parent: Vertex = vertices[i]
                    child: Vertex = vertices[parent.merged_child[child_num2]]
                    child.used = True
                    parent.merged_vertices.append(child.num)
                    parent.merged_child.extend(child.merged_child)
            if len(chosen) > unrolling_limit:
                break
        if len(chosen) > unrolling_limit:
            constants = []
            for i in chosen:
                merged: list[int] = [i] + vertices[i].merged_vertices
                merged: list[Vertex] = [vertices[j] for j in merged]
                for v in merged:
                    v.node.exclude_unrolled = True
                    for a in range(2, len(v.node.instruction)):
                        arg = v.node.instruction[a]
                        try:
                            arg = int(arg)
                            constants.append(arg)
                            continue
                        except ValueError:
                            pass
                        try:
                            arg = int(arg, 16)
                            constants.append(arg)
                            continue
                        except ValueError:
                            pass

            if len(constants) < 2:
                return
            diff = constants[1] - constants[0]
            if diff < 0:
                diff = f'i = i - {-diff}'
            else:
                diff = f'i = i + {diff}'
            first = constants[0]
            last = constants[-1]
            dst = vertices[vertices[chosen[-1]].merged_vertices[-1]].node.instruction[1]

            cur = decompiler_data.improve_cfg.start
            end = decompiler_data.improve_cfg.end
            while cur != end and not cur.children[0].exclude_unrolled:
                cur = cur.children[0]
            before = cur.state.registers[dst].val
            inside: str = vertices[vertices[chosen[0]].merged_vertices[-1]].node.state.registers[dst].val
            inside = inside.replace(f"({before})", 'acc').replace(f"{before}", 'acc')
            inside = inside.replace(str(constants[0]), 'i')
            while cur != end and cur.children[0].exclude_unrolled:
                child: Node = cur.children[0]
                cur.children = child.children

            cur.children[0].state.registers[dst].register_content._value = 'acc'  # pylint: disable=W0212
            cur.add_first_child(Region(RegionType.UNROLLED_LOOP, (before, first, last, diff, inside)))
