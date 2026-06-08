from src.ir.passes.base import PassContext
from src.ir.passes.decompilation.state import DecompilationState
from src.regions.functions_for_regions import make_region_graph_from_cfg, process_region_graph


class BuildRegionGraphPass:
    name = "build-region-graph"

    def run(self, _state: DecompilationState, _context: PassContext) -> None:
        make_region_graph_from_cfg()
        process_region_graph()
