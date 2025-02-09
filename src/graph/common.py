import enum

import graphviz

from src.exceptions import LogicalError
from src.utils import Singleton


class GraphType(enum.Enum):
    DIRECTED = "DIRECTED"
    NOT_DIRECTED = "NOT_DIRECTED"


class Graph(metaclass=Singleton):
    def __init__(
        self,
        graph_type: GraphType,
        render_path: str,
        kwargs: dict[str, object],
    ):
        self._graph_type = type
        self._render_path = render_path

        if graph_type == GraphType.DIRECTED:
            self._dot = graphviz.Digraph(**kwargs)
        elif graph_type == GraphType.NOT_DIRECTED:
            self._dot = graphviz.Graph(**kwargs)
        else:
            raise LogicalError(f"Unknown graph type '{graph_type}'")  # noqa: TRY003

    # ---------------------
    # [SECTION] Build graph
    # ---------------------

    def add_node(self, id_: str, label: str):
        self._dot.node(id_, label)

    def add_edge(self, from_id: str, to_id: str):
        self._dot.edge(from_id, to_id)

    def render(self):
        self._dot.render(self._render_path)

    # ---------------------------------------------
    # [SECTION] Manipulate with graphviz attributes
    # ---------------------------------------------

    # +===================+
    # |    GRAPH_ATTRS    |
    # +===================+
    def update_graph_attrs(self, *_, **kwargs):
        self._update_attrs(self._dot.graph_attr, **kwargs)

    def delete_graph_attrs(self, keys: list[str]):
        self._delete_attrs(self._dot.graph_attr, keys)

    # +==================+
    # |    NODE_ATTRS    |
    # +==================+
    def update_node_attrs(self, *_, **kwargs):
        self._update_attrs(self._dot.node_attr, **kwargs)

    def delete_node_attrs(self, keys: list[str]):
        self._delete_attrs(self._dot.node_attr, keys)

    # +==================+
    # |    EDGE_ATTRS    |
    # +==================+
    def update_edge_attrs(self, *_, **kwargs):
        self._update_attrs(self._dot.edge_attr, **kwargs)

    def delete_edge_attrs(self, keys: list[str]):
        self._delete_attrs(self._dot.edge_attr, keys)

    # +====================+
    # |    COMMON_ATTRS    |
    # +====================+

    def _update_attrs(self, attr_dict: dict, **kwargs):
        attr_dict.update(**kwargs)

    def _delete_attrs(self, attr_dict: dict, keys: list[str]):
        for key in keys:
            del attr_dict[key]
