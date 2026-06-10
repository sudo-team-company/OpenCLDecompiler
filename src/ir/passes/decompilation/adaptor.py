from src.ir.kernel import Kernel
from src.ir.passes.base import PassContext, PassPipeline
from src.ir.passes.decompilation.state import DecompilationState


class KernelToDecompilerPipelineAdaptor:
    name = "kernel-to-decompiler-pipeline"

    def __init__(self, pipeline: PassPipeline):
        self.pipeline = pipeline

    def run(self, kernel: Kernel, context: PassContext) -> None:
        state = DecompilationState.from_kernel(kernel)
        context.metadata["decompilation_state"] = state
        self.pipeline.run(state, context)
