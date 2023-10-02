from src.node import Node
from src.graph.common import Graph, GraphType


class ControlFlowGraph(Graph):
    def __init__(
            self,
            graph_type: GraphType,
            render_path: str,
            kwargs: dict[str, any],
    ):
        super().__init__(
            graph_type=graph_type,
            render_path=render_path,
            kwargs=kwargs,
        )

        self.update_node_attrs(
            shape="record",
        )

    def build_by_node(self, node: Node):
        """
        Build graphviz graph based on passed $node.
        Add all nodes and edges processed by using dfs algorithm on $node.
        """

        self.add_node(
            id_=node.id,
            label=f"{node.instruction[0]} | {' '.join(node.instruction[1:])}",
        )

        for parent_node in node.parent:
            self.add_edge(
                from_id=parent_node.id,
                to_id=node.id,
            )

        for child_node in node.children:
            self.build_by_node(child_node)
