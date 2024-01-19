from src import base
from src.graph.common import Graph, GraphType
from src.node import Node


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

    # +==============+
    # |    PUBLIC    |
    # +==============+

    def build_from_node(
            self,
            node: Node,
            program_name: str,
            program_id: str,
    ):
        """
        Build graphviz graph based on passed $node as a root node.
        """

        self.add_node(
            id_=program_id,
            label=program_name,
        )

        node_id = self._node_dfs_with_instructions_buffer(
            node=node,
            instructions_buffer=[],
        )

        self.add_edge(
            from_id=program_id,
            to_id=node_id,
        )

    # +===============+
    # |    PRIVATE    |
    # +===============+

    def _node_dfs_with_instructions_buffer(
            self,
            node: Node,
            instructions_buffer: list[base.Instruction],
    ) -> str:
        """
        Do dfs algorithm to build control flow graph.
        During handling, creating graph nodes for passed $node.
        Combining neighbour graph nodes in one node in case of "only neighbor" relation.

        :returns: ID of built graph node
        """

        instructions_buffer.append(node.instruction)

        child_amount = len(node.children)
        if child_amount == 0 or child_amount > 1:
            self.add_node(
                id_=node.id,
                label=self._build_node_title_based_on_instructions_list(instructions_buffer),
            )

            instructions_buffer = []

        for child_node in node.children:
            child_id = self._node_dfs_with_instructions_buffer(
                node=child_node,
                instructions_buffer=instructions_buffer,
            )

            if child_amount > 1:
                self.add_edge(
                    from_id=node.id,
                    to_id=child_id,
                )
            else:
                return child_id

        return node.id

    @staticmethod
    def _build_node_title_based_on_instructions_list(
            instructions_list: list[base.Instruction],
    ) -> str:
        tr_td_text = "\n".join([
            f"<TR><TD><B>{instruction[0]}</B></TD><TD>{' '.join(instruction[1:])}</TD></TR>"
            for instruction
            in instructions_list
        ])

        return (
            "<<TABLE>"
            f"{tr_td_text}"
            "</TABLE>>"
        )
