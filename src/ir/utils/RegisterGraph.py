from typing import Optional

class RegisterGraph:
    def __init__(self):
        self._graph: dict[str, set[str]] = {}
        self._in_degree: dict[str, int] = {}
        self._out_degree: dict[str, int] = {}
        self._numbering: dict[str, int] = {}
        self._built = False
    
    def reset(self) -> None:
        self._graph.clear()
        self._in_degree.clear()
        self._out_degree.clear()
        self._numbering.clear()
        self._built = False
    
    def _add_vertex(self, name: str) -> None:
        if name not in self._graph:
            self._graph[name] = []
            self._in_degree[name] = 0
            self._out_degree[name] = 0
    
    def add(self, *items) -> None:
        if self._built:
            raise RuntimeError("Call reset()")

        regs = items

        for i, name in enumerate(regs):
            self._add_vertex(name)
            if i < len(regs) - 1:
                next_name = regs[i + 1]
                self._add_vertex(next_name)
                if next_name not in self._graph[name]:
                    self._graph[name].append(next_name)
                    self._out_degree[name] += 1
                    self._in_degree[next_name] += 1

        return self

    
    def build(self) -> Optional[dict[str, int]]:
        #TODO сообщения об ошибках
        if self._built:
            return numbering
        
        self._built = True

        if not self._graph:
            return {}

        for name in self._graph:
            if self._in_degree[name] > 1 or self._out_degree[name] > 1:
                return None

        starts = [n for n in self._graph if self._in_degree[n] == 0]
        numbering = {}
        current = 0
        visited = set()

        for start in starts:
            curr = start
            while curr:
                if curr in visited:
                    return None
                visited.add(curr)
                numbering[curr] = current
                current += 1
                curr = self._graph[curr][0] if self._out_degree[curr] else None

        if len(visited) < len(self._graph):
            return None

        self._numbering = numbering
        return numbering
    
    def get_numbering(self) -> dict[str, int]:
        return self.numbering