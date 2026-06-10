from src.graph.control_flow_graph import CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY, ControlFlowGraph
from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState
from src.utils import get_context

CONTEXT = get_context()


class RenderControlFlowGraphPass:
    name = "render-control-flow-graph"

    def run(self, state: DecompilationState, _context: PassContext) -> None:
        decompiler_data = state.decompiler_data
        if not CONTEXT.get(CONTROL_FLOW_GRAPH_ENABLED_CONTEXT_KEY):
            return

        control_flow_graph = ControlFlowGraph.instance()
        for node in decompiler_data.starts_regions:
            control_flow_graph.build_from_node(
                node=node,
                program_name=decompiler_data.name_of_program,
                program_id=decompiler_data.pragram_id,
            )
        control_flow_graph.render()
